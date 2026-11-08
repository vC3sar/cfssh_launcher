import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../../dashboard/widgets/cyberdeck_panel.dart';
import '../models/rtsp_camera_model.dart';
import '../providers/cameras_provider.dart';
import 'camera_modal_dialog.dart';
import 'camera_scanner_dialog.dart';
import 'rtsp_player_widget.dart';

class RtspSurveillancePanel extends ConsumerWidget {
  const RtspSurveillancePanel({super.key});

  void _showAddCamera(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const CameraModalDialog(),
    );
  }

  void _showScanner(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const CameraScannerDialog(),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    RtspCameraModel camera,
  ) {
    final config = ref.read(cyberdeckConfigProvider);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: config.panelColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: config.borderColor),
        ),
        title: Text(
          'Eliminar Cámara RTSP',
          style: AppTheme.mono(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppTheme.error,
          ),
        ),
        content: Text(
          '¿Deseas eliminar "${camera.name}" (${camera.ip}) de la sección de cámaras?',
          style: AppTheme.mono(fontSize: 12.5, color: config.textPrimaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancelar',
              style: AppTheme.mono(
                fontSize: 12.5,
                color: config.textSecondaryColor,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              ref.read(camerasProvider.notifier).deleteCamera(camera.id);
              ref
                  .read(cyberdeckConfigProvider.notifier)
                  .logAction('SURV', 'Cámara eliminada: ${camera.name}');
              Navigator.pop(ctx);
            },
            child: Text(
              'Eliminar',
              style: AppTheme.mono(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(cyberdeckConfigProvider);
    final cameras = ref.watch(camerasProvider);
    final activeCam = ref.watch(activeCameraProvider);
    final accent = config.primaryAccent;
    final secondary = config.secondaryAccent;

    return CyberdeckPanel(
      moduleCode: 'CCTV',
      title: 'Vigilancia Cámaras RTSP',
      accentColor: accent,
      panelColor: config.panelColor,
      showVisualEffects: config.enableVisualEffects,
      actions: [
        // Scan Button
        CyberTapTarget(
          pressColor: secondary,
          tooltip: 'Escanear red local en busca de cámaras RTSP',
          semanticLabel: 'Escanear red local',
          onTap: () => _showScanner(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: secondary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: secondary.withValues(alpha: 0.45)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.radar_rounded, size: 14, color: secondary),
                const SizedBox(width: 4),
                Text(
                  'Escanear Red',
                  style: AppTheme.mono(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: secondary,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Add Camera Button
        CyberTapTarget(
          pressColor: accent,
          tooltip: 'Añadir nueva cámara RTSP',
          semanticLabel: 'Añadir cámara RTSP',
          onTap: () => _showAddCamera(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: accent.withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_rounded, size: 14, color: accent),
                const SizedBox(width: 3),
                Text(
                  'Nueva Cámara',
                  style: AppTheme.mono(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cameras.isNotEmpty) ...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...cameras.map((cam) {
                    final isSelected = cam.id == activeCam?.id;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 10),
                      child: CyberTapTarget(
                        onTap: () {
                          ref
                              .read(activeCameraIdProvider.notifier)
                              .selectCamera(cam.id);
                          ref
                              .read(cyberdeckConfigProvider.notifier)
                              .logAction(
                                'SURV',
                                'Canal seleccionado -> ${cam.name}',
                              );
                        },
                        pressColor: isSelected ? accent : secondary,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? accent.withValues(alpha: 0.16)
                                : config.surfaceSecondaryColor,
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                              color: isSelected ? accent : config.borderColor,
                              width: isSelected ? 1.5 : 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isSelected
                                    ? Icons.videocam_rounded
                                    : Icons.videocam_outlined,
                                size: 15,
                                color: isSelected
                                    ? accent
                                    : config.textSecondaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                cam.name,
                                style: AppTheme.mono(
                                  fontSize: 11.5,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? accent
                                      : config.textPrimaryColor,
                                ),
                              ),
                              if (isSelected) ...[
                                const SizedBox(width: 7),
                                InkWell(
                                  onTap: () =>
                                      _confirmDelete(context, ref, cam),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 14,
                                    color: config.textSecondaryColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Active Stream Viewport
            if (activeCam != null)
              RtspPlayerWidget(
                key: ValueKey('${activeCam.id}_${activeCam.url}'),
                camera: activeCam,
              )
            else
              const SizedBox.shrink(),
          ] else ...[
            // Empty State
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
              decoration: BoxDecoration(
                color: config.surfaceSecondaryColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: config.borderColor),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.videocam_off_outlined,
                    size: 40,
                    color: accent,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Vigilancia RTSP · Sin Cámaras Vinculadas',
                    style: AppTheme.mono(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: config.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Agrega tus cámaras IP RTSP (ej. rtsp://user:pass@ip:554/live/ch00_0) o escanea tu red local.',
                    textAlign: TextAlign.center,
                    style: AppTheme.mono(
                      fontSize: 11.5,
                      color: config.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(145, 42),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => _showAddCamera(context),
                        icon: const Icon(
                          Icons.add_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Agregar Cámara',
                          style: AppTheme.mono(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: secondary),
                          minimumSize: const Size(145, 42),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => _showScanner(context),
                        icon: Icon(
                          Icons.radar_rounded,
                          size: 16,
                          color: secondary,
                        ),
                        label: Text(
                          'Escanear Red',
                          style: AppTheme.mono(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
