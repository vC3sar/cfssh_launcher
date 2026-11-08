import 'dart:convert';
import 'package:intl/intl.dart';

enum ProbeProtocol {
  tcp,
  http,
  udp;

  String get displayName => name.toUpperCase();
}

enum ProbeStatus {
  online,
  degraded,
  offline,
  probing,
  unknown;

  String get label {
    switch (this) {
      case ProbeStatus.online:
        return 'ONLINE';
      case ProbeStatus.degraded:
        return 'DEGRADADO';
      case ProbeStatus.offline:
        return 'OFFLINE';
      case ProbeStatus.probing:
        return 'SONDEANDO';
      case ProbeStatus.unknown:
        return 'EN ESPERA';
    }
  }
}

class HealthTargetModel {
  final String id;
  final String name;
  final ProbeProtocol protocol;
  final String host;
  final int port;
  final String path;
  final int expectedStatusCode;
  final int timeoutMs;
  final bool isEnabled;
  final ProbeStatus status;
  final int? lastLatencyMs;
  final List<int> latencyHistory;
  final DateTime? lastChecked;
  final String? statusMessage;
  final int successCount;
  final int failCount;

  const HealthTargetModel({
    required this.id,
    required this.name,
    required this.protocol,
    required this.host,
    this.port = 80,
    this.path = '/',
    this.expectedStatusCode = 200,
    this.timeoutMs = 2500,
    this.isEnabled = true,
    this.status = ProbeStatus.unknown,
    this.lastLatencyMs,
    this.latencyHistory = const [],
    this.lastChecked,
    this.statusMessage,
    this.successCount = 0,
    this.failCount = 0,
  });

  String get endpointLabel {
    switch (protocol) {
      case ProbeProtocol.http:
        final prefix = port == 443 ? 'https://' : 'http://';
        final portSuffix = (port == 80 || port == 443) ? '' : ':$port';
        final cleanPath = path.startsWith('/') ? path : '/$path';
        return '$prefix$host$portSuffix$cleanPath';
      case ProbeProtocol.tcp:
        return '$host:$port (TCP)';
      case ProbeProtocol.udp:
        return '$host:$port (UDP)';
    }
  }

  double get uptimePercentage {
    final total = successCount + failCount;
    if (total == 0) return 100.0;
    return (successCount / total) * 100.0;
  }

  String get formattedLastChecked {
    if (lastChecked == null) return '--:--:--';
    return DateFormat('HH:mm:ss').format(lastChecked!);
  }

  String get relativeLastChecked {
    if (lastChecked == null) return 'PENDIENTE';
    final diff = DateTime.now().difference(lastChecked!);
    if (diff.inSeconds < 5) return 'AHORA MISMO';
    if (diff.inSeconds < 60) return 'HACE ${diff.inSeconds}s';
    if (diff.inMinutes < 60) return 'HACE ${diff.inMinutes}m';
    return DateFormat('HH:mm').format(lastChecked!);
  }

  HealthTargetModel copyWith({
    String? name,
    ProbeProtocol? protocol,
    String? host,
    int? port,
    String? path,
    int? expectedStatusCode,
    int? timeoutMs,
    bool? isEnabled,
    ProbeStatus? status,
    int? lastLatencyMs,
    List<int>? latencyHistory,
    DateTime? lastChecked,
    String? statusMessage,
    int? successCount,
    int? failCount,
  }) {
    return HealthTargetModel(
      id: id,
      name: name ?? this.name,
      protocol: protocol ?? this.protocol,
      host: host ?? this.host,
      port: port ?? this.port,
      path: path ?? this.path,
      expectedStatusCode: expectedStatusCode ?? this.expectedStatusCode,
      timeoutMs: timeoutMs ?? this.timeoutMs,
      isEnabled: isEnabled ?? this.isEnabled,
      status: status ?? this.status,
      lastLatencyMs: lastLatencyMs ?? this.lastLatencyMs,
      latencyHistory: latencyHistory ?? this.latencyHistory,
      lastChecked: lastChecked ?? this.lastChecked,
      statusMessage: statusMessage ?? this.statusMessage,
      successCount: successCount ?? this.successCount,
      failCount: failCount ?? this.failCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'protocol': protocol.name,
      'host': host,
      'port': port,
      'path': path,
      'expectedStatusCode': expectedStatusCode,
      'timeoutMs': timeoutMs,
      'isEnabled': isEnabled,
      'successCount': successCount,
      'failCount': failCount,
      'lastLatencyMs': lastLatencyMs,
      'lastChecked': lastChecked?.toIso8601String(),
      'statusMessage': statusMessage,
    };
  }

  factory HealthTargetModel.fromMap(Map<String, dynamic> map) {
    ProbeProtocol proto = ProbeProtocol.tcp;
    final protoStr = (map['protocol'] as String?)?.toLowerCase();
    if (protoStr == 'http') proto = ProbeProtocol.http;
    if (protoStr == 'udp') proto = ProbeProtocol.udp;

    DateTime? checked;
    if (map['lastChecked'] is String) {
      checked = DateTime.tryParse(map['lastChecked'] as String);
    }

    return HealthTargetModel(
      id: map['id'] as String? ?? 'tgt_${DateTime.now().millisecondsSinceEpoch}',
      name: map['name'] as String? ?? 'Endpoint',
      protocol: proto,
      host: map['host'] as String? ?? '127.0.0.1',
      port: (map['port'] as num?)?.toInt() ?? 80,
      path: map['path'] as String? ?? '/',
      expectedStatusCode: (map['expectedStatusCode'] as num?)?.toInt() ?? 200,
      timeoutMs: (map['timeoutMs'] as num?)?.toInt() ?? 2500,
      isEnabled: map['isEnabled'] as bool? ?? true,
      successCount: (map['successCount'] as num?)?.toInt() ?? 0,
      failCount: (map['failCount'] as num?)?.toInt() ?? 0,
      lastLatencyMs: (map['lastLatencyMs'] as num?)?.toInt(),
      lastChecked: checked,
      statusMessage: map['statusMessage'] as String?,
    );
  }

  String toJson() => jsonEncode(toMap());
  factory HealthTargetModel.fromJson(String source) =>
      HealthTargetModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}

