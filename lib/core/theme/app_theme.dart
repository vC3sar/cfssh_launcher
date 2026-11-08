import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/cyberdeck_config_provider.dart';

class AppTheme {
  static bool _isDark = true;
  static CyberdeckFontFamily _activeFont = CyberdeckFontFamily.inter;

  static bool get isDark => _isDark;
  static CyberdeckFontFamily get activeFont => _activeFont;

  // Solid Neutral Surfaces
  static const Color deepBlack = Color(0xFF0A0D14);
  static const Color background = Color(0xFF0A0D14);
  static const Color secondaryBackground = Color(0xFF131822);
  static const Color tertiaryBackground = Color(0xFF1C2331);
  static const Color graphite = Color(0xFF283246);

  // Semantic & Accent Palette
  static const Color phosphorGreen = Color(0xFF10B981); // Emerald
  static const Color electricCyan = Color(0xFF0A84FF);  // System Blue
  static const Color amberAlert = Color(0xFFF59E0B);    // Warm Amber
  static const Color primaryBlue = Color(0xFF007AFF);   // Cupertino Blue
  static const Color cyan = Color(0xFF06B6D4);          // Cyan

  // Sentinel Health Checker Dedicated Palette
  static const Color sentinelOnline = Color(0xFF10B981);   // Emerald Online
  static const Color sentinelDegraded = Color(0xFFF59E0B); // Amber Degraded
  static const Color sentinelOffline = Color(0xFFF43F5E);  // Rose Offline
  static const Color sentinelProbing = Color(0xFF38BDF8);  // Sky Probing
  static const Color sentinelTcp = Color(0xFF3B82F6);      // Royal Blue TCP
  static const Color sentinelHttp = Color(0xFF8B5CF6);     // Violet HTTP
  static const Color sentinelUdp = Color(0xFF14B8A6);      // Teal UDP

  // Dynamic Adaptive Typography & Surface Colors (Light & Dark Modes)
  static Color get textPrimary =>
      _isDark ? const Color(0xFFF5F5F7) : const Color(0xFF18181B);

  static Color get textSecondary =>
      _isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

  static Color get textDim =>
      _isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8);

  static const Color error = Color(0xFFF43F5E);   // Rose Red
  static const Color warning = Color(0xFFF59E0B); // Warm Amber
  static const Color success = Color(0xFF10B981); // Emerald Green

  // Solid Opaque Surfaces (Zero Glassmorphism)
  static Color get cardBackground =>
      _isDark ? const Color(0xFF131822) : const Color(0xFFFFFFFF);

  static Color get surfaceSecondary =>
      _isDark ? const Color(0xFF1C2331) : const Color(0xFFE9EEF5);

  static Color get cardBorder =>
      _isDark ? const Color(0xFF283246) : const Color(0xFFD5DFEC);

  /// Primary UI typography that adapts to the user's selected font family
  /// (Inter, Nothing Dot, TT Hoves Pro, TT Bluescreens, Open Sans, Nunito, Minecraft, JetBrains Mono).
  static TextStyle mono({
    double fontSize = 13,
    FontWeight fontWeight = FontWeight.w500,
    Color? color,
    double letterSpacing = 0.0,
    double? height,
    CyberdeckFontFamily? fontOverride,
  }) {
    final family = fontOverride ?? _activeFont;
    final resolvedColor = color ?? textPrimary;
    const tabular = [FontFeature.tabularFigures()];

    switch (family) {
      case CyberdeckFontFamily.dotNothing:
        return GoogleFonts.dotGothic16(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: resolvedColor,
          letterSpacing: letterSpacing.clamp(0.0, 1.2),
          height: height,
          fontFeatures: tabular,
        );
      case CyberdeckFontFamily.ttHovesPro:
        return GoogleFonts.spaceGrotesk(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: resolvedColor,
          letterSpacing: (letterSpacing - 0.15).clamp(-0.5, 0.8),
          height: height,
          fontFeatures: tabular,
        );
      case CyberdeckFontFamily.ttBluescreens:
        return GoogleFonts.barlowCondensed(
          fontSize: fontSize * 1.14,
          fontWeight: fontWeight == FontWeight.w400
              ? FontWeight.w500
              : FontWeight.w600,
          color: resolvedColor,
          letterSpacing: (letterSpacing + 0.3).clamp(0.0, 1.5),
          height: height,
          fontFeatures: tabular,
        );
      case CyberdeckFontFamily.openSans:
        return GoogleFonts.openSans(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: resolvedColor,
          letterSpacing: letterSpacing.clamp(-0.3, 0.6),
          height: height,
          fontFeatures: tabular,
        );
      case CyberdeckFontFamily.nunito:
        return GoogleFonts.nunito(
          fontSize: fontSize * 1.02,
          fontWeight: fontWeight,
          color: resolvedColor,
          letterSpacing: letterSpacing.clamp(-0.3, 0.6),
          height: height,
          fontFeatures: tabular,
        );
      case CyberdeckFontFamily.minecraft:
        return GoogleFonts.silkscreen(
          fontSize: (fontSize * 0.88).clamp(8.5, 64.0),
          fontWeight: fontWeight == FontWeight.w700 ||
                  fontWeight == FontWeight.w800 ||
                  fontWeight == FontWeight.bold
              ? FontWeight.w700
              : FontWeight.w400,
          color: resolvedColor,
          letterSpacing: 0.0,
          height: height,
          fontFeatures: tabular,
        );
      case CyberdeckFontFamily.jetBrainsMono:
        return GoogleFonts.jetBrainsMono(
          fontSize: fontSize * 0.96,
          fontWeight: fontWeight,
          color: resolvedColor,
          letterSpacing: letterSpacing.clamp(-0.3, 0.8),
          height: height,
          fontFeatures: tabular,
        );
      case CyberdeckFontFamily.inter:
        return GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: resolvedColor,
          letterSpacing: letterSpacing.clamp(-0.4, 0.5),
          height: height,
          fontFeatures: tabular,
        );
    }
  }

  /// Extra-large hero clock display style that scales properly for every font family.
  static TextStyle clockHero({
    required CyberdeckFontFamily family,
    required Color color,
    double baseSize = 72,
  }) {
    const tabular = [FontFeature.tabularFigures()];
    switch (family) {
      case CyberdeckFontFamily.dotNothing:
        return GoogleFonts.dotGothic16(
          fontSize: baseSize * 0.96,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 2.0,
          height: 1.0,
          fontFeatures: tabular,
        );
      case CyberdeckFontFamily.ttHovesPro:
        return GoogleFonts.spaceGrotesk(
          fontSize: baseSize,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: -1.5,
          height: 0.98,
          fontFeatures: tabular,
        );
      case CyberdeckFontFamily.ttBluescreens:
        return GoogleFonts.barlowCondensed(
          fontSize: baseSize * 1.18,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 1.2,
          height: 0.95,
          fontFeatures: tabular,
        );
      case CyberdeckFontFamily.openSans:
        return GoogleFonts.openSans(
          fontSize: baseSize,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: -1.0,
          height: 1.0,
          fontFeatures: tabular,
        );
      case CyberdeckFontFamily.nunito:
        return GoogleFonts.nunito(
          fontSize: baseSize,
          fontWeight: FontWeight.w800,
          color: color,
          letterSpacing: -0.8,
          height: 1.0,
          fontFeatures: tabular,
        );
      case CyberdeckFontFamily.minecraft:
        return GoogleFonts.silkscreen(
          fontSize: baseSize * 0.78,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.0,
          height: 1.05,
          fontFeatures: tabular,
        );
      case CyberdeckFontFamily.jetBrainsMono:
        return GoogleFonts.jetBrainsMono(
          fontSize: baseSize * 0.92,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: -1.0,
          height: 1.0,
          fontFeatures: tabular,
        );
      case CyberdeckFontFamily.inter:
        return GoogleFonts.inter(
          fontSize: baseSize,
          fontWeight: FontWeight.w800,
          color: color,
          letterSpacing: -1.8,
          height: 0.98,
          fontFeatures: tabular,
        );
    }
  }

  /// Technical monospace font reserved for terminal output, IP addresses, and metrics.
  static TextStyle codeMono({
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w500,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    if (_activeFont == CyberdeckFontFamily.dotNothing ||
        _activeFont == CyberdeckFontFamily.minecraft) {
      return mono(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing ?? 0.0,
        height: height,
      );
    }
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? textPrimary,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static ThemeData get darkTheme => buildCyberdeckTheme(const CyberdeckConfig());

  static ThemeData buildCyberdeckTheme(CyberdeckConfig config) {
    _isDark = config.isDarkMode;
    _activeFont = config.fontFamily;
    final accent = config.primaryAccent;
    final secondary = config.secondaryAccent;
    final brightness = config.isDarkMode ? Brightness.dark : Brightness.light;
    final baseTheme = config.isDarkMode ? ThemeData.dark() : ThemeData.light();

    final baseText = _buildTextTheme(
      config.fontFamily,
      baseTheme.textTheme,
    ).apply(
      bodyColor: config.textPrimaryColor,
      displayColor: config.textPrimaryColor,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: config.backgroundColor,
      primaryColor: accent,
      dividerColor: config.borderColor,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: accent,
        onPrimary: Colors.white,
        secondary: secondary,
        onSecondary: Colors.white,
        tertiary: config.highlightAccent,
        onTertiary: Colors.white,
        error: error,
        onError: Colors.white,
        surface: config.panelColor,
        onSurface: config.textPrimaryColor,
      ),
      textTheme: baseText,
      appBarTheme: AppBarTheme(
        backgroundColor: config.panelColor,
        foregroundColor: config.textPrimaryColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: accent),
        titleTextStyle: mono(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: config.textPrimaryColor,
        ),
      ),
      cardTheme: CardThemeData(
        color: config.panelColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: config.borderColor, width: 1),
        ),
        elevation: 0,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: config.panelColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: config.borderColor, width: 1),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: config.panelColor,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: config.panelColor,
        contentTextStyle: mono(fontSize: 13, color: config.textPrimaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: config.borderColor, width: 1),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static TextTheme _buildTextTheme(
    CyberdeckFontFamily family,
    TextTheme base,
  ) {
    switch (family) {
      case CyberdeckFontFamily.dotNothing:
        return GoogleFonts.dotGothic16TextTheme(base);
      case CyberdeckFontFamily.ttHovesPro:
        return GoogleFonts.spaceGroteskTextTheme(base);
      case CyberdeckFontFamily.ttBluescreens:
        return GoogleFonts.barlowCondensedTextTheme(base);
      case CyberdeckFontFamily.openSans:
        return GoogleFonts.openSansTextTheme(base);
      case CyberdeckFontFamily.nunito:
        return GoogleFonts.nunitoTextTheme(base);
      case CyberdeckFontFamily.minecraft:
        return GoogleFonts.silkscreenTextTheme(base);
      case CyberdeckFontFamily.jetBrainsMono:
        return GoogleFonts.jetBrainsMonoTextTheme(base);
      case CyberdeckFontFamily.inter:
        return GoogleFonts.interTextTheme(base);
    }
  }
}
