import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../../../services/device_service.dart';
import '../../apps/app_drawer_screen.dart';
import '../../apps/apps_provider.dart';
import '../../shortcuts/shortcut_dialog.dart';
import '../../shortcuts/shortcut_model.dart';
import '../../shortcuts/shortcuts_provider.dart';
import 'cyberdeck_panel.dart';

class AppGridWidget extends ConsumerWidget {
  const AppGridWidget({super.key});

  Future<void> _executeShortcut(
    BuildContext context,
    WidgetRef ref,
    ShortcutModel shortcut,
  ) async {
    ref
        .read(cyberdeckConfigProvider.notifier)
        .logAction('SHORTCUT', '${shortcut.type.toUpperCase()}: ${shortcut.title}');

    if (shortcut.type == 'url') {
      await ref.read(deviceServiceProvider).openBrowser(url: shortcut.value);
    } else if (shortcut.type == 'ssh') {
      final launched =
          await ref.read(deviceServiceProvider).launchAppByKeyword('cfssh');
      if (!launched) {
        await ref.read(deviceServiceProvider).launchAppByKeyword('term');
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Objetivo SSH: ${shortcut.value}')),
        );
      }
    } else if (shortcut.type == 'cmd') {
      _runCommandDialog(context, ref, shortcut);
    }
  }

  void _runCommandDialog(
    BuildContext context,
    WidgetRef ref,
    ShortcutModel shortcut,
  ) {
    final config = ref.read(cyberdeckConfigProvider);
    final accent = config.primaryAccent;

    showDialog(
      context: context,
      builder: (ctx) {
        return FutureBuilder<ProcessResult>(
          future: Process.run('sh', ['-c', shortcut.value]),
          builder: (ctx, snapshot) {
            String output = '\$ ${shortcut.value}\n\n';
            if (snapshot.connectionState == ConnectionState.waiting) {
              output += 'Ejecutando comando...';
            } else if (snapshot.hasError) {
              output += 'Error: ${snapshot.error}';
            } else if (snapshot.hasData) {
              final out = snapshot.data!.stdout.toString();
              final err = snapshot.data!.stderr.toString();
              output += out.isNotEmpty ? out : '(Sin salida)';
              if (err.isNotEmpty) output += '\n[STDERR]\n$err';
            }

            return AlertDialog(
              backgroundColor: config.panelColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: config.borderColor),
              ),
              title: Text(
                shortcut.title,
                style: AppTheme.mono(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: config.textPrimaryColor,
                ),
              ),
              content: SizedBox(
                width: 460,
                height: 240,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: config.surfaceSecondaryColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: config.borderColor),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      output,
                      style: AppTheme.codeMono(
                        fontSize: 11.5,
                        color: config.textPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    'Cerrar',
                    style: AppTheme.mono(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: accent,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showShortcutOptions(
    BuildContext context,
    WidgetRef ref,
    ShortcutModel shortcut,
  ) {
    final config = ref.read(cyberdeckConfigProvider);
    showModalBottomSheet(
      context: context,
      backgroundColor: config.panelColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit_outlined, color: config.primaryAccent),
              title: Text(
                'Editar acceso directo',
                style: AppTheme.mono(fontSize: 13.5, color: config.textPrimaryColor),
              ),
              onTap: () {
                Navigator.pop(ctx);
                showDialog(
                  context: context,
                  builder: (_) => ShortcutDialog(shortcut: shortcut),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded, color: AppTheme.error),
              title: Text(
                'Eliminar acceso directo',
                style: AppTheme.mono(fontSize: 13.5, color: AppTheme.error),
              ),
              onTap: () async {
                Navigator.pop(ctx);
                if (shortcut.id != null) {
                  await ref
                      .read(databaseServiceProvider)
                      .deleteShortcut(shortcut.id!);
                  ref.invalidate(shortcutsProvider);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFavoriteAppsSelector(
    BuildContext context,
    WidgetRef ref,
    List<InstalledApp> allApps,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => Consumer(
        builder: (ctx, dRef, _) {
          final cfg = dRef.watch(cyberdeckConfigProvider);
          final accent = cfg.primaryAccent;
          return AlertDialog(
            backgroundColor: cfg.panelColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: cfg.borderColor),
            ),
            title: Text(
              'Seleccionar Aplicaciones Favoritas',
              style: AppTheme.mono(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: cfg.textPrimaryColor,
              ),
            ),
            content: SizedBox(
              width: 420,
              height: 360,
              child: ListView.builder(
                itemCount: allApps.length,
                itemBuilder: (ctx, i) {
                  final app = allApps[i];
                  final isFav = cfg.favoritePackages.contains(app.packageName);
                  return CheckboxListTile(
                    value: isFav,
                    activeColor: accent,
                    checkColor: Colors.white,
                    dense: true,
                    secondary: app.icon != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.memory(app.icon!, width: 28, height: 28),
                          )
                        : Icon(Icons.apps_rounded, color: accent, size: 26),
                    title: Text(
                      app.name,
                      style: AppTheme.mono(
                        fontSize: 13,
                        fontWeight: isFav ? FontWeight.w600 : FontWeight.w400,
                        color: cfg.textPrimaryColor,
                      ),
                    ),
                    subtitle: Text(
                      app.packageName,
                      style: AppTheme.codeMono(
                        fontSize: 10,
                        color: cfg.textSecondaryColor,
                      ),
                    ),
                    onChanged: (_) {
                      dRef
                          .read(cyberdeckConfigProvider.notifier)
                          .toggleFavoriteApp(app.packageName, appName: app.name);
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(
                  'Listo',
                  style: AppTheme.mono(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: accent,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appsAsync = ref.watch(installedAppsProvider);
    final shortcutsAsync = ref.watch(shortcutsProvider);
    final config = ref.watch(cyberdeckConfigProvider);
    final accent = config.primaryAccent;
    final secondary = config.secondaryAccent;

    return CyberdeckPanel(
      moduleCode: 'FAVORITOS',
      title: 'Aplicaciones y Accesos Rápidos',
      accentColor: accent,
      panelColor: config.panelColor,
      showVisualEffects: config.enableVisualEffects,
      padding: EdgeInsets.all(14 * config.paddingScale),
      actions: [
        appsAsync.maybeWhen(
          data: (apps) => CyberTapTarget(
            pressColor: accent,
            tooltip: 'Editar aplicaciones favoritas',
            semanticLabel: 'Editar aplicaciones favoritas',
            onTap: () => _showFavoriteAppsSelector(context, ref, apps),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: config.surfaceSecondaryColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: config.borderColor),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 14,
                    color: config.highlightAccent,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Editar',
                    style: AppTheme.mono(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: config.textPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        ),
        CyberIconAction(
          icon: Icons.apps_rounded,
          color: config.textSecondaryColor,
          tooltip: 'Todas las aplicaciones',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AppDrawerScreen()),
            );
          },
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 4;
          if (constraints.maxWidth > 480) crossAxisCount = 5;
          if (constraints.maxWidth > 680) crossAxisCount = 6;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Shortcuts Section (SSH / URL / CMD)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Accesos Directos (SSH · Web · Terminal)',
                    style: AppTheme.mono(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: config.textSecondaryColor,
                    ),
                  ),
                  CyberTapTarget(
                    pressColor: accent,
                    semanticLabel: 'Nuevo acceso directo',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => const ShortcutDialog(),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Text(
                        '+ Añadir',
                        style: AppTheme.mono(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: accent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              shortcutsAsync.when(
                data: (shortcuts) {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...shortcuts.map(
                        (s) => _buildShortcutChip(
                          context,
                          ref,
                          s,
                          config,
                          accent,
                          secondary,
                        ),
                      ),
                      if (shortcuts.isEmpty)
                        _buildAddShortcutChip(context, config, accent),
                    ],
                  );
                },
                loading: () => const SizedBox(height: 36),
                error: (_, _) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 16),

              // 2. Favorite & Pinned Applications Grid
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    config.favoritePackages.isEmpty
                        ? 'Aplicaciones Destacadas'
                        : 'Favoritos (${config.favoritePackages.length})',
                    style: AppTheme.mono(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: config.textSecondaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              appsAsync.when(
                data: (apps) {
                  if (apps.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          'No se encontraron aplicaciones instaladas',
                          style: AppTheme.mono(
                            fontSize: 12,
                            color: config.textSecondaryColor,
                          ),
                        ),
                      ),
                    );
                  }

                  List<InstalledApp> displayApps;
                  if (config.favoritePackages.isNotEmpty) {
                    displayApps = apps
                        .where((a) => config.favoritePackages.contains(a.packageName))
                        .toList();
                    if (displayApps.isEmpty) {
                      displayApps = apps.take(crossAxisCount * 2).toList();
                    }
                  } else {
                    displayApps = apps.take(crossAxisCount * 2).toList();
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.92,
                    ),
                    itemCount: displayApps.length,
                    itemBuilder: (context, index) {
                      return _buildAppItem(
                        context,
                        ref,
                        displayApps[index],
                        config,
                        accent,
                      );
                    },
                  );
                },
                loading: () => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2, color: accent),
                  ),
                ),
                error: (_, _) => Text(
                  'Error al cargar aplicaciones',
                  style: AppTheme.mono(fontSize: 12, color: AppTheme.error),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildShortcutChip(
    BuildContext context,
    WidgetRef ref,
    ShortcutModel shortcut,
    CyberdeckConfig config,
    Color accent,
    Color secondary,
  ) {
    IconData iconData = Icons.language_rounded;
    Color tagColor = secondary;
    if (shortcut.type == 'ssh') {
      iconData = Icons.terminal_rounded;
      tagColor = accent;
    } else if (shortcut.type == 'cmd') {
      iconData = Icons.code_rounded;
      tagColor = AppTheme.amberAlert;
    }

    return CyberTapTarget(
      onTap: () => _executeShortcut(context, ref, shortcut),
      onLongPress: () => _showShortcutOptions(context, ref, shortcut),
      pressColor: tagColor,
      semanticLabel: '${shortcut.type.toUpperCase()}: ${shortcut.title}',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: config.surfaceSecondaryColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: config.borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, size: 15, color: tagColor),
            const SizedBox(width: 6),
            Text(
              shortcut.title,
              style: AppTheme.mono(
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: config.textPrimaryColor,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: tagColor.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                shortcut.type.toUpperCase(),
                style: AppTheme.codeMono(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: tagColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddShortcutChip(
    BuildContext context,
    CyberdeckConfig config,
    Color accent,
  ) {
    return CyberTapTarget(
      onTap: () {
        showDialog(context: context, builder: (_) => const ShortcutDialog());
      },
      pressColor: accent,
      semanticLabel: 'Añadir acceso',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: config.surfaceSecondaryColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: config.borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add_rounded, size: 15, color: accent),
            const SizedBox(width: 4),
            Text(
              'Crear acceso directo',
              style: AppTheme.mono(
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: config.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppItem(
    BuildContext context,
    WidgetRef ref,
    InstalledApp app,
    CyberdeckConfig config,
    Color accent,
  ) {
    return CyberTapTarget(
      onTap: () {
        ref
            .read(cyberdeckConfigProvider.notifier)
            .recordAppLaunch(app.packageName, appName: app.name);
        ref.read(deviceServiceProvider).launchApp(app.packageName);
      },
      onLongPress: () {
        ref.read(deviceServiceProvider).openAppInfo(app.packageName);
      },
      pressColor: accent,
      fillWidth: true,
      semanticLabel: app.name,
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          color: config.surfaceSecondaryColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: config.borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (app.icon != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.memory(
                  app.icon!,
                  width: 44,
                  height: 44,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.medium,
                ),
              )
            else
              Icon(Icons.apps_rounded, size: 42, color: accent),
            const SizedBox(height: 6),
            Text(
              app.name,
              style: AppTheme.mono(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: config.textPrimaryColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
