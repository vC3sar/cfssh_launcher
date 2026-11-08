import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import 'cyberdeck_panel.dart';

class ClockModuleWidget extends ConsumerStatefulWidget {
  const ClockModuleWidget({super.key});

  @override
  ConsumerState<ClockModuleWidget> createState() => _ClockModuleWidgetState();
}

class _ClockModuleWidgetState extends ConsumerState<ClockModuleWidget> {
  Timer? _timer;
  DateTime _now = DateTime.now();

  static const List<String> _shortDays = [
    'LUN',
    'MAR',
    'MIÉ',
    'JUE',
    'VIE',
    'SÁB',
    'DOM',
  ];

  static const List<String> _fullMonths = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => _now = DateTime.now());
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _contextualGreeting(int hour) {
    if (hour >= 5 && hour < 12) {
      return 'Buenos días';
    } else if (hour >= 12 && hour < 19) {
      return 'Buenas tardes';
    } else {
      return 'Buenas noches';
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(cyberdeckConfigProvider);
    final accent = config.primaryAccent;
    final highlight = config.highlightAccent;

    final mainTimeStr = config.use24HourFormat
        ? DateFormat('HH:mm').format(_now)
        : DateFormat('hh:mm').format(_now);
    final secondsStr = DateFormat('ss').format(_now);
    final amPmStr = DateFormat('a').format(_now).toUpperCase();

    final dayOfYear = int.parse(DateFormat('D').format(_now));
    final weekOfYear = ((dayOfYear - _now.weekday + 10) / 7).floor();
    final monthStr = _fullMonths[(_now.month - 1).clamp(0, 11)];

    // Generate 7-day strip starting Monday of current week
    final monday = _now.subtract(Duration(days: _now.weekday - 1));

    return CyberdeckPanel(
      moduleCode: 'RELOJ',
      title: 'Fecha y Hora',
      accentColor: accent,
      panelColor: config.panelColor,
      statusLabel: 'SEM $weekOfYear · DÍA $dayOfYear',
      showVisualEffects: config.enableVisualEffects,
      padding: EdgeInsets.all(16 * config.paddingScale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Greeting & Full Date Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accent.withValues(alpha: 0.35)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: highlight,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _contextualGreeting(_now.hour),
                      style: AppTheme.mono(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: accent,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Text(
                  '${_shortDays[(_now.weekday - 1).clamp(0, 6)]}, ${_now.day} de $monthStr de ${_now.year}',
                  style: AppTheme.mono(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: config.textPrimaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Hero Digital Clock (Extra Large & High-Visibility)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: config.surfaceSecondaryColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: config.borderColor),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          mainTimeStr,
                          style: AppTheme.clockHero(
                            family: config.fontFamily,
                            color: config.textPrimaryColor,
                            baseSize: 78,
                          ),
                        ),
                        if (config.showSeconds) ...[
                          const SizedBox(width: 8),
                          Text(
                            ':$secondsStr',
                            style: AppTheme.clockHero(
                              family: config.fontFamily,
                              color: highlight,
                              baseSize: 38,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!config.use24HourFormat)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: highlight.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            color: highlight.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Text(
                          amPmStr,
                          style: AppTheme.mono(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: highlight,
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: highlight.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            color: highlight.withValues(alpha: 0.45),
                          ),
                        ),
                        child: Text(
                          '24H · ${DateTime.now().timeZoneName}',
                          style: AppTheme.codeMono(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: highlight,
                          ),
                        ),
                      ),
                    const SizedBox(height: 6),
                    Text(
                      config.showSeconds
                          ? 'Tiempo real activo'
                          : 'Seg: :$secondsStr',
                      style: AppTheme.codeMono(
                        fontSize: 11,
                        color: config.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 7-Day Minimalist Calendar Strip with Spotlight Highlight for Today
          Row(
            children: List.generate(7, (idx) {
              final dayDate = monday.add(Duration(days: idx));
              final isToday = dayDate.day == _now.day &&
                  dayDate.month == _now.month &&
                  dayDate.year == _now.year;

              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: idx == 6 ? 0 : 6),
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                    color: isToday
                        ? highlight.withValues(alpha: 0.16)
                        : config.surfaceSecondaryColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isToday ? highlight : config.borderColor,
                      width: isToday ? 1.6 : 1.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        isToday ? 'HOY' : _shortDays[idx],
                        style: AppTheme.mono(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: isToday ? highlight : config.textSecondaryColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        dayDate.day.toString().padLeft(2, '0'),
                        style: AppTheme.mono(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isToday ? highlight : config.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
