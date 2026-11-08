import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../../../services/device_service.dart';
import '../../apps/apps_provider.dart';
import '../../monitor/monitor_screen.dart';
import 'cyberdeck_panel.dart';

class CalendarModuleWidget extends ConsumerWidget {
  const CalendarModuleWidget({super.key});

  void _showAddTacticalNoteDialog(BuildContext context, WidgetRef ref) {
    final ctrl = TextEditingController();
    final config = ref.read(cyberdeckConfigProvider);
    final accent = config.primaryAccent;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: config.panelColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: config.borderColor),
        ),
        title: Text(
          'Nueva Nota o Recordatorio',
          style: AppTheme.mono(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: config.textPrimaryColor,
          ),
        ),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          style: AppTheme.mono(fontSize: 13, color: config.textPrimaryColor),
          decoration: InputDecoration(
            hintText: 'Ej: Revisar servidor SSH a las 22:00...',
            hintStyle: AppTheme.mono(
              fontSize: 12,
              color: config.textSecondaryColor,
            ),
            filled: true,
            fillColor: config.surfaceSecondaryColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: config.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: accent),
            ),
          ),
          onSubmitted: (val) {
            if (val.trim().isNotEmpty) {
              ref.read(cyberdeckConfigProvider.notifier).addTacticalNote(val);
              Navigator.pop(ctx);
            }
          },
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
            style: ElevatedButton.styleFrom(backgroundColor: accent),
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                ref
                    .read(cyberdeckConfigProvider.notifier)
                    .addTacticalNote(ctrl.text);
                Navigator.pop(ctx);
              }
            },
            child: Text(
              'Guardar',
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
    final calAsync = ref.watch(calendarEventsProvider);
    final accent = config.primaryAccent;
    final secondary = config.secondaryAccent;

    return CyberdeckPanel(
      moduleCode: 'AGENDA',
      title: 'Calendario y Recordatorios',
      accentColor: secondary,
      panelColor: config.panelColor,
      showVisualEffects: config.enableVisualEffects,
      padding: EdgeInsets.all(14 * config.paddingScale),
      actions: [
        CyberIconAction(
          icon: Icons.add_rounded,
          color: accent,
          tooltip: 'Añadir recordatorio',
          onTap: () => _showAddTacticalNoteDialog(context, ref),
        ),
        CyberIconAction(
          icon: Icons.refresh_rounded,
          color: config.textSecondaryColor,
          tooltip: 'Actualizar calendario',
          onTap: () => ref.invalidate(calendarEventsProvider),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // System Calendar Events Section
          calAsync.when(
            data: (calData) {
              if (!calData.authorized) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: config.surfaceSecondaryColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: config.borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.event_note_rounded, size: 17, color: secondary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Permiso de calendario no concedido.',
                          style: AppTheme.mono(
                            fontSize: 11.5,
                            color: config.textSecondaryColor,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await ref
                              .read(deviceServiceProvider)
                              .requestCalendarPermission();
                          Future.delayed(const Duration(seconds: 2), () {
                            ref.invalidate(calendarEventsProvider);
                          });
                        },
                        child: Text(
                          'Autorizar',
                          style: AppTheme.mono(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (calData.events.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    'Sin eventos programados en los próximos 7 días.',
                    style: AppTheme.mono(
                      fontSize: 11.5,
                      color: config.textSecondaryColor,
                    ),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Próximos Eventos (${calData.events.length})',
                    style: AppTheme.mono(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: config.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...calData.events.take(3).map((ev) {
                    final dateFmt = ev.allDay
                        ? '${DateFormat('dd/MM').format(ev.begin)} · Todo el día'
                        : DateFormat('dd/MM HH:mm').format(ev.begin);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: config.surfaceSecondaryColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: config.borderColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              ev.title,
                              style: AppTheme.mono(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: config.textPrimaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            dateFmt,
                            style: AppTheme.codeMono(
                              fontSize: 10.5,
                              color: secondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              );
            },
            loading: () => const SizedBox(height: 24),
            error: (_, _) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 10),
          // Daily Notes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notas Rápidas',
                style: AppTheme.mono(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: config.textSecondaryColor,
                ),
              ),
              _TextLinkAction(
                label: '+ Añadir nota',
                color: accent,
                onTap: () => _showAddTacticalNoteDialog(context, ref),
              ),
            ],
          ),
          if (config.tacticalNotes.isEmpty)
            Text(
              'No hay notas pendientes.',
              style: AppTheme.mono(
                fontSize: 11.5,
                color: config.textSecondaryColor,
              ),
            )
          else
            ...List.generate(config.tacticalNotes.take(4).length, (idx) {
              final note = config.tacticalNotes[idx];
              return Row(
                children: [
                  Icon(Icons.circle, size: 6, color: accent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      note,
                      style: AppTheme.mono(
                        fontSize: 12,
                        color: config.textPrimaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CyberIconAction(
                    icon: Icons.check_circle_outline_rounded,
                    color: config.textSecondaryColor,
                    iconSize: 17,
                    tooltip: 'Completar nota',
                    onTap: () => ref
                        .read(cyberdeckConfigProvider.notifier)
                        .removeTacticalNote(idx),
                  ),
                ],
              );
            }),
        ],
      ),
    );
  }
}

class _TextLinkAction extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _TextLinkAction({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CyberTapTarget(
      onTap: onTap,
      pressColor: color,
      semanticLabel: label,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Text(
          label,
          style: AppTheme.mono(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
  }
}

class ActivityFeedModuleWidget extends ConsumerWidget {
  const ActivityFeedModuleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(cyberdeckConfigProvider);
    final appsAsync = ref.watch(installedAppsProvider);
    final usageAsync = ref.watch(usageRecentsProvider);
    final notifsAsync = ref.watch(activeNotificationsProvider);
    final accent = config.primaryAccent;
    final secondary = config.secondaryAccent;

    return CyberdeckPanel(
      moduleCode: 'ACTIVIDAD',
      title: 'Recientes y Notificaciones',
      accentColor: accent,
      panelColor: config.panelColor,
      showVisualEffects: config.enableVisualEffects,
      padding: EdgeInsets.all(14 * config.paddingScale),
      actions: [
        CyberIconAction(
          icon: Icons.refresh_rounded,
          color: config.textSecondaryColor,
          tooltip: 'Actualizar actividad',
          onTap: () {
            ref.invalidate(usageRecentsProvider);
            ref.invalidate(activeNotificationsProvider);
          },
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Recent Applications Strip
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Aplicaciones Recientes',
                style: AppTheme.mono(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: config.textSecondaryColor,
                ),
              ),
              usageAsync.maybeWhen(
                data: (u) => !u.authorized
                    ? _TextLinkAction(
                        label: 'Conceder acceso de uso',
                        color: accent,
                        onTap: () => ref
                            .read(deviceServiceProvider)
                            .openUsageAccessSettings(),
                      )
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 6),
          appsAsync.when(
            data: (apps) {
              final usagePackages = usageAsync.maybeWhen(
                data: (u) => u.packages,
                orElse: () => const <String>[],
              );
              final combinedPkgOrder = <String>{
                ...config.recentPackages,
                ...usagePackages,
              }.toList();

              // Only match against genuinely installed apps -> zero ghost apps
              final recentApps = <InstalledApp>[];
              for (final pkg in combinedPkgOrder) {
                final match = apps.where((a) => a.packageName == pkg).firstOrNull;
                if (match != null) recentApps.add(match);
                if (recentApps.length >= 5) break;
              }
              if (recentApps.isEmpty) {
                recentApps.addAll(apps.take(4));
              }

              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: recentApps.map((app) {
                  return CyberTapTarget(
                    pressColor: accent,
                    semanticLabel: 'Abrir ${app.name}',
                    onTap: () {
                      ref
                          .read(cyberdeckConfigProvider.notifier)
                          .recordAppLaunch(app.packageName, appName: app.name);
                      ref.read(deviceServiceProvider).launchApp(app.packageName);
                    },
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
                          if (app.icon != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.memory(
                                app.icon!,
                                width: 18,
                                height: 18,
                              ),
                            )
                          else
                            Icon(Icons.apps_rounded, size: 18, color: accent),
                          const SizedBox(width: 7),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 105),
                            child: Text(
                              app.name,
                              style: AppTheme.mono(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                                color: config.textPrimaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const SizedBox(height: 28),
            error: (_, _) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 12),

          // 2. Authorized System Notifications Section
          notifsAsync.when(
            data: (notifState) {
              if (!notifState.authorized) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                          'Notificaciones desvinculadas',
                          style: AppTheme.mono(
                            fontSize: 11.5,
                            color: config.textSecondaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _TextLinkAction(
                        label: 'Activar',
                        color: secondary,
                        onTap: () => ref
                            .read(deviceServiceProvider)
                            .openNotificationAccessSettings(),
                      ),
                    ],
                  ),
                );
              }

              if (notifState.notifications.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Sin notificaciones pendientes.',
                    style: AppTheme.mono(
                      fontSize: 11.5,
                      color: config.textSecondaryColor,
                    ),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notificaciones (${notifState.notifications.length})',
                    style: AppTheme.mono(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: config.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...notifState.notifications.take(2).map((n) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: config.surfaceSecondaryColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: config.borderColor),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.notifications_none_rounded,
                            size: 15,
                            color: accent,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${n.title}: ${n.text}',
                              style: AppTheme.mono(
                                fontSize: 11.5,
                                color: config.textPrimaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 6),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),

          // 3. Activity Log
          Text(
            'Registro de Actividad',
            style: AppTheme.mono(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: config.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: config.surfaceSecondaryColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: config.borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: config.activityLog.take(4).map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '${entry.timestamp} · ${entry.message}',
                    style: AppTheme.codeMono(
                      fontSize: 10.5,
                      color: entry.category == 'ALERT'
                          ? AppTheme.amberAlert
                          : config.textSecondaryColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
