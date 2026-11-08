import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CyberdeckThemePreset {
  phosphorMatrix,  // Esmeralda Matrix / Forest Pro
  tacticalCyan,    // Azul Cupertino / Ocean Pro
  amberTerminal,   // Ámbar Solar / Dune Pro
  stealthGraphite, // Grafito Studio / Violet Pro
}

enum CyberdeckFontFamily {
  inter,          // Inter (UI Moderna / Apple)
  dotNothing,     // Nothing Dot (Matriz de Puntos)
  ttHovesPro,     // TT Hoves Pro (Geométrica Técnica)
  ttBluescreens,  // TT Bluescreens (Condensada Display)
  openSans,       // Open Sans (Humanista Limpia)
  nunito,         // Nunito (Redondeada Suave)
  minecraft,      // Minecraft Pixel (Pixel Art Block)
  jetBrainsMono,  // JetBrains Mono (Terminal Código)
}

enum CyberdeckDensity {
  compact,
  standard,
  comfort,
}

class ActivityLogEntry {
  final String timestamp;
  final String category;
  final String message;

  const ActivityLogEntry({
    required this.timestamp,
    required this.category,
    required this.message,
  });

  Map<String, dynamic> toMap() => {
        'timestamp': timestamp,
        'category': category,
        'message': message,
      };

  factory ActivityLogEntry.fromMap(Map<String, dynamic> map) {
    return ActivityLogEntry(
      timestamp: map['timestamp'] as String? ?? '00:00',
      category: map['category'] as String? ?? 'SYS',
      message: map['message'] as String? ?? '',
    );
  }
}

class CyberdeckConfig {
  final CyberdeckThemePreset themePreset;
  final bool isDarkMode;
  final int customAccentColorValue;
  final int customHighlightColorValue;
  final int sentinelAccentColorValue;
  final CyberdeckFontFamily fontFamily;
  final bool use24HourFormat;
  final bool showSeconds;
  final CyberdeckDensity density;
  final bool enableVisualEffects;
  final bool immersiveMode;
  final String? selectedIconPack;
  final bool maskUnthemedIcons;
  final Map<String, bool> visibleModules;
  final List<String> moduleOrder;
  final List<String> favoritePackages;
  final List<String> recentPackages;
  final List<ActivityLogEntry> activityLog;
  final List<String> tacticalNotes;
  final String? defaultFileManager;
  final String operatorCallsign;

  const CyberdeckConfig({
    this.themePreset = CyberdeckThemePreset.tacticalCyan,
    this.isDarkMode = true,
    this.customAccentColorValue = 0xFF0A84FF,
    this.customHighlightColorValue = 0xFFFF9F0A,
    this.sentinelAccentColorValue = 0xFF6366F1,
    this.fontFamily = CyberdeckFontFamily.inter,
    this.use24HourFormat = true,
    this.showSeconds = false,
    this.density = CyberdeckDensity.standard,
    this.enableVisualEffects = false,
    this.immersiveMode = true,
    this.selectedIconPack,
    this.maskUnthemedIcons = true,
    this.visibleModules = const {
      'clock': true,
      'favorites': true,
      'quick_actions': true,
      'system_monitor': true,
      'network': true,
      'calendar': true,
      'activity': true,
    },
    this.moduleOrder = const [
      'clock',
      'favorites',
      'quick_actions',
      'system_monitor',
      'network',
      'calendar',
      'activity',
    ],
    this.favoritePackages = const [],
    this.recentPackages = const [],
    this.activityLog = const [],
    this.tacticalNotes = const [],
    this.defaultFileManager,
    this.operatorCallsign = 'Cyberdeck Pro',
  });

  /// Primary interactive accent color
  Color get primaryAccent => Color(customAccentColorValue);

  /// Spotlight / Highlight color for focal elements (Today badge, starred items, key metrics)
  Color get highlightAccent => Color(customHighlightColorValue);

  /// Dedicated brand accent for Sentinel Live Health Checker
  Color get sentinelAccent => Color(sentinelAccentColorValue);

  /// Harmonious secondary accent derived from the active theme preset
  Color get secondaryAccent {
    switch (themePreset) {
      case CyberdeckThemePreset.phosphorMatrix:
        return isDarkMode ? const Color(0xFF2DD4BF) : const Color(0xFF0D9488);
      case CyberdeckThemePreset.tacticalCyan:
        return isDarkMode ? const Color(0xFF38BDF8) : const Color(0xFF0284C7);
      case CyberdeckThemePreset.amberTerminal:
        return isDarkMode ? const Color(0xFFFB923C) : const Color(0xFFEA580C);
      case CyberdeckThemePreset.stealthGraphite:
        return isDarkMode ? const Color(0xFFC084FC) : const Color(0xFF7C3AED);
    }
  }

  /// Solid, clean background color tinted subtly by the active theme preset (Zero Glassmorphism)
  Color get backgroundColor {
    if (!isDarkMode) {
      switch (themePreset) {
        case CyberdeckThemePreset.phosphorMatrix:
          return const Color(0xFFF2F7F4);
        case CyberdeckThemePreset.tacticalCyan:
          return const Color(0xFFF3F6FA);
        case CyberdeckThemePreset.amberTerminal:
          return const Color(0xFFFAF6F0);
        case CyberdeckThemePreset.stealthGraphite:
          return const Color(0xFFF5F4F8);
      }
    }
    switch (themePreset) {
      case CyberdeckThemePreset.phosphorMatrix:
        return const Color(0xFF090E0C); // Deep Forest Black
      case CyberdeckThemePreset.tacticalCyan:
        return const Color(0xFF0A0D14); // Deep Ocean Slate
      case CyberdeckThemePreset.amberTerminal:
        return const Color(0xFF100D0A); // Warm Obsidian
      case CyberdeckThemePreset.stealthGraphite:
        return const Color(0xFF0C0C12); // Deep Studio Graphite
    }
  }

  /// 100% Solid primary surface for cards, panels, and dock
  Color get panelColor {
    if (!isDarkMode) {
      return const Color(0xFFFFFFFF);
    }
    switch (themePreset) {
      case CyberdeckThemePreset.phosphorMatrix:
        return const Color(0xFF121A16);
      case CyberdeckThemePreset.tacticalCyan:
        return const Color(0xFF131822);
      case CyberdeckThemePreset.amberTerminal:
        return const Color(0xFF1A1612);
      case CyberdeckThemePreset.stealthGraphite:
        return const Color(0xFF161620);
    }
  }

  /// Solid secondary surface for nested tiles, inputs, and pills
  Color get surfaceSecondaryColor {
    if (!isDarkMode) {
      switch (themePreset) {
        case CyberdeckThemePreset.phosphorMatrix:
          return const Color(0xFFE8F0EC);
        case CyberdeckThemePreset.tacticalCyan:
          return const Color(0xFFE9EEF5);
        case CyberdeckThemePreset.amberTerminal:
          return const Color(0xFFF2ECE4);
        case CyberdeckThemePreset.stealthGraphite:
          return const Color(0xFFECEAF2);
      }
    }
    switch (themePreset) {
      case CyberdeckThemePreset.phosphorMatrix:
        return const Color(0xFF1A2520);
      case CyberdeckThemePreset.tacticalCyan:
        return const Color(0xFF1C2331);
      case CyberdeckThemePreset.amberTerminal:
        return const Color(0xFF251F1A);
      case CyberdeckThemePreset.stealthGraphite:
        return const Color(0xFF20202E);
    }
  }

  /// Discrete 1px solid border color
  Color get borderColor {
    if (!isDarkMode) {
      switch (themePreset) {
        case CyberdeckThemePreset.phosphorMatrix:
          return const Color(0xFFD3E2DA);
        case CyberdeckThemePreset.tacticalCyan:
          return const Color(0xFFD5DFEC);
        case CyberdeckThemePreset.amberTerminal:
          return const Color(0xFFE4D9C8);
        case CyberdeckThemePreset.stealthGraphite:
          return const Color(0xFFDAD6E5);
      }
    }
    switch (themePreset) {
      case CyberdeckThemePreset.phosphorMatrix:
        return const Color(0xFF263830);
      case CyberdeckThemePreset.tacticalCyan:
        return const Color(0xFF283246);
      case CyberdeckThemePreset.amberTerminal:
        return const Color(0xFF362D24);
      case CyberdeckThemePreset.stealthGraphite:
        return const Color(0xFF2E2E42);
    }
  }

  Color get textPrimaryColor {
    return isDarkMode ? const Color(0xFFF5F5F7) : const Color(0xFF18181B);
  }

  Color get textSecondaryColor {
    return isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
  }

  double get paddingScale {
    switch (density) {
      case CyberdeckDensity.compact:
        return 0.85;
      case CyberdeckDensity.standard:
        return 1.0;
      case CyberdeckDensity.comfort:
        return 1.15;
    }
  }

  CyberdeckConfig copyWith({
    CyberdeckThemePreset? themePreset,
    bool? isDarkMode,
    int? customAccentColorValue,
    int? customHighlightColorValue,
    int? sentinelAccentColorValue,
    CyberdeckFontFamily? fontFamily,
    bool? use24HourFormat,
    bool? showSeconds,
    CyberdeckDensity? density,
    bool? enableVisualEffects,
    bool? immersiveMode,
    String? selectedIconPack,
    bool clearSelectedIconPack = false,
    bool? maskUnthemedIcons,
    Map<String, bool>? visibleModules,
    List<String>? moduleOrder,
    List<String>? favoritePackages,
    List<String>? recentPackages,
    List<ActivityLogEntry>? activityLog,
    List<String>? tacticalNotes,
    String? defaultFileManager,
    bool clearDefaultFileManager = false,
    String? operatorCallsign,
  }) {
    return CyberdeckConfig(
      themePreset: themePreset ?? this.themePreset,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      customAccentColorValue:
          customAccentColorValue ?? this.customAccentColorValue,
      customHighlightColorValue:
          customHighlightColorValue ?? this.customHighlightColorValue,
      sentinelAccentColorValue:
          sentinelAccentColorValue ?? this.sentinelAccentColorValue,
      fontFamily: fontFamily ?? this.fontFamily,
      use24HourFormat: use24HourFormat ?? this.use24HourFormat,
      showSeconds: showSeconds ?? this.showSeconds,
      density: density ?? this.density,
      enableVisualEffects: enableVisualEffects ?? this.enableVisualEffects,
      immersiveMode: immersiveMode ?? this.immersiveMode,
      selectedIconPack: clearSelectedIconPack
          ? null
          : (selectedIconPack ?? this.selectedIconPack),
      maskUnthemedIcons: maskUnthemedIcons ?? this.maskUnthemedIcons,
      visibleModules: visibleModules ?? this.visibleModules,
      moduleOrder: moduleOrder ?? this.moduleOrder,
      favoritePackages: favoritePackages ?? this.favoritePackages,
      recentPackages: recentPackages ?? this.recentPackages,
      activityLog: activityLog ?? this.activityLog,
      tacticalNotes: tacticalNotes ?? this.tacticalNotes,
      defaultFileManager: clearDefaultFileManager
          ? null
          : (defaultFileManager ?? this.defaultFileManager),
      operatorCallsign: operatorCallsign ?? this.operatorCallsign,
    );
  }
}

class CyberdeckConfigNotifier extends Notifier<CyberdeckConfig> {
  @override
  CyberdeckConfig build() {
    _loadFromPrefs();
    return CyberdeckConfig(
      activityLog: [
        ActivityLogEntry(
          timestamp: _nowStr(),
          category: 'BOOT',
          message: 'Sistema Cyberdeck inicializado',
        ),
      ],
    );
  }

  static String _nowStr() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final presetIdx = prefs.getInt('cd_theme_preset') ?? 1;
    final isDark = prefs.getBool('cd_is_dark_mode') ?? true;
    final accentVal = prefs.getInt('cd_accent_color') ?? 0xFF0A84FF;
    final highlightVal = prefs.getInt('cd_highlight_color') ?? 0xFFFF9F0A;
    final sentinelVal = prefs.getInt('cd_sentinel_color') ?? 0xFF6366F1;
    final fontIdx = prefs.getInt('cd_font_family') ?? 0;
    final use24h = prefs.getBool('cd_use_24h') ?? true;
    final showSec = prefs.getBool('cd_show_sec') ?? false;
    final densityIdx = prefs.getInt('cd_density') ?? 1;
    final fx = prefs.getBool('cd_visual_fx') ?? false;
    final immersive = prefs.getBool('cd_immersive') ?? true;
    final iconPack = prefs.getString('cd_selected_icon_pack');
    final maskIcons = prefs.getBool('cd_mask_unthemed') ?? true;
    final favs = prefs.getStringList('cd_favorites') ?? [];
    final recents = prefs.getStringList('cd_recents') ?? [];
    final notes = prefs.getStringList('cd_tactical_notes') ??
        [
          'Verificar enlaces SSH y servicios activos',
          'Monitorear estado de red y batería',
        ];
    final fm = prefs.getString('default_file_manager');
    final callsign = prefs.getString('cd_callsign') ?? 'Cyberdeck Pro';

    Map<String, bool> visModules = Map<String, bool>.from(state.visibleModules);
    final visJson = prefs.getString('cd_visible_modules');
    if (visJson != null) {
      try {
        final decoded = json.decode(visJson) as Map<String, dynamic>;
        decoded.forEach((k, v) {
          if (v is bool) visModules[k] = v;
        });
      } catch (_) {}
    }

    List<String> modOrder = List<String>.from(state.moduleOrder);
    final savedOrder = prefs.getStringList('cd_module_order');
    if (savedOrder != null && savedOrder.isNotEmpty) {
      modOrder = savedOrder;
      for (final key in state.moduleOrder) {
        if (!modOrder.contains(key)) modOrder.add(key);
      }
    }

    List<ActivityLogEntry> logs = List<ActivityLogEntry>.from(state.activityLog);
    final savedLogs = prefs.getStringList('cd_activity_log');
    if (savedLogs != null && savedLogs.isNotEmpty) {
      try {
        logs = savedLogs
            .map((s) =>
                ActivityLogEntry.fromMap(json.decode(s) as Map<String, dynamic>))
            .toList();
      } catch (_) {}
    }

    state = state.copyWith(
      themePreset: CyberdeckThemePreset.values[
          presetIdx.clamp(0, CyberdeckThemePreset.values.length - 1)],
      isDarkMode: isDark,
      customAccentColorValue: accentVal,
      customHighlightColorValue: highlightVal,
      sentinelAccentColorValue: sentinelVal,
      fontFamily: CyberdeckFontFamily.values[
          fontIdx.clamp(0, CyberdeckFontFamily.values.length - 1)],
      use24HourFormat: use24h,
      showSeconds: showSec,
      density: CyberdeckDensity
          .values[densityIdx.clamp(0, CyberdeckDensity.values.length - 1)],
      enableVisualEffects: fx,
      immersiveMode: immersive,
      selectedIconPack: iconPack,
      maskUnthemedIcons: maskIcons,
      visibleModules: visModules,
      moduleOrder: modOrder,
      favoritePackages: favs.toSet().toList(),
      recentPackages: recents.toSet().toList(),
      activityLog: logs,
      tacticalNotes: notes,
      defaultFileManager: fm,
      operatorCallsign: callsign,
    );
  }

  Future<void> setDarkMode(bool isDark) async {
    state = state.copyWith(isDarkMode: isDark);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cd_is_dark_mode', isDark);
    logAction('THEME', isDark ? 'Modo Oscuro activado' : 'Modo Claro activado');
  }

  Future<void> setThemePreset(CyberdeckThemePreset preset) async {
    int defaultAccent = state.customAccentColorValue;
    int defaultHighlight = state.customHighlightColorValue;
    switch (preset) {
      case CyberdeckThemePreset.phosphorMatrix:
        defaultAccent = 0xFF10B981;    // Emerald
        defaultHighlight = 0xFFF59E0B; // Warm Amber spotlight
        break;
      case CyberdeckThemePreset.tacticalCyan:
        defaultAccent = 0xFF0A84FF;    // System Blue
        defaultHighlight = 0xFF38BDF8; // Sky Cyan spotlight
        break;
      case CyberdeckThemePreset.amberTerminal:
        defaultAccent = 0xFFF59E0B;    // Solar Amber
        defaultHighlight = 0xFF10B981; // Emerald contrast spotlight
        break;
      case CyberdeckThemePreset.stealthGraphite:
        defaultAccent = 0xFF8B5CF6;    // Studio Violet
        defaultHighlight = 0xFFEC4899; // Rose Pink spotlight
        break;
    }
    state = state.copyWith(
      themePreset: preset,
      customAccentColorValue: defaultAccent,
      customHighlightColorValue: defaultHighlight,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cd_theme_preset', preset.index);
    await prefs.setInt('cd_accent_color', defaultAccent);
    await prefs.setInt('cd_highlight_color', defaultHighlight);
    logAction('THEME', 'Perfil visual actualizado -> ${preset.name}');
  }

  Future<void> setAccentColor(int colorValue) async {
    state = state.copyWith(customAccentColorValue: colorValue);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cd_accent_color', colorValue);
  }

  Future<void> setHighlightColor(int colorValue) async {
    state = state.copyWith(customHighlightColorValue: colorValue);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cd_highlight_color', colorValue);
  }

  Future<void> setSentinelAccentColor(int colorValue) async {
    state = state.copyWith(sentinelAccentColorValue: colorValue);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cd_sentinel_color', colorValue);
  }

  Future<void> setFontFamily(CyberdeckFontFamily family) async {
    state = state.copyWith(fontFamily: family);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cd_font_family', family.index);
    logAction('FONT', 'Tipografía cambiada -> ${family.name}');
  }

  Future<void> setSelectedIconPackConfig(String? packageName) async {
    final normalized = (packageName != null && packageName.trim().isNotEmpty)
        ? packageName.trim()
        : null;
    state = state.copyWith(
      selectedIconPack: normalized,
      clearSelectedIconPack: normalized == null,
    );
    final prefs = await SharedPreferences.getInstance();
    if (normalized == null) {
      await prefs.remove('cd_selected_icon_pack');
      logAction('ICON_PACK', 'Iconos originales del sistema restaurados');
    } else {
      await prefs.setString('cd_selected_icon_pack', normalized);
      logAction('ICON_PACK', 'Paquete de iconos aplicado: $normalized');
    }
  }

  Future<void> setMaskUnthemedIcons(bool enabled) async {
    state = state.copyWith(maskUnthemedIcons: enabled);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cd_mask_unthemed', enabled);
  }

  Future<void> setTimeFormat({bool? use24h, bool? showSeconds}) async {
    final next24 = use24h ?? state.use24HourFormat;
    final nextSec = showSeconds ?? state.showSeconds;
    state = state.copyWith(use24HourFormat: next24, showSeconds: nextSec);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cd_use_24h', next24);
    await prefs.setBool('cd_show_sec', nextSec);
  }

  Future<void> setDensity(CyberdeckDensity density) async {
    state = state.copyWith(density: density);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cd_density', density.index);
  }

  Future<void> setVisualEffects(bool enabled) async {
    state = state.copyWith(enableVisualEffects: enabled);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cd_visual_fx', enabled);
  }

  Future<void> setImmersiveMode(bool enabled) async {
    state = state.copyWith(immersiveMode: enabled);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cd_immersive', enabled);
  }

  Future<void> toggleModuleVisibility(String moduleKey, bool visible) async {
    final updated = Map<String, bool>.from(state.visibleModules);
    updated[moduleKey] = visible;
    state = state.copyWith(visibleModules: updated);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cd_visible_modules', json.encode(updated));
  }

  Future<void> reorderModules(int oldIndex, int newIndex) async {
    final list = List<String>.from(state.moduleOrder);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    state = state.copyWith(moduleOrder: list);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cd_module_order', list);
    logAction('LAYOUT', 'Orden de módulos actualizado');
  }

  Future<void> moveModule(String moduleKey, int delta) async {
    final list = List<String>.from(state.moduleOrder);
    final idx = list.indexOf(moduleKey);
    if (idx == -1) return;
    final target = (idx + delta).clamp(0, list.length - 1);
    if (target == idx) return;
    final item = list.removeAt(idx);
    list.insert(target, item);
    state = state.copyWith(moduleOrder: list);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cd_module_order', list);
  }

  Future<void> toggleFavoriteApp(String packageName, {String? appName}) async {
    final favs = List<String>.from(state.favoritePackages);
    final exists = favs.contains(packageName);
    if (exists) {
      favs.remove(packageName);
      logAction('FAV', 'Eliminado de favoritos: ${appName ?? packageName}');
    } else {
      favs.add(packageName);
      logAction('FAV', 'Añadido a favoritos: ${appName ?? packageName}');
    }
    state = state.copyWith(favoritePackages: favs);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cd_favorites', favs);
  }

  /// Purges all references to an uninstalled or disabled package so ghost apps never persist.
  Future<void> purgeUninstalledPackage(String packageName) async {
    bool changed = false;
    final favs = List<String>.from(state.favoritePackages);
    final recents = List<String>.from(state.recentPackages);
    bool clearFm = false;

    if (favs.remove(packageName)) changed = true;
    if (recents.remove(packageName)) changed = true;
    if (state.defaultFileManager == packageName) {
      clearFm = true;
      changed = true;
    }

    if (!changed) return;

    state = state.copyWith(
      favoritePackages: favs,
      recentPackages: recents,
      clearDefaultFileManager: clearFm,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cd_favorites', favs);
    await prefs.setStringList('cd_recents', recents);
    if (clearFm) {
      await prefs.remove('default_file_manager');
    }
  }

  /// Reconciles stored favorites, recents, and file manager with the real set of installed packages.
  Future<void> reconcileWithInstalledPackages(
      Set<String> installedPackages) async {
    if (installedPackages.isEmpty) return;

    final validFavs = state.favoritePackages
        .where((pkg) => installedPackages.contains(pkg))
        .toSet()
        .toList();
    final validRecents = state.recentPackages
        .where((pkg) => installedPackages.contains(pkg))
        .toSet()
        .toList();
    final fmInvalid = state.defaultFileManager != null &&
        !installedPackages.contains(state.defaultFileManager);

    final favChanged = validFavs.length != state.favoritePackages.length;
    final recChanged = validRecents.length != state.recentPackages.length;

    if (!favChanged && !recChanged && !fmInvalid) return;

    state = state.copyWith(
      favoritePackages: validFavs,
      recentPackages: validRecents,
      clearDefaultFileManager: fmInvalid,
    );

    final prefs = await SharedPreferences.getInstance();
    if (favChanged) await prefs.setStringList('cd_favorites', validFavs);
    if (recChanged) await prefs.setStringList('cd_recents', validRecents);
    if (fmInvalid) await prefs.remove('default_file_manager');
  }

  Future<void> recordAppLaunch(String packageName, {String? appName}) async {
    final recents = List<String>.from(state.recentPackages);
    recents.remove(packageName);
    recents.insert(0, packageName);
    if (recents.length > 14) {
      recents.removeRange(14, recents.length);
    }
    state = state.copyWith(recentPackages: recents);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cd_recents', recents);
    await logAction('EXEC', 'Iniciado: ${appName ?? packageName}');
  }

  Future<void> logAction(String category, String message) async {
    final entry = ActivityLogEntry(
      timestamp: _nowStr(),
      category: category,
      message: message,
    );
    final logs = [entry, ...state.activityLog].take(25).toList();
    state = state.copyWith(activityLog: logs);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'cd_activity_log',
      logs.map((e) => json.encode(e.toMap())).toList(),
    );
  }

  Future<void> addTacticalNote(String note) async {
    if (note.trim().isEmpty) return;
    final updated = [note.trim(), ...state.tacticalNotes];
    state = state.copyWith(tacticalNotes: updated);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cd_tactical_notes', updated);
    logAction('AGENDA', 'Nota añadida');
  }

  Future<void> removeTacticalNote(int index) async {
    final updated = List<String>.from(state.tacticalNotes);
    if (index >= 0 && index < updated.length) {
      updated.removeAt(index);
      state = state.copyWith(tacticalNotes: updated);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('cd_tactical_notes', updated);
    }
  }

  Future<void> setDefaultFileManager(String packageName) async {
    state = state.copyWith(defaultFileManager: packageName);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('default_file_manager', packageName);
    logAction('CFG', 'Gestor de archivos -> $packageName');
  }

  Future<void> setOperatorCallsign(String callsign) async {
    if (callsign.trim().isEmpty) return;
    state = state.copyWith(operatorCallsign: callsign.trim());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cd_callsign', callsign.trim());
  }
}

final cyberdeckConfigProvider =
    NotifierProvider<CyberdeckConfigNotifier, CyberdeckConfig>(
  CyberdeckConfigNotifier.new,
);
