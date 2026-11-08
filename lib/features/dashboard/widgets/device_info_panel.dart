import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../../apps/apps_provider.dart';
import '../../monitor/monitor_screen.dart';
import '../../network/ping_screen.dart';
import '../../vpn/vpn_screen.dart';
import 'cyberdeck_panel.dart';

class SystemMonitorModule extends ConsumerWidget {
  const SystemMonitorModule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(monitorStatsProvider);
    final config = ref.watch(cyberdeckConfigProvider);
    final accent = config.primaryAccent;
    final secondary = config.secondaryAccent;

    return CyberdeckPanel(
      moduleCode: 'SISTEMA',
      title: 'Estado del Dispositivo',
      accentColor: accent,
      panelColor: config.panelColor,
      showVisualEffects: config.enableVisualEffects,
      padding: EdgeInsets.all(14 * config.paddingScale),
      actions: [
        CyberIconAction(
          icon: Icons.refresh_rounded,
          color: config.textSecondaryColor,
          tooltip: 'Actualizar estado',
          onTap: () => ref.invalidate(monitorStatsProvider),
        ),
        CyberIconAction(
          icon: Icons.open_in_new_rounded,
          color: accent,
          tooltip: 'Abrir diagnóstico completo',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MonitorScreen()),
            );
          },
        ),
      ],
      child: statsAsync.when(
        data: (stats) {
          final ramTotal = (stats['ramTotal'] as num?)?.toDouble() ?? 1.0;
          final ramAvail = (stats['ramAvailable'] as num?)?.toDouble() ?? 0.0;
          final ramUsed = (ramTotal - ramAvail).clamp(0.0, ramTotal);
          final ramPct = (ramUsed / ramTotal).clamp(0.0, 1.0);
          final ramUsedGB = (ramUsed / (1024 * 1024 * 1024)).toStringAsFixed(2);
          final ramTotalGB = (ramTotal / (1024 * 1024 * 1024)).toStringAsFixed(1);

          final storTotal = (stats['storageTotal'] as num?)?.toDouble() ?? 1.0;
          final storUsed = (stats['storageUsed'] as num?)?.toDouble() ?? 0.0;
          final storAvail = (stats['storageAvailable'] as num?)?.toDouble() ?? 0.0;
          final storPct =
              storTotal > 0 ? (storUsed / storTotal).clamp(0.0, 1.0) : 0.0;
          final storUsedGB = (storUsed / (1024 * 1024 * 1024)).toStringAsFixed(1);
          final storTotalGB = (storTotal / (1024 * 1024 * 1024)).toStringAsFixed(1);
          final storAvailGB = (storAvail / (1024 * 1024 * 1024)).toStringAsFixed(1);

          final battery = (stats['battery'] as num?)?.toDouble() ?? 0.0;
          final batPct = (battery / 100.0).clamp(0.0, 1.0);
          final isCharging = (stats['isCharging'] as bool?) ?? false;
          final chargeSrc = (stats['chargingSource'] as String?) ?? 'BAT';
          final batTemp = (stats['batteryTemp'] as num?)?.toDouble() ?? 0.0;

          final model = (stats['model'] as String?) ?? 'Android';
          final androidVer = (stats['androidVersion'] as String?) ?? '13';
          final sdkInt = (stats['sdkInt'] as num?)?.toInt() ?? 33;
          final uptimeMs = (stats['uptimeMillis'] as num?)?.toInt() ?? 0;
          final upHours = (uptimeMs ~/ 3600000).toString().padLeft(2, '0');
          final upMins = ((uptimeMs % 3600000) ~/ 60000).toString().padLeft(2, '0');

          final batColor = battery <= 15
              ? AppTheme.error
              : (battery <= 30 ? AppTheme.amberAlert : AppTheme.phosphorGreen);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Battery Telemetry
              _buildMetricHeader(
                config: config,
                label: 'Batería',
                value:
                    '${battery.toInt()}% ${isCharging ? "($chargeSrc)" : ""}',
                subValue: '${batTemp.toStringAsFixed(1)}°C',
                color: batColor,
              ),
              const SizedBox(height: 6),
              CyberdeckSegmentedBar(
                value: batPct,
                activeColor: batColor,
              ),
              const SizedBox(height: 12),

              // 2. RAM Telemetry
              _buildMetricHeader(
                config: config,
                label: 'Memoria RAM',
                value: '$ramUsedGB / $ramTotalGB GB',
                subValue: '${(ramPct * 100).toInt()}%',
                color: ramPct > 0.85 ? AppTheme.amberAlert : secondary,
              ),
              const SizedBox(height: 6),
              CyberdeckSegmentedBar(
                value: ramPct,
                activeColor: ramPct > 0.85 ? AppTheme.amberAlert : secondary,
              ),
              const SizedBox(height: 12),

              // 3. Internal Storage Telemetry
              _buildMetricHeader(
                config: config,
                label: 'Almacenamiento',
                value: '$storUsedGB / $storTotalGB GB',
                subValue: 'Libre: $storAvailGB GB',
                color: storPct > 0.90 ? AppTheme.error : accent,
              ),
              const SizedBox(height: 6),
              CyberdeckSegmentedBar(
                value: storPct,
                activeColor: storPct > 0.90 ? AppTheme.error : accent,
              ),
              const SizedBox(height: 12),

              // 4. Device Hardware Identity Footer
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: config.surfaceSecondaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: config.borderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        '$model · Android $androidVer (API $sdkInt)',
                        style: AppTheme.mono(
                          fontSize: 11,
                          color: config.textSecondaryColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'Activo ${upHours}h ${upMins}m',
                      style: AppTheme.codeMono(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: accent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: CircularProgressIndicator(strokeWidth: 2, color: accent),
          ),
        ),
        error: (_, _) => Text(
          'No fue posible leer métricas del sistema',
          style: AppTheme.mono(fontSize: 11.5, color: AppTheme.error),
        ),
      ),
    );
  }

  Widget _buildMetricHeader({
    required CyberdeckConfig config,
    required String label,
    required String value,
    required String subValue,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTheme.mono(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: config.textPrimaryColor,
          ),
        ),
        Row(
          children: [
            Text(
              subValue,
              style: AppTheme.codeMono(
                fontSize: 10.5,
                color: config.textSecondaryColor,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: AppTheme.codeMono(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class NetworkModuleWidget extends ConsumerWidget {
  const NetworkModuleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(monitorStatsProvider);
    final config = ref.watch(cyberdeckConfigProvider);
    final accent = config.primaryAccent;
    final secondary = config.secondaryAccent;

    return CyberdeckPanel(
      moduleCode: 'RED',
      title: 'Conectividad y Red Local',
      accentColor: secondary,
      panelColor: config.panelColor,
      showVisualEffects: config.enableVisualEffects,
      padding: EdgeInsets.all(14 * config.paddingScale),
      child: statsAsync.when(
        data: (stats) {
          final isConnected = (stats['isConnected'] as bool?) ?? false;
          final connType = (stats['connectionType'] as String?) ?? 'OFFLINE';
          final wifiEnabled = (stats['wifiEnabled'] as bool?) ?? false;
          final wifiSsid = (stats['wifiSsid'] as String?) ?? 'N/A';
          final wifiRssi = (stats['wifiRssi'] as num?)?.toInt() ?? -100;
          final wifiSpeed = (stats['wifiLinkSpeed'] as num?)?.toInt() ?? 0;
          final localIp = (stats['localIp'] as String?) ?? '0.0.0.0';
          final vpnActive = (stats['vpnActive'] as bool?) ?? false;
          final btEnabled = (stats['bluetoothEnabled'] as bool?) ?? false;
          final btState = (stats['bluetoothState'] as String?) ?? 'OFF';
          final airplane = (stats['airplaneMode'] as bool?) ?? false;

          final ssidMasked = wifiSsid == 'WLAN_ACTIVE';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Primary Network Row
              Row(
                children: [
                  Expanded(
                    child: _buildNetStatBox(
                      config: config,
                      label: 'Conexión',
                      value: isConnected ? connType : 'Sin Red',
                      sub: 'IP: $localIp',
                      color: isConnected
                          ? AppTheme.phosphorGreen
                          : AppTheme.amberAlert,
                      icon: isConnected
                          ? Icons.wifi_tethering_rounded
                          : Icons.portable_wifi_off_rounded,
                      onTap: () => ref.read(deviceServiceProvider).openWifiSettings(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildNetStatBox(
                      config: config,
                      label: 'Red Wi-Fi',
                      value: wifiEnabled ? wifiSsid : 'Desactivado',
                      sub: wifiEnabled && wifiSpeed > 0
                          ? '$wifiRssi dBm · $wifiSpeed Mbps'
                          : (ssidMasked ? 'Toca para ver SSID' : 'Sin señal'),
                      color: wifiEnabled ? secondary : config.textSecondaryColor,
                      icon: Icons.router_outlined,
                      onTap: () async {
                        if (ssidMasked) {
                          await ref
                              .read(deviceServiceProvider)
                              .requestLocationPermission();
                          ref.invalidate(monitorStatsProvider);
                        } else {
                          ref.read(deviceServiceProvider).openWifiSettings();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Secondary Row: Bluetooth, Airplane, VPN
              Row(
                children: [
                  Expanded(
                    child: _buildMiniBadge(
                      config: config,
                      label: 'BT: $btState',
                      icon: Icons.bluetooth_rounded,
                      active: btEnabled,
                      activeColor: secondary,
                      onTap: () =>
                          ref.read(deviceServiceProvider).openBluetoothSettings(),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _buildMiniBadge(
                      config: config,
                      label: airplane ? 'Avión' : 'Radio OK',
                      icon: Icons.airplanemode_active_rounded,
                      active: airplane,
                      activeColor: AppTheme.amberAlert,
                      onTap: () =>
                          ref.read(deviceServiceProvider).openSystemSettings(),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _buildMiniBadge(
                      config: config,
                      label: vpnActive ? 'VPN Activa' : 'VPN Off',
                      icon: Icons.vpn_lock_rounded,
                      active: vpnActive,
                      activeColor: accent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const VpnScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Network Tools Row (Ping & VPN Settings)
              Row(
                children: [
                  Expanded(
                    child: CyberTapTarget(
                      onTap: () {
                        ref
                            .read(cyberdeckConfigProvider.notifier)
                            .logAction('NET', 'Herramienta Ping abierta');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PingScreen()),
                        );
                      },
                      pressColor: accent,
                      fillWidth: true,
                      semanticLabel: 'Diagnóstico Ping',
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: config.surfaceSecondaryColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: config.borderColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.terminal_rounded, size: 15, color: accent),
                            const SizedBox(width: 6),
                            Text(
                              'Ping / Red',
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
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CyberTapTarget(
                      onTap: () =>
                          ref.read(deviceServiceProvider).openVpnSettings(),
                      pressColor: secondary,
                      fillWidth: true,
                      semanticLabel: 'Ajustes VPN',
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: config.surfaceSecondaryColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: config.borderColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shield_outlined, size: 15, color: secondary),
                            const SizedBox(width: 6),
                            Text(
                              'Ajustes VPN',
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
                  ),
                ],
              ),
            ],
          );
        },
        loading: () => const SizedBox(height: 60),
        error: (_, _) => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildNetStatBox({
    required CyberdeckConfig config,
    required String label,
    required String value,
    required String sub,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return CyberTapTarget(
      onTap: onTap,
      pressColor: color,
      fillWidth: true,
      semanticLabel: '$label: $value',
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: config.surfaceSecondaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: config.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 14, color: color),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    label,
                    style: AppTheme.mono(
                      fontSize: 10.5,
                      color: config.textSecondaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: AppTheme.mono(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: config.textPrimaryColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              sub,
              style: AppTheme.codeMono(
                fontSize: 10,
                color: config.textSecondaryColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniBadge({
    required CyberdeckConfig config,
    required String label,
    required IconData icon,
    required bool active,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    final c = active ? activeColor : config.textSecondaryColor;
    return CyberTapTarget(
      onTap: onTap,
      pressColor: c,
      fillWidth: true,
      semanticLabel: label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
        decoration: BoxDecoration(
          color: active
              ? activeColor.withValues(alpha: 0.12)
              : config.surfaceSecondaryColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: active ? activeColor.withValues(alpha: 0.4) : config.borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 13, color: c),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                label,
                style: AppTheme.mono(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: active ? c : config.textPrimaryColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Wrapper combining System Monitor & Network
class DeviceInfoPanel extends StatelessWidget {
  const DeviceInfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 310,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SystemMonitorModule(),
          SizedBox(height: 12),
          NetworkModuleWidget(),
        ],
      ),
    );
  }
}
