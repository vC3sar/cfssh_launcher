class RtspCameraModel {
  final String id;
  final String name;
  final String url;
  final String user;
  final String password;
  final String ip;
  final int port;
  final String path;
  final bool isMuted;

  const RtspCameraModel({
    required this.id,
    required this.name,
    required this.url,
    this.user = 'admin',
    this.password = '',
    this.ip = '192.168.1.176',
    this.port = 554,
    this.path = '/live/ch00_0',
    this.isMuted = true,
  });

  /// Builds a standard RTSP URL string:
  /// rtsp://user:password@ip:port/path
  static String buildUrl({
    required String user,
    required String password,
    required String ip,
    required int port,
    required String path,
  }) {
    final cleanIp = ip.trim().replaceAll('http://', '').replaceAll('rtsp://', '').replaceAll('/', '');
    final cleanPath = path.trim().startsWith('/') ? path.trim() : '/${path.trim()}';
    
    if (user.trim().isEmpty && password.trim().isEmpty) {
      return 'rtsp://$cleanIp:$port$cleanPath';
    } else if (password.trim().isEmpty) {
      return 'rtsp://${user.trim()}@$cleanIp:$port$cleanPath';
    } else {
      return 'rtsp://${user.trim()}:${password.trim()}@$cleanIp:$port$cleanPath';
    }
  }

  /// Parses an existing RTSP URL into components
  static ({String user, String password, String ip, int port, String path}) parseUrl(String fullUrl) {
    try {
      final uri = Uri.parse(fullUrl.trim());
      String user = '';
      String password = '';
      if (uri.userInfo.isNotEmpty) {
        final parts = uri.userInfo.split(':');
        user = parts[0];
        if (parts.length > 1) {
          password = parts.sublist(1).join(':');
        }
      }
      final ip = uri.host.isNotEmpty ? uri.host : '192.168.1.176';
      final port = uri.port > 0 ? uri.port : 554;
      final path = uri.path.isNotEmpty ? uri.path : '/live/ch00_0';
      return (user: user, password: password, ip: ip, port: port, path: path);
    } catch (_) {
      return (user: 'admin', password: '', ip: '192.168.1.176', port: 554, path: '/live/ch00_0');
    }
  }

  /// Returns masked URL for security in HUD (hides password)
  String get maskedUrl {
    try {
      final parsed = parseUrl(url);
      if (parsed.user.isEmpty) {
        return 'rtsp://${parsed.ip}:${parsed.port}${parsed.path}';
      }
      final passMask = parsed.password.isNotEmpty ? '••••' : '';
      final auth = passMask.isNotEmpty ? '${parsed.user}:$passMask@' : '${parsed.user}@';
      return 'rtsp://$auth${parsed.ip}:${parsed.port}${parsed.path}';
    } catch (_) {
      return url;
    }
  }

  RtspCameraModel copyWith({
    String? id,
    String? name,
    String? url,
    String? user,
    String? password,
    String? ip,
    int? port,
    String? path,
    bool? isMuted,
  }) {
    return RtspCameraModel(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      user: user ?? this.user,
      password: password ?? this.password,
      ip: ip ?? this.ip,
      port: port ?? this.port,
      path: path ?? this.path,
      isMuted: isMuted ?? this.isMuted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'user': user,
      'password': password,
      'ip': ip,
      'port': port,
      'path': path,
      'isMuted': isMuted,
    };
  }

  factory RtspCameraModel.fromMap(Map<String, dynamic> map) {
    return RtspCameraModel(
      id: map['id'] as String? ?? 'cam_${DateTime.now().millisecondsSinceEpoch}',
      name: map['name'] as String? ?? 'CÁMARA RTSP',
      url: map['url'] as String? ?? 'rtsp://admin:admin123@192.168.1.176:554/live/ch00_0',
      user: map['user'] as String? ?? 'admin',
      password: map['password'] as String? ?? '',
      ip: map['ip'] as String? ?? '192.168.1.176',
      port: (map['port'] as num?)?.toInt() ?? 554,
      path: map['path'] as String? ?? '/live/ch00_0',
      isMuted: (map['isMuted'] as bool?) ?? true,
    );
  }
}

