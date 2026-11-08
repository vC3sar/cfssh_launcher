import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../services/device_service.dart';

final deviceServiceProvider = Provider<DeviceService>((ref) {
  return DeviceService();
});

class InstalledAppsNotifier extends AsyncNotifier<List<InstalledApp>> {
  StreamSubscription<PackageChangeEvent>? _sub;
  bool _isSyncing = false;

  @override
  Future<List<InstalledApp>> build() async {
    final service = ref.read(deviceServiceProvider);

    _sub?.cancel();
    _sub = service.packageEvents.listen(_handlePackageEvent);
    ref.onDispose(() {
      _sub?.cancel();
    });

    final apps = await service.getInstalledApps();
    final deduped = _deduplicateAndSort(apps);

    // Reconcile stored favorites/recents so no ghost apps survive across restarts
    final validSet = deduped.map((a) => a.packageName).toSet();
    if (validSet.isNotEmpty) {
      Future.microtask(() {
        ref
            .read(cyberdeckConfigProvider.notifier)
            .reconcileWithInstalledPackages(validSet);
      });
    }

    return deduped;
  }

  void _handlePackageEvent(PackageChangeEvent event) {
    final pkg = event.packageName;
    if (pkg.isEmpty) return;

    // If an icon pack was installed, updated, or removed, refresh the icon packs list
    if (event.isIconPack) {
      ref.invalidate(installedIconPacksProvider);
      ref
          .read(cyberdeckConfigProvider.notifier)
          .setSelectedIconPackConfig(event.selectedIconPack);
    }

    final currentList = state.value;
    if (currentList == null) {
      syncApps(forceRefresh: event.isIconPack);
      return;
    }

    if (event.type == 'removed') {
      final updated = currentList.where((a) => a.packageName != pkg).toList();
      if (updated.length != currentList.length) {
        state = AsyncData(updated);
      }
      ref.read(cyberdeckConfigProvider.notifier).purgeUninstalledPackage(pkg);
      ref
          .read(cyberdeckConfigProvider.notifier)
          .logAction('PKG', 'Aplicación desinstalada: $pkg');

      if (event.isIconPack) {
        syncApps(forceRefresh: true);
      }
      return;
    }

    // 'added', 'updated', or 'changed'
    final newApp = event.app;
    if (newApp != null && newApp.packageName.isNotEmpty) {
      final list = List<InstalledApp>.from(currentList);
      final existingIdx = list.indexWhere((a) => a.packageName == pkg);
      if (existingIdx >= 0) {
        list[existingIdx] = newApp;
      } else {
        list.add(newApp);
      }
      state = AsyncData(_deduplicateAndSort(list));

      final actionLabel = event.type == 'added'
          ? 'Nueva app instalada: ${newApp.name}'
          : 'App actualizada: ${newApp.name}';
      ref.read(cyberdeckConfigProvider.notifier).logAction('PKG', actionLabel);

      if (event.isIconPack) {
        syncApps(forceRefresh: true);
      }
    } else {
      // Package exists in system but has no launchable activity (or was disabled)
      final updated = currentList.where((a) => a.packageName != pkg).toList();
      if (updated.length != currentList.length) {
        state = AsyncData(updated);
        ref.read(cyberdeckConfigProvider.notifier).purgeUninstalledPackage(pkg);
      }
    }
  }

  /// Synchronizes the app list with PackageManager incrementally, updating state
  /// only if packages or metadata changed.
  Future<void> syncApps({bool forceRefresh = false}) async {
    if (_isSyncing && !forceRefresh) return;
    _isSyncing = true;
    try {
      final service = ref.read(deviceServiceProvider);
      final freshApps = await service.getInstalledApps(forceRefresh: forceRefresh);
      final deduped = _deduplicateAndSort(freshApps);

      final validSet = deduped.map((a) => a.packageName).toSet();
      if (validSet.isNotEmpty) {
        await ref
            .read(cyberdeckConfigProvider.notifier)
            .reconcileWithInstalledPackages(validSet);
      }

      final current = state.value;
      if (forceRefresh || current == null || _hasDifferences(current, deduped)) {
        state = AsyncData(deduped);
      }
    } finally {
      _isSyncing = false;
    }
  }

  /// Applies an icon pack (or null for original system icons) and refreshes all icons immediately.
  Future<bool> applyIconPack(String? iconPackPackage) async {
    final service = ref.read(deviceServiceProvider);
    final ok = await service.setSelectedIconPack(iconPackPackage);
    if (ok) {
      await ref
          .read(cyberdeckConfigProvider.notifier)
          .setSelectedIconPackConfig(iconPackPackage);
      ref.invalidate(installedIconPacksProvider);
      await syncApps(forceRefresh: true);
    }
    return ok;
  }

  /// Toggles icon masking for unthemed apps and refreshes icons immediately.
  Future<void> setIconMasking(bool enabled) async {
    final service = ref.read(deviceServiceProvider);
    await service.setIconMasking(enabled);
    await ref
        .read(cyberdeckConfigProvider.notifier)
        .setMaskUnthemedIcons(enabled);
    await syncApps(forceRefresh: true);
  }

  /// Sets or resets a custom alternative icon for a single package.
  Future<void> updateSingleAppCustomIcon(
    String packageName,
    String? drawableName,
  ) async {
    final service = ref.read(deviceServiceProvider);
    final updatedApp = await service.setCustomAppIcon(packageName, drawableName);
    if (updatedApp != null) {
      final current = state.value ?? [];
      final list = List<InstalledApp>.from(current);
      final idx = list.indexWhere((a) => a.packageName == packageName);
      if (idx >= 0) {
        list[idx] = updatedApp;
        state = AsyncData(_deduplicateAndSort(list));
      }
    }
  }

  List<InstalledApp> _deduplicateAndSort(List<InstalledApp> raw) {
    final map = <String, InstalledApp>{};
    for (final app in raw) {
      if (app.packageName.isEmpty) continue;
      map[app.packageName] = app;
    }
    final list = map.values.toList();
    list.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return list;
  }

  bool _hasDifferences(List<InstalledApp> a, List<InstalledApp> b) {
    if (a.length != b.length) return true;
    for (int i = 0; i < a.length; i++) {
      final x = a[i];
      final y = b[i];
      if (x.packageName != y.packageName ||
          x.name != y.name ||
          x.versionCode != y.versionCode ||
          x.lastUpdateTime != y.lastUpdateTime ||
          (x.icon?.length ?? 0) != (y.icon?.length ?? 0)) {
        return true;
      }
    }
    return false;
  }
}

final installedAppsProvider =
    AsyncNotifierProvider<InstalledAppsNotifier, List<InstalledApp>>(
  InstalledAppsNotifier.new,
);

final installedIconPacksProvider = FutureProvider<List<IconPackInfo>>((ref) async {
  final service = ref.read(deviceServiceProvider);
  return await service.getInstalledIconPacks();
});
