import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../services/device_service.dart';
import '../apps/apps_provider.dart';

/// Periodic lightweight system telemetry provider (updates every 6s when active)
final monitorStatsProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final timer = Timer(const Duration(seconds: 6), () {
    ref.invalidateSelf();
  });
  ref.onDispose(timer.cancel);
  return await ref.read(deviceServiceProvider).getMonitorStats();
});

final calendarEventsProvider = FutureProvider.autoDispose<
    ({bool authorized, List<CalendarEventItem> events})>((ref) async {
  final timer = Timer(const Duration(seconds: 45), () {
    ref.invalidateSelf();
  });
  ref.onDispose(timer.cancel);
  return await ref.read(deviceServiceProvider).getCalendarEvents();
});

final activeNotificationsProvider = FutureProvider.autoDispose<
    ({bool authorized, List<SystemNotificationItem> notifications})>((ref) async {
  final timer = Timer(const Duration(seconds: 10), () {
    ref.invalidateSelf();
  });
  ref.onDispose(timer.cancel);
  return await ref.read(deviceServiceProvider).getActiveNotifications();
});

final usageRecentsProvider =
    FutureProvider.autoDispose<({bool authorized, List<String> packages})>(
        (ref) async {
  return await ref.read(deviceServiceProvider).getUsageRecentApps();
});

class MonitorScreen extends ConsumerWidget {
  const MonitorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(monitorStatsProvider);
    final config = ref.watch(cyberdeckConfigProvider);
    final accent = config.primaryAccent;
    final highlight = config.highlightAccent;

    return Scaffold(
      backgroundColor: config.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Diagnóstico y Telemetría del Sistema',
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
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_rounded, color: accent),
            tooltip: 'Actualizar métricas',
            onPressed: () => ref.invalidate(monitorStatsProvider),
          ),
        ],
      ),
      body: SafeArea(
        child: statsAsync.when(
          data: (stats) {
            final ramTotal = (stats['ramTotal'] as num?)?.toDouble() ?? 1.0;
            final ramAvail = (stats['ramAvailable'] as num?)?.toDouble() ?? 0.0;
            final ramUsed = (ramTotal - ramAvail).clamp(0.0, ramTotal);
            final ramLow = (stats['ramLowMemory'] as bool?) ?? false;

            final storageTotal =
                (stats['storageTotal'] as num?)?.toDouble() ?? 1.0;
            final storageUsed =
                (stats['storageUsed'] as num?)?.toDouble() ?? 0.0;
            final storageAvail =
                (stats['storageAvailable'] as num?)?.toDouble() ?? 0.0;

            final battery = (stats['battery'] as num?)?.toDouble() ?? 0.0;
            final isCharging = (stats['isCharging'] as bool?) ?? false;
            final chargingSource =
                (stats['chargingSource'] as String?) ?? 'BAT';
            final batteryTemp =
                (stats['batteryTemp'] as num?)?.toDouble() ?? 0.0;
            final batteryVolt = (stats['batteryVoltage'] as num?)?.toInt() ?? 0;
            final batteryHealth =
                (stats['batteryHealth'] as String?) ?? 'NOMINAL';

            final manufacturer =
                (stats['manufacturer'] as String?) ?? 'SAMSUNG';
            final model = (stats['model'] as String?) ?? 'SM-T220';
            final device = (stats['device'] as String?) ?? 'gta7lite';
            final androidVer = (stats['androidVersion'] as String?) ?? '13';
            final sdkInt = (stats['sdkInt'] as num?)?.toInt() ?? 33;
            final secPatch = (stats['securityPatch'] as String?) ?? 'N/A';
            final cpuCores = (stats['cpuCores'] as num?)?.toInt() ?? 8;
            final uptimeMs = (stats['uptimeMillis'] as num?)?.toInt() ?? 0;

            final ramTotalGB =
                (ramTotal / (1024 * 1024 * 1024)).toStringAsFixed(2);
            final ramUsedGB =
                (ramUsed / (1024 * 1024 * 1024)).toStringAsFixed(2);
            final ramPercent = (ramUsed / ramTotal).clamp(0.0, 1.0);

            final storTotalGB =
                (storageTotal / (1024 * 1024 * 1024)).toStringAsFixed(1);
            final storUsedGB =
                (storageUsed / (1024 * 1024 * 1024)).toStringAsFixed(1);
            final storAvailGB =
                (storageAvail / (1024 * 1024 * 1024)).toStringAsFixed(1);
            final storPercent = storageTotal > 0
                ? (storageUsed / storageTotal).clamp(0.0, 1.0)
                : 0.0;

            final batPercent = (battery / 100.0).clamp(0.0, 1.0);
            final uptimeHrs = (uptimeMs ~/ 3600000).toString().padLeft(2, '0');
            final uptimeMin =
                ((uptimeMs % 3600000) ~/ 60000).toString().padLeft(2, '0');

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                        width: 280,
                        child: _buildTelemetryCard(
                          config: config,
                          title: 'Batería y Energía',
                          value: '${battery.toStringAsFixed(0)}%',
                          subtitle:
                              '${isCharging ? "Cargando ($chargingSource)" : "En batería"} · ${batteryTemp.toStringAsFixed(1)}°C · ${batteryVolt}mV · $batteryHealth',
                          percent: batPercent,
                          color: battery > 20
                              ? AppTheme.phosphorGreen
                              : AppTheme.error,
                          icon: isCharging
                              ? Icons.battery_charging_full_rounded
                              : Icons.battery_full_rounded,
                        ),
                      ),
                      SizedBox(
                        width: 280,
                        child: _buildTelemetryCard(
                          config: config,
                          title: 'Memoria RAM Activa',
                          value: '$ramUsedGB / $ramTotalGB GB',
                          subtitle:
                              'Uso ${(ramPercent * 100).toInt()}% · Estado: ${ramLow ? "Memoria baja" : "Óptimo"}',
                          percent: ramPercent,
                          color: ramPercent > 0.85 ? highlight : accent,
                          icon: Icons.memory_rounded,
                        ),
                      ),
                      SizedBox(
                        width: 280,
                        child: _buildTelemetryCard(
                          config: config,
                          title: 'Almacenamiento Interno',
                          value: '$storUsedGB / $storTotalGB GB',
                          subtitle:
                              'Disponible: $storAvailGB GB · Uso ${(storPercent * 100).toInt()}%',
                          percent: storPercent,
                          color: storPercent > 0.90
                              ? AppTheme.error
                              : config.secondaryAccent,
                          icon: Icons.storage_rounded,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: config.panelColor,
                      border: Border.all(color: config.borderColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Especificaciones de Hardware',
                          style: AppTheme.mono(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: accent,
                          ),
                        ),
                        Divider(color: config.borderColor, height: 22),
                        _buildSpecRow(
                          config,
                          'Fabricante / Modelo',
                          '$manufacturer $model ($device)',
                        ),
                        _buildSpecRow(
                          config,
                          'Sistema Operativo',
                          'Android $androidVer (API SDK $sdkInt)',
                        ),
                        _buildSpecRow(config, 'Parche de Seguridad', secPatch),
                        _buildSpecRow(
                          config,
                          'Núcleos de Procesador',
                          '$cpuCores núcleos activos',
                        ),
                        _buildSpecRow(
                          config,
                          'Tiempo Activo (Uptime)',
                          '${uptimeHrs}h ${uptimeMin}m',
                          valueColor: highlight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => Center(
            child: CircularProgressIndicator(color: accent),
          ),
          error: (err, stack) => Center(
            child: Text(
              'Error: $err',
              style: AppTheme.mono(color: AppTheme.error),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecRow(
    CyberdeckConfig config,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.mono(
              fontSize: 12,
              color: config.textSecondaryColor,
            ),
          ),
          Text(
            value,
            style: AppTheme.codeMono(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: valueColor ?? config.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryCard({
    required CyberdeckConfig config,
    required String title,
    required String value,
    required String subtitle,
    required double percent,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: config.panelColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: config.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: AppTheme.mono(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: config.textSecondaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTheme.codeMono(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: config.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 8,
              backgroundColor: config.surfaceSecondaryColor,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: AppTheme.mono(
              fontSize: 11,
              color: config.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
