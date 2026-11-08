import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../models/rtsp_camera_model.dart';
import '../providers/cameras_provider.dart';
import '../services/camera_scanner_service.dart';

class CameraModalDialog extends ConsumerStatefulWidget {
  final RtspCameraModel? camera;
  final String? initialIp;
  final int? initialPort;

  const CameraModalDialog({
    super.key,
    this.camera,
    this.initialIp,
    this.initialPort,
  });

  @override
  ConsumerState<CameraModalDialog> createState() => _CameraModalDialogState();
}

class _CameraModalDialogState extends ConsumerState<CameraModalDialog> {
  late TextEditingController _nameController;
  late TextEditingController _urlController;
  late TextEditingController _userController;
  late TextEditingController _passwordController;
  late TextEditingController _ipController;
  late TextEditingController _portController;
  late TextEditingController _pathController;

  bool _isManualUrlMode = false;
  bool _obscurePassword = true;
  bool _isTesting = false;
  String? _testResult;
  bool _testSuccess = false;

  static const List<({String brand, String path, String desc})> _templates = [
    (brand: 'Dahua Substream (Fluido)', path: '/live/ch00_1', desc: 'Substream ligero recomendado'),
    (brand: 'Dahua Main', path: '/live/ch00_0', desc: 'Canal 1 Main Stream HD'),
    (brand: 'Dahua Realmonitor Sub', path: '/cam/realmonitor?channel=1&subtype=1', desc: 'Substream ligero Dahua'),
    (brand: 'Hikvision Substream', path: '/Streaming/Channels/102', desc: 'Canal 102 Substream ligero'),
    (brand: 'Hikvision Main', path: '/Streaming/Channels/101', desc: 'Canal 101 H.264 Main'),
    (brand: 'Reolink Substream', path: '/h264Preview_01_sub', desc: 'Substream ligero fluido'),
    (brand: 'Tapo / TP-Link', path: '/stream2', desc: 'Canal Fluido Stream 2'),
    (brand: 'ONVIF Genérico', path: '/onvif1', desc: 'Perfil S Estándar'),
  ];

  @override
  void initState() {
    super.initState();
    final cam = widget.camera;
    if (cam != null) {
      _nameController = TextEditingController(text: cam.name);
      _urlController = TextEditingController(text: cam.url);
      _userController = TextEditingController(text: cam.user);
      _passwordController = TextEditingController(text: cam.password);
      _ipController = TextEditingController(text: cam.ip);
      _portController = TextEditingController(text: cam.port.toString());
      _pathController = TextEditingController(text: cam.path);
    } else {
      _nameController = TextEditingController(text: 'Cámara 01 · Entrada');
      _urlController = TextEditingController(
        text:
            'rtsp://admin:admin123@${widget.initialIp ?? "192.168.1.176"}:${widget.initialPort ?? 554}/live/ch00_0',
      );
      _userController = TextEditingController(text: 'admin');
      _passwordController = TextEditingController(text: 'admin123');
      _ipController =
          TextEditingController(text: widget.initialIp ?? '192.168.1.176');
      _portController =
          TextEditingController(text: (widget.initialPort ?? 554).toString());
      _pathController = TextEditingController(text: '/live/ch00_0');
    }

    _userController.addListener(_syncFromModularFields);
    _passwordController.addListener(_syncFromModularFields);
    _ipController.addListener(_syncFromModularFields);
    _portController.addListener(_syncFromModularFields);
    _pathController.addListener(_syncFromModularFields);
  }

  void _syncFromModularFields() {
    if (_isManualUrlMode) return;
    final user = _userController.text;
    final pass = _passwordController.text;
    final ip = _ipController.text;
    final port = int.tryParse(_portController.text) ?? 554;
    final path = _pathController.text;
    final built = RtspCameraModel.buildUrl(
      user: user,
      password: pass,
      ip: ip,
      port: port,
      path: path,
    );
    if (_urlController.text != built) {
      _urlController.text = built;
    }
  }

  void _syncFromFullUrl() {
    final parsed = RtspCameraModel.parseUrl(_urlController.text);
    _userController.text = parsed.user;
    _passwordController.text = parsed.password;
    _ipController.text = parsed.ip;
    _portController.text = parsed.port.toString();
    _pathController.text = parsed.path;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    _ipController.dispose();
    _portController.dispose();
    _pathController.dispose();
    super.dispose();
  }

  Future<void> _testConnection() async {
    final ip = _ipController.text.trim();
    final port = int.tryParse(_portController.text.trim()) ?? 554;

    if (ip.isEmpty) {
      setState(() {
        _testResult = 'Ingresa una dirección IP o host válido';
        _testSuccess = false;
      });
      return;
    }

    setState(() {
      _isTesting = true;
      _testResult = 'Sondeando puerto RTSP ($ip:$port)...';
    });

    final latency = await CameraScannerService.testConnection(ip, port);

    if (mounted) {
      setState(() {
        _isTesting = false;
        if (latency >= 0) {
          _testSuccess = true;
          _testResult = 'Conexión TCP exitosa · Latencia: ${latency}ms';
        } else {
          _testSuccess = false;
          _testResult =
              'Sin respuesta en $ip:$port · Verifica que la cámara esté encendida';
        }
      });
    }
  }

  void _saveCamera() {
    final name = _nameController.text.trim().isNotEmpty
        ? _nameController.text.trim()
        : 'Cámara RTSP';
    final url = _urlController.text.trim();
    final user = _userController.text.trim();
    final pass = _passwordController.text.trim();
    final ip = _ipController.text.trim();
    final port = int.tryParse(_portController.text.trim()) ?? 554;
    final path = _pathController.text.trim();

    if (url.isEmpty || ip.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completa los datos de la cámara RTSP'),
        ),
      );
      return;
    }

    final newCam = RtspCameraModel(
      id: widget.camera?.id ?? 'cam_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      url: url,
      user: user,
      password: pass,
      ip: ip,
      port: port,
      path: path.startsWith('/') ? path : '/$path',
      isMuted: widget.camera?.isMuted ?? true,
    );

    if (widget.camera != null) {
      ref.read(camerasProvider.notifier).updateCamera(newCam);
    } else {
      ref.read(camerasProvider.notifier).addCamera(newCam);
      ref.read(activeCameraIdProvider.notifier).selectCamera(newCam.id);
    }

    ref.read(cyberdeckConfigProvider.notifier).logAction(
          'SURV',
          widget.camera != null
              ? 'Cámara actualizada -> $name'
              : 'Nueva cámara registrada -> $name',
        );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(cyberdeckConfigProvider);
    final accent = config.primaryAccent;
    final secondary = config.secondaryAccent;

    return Dialog(
      backgroundColor: config.panelColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: config.borderColor),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 620, maxHeight: 720),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.videocam_rounded,
                      size: 18,
                      color: accent,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.camera != null
                          ? 'Editar Cámara RTSP'
                          : 'Vincular Nueva Cámara RTSP',
                      style: AppTheme.mono(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: config.textPrimaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: config.textSecondaryColor,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Divider(color: config.borderColor, height: 22),

              // Camera Tag / Name
              Text(
                'Nombre de la Cámara',
                style: AppTheme.mono(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: config.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _nameController,
                style: AppTheme.mono(
                  fontSize: 12.5,
                  color: config.textPrimaryColor,
                ),
                decoration: _buildInputDecoration(
                  config,
                  'Ej: Cámara Entrada Principal',
                  accent,
                ),
              ),
              const SizedBox(height: 14),

              // Mode Selector Tabs
              Row(
                children: [
                  Expanded(
                    child: CyberTapTarget(
                      onTap: () {
                        setState(() {
                          _isManualUrlMode = false;
                          _syncFromModularFields();
                        });
                      },
                      pressColor: accent,
                      fillWidth: true,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        decoration: BoxDecoration(
                          color: !_isManualUrlMode
                              ? accent.withValues(alpha: 0.16)
                              : config.surfaceSecondaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: !_isManualUrlMode
                                ? accent
                                : config.borderColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Constructor Modular',
                            style: AppTheme.mono(
                              fontSize: 12,
                              fontWeight: !_isManualUrlMode
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: !_isManualUrlMode
                                  ? accent
                                  : config.textPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CyberTapTarget(
                      onTap: () {
                        setState(() {
                          _isManualUrlMode = true;
                          _syncFromFullUrl();
                        });
                      },
                      pressColor: secondary,
                      fillWidth: true,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        decoration: BoxDecoration(
                          color: _isManualUrlMode
                              ? secondary.withValues(alpha: 0.16)
                              : config.surfaceSecondaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _isManualUrlMode
                                ? secondary
                                : config.borderColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'URL Directa Completa',
                            style: AppTheme.mono(
                              fontSize: 12,
                              fontWeight: _isManualUrlMode
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: _isManualUrlMode
                                  ? secondary
                                  : config.textPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              if (!_isManualUrlMode) ...[
                // Modular Builder: User, Password, IP, Port, Path
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usuario (RTSP)',
                            style: AppTheme.mono(
                              fontSize: 11.5,
                              color: config.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _userController,
                            style: AppTheme.mono(
                              fontSize: 12.5,
                              color: config.textPrimaryColor,
                            ),
                            decoration: _buildInputDecoration(
                              config,
                              'admin',
                              accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contraseña',
                            style: AppTheme.mono(
                              fontSize: 11.5,
                              color: config.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: AppTheme.mono(
                              fontSize: 12.5,
                              color: config.textPrimaryColor,
                            ),
                            decoration: _buildInputDecoration(
                              config,
                              'admin123',
                              accent,
                            ).copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 17,
                                  color: config.textSecondaryColor,
                                ),
                                onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dirección IP / Host',
                            style: AppTheme.mono(
                              fontSize: 11.5,
                              color: config.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _ipController,
                            style: AppTheme.codeMono(
                              fontSize: 12.5,
                              color: config.textPrimaryColor,
                            ),
                            decoration: _buildInputDecoration(
                              config,
                              '192.168.1.176',
                              accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Puerto',
                            style: AppTheme.mono(
                              fontSize: 11.5,
                              color: config.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _portController,
                            keyboardType: TextInputType.number,
                            style: AppTheme.codeMono(
                              fontSize: 12.5,
                              color: config.textPrimaryColor,
                            ),
                            decoration: _buildInputDecoration(
                              config,
                              '554',
                              accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Canal / Ruta de Stream',
                  style: AppTheme.mono(
                    fontSize: 11.5,
                    color: config.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _pathController,
                  style: AppTheme.codeMono(
                    fontSize: 12.5,
                    color: config.textPrimaryColor,
                  ),
                  decoration: _buildInputDecoration(
                    config,
                    '/live/ch00_0',
                    accent,
                  ),
                ),
                const SizedBox(height: 10),

                // Quick Brand Path Templates
                Text(
                  'Plantillas rápidas por fabricante:',
                  style: AppTheme.mono(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: config.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: _templates.map((tpl) {
                    return InkWell(
                      onTap: () {
                        _pathController.text = tpl.path;
                        _syncFromModularFields();
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: config.surfaceSecondaryColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: config.borderColor),
                        ),
                        child: Text(
                          '${tpl.brand} · ${tpl.path}',
                          style: AppTheme.codeMono(
                            fontSize: 10,
                            color: secondary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ] else ...[
                // Manual URL Input
                Text(
                  'URL RTSP Completa',
                  style: AppTheme.mono(
                    fontSize: 11.5,
                    color: config.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _urlController,
                  maxLines: 2,
                  style: AppTheme.codeMono(
                    fontSize: 12,
                    color: config.textPrimaryColor,
                  ),
                  decoration: _buildInputDecoration(
                    config,
                    'rtsp://admin:admin123@192.168.1.176:554/live/ch00_0',
                    secondary,
                  ),
                  onChanged: (_) => _syncFromFullUrl(),
                ),
              ],

              const SizedBox(height: 14),

              // Live URL Preview Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: config.surfaceSecondaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: config.borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Previsualización de enlace RTSP:',
                      style: AppTheme.mono(
                        fontSize: 10.5,
                        color: config.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SelectableText(
                      _urlController.text,
                      style: AppTheme.codeMono(
                        fontSize: 11.5,
                        color: accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Test Connection Status
              if (_testResult != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _testSuccess
                        ? AppTheme.phosphorGreen.withValues(alpha: 0.14)
                        : AppTheme.error.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _testSuccess
                          ? AppTheme.phosphorGreen
                          : AppTheme.error,
                    ),
                  ),
                  child: Text(
                    _testResult!,
                    style: AppTheme.mono(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: _testSuccess
                          ? AppTheme.phosphorGreen
                          : AppTheme.error,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(48, 44),
                        side: BorderSide(color: secondary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _isTesting ? null : _testConnection,
                      icon: _isTesting
                          ? SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: secondary,
                              ),
                            )
                          : Icon(
                              Icons.network_check_rounded,
                              size: 16,
                              color: secondary,
                            ),
                      label: Text(
                        'Probar Conexión',
                        style: AppTheme.mono(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: secondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(48, 44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _saveCamera,
                      icon: const Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                      label: Text(
                        widget.camera != null
                            ? 'Actualizar Cámara'
                            : 'Guardar Cámara',
                        style: AppTheme.mono(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(
    CyberdeckConfig config,
    String hint,
    Color accentColor,
  ) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTheme.mono(
        fontSize: 11.5,
        color: config.textSecondaryColor.withValues(alpha: 0.7),
      ),
      filled: true,
      fillColor: config.surfaceSecondaryColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: config.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: accentColor, width: 1.5),
      ),
    );
  }
}
