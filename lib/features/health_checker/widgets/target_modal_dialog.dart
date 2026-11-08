import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../models/health_target_model.dart';
import '../providers/health_checker_provider.dart';
import '../services/probe_service.dart';

class TargetModalDialog extends ConsumerStatefulWidget {
  final HealthTargetModel? target;

  const TargetModalDialog({super.key, this.target});

  @override
  ConsumerState<TargetModalDialog> createState() => _TargetModalDialogState();
}

class _TargetModalDialogState extends ConsumerState<TargetModalDialog> {
  late TextEditingController _nameController;
  late TextEditingController _hostController;
  late TextEditingController _portController;
  late TextEditingController _pathController;
  late TextEditingController _expectedCodeController;
  late TextEditingController _timeoutController;
  late ProbeProtocol _selectedProtocol;

  bool _isTesting = false;
  ProbeResult? _testResult;

  static const List<
      ({
        String name,
        String host,
        int port,
        ProbeProtocol proto,
        String path,
      })> _presets = [
    (
      name: 'Gateway Local',
      host: '192.168.1.1',
      port: 80,
      proto: ProbeProtocol.tcp,
      path: '/',
    ),
    (
      name: 'Cloudflare DNS',
      host: '1.1.1.1',
      port: 53,
      proto: ProbeProtocol.udp,
      path: '/',
    ),
    (
      name: 'Google HTTPS',
      host: 'https://www.google.com',
      port: 443,
      proto: ProbeProtocol.http,
      path: '/',
    ),
    (
      name: 'Servidor SSH',
      host: '192.168.1.100',
      port: 22,
      proto: ProbeProtocol.tcp,
      path: '/',
    ),
    (
      name: 'Cámara RTSP',
      host: '192.168.1.176',
      port: 554,
      proto: ProbeProtocol.tcp,
      path: '/',
    ),
  ];

  @override
  void initState() {
    super.initState();
    final t = widget.target;
    _nameController = TextEditingController(text: t?.name ?? '');
    _hostController = TextEditingController(text: t?.host ?? '');
    _portController = TextEditingController(text: (t?.port ?? 443).toString());
    _pathController = TextEditingController(text: t?.httpPath ?? '/');
    _expectedCodeController =
        TextEditingController(text: (t?.expectedStatusCode ?? 200).toString());
    _timeoutController =
        TextEditingController(text: (t?.timeoutMs ?? 2500).toString());
    _selectedProtocol = t?.protocol ?? ProbeProtocol.tcp;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _hostController.dispose();
    _portController.dispose();
    _pathController.dispose();
    _expectedCodeController.dispose();
    _timeoutController.dispose();
    super.dispose();
  }

  void _applyPreset(
    ({
      String name,
      String host,
      int port,
      ProbeProtocol proto,
      String path,
    }) preset,
  ) {
    setState(() {
      _nameController.text = preset.name;
      _hostController.text = preset.host;
      _portController.text = preset.port.toString();
      _selectedProtocol = preset.proto;
      _pathController.text = preset.path;
      _testResult = null;
    });
  }

  HealthTargetModel _buildModel() {
    final name = _nameController.text.trim().isEmpty
        ? 'Endpoint ${_selectedProtocol.displayName}'
        : _nameController.text.trim();
    final host = _hostController.text.trim().isEmpty
        ? '127.0.0.1'
        : _hostController.text.trim();
    final port = int.tryParse(_portController.text.trim()) ??
        (_selectedProtocol == ProbeProtocol.udp ? 53 : 80);
    final path = _pathController.text.trim().isEmpty
        ? '/'
        : _pathController.text.trim();
    final expected = int.tryParse(_expectedCodeController.text.trim()) ?? 200;
    final timeout =
        (int.tryParse(_timeoutController.text.trim()) ?? 2500).clamp(500, 10000);

    return HealthTargetModel(
      id: widget.target?.id ??
          'probe_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      host: host,
      port: port,
      protocol: _selectedProtocol,
      httpPath: path,
      expectedStatusCode: expected,
      timeoutMs: timeout,
      isEnabled: widget.target?.isEnabled ?? true,
    );
  }

  Future<void> _runConnectionTest() async {
    setState(() {
      _isTesting = true;
      _testResult = null;
    });

    final tempTarget = _buildModel();
    final res = await HealthProbeService.probe(tempTarget);

    if (mounted) {
      setState(() {
        _isTesting = false;
        _testResult = res;
      });
    }
  }

  void _saveTarget() {
    if (_hostController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa una IP, dominio o URL válida')),
      );
      return;
    }

    final model = _buildModel();
    if (widget.target != null) {
      ref.read(healthTargetsProvider.notifier).updateTarget(model);
      ref.read(cyberdeckConfigProvider.notifier).logAction(
            'HEALTH',
            'Endpoint actualizado -> ${model.name} (${model.protocol.displayName})',
          );
    } else {
      ref.read(healthTargetsProvider.notifier).addTarget(model);
      ref.read(cyberdeckConfigProvider.notifier).logAction(
            'HEALTH',
            'Endpoint registrado -> ${model.name} (${model.protocol.displayName})',
          );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(cyberdeckConfigProvider);
    final sentinelBrand = config.sentinelAccent;

    return Dialog(
      backgroundColor: config.panelColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: config.borderColor),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 540),
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
                      color: sentinelBrand.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.monitor_heart_rounded,
                      size: 18,
                      color: sentinelBrand,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.target != null
                          ? 'Editar Endpoint de Sentinel'
                          : 'Registrar Nuevo Endpoint en Sentinel',
                      style: AppTheme.mono(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: config.textPrimaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: config.textSecondaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Presets selector
              Text(
                'PLANTILLAS RÁPIDAS',
                style: AppTheme.codeMono(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: config.textSecondaryColor,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _presets.map((p) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 4),
                      child: CyberTapTarget(
                        onTap: () => _applyPreset(p),
                        pressColor: sentinelBrand,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: config.surfaceSecondaryColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: config.borderColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildProtocolBadge(p.proto),
                              const SizedBox(width: 6),
                              Text(
                                p.name,
                                style: AppTheme.mono(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                  color: config.textPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 14),

              // Protocol Selector
              Text(
                'PROTOCOLO DE MONITOREO',
                style: AppTheme.codeMono(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: config.textSecondaryColor,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: ProbeProtocol.values.map((proto) {
                  final isSelected = proto == _selectedProtocol;
                  final protoColor = _getProtocolColor(proto);
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: CyberTapTarget(
                        onTap: () {
                          setState(() {
                            _selectedProtocol = proto;
                            if (proto == ProbeProtocol.udp &&
                                _portController.text == '80') {
                              _portController.text = '53';
                            } else if (proto == ProbeProtocol.tcp &&
                                _portController.text == '53') {
                              _portController.text = '443';
                            }
                            _testResult = null;
                          });
                        },
                        pressColor: protoColor,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? protoColor.withValues(alpha: 0.16)
                                : config.surfaceSecondaryColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? protoColor
                                  : config.borderColor,
                              width: isSelected ? 1.5 : 1.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              proto.displayName,
                              style: AppTheme.codeMono(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? protoColor
                                    : config.textPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 14),

              // Target Name
              _buildTextField(
                config: config,
                controller: _nameController,
                label: 'Nombre Identificador',
                hint: 'Ej: Router Principal / Servidor SSH / API',
                accent: sentinelBrand,
              ),
              const SizedBox(height: 12),

              // Host & Port
              Row(
                children: [
                  Expanded(
                    flex: 70,
                    child: _buildTextField(
                      config: config,
                      controller: _hostController,
                      label: 'Host / IP / Dominio',
                      hint: 'Ej: 192.168.1.1 o api.dominio.com',
                      accent: sentinelBrand,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 30,
                    child: _buildTextField(
                      config: config,
                      controller: _portController,
                      label: 'Puerto',
                      hint: '80 / 443 / 554',
                      accent: sentinelBrand,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // HTTP specific fields
              if (_selectedProtocol == ProbeProtocol.http) ...[
                Row(
                  children: [
                    Expanded(
                      flex: 65,
                      child: _buildTextField(
                        config: config,
                        controller: _pathController,
                        label: 'Ruta HTTP (Path)',
                        hint: '/ o /health',
                        accent: sentinelBrand,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 35,
                      child: _buildTextField(
                        config: config,
                        controller: _expectedCodeController,
                        label: 'Código HTTP',
                        hint: '200',
                        accent: sentinelBrand,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],

              // Timeout
              _buildTextField(
                config: config,
                controller: _timeoutController,
                label: 'Tiempo máximo de espera (ms)',
                hint: '2500',
                accent: sentinelBrand,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 14),

              // Live Connectivity Test Button & Result
              Row(
                children: [
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppTheme.sentinelProbing.withValues(alpha: 0.6),
                      ),
                      foregroundColor: AppTheme.sentinelProbing,
                      minimumSize: const Size(170, 42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _isTesting ? null : _runConnectionTest,
                    icon: _isTesting
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppTheme.sentinelProbing,
                            ),
                          )
                        : const Icon(
                            Icons.bolt_rounded,
                            size: 16,
                            color: AppTheme.sentinelProbing,
                          ),
                    label: Text(
                      _isTesting ? 'Probando...' : 'Probar Conexión',
                      style: AppTheme.mono(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.sentinelProbing,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (_testResult != null)
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _testResult!.status == ProbeStatus.online
                              ? AppTheme.sentinelOnline.withValues(alpha: 0.14)
                              : _testResult!.status == ProbeStatus.degraded
                                  ? AppTheme.sentinelDegraded
                                      .withValues(alpha: 0.14)
                                  : AppTheme.sentinelOffline
                                      .withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _testResult!.status == ProbeStatus.online
                                ? AppTheme.sentinelOnline
                                : _testResult!.status == ProbeStatus.degraded
                                    ? AppTheme.sentinelDegraded
                                    : AppTheme.sentinelOffline,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _testResult!.status == ProbeStatus.online
                                  ? Icons.check_circle_rounded
                                  : Icons.error_outline_rounded,
                              size: 15,
                              color: _testResult!.status == ProbeStatus.online
                                  ? AppTheme.sentinelOnline
                                  : AppTheme.sentinelOffline,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                _testResult!.message,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.codeMono(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: _testResult!.status ==
                                          ProbeStatus.online
                                      ? AppTheme.sentinelOnline
                                      : _testResult!.status ==
                                              ProbeStatus.degraded
                                          ? AppTheme.sentinelDegraded
                                          : AppTheme.sentinelOffline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // Bottom Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancelar',
                      style: AppTheme.mono(
                        fontSize: 12.5,
                        color: config.textSecondaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: sentinelBrand,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(155, 42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _saveTarget,
                    icon: const Icon(
                      Icons.check_rounded,
                      size: 17,
                      color: Colors.white,
                    ),
                    label: Text(
                      widget.target != null ? 'Actualizar' : 'Guardar Endpoint',
                      style: AppTheme.mono(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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

  Widget _buildTextField({
    required CyberdeckConfig config,
    required TextEditingController controller,
    required String label,
    required String hint,
    required Color accent,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.mono(
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            color: config.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: AppTheme.mono(fontSize: 12.5, color: config.textPrimaryColor),
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            hintStyle: AppTheme.mono(
              fontSize: 12,
              color: config.textSecondaryColor.withValues(alpha: 0.65),
            ),
            filled: true,
            fillColor: config.surfaceSecondaryColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 11,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: config.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: accent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  static Color _getProtocolColor(ProbeProtocol proto) {
    switch (proto) {
      case ProbeProtocol.tcp:
        return AppTheme.sentinelTcp;
      case ProbeProtocol.http:
        return AppTheme.sentinelHttp;
      case ProbeProtocol.udp:
        return AppTheme.sentinelUdp;
    }
  }

  static Widget _buildProtocolBadge(ProbeProtocol proto) {
    final color = _getProtocolColor(proto);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        proto.displayName,
        style: AppTheme.codeMono(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
