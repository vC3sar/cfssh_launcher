import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../monitor/monitor_screen.dart';
import '../services/camera_scanner_service.dart';
import 'camera_modal_dialog.dart';

class CameraScannerDialog extends ConsumerStatefulWidget {
  const CameraScannerDialog({super.key});

  @override
  ConsumerState<CameraScannerDialog> createState() =>
      _CameraScannerDialogState();
}

class _CameraScannerDialogState extends ConsumerState<CameraScannerDialog> {
  late TextEditingController _subnetController;
  late TextEditingController _portController;
  StreamSubscription? _scanSub;
  final List<DiscoveredCamera> _discovered = [];
  double _progress = 0.0;
  String _status = 'Listo para iniciar escaneo en red local';
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _portController = TextEditingController(text: '554');
    final stats = ref.read(monitorStatsProvider).asData?.value;
    final localIp = (stats?['localIp'] as String?) ?? '192.168.1.100';
    final subnet = CameraScannerService.extractSubnet(localIp);
    _subnetController = TextEditingController(text: subnet);
  }

  @override
  void dispose() {
    _scanSub?.cancel();
    _subnetController.dispose();
    _portController.dispose();
    super.dispose();
  }

  void _startScan() {
    _scanSub?.cancel();
    setState(() {
      _discovered.clear();
      _isScanning = true;
      _progress = 0.0;
      _status = 'Explorando subred local...';
    });

    final subnet = _subnetController.text.trim();
    final port = int.tryParse(_portController.text.trim()) ?? 554;

    _scanSub =
        CameraScannerService.scanSubnet(subnet: subnet, port: port).listen(
      (event) {
        if (!mounted) return;
        setState(() {
          _progress = event.progress;
          _status = event.status;
          if (event.found != null) {
            _discovered.add(event.found!);
          }
        });
      },
      onDone: () {
        if (!mounted) return;
        setState(() {
          _isScanning = false;
          _status =
              'Escaneo completado · Dispositivos encontrados: ${_discovered.length}';
        });
      },
      onError: (err) {
        if (!mounted) return;
        setState(() {
          _isScanning = false;
          _status = 'Error en escaneo: $err';
        });
      },
    );
  }

  void _stopScan() {
    _scanSub?.cancel();
    setState(() {
      _isScanning = false;
      _status = 'Escaneo detenido';
    });
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
        constraints: const BoxConstraints(maxWidth: 640, maxHeight: 680),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: secondary.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.radar_rounded,
                      color: secondary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Escáner de Cámaras RTSP en Red Local',
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
              Divider(color: config.borderColor, height: 20),

              // Inputs for Subnet & Port
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prefijo de Subred IP',
                          style: AppTheme.mono(
                            fontSize: 11.5,
                            color: config.textSecondaryColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          controller: _subnetController,
                          style: AppTheme.codeMono(
                            fontSize: 12.5,
                            color: config.textPrimaryColor,
                          ),
                          decoration: InputDecoration(
                            hintText: '192.168.1',
                            filled: true,
                            fillColor: config.surfaceSecondaryColor,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: config.borderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: secondary),
                            ),
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
                          'Puerto RTSP',
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
                          decoration: InputDecoration(
                            hintText: '554',
                            filled: true,
                            fillColor: config.surfaceSecondaryColor,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: config.borderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: secondary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isScanning ? AppTheme.error : secondary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(125, 42),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _isScanning ? _stopScan : _startScan,
                      icon: Icon(
                        _isScanning
                            ? Icons.stop_rounded
                            : Icons.play_arrow_rounded,
                        size: 17,
                        color: Colors.white,
                      ),
                      label: Text(
                        _isScanning ? 'Detener' : 'Escanear',
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

              const SizedBox(height: 12),

              // Progress bar & radar status text
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 6,
                  backgroundColor: config.surfaceSecondaryColor,
                  valueColor: AlwaysStoppedAnimation<Color>(secondary),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      _status,
                      style: AppTheme.mono(
                        fontSize: 11,
                        color: secondary,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${(_progress * 100).toInt()}%',
                    style: AppTheme.codeMono(
                      fontSize: 11,
                      color: config.textSecondaryColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Results Header
              Text(
                'Dispositivos RTSP detectados (${_discovered.length})',
                style: AppTheme.mono(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: config.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 8),

              // List of discovered cameras
              Expanded(
                child: _discovered.isEmpty
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: config.surfaceSecondaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: config.borderColor),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.videocam_off_outlined,
                                size: 36,
                                color: config.textSecondaryColor,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _isScanning
                                    ? 'Explorando la subred en busca de cámaras RTSP...'
                                    : 'Sin resultados.\nPulsa "Escanear" para buscar cámaras en tu red local.',
                                textAlign: TextAlign.center,
                                style: AppTheme.mono(
                                  fontSize: 12,
                                  color: config.textSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _discovered.length,
                        itemBuilder: (context, idx) {
                          final cam = _discovered[idx];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: config.surfaceSecondaryColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: config.borderColor),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.videocam_rounded,
                                  color: secondary,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${cam.ip}:${cam.port}',
                                        style: AppTheme.codeMono(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: config.textPrimaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Puerto RTSP activo · Latencia: ${cam.latencyMs}ms',
                                        style: AppTheme.mono(
                                          fontSize: 11,
                                          color: accent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: accent,
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(110, 38),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (_) => CameraModalDialog(
                                        initialIp: cam.ip,
                                        initialPort: cam.port,
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.add_link_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    'Vincular',
                                    style: AppTheme.mono(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 10),

              // Bottom Cancel
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cerrar',
                    style: AppTheme.mono(
                      fontSize: 12.5,
                      color: config.textSecondaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
