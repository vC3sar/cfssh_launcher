import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/cyber_tap_target.dart';
import '../../services/device_service.dart';
import '../settings/settings_screen.dart';
import 'apps_provider.dart';

class AppDrawerScreen extends ConsumerStatefulWidget {
  const AppDrawerScreen({super.key});

  @override
  ConsumerState<AppDrawerScreen> createState() => _AppDrawerScreenState();
}

class _AppDrawerScreenState extends ConsumerState<AppDrawerScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _onlyFavorites = false;
  bool _isManualSyncing = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _triggerManualSync() async {
    if (_isManualSyncing) return;
    setState(() => _isManualSyncing = true);
    try {
      await ref.read(installedAppsProvider.notifier).syncApps(forceRefresh: true);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lista de aplicaciones e iconos sincronizada'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isManualSyncing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appsAsync = ref.watch(installedAppsProvider);
    final config = ref.watch(cyberdeckConfigProvider);
    final accent = config.primaryAccent;
    final secondary = config.secondaryAccent;

    return Scaffold(
      backgroundColor: config.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Clean Spotlight-style Header Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: config.panelColor,
                border: Border(
                  bottom: BorderSide(color: config.borderColor, width: 1),
                ),
              ),
              child: Row(
                children: [
                  if (Navigator.canPop(context)) ...[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: config.textPrimaryColor,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 6),
                  ],
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: AppTheme.mono(
                        fontSize: 13.5,
                        color: config.textPrimaryColor,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Buscar aplicaciones...',
                        hintStyle: AppTheme.mono(
                          fontSize: 13,
                          color: config.textSecondaryColor,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: config.textSecondaryColor,
                          size: 19,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.cancel_rounded,
                                  size: 17,
                                  color: config.textSecondaryColor,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _searchQuery = '');
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: config.surfaceSecondaryColor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: config.borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: config.borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: accent, width: 1.4),
                        ),
                      ),
                      onChanged: (val) =>
                          setState(() => _searchQuery = val.toLowerCase()),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Filter Favorites Toggle
                  CyberTapTarget(
                    onTap: () =>
                        setState(() => _onlyFavorites = !_onlyFavorites),
                    pressColor: config.highlightAccent,
                    semanticLabel: _onlyFavorites
                        ? 'Mostrar todas las aplicaciones'
                        : 'Filtrar solo favoritas',
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: _onlyFavorites
                            ? config.highlightAccent
                            : config.surfaceSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _onlyFavorites
                              ? config.highlightAccent
                              : config.borderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _onlyFavorites
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: 17,
                            color: _onlyFavorites
                                ? Colors.white
                                : config.highlightAccent,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Favoritos',
                            style: AppTheme.mono(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _onlyFavorites
                                  ? Colors.white
                                  : config.textPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Manual Package Sync Button
                  CyberTapTarget(
                    onTap: _triggerManualSync,
                    pressColor: accent,
                    tooltip: 'Sincronizar aplicaciones instaladas',
                    semanticLabel: 'Sincronizar aplicaciones instaladas',
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: config.surfaceSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: config.borderColor),
                      ),
                      child: _isManualSyncing
                          ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: accent,
                              ),
                            )
                          : Icon(
                              Icons.sync_rounded,
                              size: 17,
                              color: config.textPrimaryColor,
                            ),
                    ),
                  ),
                ],
              ),
            ),

            // Active Icon Pack Status Bar
            if (config.selectedIconPack != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: config.surfaceSecondaryColor,
                  border: Border(
                    bottom: BorderSide(color: config.borderColor, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.palette_outlined, size: 14, color: accent),
                        const SizedBox(width: 6),
                        Text(
                          'Icon Pack activo: ${config.selectedIconPack}',
                          style: AppTheme.mono(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: config.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Cambiar',
                        style: AppTheme.mono(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: accent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Applications Grid
            Expanded(
              child: appsAsync.when(
                data: (apps) {
                  final filteredApps = apps.where((app) {
                    final matchesQuery =
                        app.name.toLowerCase().contains(_searchQuery) ||
                            app.packageName.toLowerCase().contains(_searchQuery);
                    final matchesFav = !_onlyFavorites ||
                        config.favoritePackages.contains(app.packageName);
                    return matchesQuery && matchesFav;
                  }).toList();

                  if (filteredApps.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.apps_outage_rounded,
                            size: 42,
                            color: config.textSecondaryColor,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No se encontraron aplicaciones coincidentes',
                            style: AppTheme.mono(
                              fontSize: 14,
                              color: config.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    color: accent,
                    backgroundColor: config.panelColor,
                    onRefresh: _triggerManualSync,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(18),
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 126,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.86,
                      ),
                      itemCount: filteredApps.length,
                      itemBuilder: (context, index) {
                        final app = filteredApps[index];
                        final isFav =
                            config.favoritePackages.contains(app.packageName);
                        return _buildAppTile(
                          app: app,
                          isFav: isFav,
                          config: config,
                          accent: accent,
                          secondary: secondary,
                        );
                      },
                    ),
                  );
                },
                loading: () => Center(
                  child: CircularProgressIndicator(color: accent),
                ),
                error: (err, _) => Center(
                  child: Text(
                    'Error al cargar aplicaciones: $err',
                    style: AppTheme.mono(color: AppTheme.error),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppTile({
    required InstalledApp app,
    required bool isFav,
    required CyberdeckConfig config,
    required Color accent,
    required Color secondary,
  }) {
    return CyberTapTarget(
      key: ValueKey('drawer_${app.packageName}_${app.versionCode}_${app.icon?.length ?? 0}'),
      onTap: () {
        ref
            .read(cyberdeckConfigProvider.notifier)
            .recordAppLaunch(app.packageName, appName: app.name);
        ref.read(deviceServiceProvider).launchApp(app.packageName);
      },
      onLongPress: () => _showAppActionSheet(app, isFav, config, accent),
      pressColor: accent,
      fillWidth: true,
      semanticLabel: app.name,
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: config.panelColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isFav
                ? config.highlightAccent.withValues(alpha: 0.65)
                : config.borderColor,
            width: isFav ? 1.3 : 1,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (app.icon != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        app.icon!,
                        width: 50,
                        height: 50,
                        gaplessPlayback: true,
                        filterQuality: FilterQuality.medium,
                      ),
                    )
                  else
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: config.surfaceSecondaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.apps_rounded, size: 28, color: accent),
                    ),
                  const SizedBox(height: 9),
                  Text(
                    app.name,
                    style: AppTheme.mono(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: config.textPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Positioned(
              top: -6,
              right: -6,
              child: CyberTapTarget(
                minWidth: 40,
                minHeight: 40,
                pressColor: accent,
                semanticLabel:
                    isFav ? 'Quitar de favoritos' : 'Añadir a favoritos',
                onTap: () {
                  ref
                      .read(cyberdeckConfigProvider.notifier)
                      .toggleFavoriteApp(app.packageName, appName: app.name);
                },
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    isFav ? Icons.star_rounded : Icons.star_border_rounded,
                    size: 16,
                    color: isFav
                        ? config.highlightAccent
                        : config.textSecondaryColor.withValues(alpha: 0.45),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAppActionSheet(
    InstalledApp app,
    bool isFav,
    CyberdeckConfig config,
    Color accent,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: config.panelColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // App Header in Bottom Sheet
              ListTile(
                leading: app.icon != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(app.icon!, width: 42, height: 42),
                      )
                    : Icon(Icons.apps_rounded, size: 40, color: accent),
                title: Text(
                  app.name,
                  style: AppTheme.mono(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: config.textPrimaryColor,
                  ),
                ),
                subtitle: Text(
                  app.packageName,
                  style: AppTheme.codeMono(
                    fontSize: 11,
                    color: config.textSecondaryColor,
                  ),
                ),
              ),
              Divider(color: config.borderColor),
              ListTile(
                leading: Icon(Icons.launch_rounded, color: accent),
                title: Text(
                  'Abrir aplicación',
                  style: AppTheme.mono(fontSize: 13.5, color: config.textPrimaryColor),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  ref
                      .read(cyberdeckConfigProvider.notifier)
                      .recordAppLaunch(app.packageName, appName: app.name);
                  ref.read(deviceServiceProvider).launchApp(app.packageName);
                },
              ),
              ListTile(
                leading: Icon(
                  isFav ? Icons.star_outline_rounded : Icons.star_rounded,
                  color: accent,
                ),
                title: Text(
                  isFav ? 'Quitar de Favoritos' : 'Fijar en Favoritos',
                  style: AppTheme.mono(fontSize: 13.5, color: config.textPrimaryColor),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  ref
                      .read(cyberdeckConfigProvider.notifier)
                      .toggleFavoriteApp(app.packageName, appName: app.name);
                },
              ),
              if (config.selectedIconPack != null)
                ListTile(
                  leading: Icon(Icons.auto_awesome_mosaic_outlined, color: config.secondaryAccent),
                  title: Text(
                    'Elegir icono alternativo del paquete',
                    style: AppTheme.mono(fontSize: 13.5, color: config.textPrimaryColor),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _showAlternativeIconPicker(app, config, accent);
                  },
                ),
              ListTile(
                leading: Icon(Icons.info_outline_rounded, color: config.textSecondaryColor),
                title: Text(
                  'Información de la aplicación',
                  style: AppTheme.mono(fontSize: 13.5, color: config.textPrimaryColor),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  ref.read(deviceServiceProvider).openAppInfo(app.packageName);
                },
              ),
              if (!app.isSystemApp)
                ListTile(
                  leading: const Icon(Icons.delete_outline_rounded, color: AppTheme.error),
                  title: Text(
                    'Desinstalar aplicación',
                    style: AppTheme.mono(fontSize: 13.5, color: AppTheme.error),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    ref.read(deviceServiceProvider).uninstallApp(app.packageName);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlternativeIconPicker(
    InstalledApp app,
    CyberdeckConfig config,
    Color accent,
  ) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: config.panelColor,
          title: Text(
            'Iconos alternativos: ${app.name}',
            style: AppTheme.mono(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: config.textPrimaryColor,
            ),
          ),
          content: SizedBox(
            width: 420,
            height: 300,
            child: FutureBuilder<List<AlternativeIconItem>>(
              future: ref
                  .read(deviceServiceProvider)
                  .getAlternativeIcons(app.packageName, app.name),
              builder: (ctx, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: accent));
                }
                final items = snap.data ?? [];
                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      'No se encontraron iconos alternativos adicionales para esta app en el paquete activo.',
                      textAlign: TextAlign.center,
                      style: AppTheme.mono(
                        fontSize: 12.5,
                        color: config.textSecondaryColor,
                      ),
                    ),
                  );
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: items.length,
                  itemBuilder: (ctx, i) {
                    final item = items[i];
                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        Navigator.pop(ctx);
                        await ref
                            .read(installedAppsProvider.notifier)
                            .updateSingleAppCustomIcon(
                              app.packageName,
                              item.drawableName,
                            );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: config.surfaceSecondaryColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: config.borderColor),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.memory(item.icon, width: 42, height: 42),
                            const SizedBox(height: 4),
                            Text(
                              item.drawableName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.mono(
                                fontSize: 9.5,
                                color: config.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(ctx);
                await ref
                    .read(installedAppsProvider.notifier)
                    .updateSingleAppCustomIcon(app.packageName, null);
              },
              child: Text(
                'Restaurar predeterminado',
                style: AppTheme.mono(fontSize: 12, color: config.textSecondaryColor),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Cerrar',
                style: AppTheme.mono(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: accent,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
