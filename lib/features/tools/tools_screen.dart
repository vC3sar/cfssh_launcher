import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/cyber_tap_target.dart';
import '../apps/apps_provider.dart';

class ToolsScreen extends ConsumerWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(cyberdeckConfigProvider);
    final accent = config.primaryAccent;

    return Scaffold(
      backgroundColor: config.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Herramientas del Sistema',
          style: AppTheme.mono(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: config.textPrimaryColor,
          ),
        ),
        backgroundColor: config.panelColor,
        elevation: 0,
        iconTheme: IconThemeData(color: config.textPrimaryColor),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: config.borderColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ACCESOS DIRECTOS DEL SISTEMA ANDROID',
              style: AppTheme.codeMono(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: config.textSecondaryColor,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 12),
            _buildToolItem(
              config: config,
              accent: accent,
              icon: Icons.wifi_rounded,
              title: 'Wi-Fi',
              subtitle: 'Ajustes de redes inalámbricas',
              onTap: () => ref.read(deviceServiceProvider).openWifiSettings(),
            ),
            const SizedBox(height: 10),
            _buildToolItem(
              config: config,
              accent: accent,
              icon: Icons.bluetooth_rounded,
              title: 'Bluetooth',
              subtitle: 'Conexión de dispositivos',
              onTap: () => ref.read(deviceServiceProvider).openBluetoothSettings(),
            ),
            const SizedBox(height: 10),
            _buildToolItem(
              config: config,
              accent: accent,
              icon: Icons.display_settings_rounded,
              title: 'Pantalla',
              subtitle: 'Brillo y ajustes de visualización',
              onTap: () => ref.read(deviceServiceProvider).openDisplaySettings(),
            ),
            const SizedBox(height: 10),
            _buildToolItem(
              config: config,
              accent: accent,
              icon: Icons.settings_outlined,
              title: 'Ajustes Generales',
              subtitle: 'Configuración completa del dispositivo Android',
              onTap: () => ref.read(deviceServiceProvider).openSystemSettings(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolItem({
    required CyberdeckConfig config,
    required Color accent,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return CyberTapTarget(
      onTap: onTap,
      pressColor: accent,
      fillWidth: true,
      semanticLabel: title,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: config.panelColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: config.borderColor),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 22, color: accent),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.mono(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: config.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTheme.mono(
                      color: config.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: config.textSecondaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
