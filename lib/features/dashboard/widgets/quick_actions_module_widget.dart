import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../../apps/apps_provider.dart';
import '../../monitor/monitor_screen.dart';
import '../../settings/settings_screen.dart';
import '../../tools/tools_screen.dart';
import 'cyberdeck_panel.dart';

class QuickActionsModuleWidget extends ConsumerStatefulWidget {
  const QuickActionsModuleWidget({super.key});

  @override
  ConsumerState<QuickActionsModuleWidget> createState() =>
      _QuickActionsModuleWidgetState();
}

class _QuickActionsModuleWidgetState
    extends ConsumerState<QuickActionsModuleWidget> {
  bool _torchActive = false;

  Future<void> _handleFlashlightTap(BuildContext context) async {
    final res = await ref.read(deviceServiceProvider).toggleFlashlight();
    final hasHw = (res['hasHardwareFlash'] as bool?) ?? false;
    final enabled = (res['enabled'] as bool?) ?? false;

    if (hasHw) {
      setState(() => _torchActive = enabled);
      ref
          .read(cyberdeckConfigProvider.notifier)
          .logAction('TORCH', enabled ? 'Linterna LED: ON' : 'Linterna LED: OFF');
    } else {
      ref.read(cyberdeckConfigProvider.notifier).logAction(
            'TORCH',
            'Linterna de pantalla activada',
          );
      if (context.mounted) {
        _showScreenTorchDialog(context);
      }
    }
  }

  void _showScreenTorchDialog(BuildContext context) {
    bool useWarm = false;
    showDialog(
      context: context,
      barrierColor: Colors.black,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            final bgColor =
                useWarm ? const Color(0xFFFFF3DC) : Colors.white;
            return Dialog.fullscreen(
              backgroundColor: bgColor,
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.flashlight_on_rounded,
                        size: 64,
                        color: Colors.black87,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Linterna de Pantalla',
                        style: AppTheme.mono(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Iluminación de pantalla completa activa.',
                        textAlign: TextAlign.center,
                        style: AppTheme.mono(
                          fontSize: 12.5,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              setDialogState(() => useWarm = !useWarm);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              foregroundColor: Colors.white,
                            ),
                            icon: const Icon(Icons.wb_sunny_outlined, size: 16),
                            label: Text(
                              useWarm ? 'Luz Blanca' : 'Luz Cálida',
                              style: AppTheme.mono(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: () => Navigator.pop(ctx),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.error,
                              foregroundColor: Colors.white,
                            ),
                            icon: const Icon(Icons.power_settings_new_rounded, size: 16),
                            label: Text(
                              'Apagar',
                              style: AppTheme.mono(
                                fontSize: 12,
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
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(cyberdeckConfigProvider);
    final statsAsync = ref.watch(monitorStatsProvider);
    final accent = config.primaryAccent;
    final secondary = config.secondaryAccent;

    final volumePct = statsAsync.maybeWhen(
      data: (s) => (s['volumePercent'] as num?)?.toInt() ?? 50,
      orElse: () => 50,
    );

    return CyberdeckPanel(
      moduleCode: 'CONTROL',
      title: 'Centro de Control y Multimedia',
      accentColor: accent,
      panelColor: config.panelColor,
      showVisualEffects: config.enableVisualEffects,
      padding: EdgeInsets.all(14 * config.paddingScale),
      actions: [
        CyberIconAction(
          icon: Icons.handyman_outlined,
          color: config.textSecondaryColor,
          tooltip: 'Herramientas del sistema',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ToolsScreen()),
            );
          },
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final tileWidth = (constraints.maxWidth - 16) / 3;
              final tileExtent = (tileWidth / 2.15).clamp(50.0, 72.0);
              return GridView(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: tileExtent,
                ),
                children: [
                  _buildActionTile(
                    config: config,
                    icon: Icons.settings_outlined,
                    label: 'Sistema',
                    accent: accent,
                    onTap: () {
                      ref
                          .read(cyberdeckConfigProvider.notifier)
                          .logAction('CMD', 'Ajustes del sistema');
                      ref.read(deviceServiceProvider).openSystemSettings();
                    },
                  ),
                  _buildActionTile(
                    config: config,
                    icon: _torchActive
                        ? Icons.flashlight_on_rounded
                        : Icons.flashlight_off_outlined,
                    label: _torchActive ? 'Activa' : 'Linterna',
                    accent: _torchActive ? AppTheme.amberAlert : accent,
                    active: _torchActive,
                    onTap: () => _handleFlashlightTap(context),
                  ),
                  _buildActionTile(
                    config: config,
                    icon: Icons.camera_alt_outlined,
                    label: 'Cámara',
                    accent: secondary,
                    onTap: () {
                      ref
                          .read(cyberdeckConfigProvider.notifier)
                          .logAction('CMD', 'Cámara abierta');
                      ref.read(deviceServiceProvider).openCamera();
                    },
                  ),
                  _buildActionTile(
                    config: config,
                    icon: Icons.folder_outlined,
                    label: 'Archivos',
                    accent: secondary,
                    onTap: () {
                      ref
                          .read(cyberdeckConfigProvider.notifier)
                          .logAction('CMD', 'Gestor de archivos');
                      ref.read(deviceServiceProvider).openFileManager(
                            packageName: config.defaultFileManager,
                          );
                    },
                  ),
                  _buildActionTile(
                    config: config,
                    icon: Icons.wifi_rounded,
                    label: 'Wi-Fi',
                    accent: accent,
                    onTap: () {
                      ref
                          .read(cyberdeckConfigProvider.notifier)
                          .logAction('CMD', 'Ajustes Wi-Fi');
                      ref.read(deviceServiceProvider).openWifiSettings();
                    },
                  ),
                  _buildActionTile(
                    config: config,
                    icon: Icons.bluetooth_rounded,
                    label: 'Bluetooth',
                    accent: secondary,
                    onTap: () {
                      ref
                          .read(cyberdeckConfigProvider.notifier)
                          .logAction('CMD', 'Ajustes Bluetooth');
                      ref.read(deviceServiceProvider).openBluetoothSettings();
                    },
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          // Media & Audio Controller Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: config.surfaceSecondaryColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: config.borderColor),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Audio y Reproducción',
                      style: AppTheme.mono(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: config.textSecondaryColor,
                      ),
                    ),
                    Text(
                      'Volumen: $volumePct%',
                      style: AppTheme.codeMono(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMediaBtn(
                      config,
                      Icons.skip_previous_rounded,
                      'Anterior',
                      config.textPrimaryColor,
                      () async {
                        await ref.read(deviceServiceProvider).mediaControl('previous');
                        ref.invalidate(monitorStatsProvider);
                      },
                    ),
                    _buildMediaBtn(
                      config,
                      Icons.play_arrow_rounded,
                      'Reproducir / Pausar',
                      accent,
                      () async {
                        await ref.read(deviceServiceProvider).mediaControl('play_pause');
                        ref.invalidate(monitorStatsProvider);
                      },
                    ),
                    _buildMediaBtn(
                      config,
                      Icons.skip_next_rounded,
                      'Siguiente',
                      config.textPrimaryColor,
                      () async {
                        await ref.read(deviceServiceProvider).mediaControl('next');
                        ref.invalidate(monitorStatsProvider);
                      },
                    ),
                    Container(width: 1, height: 20, color: config.borderColor),
                    _buildMediaBtn(
                      config,
                      Icons.volume_down_rounded,
                      'Bajar volumen',
                      secondary,
                      () async {
                        await ref.read(deviceServiceProvider).mediaControl('vol_down');
                        ref.invalidate(monitorStatsProvider);
                      },
                    ),
                    _buildMediaBtn(
                      config,
                      Icons.volume_up_rounded,
                      'Subir volumen',
                      secondary,
                      () async {
                        await ref.read(deviceServiceProvider).mediaControl('vol_up');
                        ref.invalidate(monitorStatsProvider);
                      },
                    ),
                    _buildMediaBtn(
                      config,
                      Icons.volume_off_rounded,
                      'Silenciar',
                      AppTheme.amberAlert,
                      () async {
                        await ref.read(deviceServiceProvider).mediaControl('mute');
                        ref.invalidate(monitorStatsProvider);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Quick Settings Row
          Row(
            children: [
              Expanded(
                child: CyberTapTarget(
                  onTap: () => ref.read(deviceServiceProvider).openDisplaySettings(),
                  pressColor: accent,
                  fillWidth: true,
                  semanticLabel: 'Brillo y pantalla',
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: config.surfaceSecondaryColor,
                      border: Border.all(color: config.borderColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Brillo y Pantalla',
                        style: AppTheme.mono(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: config.textPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CyberTapTarget(
                  pressColor: accent,
                  fillWidth: true,
                  semanticLabel: 'Ajustes del Launcher',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.12),
                      border: Border.all(color: accent.withValues(alpha: 0.35)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Ajustes del Launcher',
                        style: AppTheme.mono(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: accent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required CyberdeckConfig config,
    required IconData icon,
    required String label,
    required Color accent,
    required VoidCallback onTap,
    bool active = false,
  }) {
    return CyberTapTarget(
      onTap: onTap,
      pressColor: accent,
      fillWidth: true,
      semanticLabel: label,
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: active
              ? accent.withValues(alpha: 0.16)
              : config.surfaceSecondaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: active ? accent : config.borderColor,
            width: active ? 1.4 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 17, color: accent),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: AppTheme.mono(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: config.textPrimaryColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaBtn(
    CyberdeckConfig config,
    IconData icon,
    String tooltip,
    Color color,
    VoidCallback onTap,
  ) {
    return CyberTapTarget(
      onTap: onTap,
      pressColor: color,
      tooltip: tooltip,
      semanticLabel: tooltip,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: config.panelColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: config.borderColor),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
