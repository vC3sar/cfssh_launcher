import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../../dashboard/widgets/cyberdeck_panel.dart';
import '../models/health_target_model.dart';
import '../providers/health_checker_provider.dart';
import 'target_modal_dialog.dart';

class HealthCheckerPanel extends ConsumerWidget {
  const HealthCheckerPanel({super.key});

  static const List<({String name, int hex})> _sentinelPalettes = [
    (name: 'Índigo Sentinel', hex: 0xFF6366F1),
    (name: 'Cian Radar', hex: 0xFF06B6D4),
    (name: 'Esmeralda Pulso', hex: 0xFF10B981),
    (name: 'Violeta Neural', hex: 0xFFA855F7),
    (name: 'Ámbar Monitor', hex: 0xFFF59E0B),
  ];

  void _showAddModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const TargetModalDialog(),
    );
  }

  void _showEditModal(BuildContext context, HealthTargetModel target) {
    showDialog(
      context: context,
      builder: (_) => TargetModalDialog(target: target),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    HealthTargetModel target,
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
          'Eliminar Endpoint de Sentinel',
          style: AppTheme.mono(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppTheme.sentinelOffline,
          ),
        ),
        content: Text(
          '¿Deseas desvincular "${target.name}" (${target.endpointLabel}) del monitor en vivo?',
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
              backgroundColor: AppTheme.sentinelOffline,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              ref.read(healthTargetsProvider.notifier).deleteTarget(target.id);
              ref.read(cyberdeckConfigProvider.notifier).logAction(
                    'HEALTH',
                    'Endpoint eliminado -> ${target.name}',
                  );
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

  void _showIntervalAndPaletteSheet(BuildContext context, WidgetRef ref) {
    final intervals = [
      (sec: 5, label: 'Cada 5 segundos', desc: 'Monitoreo en tiempo real de alta frecuencia'),
      (sec: 10, label: 'Cada 10 segundos', desc: 'Frecuencia estándar recomendada'),
      (sec: 15, label: 'Cada 15 segundos', desc: 'Equilibrio óptimo entre precisión y red'),
      (sec: 30, label: 'Cada 30 segundos', desc: 'Bajo consumo de recursos'),
      (sec: 60, label: 'Cada 60 segundos (1 min)', desc: 'Sondeo periódico ligero'),
      (sec: 120, label: 'Cada 120 segundos (2 min)', desc: 'Modo ahorro extendido'),
      (sec: 0, label: 'Pausado (Solo manual)', desc: 'Desactiva el sondeo automático'),
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ref.read(cyberdeckConfigProvider).panelColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) => Consumer(
        builder: (ctx, sheetRef, _) {
          final config = sheetRef.watch(cyberdeckConfigProvider);
          final current = sheetRef.watch(autoProbeIntervalProvider);
          final sentinelColor = config.sentinelAccent;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: sentinelColor.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.monitor_heart_rounded,
                          size: 18,
                          color: sentinelColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Configuración de Sentinel Health Live',
                              style: AppTheme.mono(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: config.textPrimaryColor,
                              ),
                            ),
                            Text(
                              'Personaliza el color propio de Sentinel y su frecuencia de chequeo.',
                              style: AppTheme.mono(
                                fontSize: 11.5,
                                color: config.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Sentinel Custom Color Swatches
                  Text(
                    'COLOR DE IDENTIDAD SENTINEL',
                    style: AppTheme.codeMono(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: config.textSecondaryColor,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _sentinelPalettes.map((swatch) {
                      final selected =
                          config.sentinelAccentColorValue == swatch.hex;
                      final c = Color(swatch.hex);
                      return CyberTapTarget(
                        onTap: () => sheetRef
                            .read(cyberdeckConfigProvider.notifier)
                            .setSentinelAccentColor(swatch.hex),
                        pressColor: c,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? c.withValues(alpha: 0.15)
                                : config.surfaceSecondaryColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selected ? c : config.borderColor,
                              width: selected ? 1.5 : 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 11,
                                height: 11,
                                decoration: BoxDecoration(
                                  color: c,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 7),
                              Text(
                                swatch.name,
                                style: AppTheme.mono(
                                  fontSize: 11.5,
                                  fontWeight: selected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: selected ? c : config.textPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  Divider(color: config.borderColor, height: 26),

                  Text(
                    'FRECUENCIA DE AUTO-SONDEO (TIME RECHECK)',
                    style: AppTheme.codeMono(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: config.textSecondaryColor,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...intervals.map((item) {
                    final isSelected = item.sec == current;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      child: ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 2,
                        ),
                        tileColor: isSelected
                            ? sentinelColor.withValues(alpha: 0.12)
                            : config.surfaceSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: isSelected ? sentinelColor : config.borderColor,
                            width: isSelected ? 1.4 : 1.0,
                          ),
                        ),
                        leading: Icon(
                          item.sec == 0
                              ? Icons.pause_circle_outline_rounded
                              : Icons.timer_outlined,
                          color: isSelected
                              ? sentinelColor
                              : config.textSecondaryColor,
                          size: 20,
                        ),
                        title: Text(
                          item.label,
                          style: AppTheme.mono(
                            fontSize: 12,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? sentinelColor
                                : config.textPrimaryColor,
                          ),
                        ),
                        subtitle: Text(
                          item.desc,
                          style: AppTheme.mono(
                            fontSize: 10.5,
                            color: config.textSecondaryColor,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(
                                Icons.check_circle_rounded,
                                size: 18,
                                color: sentinelColor,
                              )
                            : null,
                        onTap: () {
                          sheetRef
                              .read(autoProbeIntervalProvider.notifier)
                              .setInterval(item.sec);
                          sheetRef
                              .read(cyberdeckConfigProvider.notifier)
                              .logAction(
                                'HEALTH',
                                item.sec > 0
                                    ? 'Intervalo Sentinel -> ${item.sec}s'
                                    : 'Sondeo automático pausado',
                              );
                          Navigator.pop(ctx);
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(cyberdeckConfigProvider);
    final targets = ref.watch(healthTargetsProvider);
    final autoInterval = ref.watch(autoProbeIntervalProvider);
    final isProbingAll = ref.watch(isProbingAllProvider);
    final lastGlobalCheck = ref.watch(lastGlobalCheckProvider);

    // Sentinel uses its own dedicated brand accent & semantic palette
    final sentinelBrand = config.sentinelAccent;
    final highlight = config.highlightAccent;

    // Calculate Summary Stats
    final total = targets.length;
    final onlineCount =
        targets.where((t) => t.status == ProbeStatus.online).length;
    final degradedCount =
        targets.where((t) => t.status == ProbeStatus.degraded).length;
    final offlineCount =
        targets.where((t) => t.status == ProbeStatus.offline).length;

    int totalLatency = 0;
    int measuredCount = 0;
    for (final t in targets) {
      if ((t.status == ProbeStatus.online ||
              t.status == ProbeStatus.degraded) &&
          t.lastLatencyMs != null &&
          t.lastLatencyMs! > 0) {
        totalLatency += t.lastLatencyMs!;
        measuredCount++;
      }
    }
    final avgLatency =
        measuredCount > 0 ? (totalLatency / measuredCount).round() : 0;

    // Global Last Check formatting
    String lastCheckDisplay = 'Sin escaneo';
    if (lastGlobalCheck != null) {
      final timeStr = DateFormat('HH:mm:ss').format(lastGlobalCheck);
      final diff = DateTime.now().difference(lastGlobalCheck);
      final relStr = diff.inSeconds < 5
          ? 'ahora'
          : diff.inSeconds < 60
              ? 'hace ${diff.inSeconds}s'
              : 'hace ${diff.inMinutes}m';
      lastCheckDisplay = '$timeStr ($relStr)';
    }

    return CyberdeckPanel(
      moduleCode: 'SENTINEL',
      title: 'Sentinel Live Health Checker',
      accentColor: sentinelBrand,
      panelColor: config.panelColor,
      showVisualEffects: config.enableVisualEffects,
      actions: [
        // Auto Polling Interval & Palette Button
        CyberTapTarget(
          pressColor: sentinelBrand,
          tooltip: 'Configurar frecuencia y paleta de Sentinel',
          semanticLabel: 'Configurar Sentinel',
          onTap: () => _showIntervalAndPaletteSheet(context, ref),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: autoInterval > 0
                  ? AppTheme.sentinelOnline.withValues(alpha: 0.14)
                  : AppTheme.sentinelDegraded.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: autoInterval > 0
                    ? AppTheme.sentinelOnline.withValues(alpha: 0.45)
                    : AppTheme.sentinelDegraded.withValues(alpha: 0.45),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: autoInterval > 0
                        ? AppTheme.sentinelOnline
                        : AppTheme.sentinelDegraded,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  autoInterval > 0 ? 'Auto ${autoInterval}s' : 'Pausado',
                  style: AppTheme.mono(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: autoInterval > 0
                        ? AppTheme.sentinelOnline
                        : AppTheme.sentinelDegraded,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Probe All Now Button
        CyberTapTarget(
          pressColor: AppTheme.sentinelProbing,
          tooltip: 'Sondear todos los endpoints ahora',
          semanticLabel: 'Sondear todo ahora',
          onTap: isProbingAll
              ? null
              : () => ref.read(healthTargetsProvider.notifier).probeAll(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: AppTheme.sentinelProbing.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.sentinelProbing.withValues(alpha: 0.45),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isProbingAll
                    ? const SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.8,
                          color: AppTheme.sentinelProbing,
                        ),
                      )
                    : const Icon(
                        Icons.bolt_rounded,
                        size: 14,
                        color: AppTheme.sentinelProbing,
                      ),
                const SizedBox(width: 4),
                Text(
                  'Sondear',
                  style: AppTheme.mono(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.sentinelProbing,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Add Target Button
        CyberTapTarget(
          pressColor: sentinelBrand,
          tooltip: 'Añadir nuevo endpoint (TCP / HTTP / UDP)',
          semanticLabel: 'Añadir endpoint',
          onTap: () => _showAddModal(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: sentinelBrand.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: sentinelBrand.withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_rounded, size: 14, color: sentinelBrand),
                const SizedBox(width: 3),
                Text(
                  'Nuevo',
                  style: AppTheme.mono(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: sentinelBrand,
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
          // Telemetry Summary KPI Bar with Sentinel Semantic Pills
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: config.surfaceSecondaryColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: config.borderColor),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildKpiBadge(
                    config: config,
                    label: 'Total',
                    value: total.toString(),
                    color: sentinelBrand,
                  ),
                  const SizedBox(width: 8),
                  _buildKpiBadge(
                    config: config,
                    label: 'Online',
                    value: onlineCount.toString(),
                    color: AppTheme.sentinelOnline,
                  ),
                  const SizedBox(width: 8),
                  _buildKpiBadge(
                    config: config,
                    label: 'Degradado',
                    value: degradedCount.toString(),
                    color: AppTheme.sentinelDegraded,
                  ),
                  const SizedBox(width: 8),
                  _buildKpiBadge(
                    config: config,
                    label: 'Offline',
                    value: offlineCount.toString(),
                    color: AppTheme.sentinelOffline,
                  ),
                  const SizedBox(width: 8),
                  _buildKpiBadge(
                    config: config,
                    label: 'Latencia Media',
                    value: measuredCount > 0 ? '${avgLatency}ms' : '--',
                    color: AppTheme.sentinelProbing,
                  ),
                  const SizedBox(width: 12),
                  // Last Check Spotlight Pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: highlight.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: highlight.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 13,
                          color: highlight,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Último chequeo: ',
                          style: AppTheme.mono(
                            fontSize: 10.5,
                            color: config.textSecondaryColor,
                          ),
                        ),
                        Text(
                          lastCheckDisplay,
                          style: AppTheme.codeMono(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: highlight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Target Endpoints Cards List
          if (targets.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: targets.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, idx) {
                final target = targets[idx];
                return _buildTargetCard(
                  context,
                  ref,
                  target,
                  config,
                  sentinelBrand,
                );
              },
            )
          else
            _buildEmptyState(context, config, sentinelBrand),
        ],
      ),
    );
  }

  Widget _buildKpiBadge({
    required CyberdeckConfig config,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            '$label: ',
            style: AppTheme.mono(
              fontSize: 10.5,
              color: config.textSecondaryColor,
            ),
          ),
          Text(
            value,
            style: AppTheme.codeMono(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetCard(
    BuildContext context,
    WidgetRef ref,
    HealthTargetModel target,
    CyberdeckConfig config,
    Color sentinelBrand,
  ) {
    final statusColor = _getStatusColor(target.status);
    final protoColor = _getProtocolColor(target.protocol);

    return Container(
      decoration: BoxDecoration(
        color: config.surfaceSecondaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: target.isEnabled
              ? statusColor.withValues(alpha: 0.45)
              : config.borderColor,
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Target Header Row
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 10, 8),
            child: Row(
              children: [
                // Distinct Protocol Pill (TCP / HTTP / UDP)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: protoColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: protoColor.withValues(alpha: 0.55),
                    ),
                  ),
                  child: Text(
                    target.protocol.displayName,
                    style: AppTheme.codeMono(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: protoColor,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Target Name & Endpoint address
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        target.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.mono(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: target.isEnabled
                              ? config.textPrimaryColor
                              : config.textSecondaryColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        target.endpointLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.codeMono(
                          fontSize: 10.5,
                          color: config.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Semantic Status Badge & Latency
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.55),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (target.status == ProbeStatus.probing)
                        SizedBox(
                          width: 10,
                          height: 10,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.6,
                            color: statusColor,
                          ),
                        )
                      else
                        Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      const SizedBox(width: 6),
                      Text(
                        target.status.label,
                        style: AppTheme.mono(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                        ),
                      ),
                      if (target.lastLatencyMs != null &&
                          target.lastLatencyMs! > 0) ...[
                        const SizedBox(width: 6),
                        Text(
                          '${target.lastLatencyMs}ms',
                          style: AppTheme.codeMono(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: config.textPrimaryColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, thickness: 1, color: config.borderColor),

          // Telemetry and Color-Coded Controls Row
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 10, 8),
            child: Row(
              children: [
                // Mini Latency History Sparkline, Last Check & Diagnostic Message
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              'Historial: ',
                              style: AppTheme.mono(
                                fontSize: 10,
                                color: config.textSecondaryColor,
                              ),
                            ),
                            const SizedBox(width: 4),
                            ...List.generate(8, (i) {
                              final history = target.latencyHistory;
                              int? val;
                              if (i < history.length) {
                                val = history[history.length -
                                    1 -
                                    (7 - i >= history.length ? 0 : 7 - i)];
                              }
                              return _buildSparklineBar(val, config);
                            }),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.sentinelOnline
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Uptime ${target.uptimePercentage.toStringAsFixed(1)}%',
                                style: AppTheme.codeMono(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.sentinelOnline,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Last Check Badge per target
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: config.panelColor,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: config.borderColor),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.schedule_rounded,
                                    size: 10,
                                    color: sentinelBrand,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${target.formattedLastChecked} (${target.relativeLastChecked})',
                                    style: AppTheme.codeMono(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
                                      color: target.lastChecked != null
                                          ? config.textPrimaryColor
                                          : config.textSecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        target.statusMessage ??
                            'En espera del próximo ciclo de sondeo...',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.codeMono(
                          fontSize: 10,
                          color: target.status == ProbeStatus.offline
                              ? AppTheme.sentinelOffline
                              : config.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Dedicated Color-Coded Action Controls
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 1. Single Probe Now (Sky Blue)
                    _buildTargetActionBtn(
                      icon: Icons.bolt_rounded,
                      color: AppTheme.sentinelProbing,
                      tooltip: 'Sondear este endpoint ahora',
                      onTap: target.status == ProbeStatus.probing
                          ? null
                          : () => ref
                              .read(healthTargetsProvider.notifier)
                              .probeTarget(target.id),
                    ),
                    const SizedBox(width: 6),

                    // 2. Toggle Enable/Disable (Amber when pausing / Emerald when resuming)
                    _buildTargetActionBtn(
                      icon: target.isEnabled
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: target.isEnabled
                          ? AppTheme.sentinelDegraded
                          : AppTheme.sentinelOnline,
                      tooltip: target.isEnabled
                          ? 'Pausar monitorización'
                          : 'Reanudar monitorización',
                      onTap: () => ref
                          .read(healthTargetsProvider.notifier)
                          .toggleTargetEnabled(target.id),
                    ),
                    const SizedBox(width: 6),

                    // 3. Edit Target (Sentinel Brand Accent)
                    _buildTargetActionBtn(
                      icon: Icons.tune_rounded,
                      color: sentinelBrand,
                      tooltip: 'Editar endpoint',
                      onTap: () => _showEditModal(context, target),
                    ),
                    const SizedBox(width: 6),

                    // 4. Delete Target (Rose Coral)
                    _buildTargetActionBtn(
                      icon: Icons.delete_outline_rounded,
                      color: AppTheme.sentinelOffline,
                      tooltip: 'Eliminar endpoint',
                      onTap: () => _confirmDelete(context, ref, target),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetActionBtn({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback? onTap,
  }) {
    return CyberTapTarget(
      onTap: onTap,
      pressColor: color,
      tooltip: tooltip,
      semanticLabel: tooltip,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.13),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Icon(icon, size: 15, color: color),
      ),
    );
  }

  Widget _buildSparklineBar(int? latencyMs, CyberdeckConfig config) {
    Color barColor;
    double height = 4.0;

    if (latencyMs == null) {
      barColor = config.borderColor;
      height = 4.0;
    } else if (latencyMs == 0) {
      barColor = AppTheme.sentinelOffline;
      height = 11.0;
    } else if (latencyMs < 80) {
      barColor = AppTheme.sentinelOnline;
      height = 6.5;
    } else if (latencyMs < 220) {
      barColor = AppTheme.sentinelProbing;
      height = 9.0;
    } else {
      barColor = AppTheme.sentinelDegraded;
      height = 12.0;
    }

    return Container(
      width: 4,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 1.5),
      alignment: Alignment.bottomCenter,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: barColor,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    CyberdeckConfig config,
    Color sentinelBrand,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: config.surfaceSecondaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: config.borderColor),
      ),
      child: Column(
        children: [
          Icon(
            Icons.monitor_heart_outlined,
            size: 38,
            color: sentinelBrand,
          ),
          const SizedBox(height: 10),
          Text(
            'Sentinel Health Checker · Sin Endpoints Activos',
            style: AppTheme.mono(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: config.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Añade puntos de control TCP, HTTP o UDP para supervisar su latencia y disponibilidad en tiempo real.',
            textAlign: TextAlign.center,
            style: AppTheme.mono(
              fontSize: 11.5,
              color: config.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: sentinelBrand,
              foregroundColor: Colors.white,
              minimumSize: const Size(170, 42),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => _showAddModal(context),
            icon: const Icon(Icons.add_rounded, size: 17, color: Colors.white),
            label: Text(
              'Registrar Endpoint',
              style: AppTheme.mono(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Color _getStatusColor(ProbeStatus status) {
    switch (status) {
      case ProbeStatus.online:
        return AppTheme.sentinelOnline;
      case ProbeStatus.degraded:
        return AppTheme.sentinelDegraded;
      case ProbeStatus.offline:
        return AppTheme.sentinelOffline;
      case ProbeStatus.probing:
        return AppTheme.sentinelProbing;
      case ProbeStatus.unknown:
        return const Color(0xFF94A3B8);
    }
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
}
