import 'dart:async';
import 'dart:io';

class DiscoveredCamera {
  final String ip;
  final int port;
  final int latencyMs;
  final String label;

  const DiscoveredCamera({
    required this.ip,
    required this.port,
    required this.latencyMs,
    required this.label,
  });
}

class CameraScannerService {
  /// Extracts the base subnet prefix from an IPv4 string (e.g. "192.168.1.45" -> "192.168.1")
  static String extractSubnet(String ip) {
    final parts = ip.trim().split('.');
    if (parts.length == 4) {
      return '${parts[0]}.${parts[1]}.${parts[2]}';
    }
    return '192.168.1';
  }

  /// Quickly tests if a specific IP & port accepts TCP connections.
  /// Returns the latency in milliseconds or -1 if unreachable.
  static Future<int> testConnection(String ip, int port, {Duration timeout = const Duration(milliseconds: 700)}) async {
    final sw = Stopwatch()..start();
    try {
      final socket = await Socket.connect(ip.trim(), port, timeout: timeout);
      sw.stop();
      socket.destroy();
      return sw.elapsedMilliseconds;
    } catch (_) {
      return -1;
    }
  }

  /// Scans a local subnet (e.g. "192.168.1") on target ports (default RTSP 554)
  /// using non-blocking concurrent batch processing.
  static Stream<({double progress, DiscoveredCamera? found, String status})> scanSubnet({
    required String subnet,
    int port = 554,
    int batchSize = 25,
    Duration timeout = const Duration(milliseconds: 380),
  }) async* {
    final cleanSubnet = subnet.trim().replaceAll(RegExp(r'\.+$'), '');
    const int totalIps = 254;

    int tested = 0;

    for (int start = 1; start <= totalIps; start += batchSize) {
      final end = (start + batchSize - 1).clamp(1, totalIps);
      final futures = <Future<DiscoveredCamera?>>[];

      for (int i = start; i <= end; i++) {
        final targetIp = '$cleanSubnet.$i';
        futures.add(_probeIp(targetIp, port, timeout));
      }

      final results = await Future.wait(futures);
      tested += (end - start + 1);
      final progress = (tested / totalIps).clamp(0.0, 1.0);

      for (final camera in results) {
        if (camera != null) {
          yield (progress: progress, found: camera, status: 'CÁMARA DETECTADA EN ${camera.ip}:$port (${camera.latencyMs}ms)');
        }
      }

      yield (progress: progress, found: null, status: 'SONDEANDO $cleanSubnet.$start-$end (PUERTO $port)...');
    }

    yield (progress: 1.0, found: null, status: 'ESCÁNEO DE SUBRED FINALIZADO');
  }

  static Future<DiscoveredCamera?> _probeIp(String ip, int port, Duration timeout) async {
    final sw = Stopwatch()..start();
    try {
      final socket = await Socket.connect(ip, port, timeout: timeout);
      sw.stop();
      socket.destroy();
      return DiscoveredCamera(
        ip: ip,
        port: port,
        latencyMs: sw.elapsedMilliseconds,
        label: 'ENDPOINT RTSP ENCONTRADO',
      );
    } catch (_) {
      return null;
    }
  }
}

