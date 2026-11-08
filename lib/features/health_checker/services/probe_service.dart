import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/health_target_model.dart';

class ProbeResult {
  final ProbeStatus status;
  final int latencyMs;
  final String message;

  const ProbeResult({
    required this.status,
    required this.latencyMs,
    required this.message,
  });

  factory ProbeResult.online(int latencyMs, [String? msg]) {
    final isDegraded = latencyMs > 450;
    return ProbeResult(
      status: isDegraded ? ProbeStatus.degraded : ProbeStatus.online,
      latencyMs: latencyMs,
      message: msg ?? (isDegraded ? 'LATENCIA ALTA (${latencyMs}ms)' : 'RESPONDIENDO (${latencyMs}ms)'),
    );
  }

  factory ProbeResult.offline(String error) {
    return ProbeResult(
      status: ProbeStatus.offline,
      latencyMs: 0,
      message: error,
    );
  }
}

class ProbeService {
  /// Probes any health target according to its protocol (TCP, HTTP, UDP).
  static Future<ProbeResult> testProbe(HealthTargetModel target) async {
    switch (target.protocol) {
      case ProbeProtocol.tcp:
        return _probeTcp(target.host, target.port, target.timeoutMs);
      case ProbeProtocol.http:
        return _probeHttp(target.host, target.port, target.path, target.expectedStatusCode, target.timeoutMs);
      case ProbeProtocol.udp:
        return _probeUdp(target.host, target.port, target.timeoutMs);
    }
  }

  /// TCP Socket probe
  static Future<ProbeResult> _probeTcp(String host, int port, int timeoutMs) async {
    final sw = Stopwatch()..start();
    try {
      final cleanHost = host.trim().replaceAll(RegExp(r'^https?://'), '').split('/')[0].split(':')[0];
      final socket = await Socket.connect(
        cleanHost,
        port,
        timeout: Duration(milliseconds: timeoutMs),
      );
      sw.stop();
      final latency = sw.elapsedMilliseconds;
      socket.destroy();
      return ProbeResult.online(latency, 'TCP PORT $port ABIERTO (${latency}ms)');
    } on SocketException catch (e) {
      sw.stop();
      final msg = e.osError?.message ?? e.message;
      if (msg.toLowerCase().contains('connection refused') || e.osError?.errorCode == 111) {
        return ProbeResult.offline('PUERTO $port RECHAZADO');
      }
      if (msg.toLowerCase().contains('timed out')) {
        return ProbeResult.offline('TIMEOUT (> ${timeoutMs}ms)');
      }
      return ProbeResult.offline('ERROR TCP: $msg');
    } on TimeoutException {
      sw.stop();
      return ProbeResult.offline('TIMEOUT (> ${timeoutMs}ms)');
    } catch (e) {
      sw.stop();
      return ProbeResult.offline('FALLO TCP: $e');
    }
  }

  /// HTTP / HTTPS probe
  static Future<ProbeResult> _probeHttp(
    String host,
    int port,
    String path,
    int expectedStatus,
    int timeoutMs,
  ) async {
    final sw = Stopwatch()..start();
    try {
      String cleanHost = host.trim();
      String scheme = port == 443 ? 'https' : 'http';
      if (cleanHost.startsWith('http://')) {
        scheme = 'http';
        cleanHost = cleanHost.substring(7);
      } else if (cleanHost.startsWith('https://')) {
        scheme = 'https';
        cleanHost = cleanHost.substring(8);
      }

      // Strip any path attached to host
      if (cleanHost.contains('/')) {
        final parts = cleanHost.split('/');
        cleanHost = parts[0];
      }

      // Handle custom port in host if present
      int targetPort = port;
      if (cleanHost.contains(':')) {
        final hostParts = cleanHost.split(':');
        cleanHost = hostParts[0];
        targetPort = int.tryParse(hostParts[1]) ?? port;
      }

      final cleanPath = path.startsWith('/') ? path : '/$path';
      final uri = (targetPort == 80 && scheme == 'http') || (targetPort == 443 && scheme == 'https')
          ? Uri(scheme: scheme, host: cleanHost, path: cleanPath)
          : Uri(scheme: scheme, host: cleanHost, port: targetPort, path: cleanPath);

      final response = await http.get(uri).timeout(Duration(milliseconds: timeoutMs));
      sw.stop();
      final latency = sw.elapsedMilliseconds;

      final isExpected = (response.statusCode == expectedStatus) ||
          (expectedStatus == 200 && response.statusCode >= 200 && response.statusCode < 400);

      if (isExpected) {
        return ProbeResult.online(latency, 'HTTP ${response.statusCode} OK (${latency}ms)');
      } else {
        return ProbeResult(
          status: ProbeStatus.degraded,
          latencyMs: latency,
          message: 'HTTP ${response.statusCode} (ESPERADO $expectedStatus)',
        );
      }
    } on TimeoutException {
      sw.stop();
      return ProbeResult.offline('HTTP TIMEOUT (> ${timeoutMs}ms)');
    } on SocketException catch (e) {
      sw.stop();
      return ProbeResult.offline('HOST INALCANZABLE: ${e.osError?.message ?? e.message}');
    } catch (e) {
      sw.stop();
      return ProbeResult.offline('ERROR HTTP: $e');
    }
  }

  /// UDP Datagram probe
  /// For port 53 (DNS), sends a lightweight DNS query for 'google.com' (A record).
  /// For other ports, sends a small heartbeat datagram.
  static Future<ProbeResult> _probeUdp(String host, int port, int timeoutMs) async {
    final sw = Stopwatch()..start();
    RawDatagramSocket? socket;
    try {
      final cleanHost = host.trim().replaceAll(RegExp(r'^https?://'), '').split('/')[0].split(':')[0];
      final addresses = await InternetAddress.lookup(cleanHost);
      if (addresses.isEmpty) {
        return ProbeResult.offline('DNS LOOKUP FALLIDO');
      }
      final targetAddress = addresses.first;

      socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);

      List<int> packet;
      if (port == 53) {
        // Standard DNS query header + question for 'google.com'
        packet = [
          0xAA, 0xBB, // ID
          0x01, 0x00, // Flags (recursion desired)
          0x00, 0x01, // QDCOUNT = 1
          0x00, 0x00, // ANCOUNT = 0
          0x00, 0x00, // NSCOUNT = 0
          0x00, 0x00, // ARCOUNT = 0
          // 6 'google' 3 'com' 0
          0x06, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65,
          0x03, 0x63, 0x6f, 0x6d, 0x00,
          0x00, 0x01, // QTYPE = A
          0x00, 0x01, // QCLASS = IN
        ];
      } else {
        // Echo / Heartbeat ping packet
        packet = [0x50, 0x49, 0x4e, 0x47, 0x00];
      }

      final completer = Completer<ProbeResult>();
      Timer? timer;

      socket.listen((event) {
        if (event == RawSocketEvent.read) {
          final datagram = socket?.receive();
          if (datagram != null && !completer.isCompleted) {
            sw.stop();
            timer?.cancel();
            final latency = sw.elapsedMilliseconds;
            completer.complete(ProbeResult.online(latency, 'UDP PORT $port RESPUESTA (${latency}ms)'));
          }
        }
      });

      socket.send(packet, targetAddress, port);

      timer = Timer(Duration(milliseconds: timeoutMs), () {
        if (!completer.isCompleted) {
          sw.stop();
          // For non-DNS UDP (where remote servers often don't reply directly due to firewall),
          // if packet was dispatched to reachable host, we mark as host reachable
          if (port != 53 && sw.elapsedMilliseconds < timeoutMs) {
            completer.complete(ProbeResult.online(sw.elapsedMilliseconds, 'UDP DATAGRAM ENVIADO'));
          } else {
            completer.complete(ProbeResult.offline('UDP SIN RESPUESTA (> ${timeoutMs}ms)'));
          }
        }
      });

      final result = await completer.future;
      return result;
    } on SocketException catch (e) {
      sw.stop();
      return ProbeResult.offline('ERROR UDP: ${e.message}');
    } catch (e) {
      sw.stop();
      return ProbeResult.offline('FALLO UDP: $e');
    } finally {
      socket?.close();
    }
  }
}

