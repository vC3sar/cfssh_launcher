import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../../apps/apps_provider.dart';
import '../../monitor/monitor_screen.dart';
import '../../settings/settings_screen.dart';
import '../weather_provider.dart';

class TopHeaderWidget extends ConsumerWidget {
  const TopHeaderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(cyberdeckConfigProvider);
    final statsAsync = ref.watch(monitorStatsProvider);
    final weatherAsync = ref.watch(weatherProvider);
    final accent = config.primaryAccent;
    final secondary = config.secondaryAccent;
    final highlight = config.highlightAccent;

    return RepaintBoundary(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 16 * config.paddingScale,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: config.panelColor,
          border: Border(
            bottom: BorderSide(
              color: config.borderColor,
              width: 1,
            ),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompactWidth = constraints.maxWidth < 740;

            return Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              runSpacing: 4,
              children: [
                // Left Cluster: Callsign + High-Visibility Clock + Date
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: config.surfaceSecondaryColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: config.borderColor),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: highlight,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isCompactWidth ? 'Deck' : config.operatorCallsign,
                            style: AppTheme.mono(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: config.textPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    _HeaderClockTicker(
                      use24Hour: config.use24HourFormat,
                      textColor: config.textPrimaryColor,
                      secondaryColor: config.textSecondaryColor,
                      accentColor: accent,
                      borderColor: config.borderColor,
                      compact: isCompactWidth,
                    ),
                  ],
                ),

                // Right Cluster: Clean System Status Pills & Quick Controls
                statsAsync.when(
                  data: (stats) {
                    final battery = (stats['battery'] as num?)?.toInt() ?? 0;
                    final isCharging = (stats['isCharging'] as bool?) ?? false;
                    final isConnected = (stats['isConnected'] as bool?) ?? false;
                    final wifiEnabled = (stats['wifiEnabled'] as bool?) ?? false;
                    final wifiSsid = (stats['wifiSsid'] as String?) ?? 'Wi-Fi';
                    final airplaneMode = (stats['airplaneMode'] as bool?) ?? false;
                    final btEnabled = (stats['bluetoothEnabled'] as bool?) ?? false;

                    final batColor = battery <= 15
                        ? AppTheme.error
                        : (battery <= 30 ? AppTheme.amberAlert : AppTheme.phosphorGreen);

                    return Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        weatherAsync.maybeWhen(
                          data: (w) => _StatusPill(
                            icon: Icons.wb_sunny_outlined,
                            label: '${w.temperature.toStringAsFixed(0)}°C',
                            color: highlight,
                            surfaceColor: config.surfaceSecondaryColor,
                            borderColor: config.borderColor,
                            highlighted: true,
                          ),
                          orElse: () => const SizedBox.shrink(),
                        ),

                        if (airplaneMode)
                          _StatusPill(
                            icon: Icons.airplanemode_active,
                            label: 'Avión',
                            color: AppTheme.amberAlert,
                            surfaceColor: config.surfaceSecondaryColor,
                            borderColor: config.borderColor,
                            highlighted: true,
                            onTap: () => ref.read(deviceServiceProvider).openSystemSettings(),
                          ),

                        // Wi-Fi / Network Pill
                        _StatusPill(
                          icon: isConnected && wifiEnabled ? Icons.wifi : Icons.wifi_off,
                          label: wifiEnabled
                              ? (isCompactWidth || wifiSsid == 'WLAN_ACTIVE' ? 'Wi-Fi' : wifiSsid)
                              : 'Sin red',
                          color: isConnected ? accent : config.textSecondaryColor,
                          surfaceColor: config.surfaceSecondaryColor,
                          borderColor: config.borderColor,
                          onTap: () => ref.read(deviceServiceProvider).openWifiSettings(),
                        ),

                        // Bluetooth Status
                        _StatusPill(
                          icon: btEnabled ? Icons.bluetooth_connected : Icons.bluetooth,
                          label: btEnabled ? 'BT' : 'Off',
                          color: btEnabled ? secondary : config.textSecondaryColor,
                          surfaceColor: config.surfaceSecondaryColor,
                          borderColor: config.borderColor,
                          onTap: () => ref.read(deviceServiceProvider).openBluetoothSettings(),
                        ),

                        // Battery Percentage
                        _StatusPill(
                          icon: isCharging
                              ? Icons.battery_charging_full_rounded
                              : Icons.battery_full_rounded,
                          label: '$battery%',
                          color: batColor,
                          surfaceColor: config.surfaceSecondaryColor,
                          borderColor: config.borderColor,
                          highlighted: battery <= 20 || isCharging,
                        ),

                        // Light / Dark Mode Quick Toggle
                        CyberTapTarget(
                          pressColor: accent,
                          tooltip: config.isDarkMode ? 'Cambiar a Modo Claro' : 'Cambiar a Modo Oscuro',
                          semanticLabel: 'Alternar tema claro u oscuro',
                          onTap: () {
                            ref
                                .read(cyberdeckConfigProvider.notifier)
                                .setDarkMode(!config.isDarkMode);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: config.surfaceSecondaryColor,
                              border: Border.all(color: config.borderColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              config.isDarkMode
                                  ? Icons.light_mode_outlined
                                  : Icons.dark_mode_outlined,
                              size: 16,
                              color: highlight,
                            ),
                          ),
                        ),

                        // Settings Button
                        CyberTapTarget(
                          pressColor: accent,
                          tooltip: 'Ajustes del Launcher',
                          semanticLabel: 'Ajustes del Launcher',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SettingsScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: accent.withValues(alpha: 0.14),
                              border: Border.all(color: accent.withValues(alpha: 0.4)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.tune_rounded,
                              size: 16,
                              color: accent,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => Text(
                    'Sincronizando...',
                    style: AppTheme.mono(fontSize: 11, color: secondary),
                  ),
                  error: (_, _) => const SizedBox.shrink(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _HeaderClockTicker extends StatefulWidget {
  final bool use24Hour;
  final Color textColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color borderColor;
  final bool compact;

  const _HeaderClockTicker({
    required this.use24Hour,
    required this.textColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.borderColor,
    required this.compact,
  });

  @override
  State<_HeaderClockTicker> createState() => _HeaderClockTickerState();
}

class _HeaderClockTickerState extends State<_HeaderClockTicker> {
  late Timer _timer;
  DateTime _now = DateTime.now();

  static const List<String> _daysEs = [
    'Lun',
    'Mar',
    'Mié',
    'Jue',
    'Vie',
    'Sáb',
    'Dom',
  ];

  static const List<String> _monthsEs = [
    'ene',
    'feb',
    'mar',
    'abr',
    'may',
    'jun',
    'jul',
    'ago',
    'sep',
    'oct',
    'nov',
    'dic',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final current = DateTime.now();
      if (current.minute != _now.minute) {
        if (mounted) {
          setState(() => _now = current);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeStr = widget.use24Hour
        ? DateFormat('HH:mm').format(_now)
        : DateFormat('hh:mm a').format(_now);
    final dayName = _daysEs[(_now.weekday - 1).clamp(0, 6)];
    final monthName = _monthsEs[(_now.month - 1).clamp(0, 11)];
    final fullDate = '$dayName ${_now.day} $monthName';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          timeStr,
          style: AppTheme.mono(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: widget.textColor,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 1,
          height: 15,
          color: widget.borderColor,
        ),
        const SizedBox(width: 10),
        Text(
          fullDate,
          style: AppTheme.mono(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: widget.secondaryColor,
          ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color surfaceColor;
  final Color borderColor;
  final bool highlighted;
  final VoidCallback? onTap;

  const _StatusPill({
    required this.icon,
    required this.label,
    required this.color,
    required this.surfaceColor,
    required this.borderColor,
    this.highlighted = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final pill = Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: highlighted ? color.withValues(alpha: 0.14) : surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: highlighted ? color.withValues(alpha: 0.45) : borderColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: AppTheme.mono(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );

    if (onTap == null) {
      return ConstrainedBox(
        constraints: const BoxConstraints(minHeight: kCyberMinTouchTarget),
        child: Align(widthFactor: 1, heightFactor: 1, child: pill),
      );
    }

    return CyberTapTarget(
      onTap: onTap,
      pressColor: color,
      semanticLabel: label,
      child: pill,
    );
  }
}
