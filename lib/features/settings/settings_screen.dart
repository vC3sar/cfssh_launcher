import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/cyber_tap_target.dart';
import '../../services/device_service.dart';
import '../apps/apps_provider.dart';
import '../monitor/monitor_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _applyingIconPack = false;

  static const Map<String, String> _moduleNames = {
    'clock': 'Reloj Principal y Calendario Semanal',
    'favorites': 'Aplicaciones Favoritas y Accesos Rápidos',
    'quick_actions': 'Centro de Control y Multimedia',
    'system_monitor': 'Estado del Sistema (RAM, Batería, Linterna)',
    'network': 'Conectividad y Red Local',
    'calendar': 'Agenda y Próximos Eventos',
    'activity': 'Recientes, Notificaciones y Actividad',
  };

  static const List<({String name, int hex})> _accentSwatches = [
    (name: 'Azul Sistema', hex: 0xFF0A84FF),
    (name: 'Verde Esmeralda', hex: 0xFF10B981),
    (name: 'Índigo Pro', hex: 0xFF6366F1),
    (name: 'Ámbar Solar', hex: 0xFFF59E0B),
    (name: 'Cian Técnico', hex: 0xFF06B6D4),
    (name: 'Violeta Studio', hex: 0xFF8B5CF6),
    (name: 'Rojo Coral', hex: 0xFFF43F5E),
  ];

  static const List<({String name, int hex})> _highlightSwatches = [
    (name: 'Ámbar Puntual', hex: 0xFFF59E0B),
    (name: 'Cian Cielo', hex: 0xFF38BDF8),
    (name: 'Rosa Magenta', hex: 0xFFEC4899),
    (name: 'Esmeralda Vivo', hex: 0xFF10B981),
    (name: 'Violeta Luz', hex: 0xFFA855F7),
    (name: 'Naranja Coral', hex: 0xFFF97316),
    (name: 'Amarillo Oro', hex: 0xFFEAB308),
  ];

  static const List<({String name, int hex})> _sentinelSwatches = [
    (name: 'Índigo Sentinel', hex: 0xFF6366F1),
    (name: 'Cian Radar', hex: 0xFF06B6D4),
    (name: 'Esmeralda Pulso', hex: 0xFF10B981),
    (name: 'Violeta Neural', hex: 0xFFA855F7),
    (name: 'Ámbar Monitor', hex: 0xFFF59E0B),
  ];

  static const List<
      ({
        CyberdeckFontFamily family,
        String title,
        String subtitle,
        String sample,
      })> _fontOptions = [
    (
      family: CyberdeckFontFamily.inter,
      title: 'Inter',
      subtitle: 'Neutra moderna estilo Apple',
      sample: '09:48 · Aa Bb',
    ),
    (
      family: CyberdeckFontFamily.dotNothing,
      title: 'Nothing Dot',
      subtitle: 'Matriz de puntos Nothing OS',
      sample: '09:48 · DOT',
    ),
    (
      family: CyberdeckFontFamily.ttHovesPro,
      title: 'TT Hoves Pro',
      subtitle: 'Geométrica técnica precisa',
      sample: '09:48 · PRO',
    ),
    (
      family: CyberdeckFontFamily.ttBluescreens,
      title: 'TT Bluescreens',
      subtitle: 'Condensada alta visibilidad',
      sample: '09:48 · DISPLAY',
    ),
    (
      family: CyberdeckFontFamily.openSans,
      title: 'Open Sans',
      subtitle: 'Humanista clara y abierta',
      sample: '09:48 · Sans',
    ),
    (
      family: CyberdeckFontFamily.nunito,
      title: 'Nunito',
      subtitle: 'Redondeada orgánica y suave',
      sample: '09:48 · Soft',
    ),
    (
      family: CyberdeckFontFamily.minecraft,
      title: 'Minecraft Font',
      subtitle: 'Pixel art retro bloque',
      sample: '09:48 PIXEL',
    ),
    (
      family: CyberdeckFontFamily.jetBrainsMono,
      title: 'JetBrains Mono',
      subtitle: 'Monoespaciada de ingeniería',
      sample: '09:48 · MONO',
    ),
  ];

  Future<void> _selectIconPack(String? packageName, String label) async {
    if (_applyingIconPack) return;
    setState(() => _applyingIconPack = true);
    try {
      await ref.read(installedAppsProvider.notifier).applyIconPack(packageName);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              packageName == null
                  ? 'Iconos originales restaurados'
                  : 'Paquete de iconos "$label" aplicado',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _applyingIconPack = false);
      }
    }
  }

  Future<void> _toggleIconMasking(bool enabled) async {
    if (_applyingIconPack) return;
    setState(() => _applyingIconPack = true);
    try {
      await ref.read(installedAppsProvider.notifier).setIconMasking(enabled);
    } finally {
      if (mounted) {
        setState(() => _applyingIconPack = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(cyberdeckConfigProvider);
    final notifier = ref.read(cyberdeckConfigProvider.notifier);
    final accent = config.primaryAccent;
    final secondary = config.secondaryAccent;

    return Scaffold(
      backgroundColor: config.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Ajustes del Launcher',
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
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // 1. Apariencia, Paleta de Tema, Acento Primario y Color de Destacado Puntual
            _buildSectionHeader('1. TEMA VISUAL, ACENTO Y DESTACADO PUNTUAL', config),
            _buildCard(
              config: config,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Modo de Apariencia',
                    style: AppTheme.mono(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: config.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Superficies sólidas calibradas con alto contraste y cero glassmorphism.',
                    style: AppTheme.mono(
                      fontSize: 11.5,
                      color: config.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildModeOption(
                          config: config,
                          icon: Icons.light_mode_rounded,
                          title: 'Modo Claro',
                          subtitle: 'Superficies claras',
                          selected: !config.isDarkMode,
                          accent: accent,
                          onTap: () => notifier.setDarkMode(false),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildModeOption(
                          config: config,
                          icon: Icons.dark_mode_rounded,
                          title: 'Modo Oscuro',
                          subtitle: 'Superficies profundas',
                          selected: config.isDarkMode,
                          accent: accent,
                          onTap: () => notifier.setDarkMode(true),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: config.borderColor, height: 28),
                  Text(
                    'Perfiles de Tema (Paleta Base + Superficies)',
                    style: AppTheme.mono(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: config.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildPresetChip(
                        config: config,
                        label: 'Azul Ocean Pro',
                        preset: CyberdeckThemePreset.tacticalCyan,
                        current: config.themePreset,
                        color: const Color(0xFF0A84FF),
                        onTap: () => notifier.setThemePreset(
                          CyberdeckThemePreset.tacticalCyan,
                        ),
                      ),
                      _buildPresetChip(
                        config: config,
                        label: 'Esmeralda Forest',
                        preset: CyberdeckThemePreset.phosphorMatrix,
                        current: config.themePreset,
                        color: const Color(0xFF10B981),
                        onTap: () => notifier.setThemePreset(
                          CyberdeckThemePreset.phosphorMatrix,
                        ),
                      ),
                      _buildPresetChip(
                        config: config,
                        label: 'Ámbar Solar',
                        preset: CyberdeckThemePreset.amberTerminal,
                        current: config.themePreset,
                        color: const Color(0xFFF59E0B),
                        onTap: () => notifier.setThemePreset(
                          CyberdeckThemePreset.amberTerminal,
                        ),
                      ),
                      _buildPresetChip(
                        config: config,
                        label: 'Grafito Violeta',
                        preset: CyberdeckThemePreset.stealthGraphite,
                        current: config.themePreset,
                        color: const Color(0xFF8B5CF6),
                        onTap: () => notifier.setThemePreset(
                          CyberdeckThemePreset.stealthGraphite,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Color de Acento Primario (Botones y Selección)',
                    style: AppTheme.mono(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: config.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _accentSwatches.map((swatch) {
                      final isSelected =
                          config.customAccentColorValue == swatch.hex;
                      final c = Color(swatch.hex);
                      return _buildColorSwatchChip(
                        config: config,
                        name: swatch.name,
                        color: c,
                        isSelected: isSelected,
                        onTap: () => notifier.setAccentColor(swatch.hex),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Color de Destacado Puntual (Hoy, Segundos, Indicadores Clave)',
                    style: AppTheme.mono(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: config.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _highlightSwatches.map((swatch) {
                      final isSelected =
                          config.customHighlightColorValue == swatch.hex;
                      final c = Color(swatch.hex);
                      return _buildColorSwatchChip(
                        config: config,
                        name: swatch.name,
                        color: c,
                        isSelected: isSelected,
                        onTap: () => notifier.setHighlightColor(swatch.hex),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Color Propio de Sentinel Health Live',
                    style: AppTheme.mono(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: config.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _sentinelSwatches.map((swatch) {
                      final isSelected =
                          config.sentinelAccentColorValue == swatch.hex;
                      final c = Color(swatch.hex);
                      return _buildColorSwatchChip(
                        config: config,
                        name: swatch.name,
                        color: c,
                        isSelected: isSelected,
                        onTap: () => notifier.setSentinelAccentColor(swatch.hex),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. Tipografía del Sistema y del Reloj
            _buildSectionHeader('2. TIPOGRAFÍA DEL SISTEMA Y RELOJ', config),
            _buildTypographySection(config, notifier, accent),
            const SizedBox(height: 24),

            // 3. Icon Packs Section
            _buildSectionHeader('3. ICON PACKS (PAQUETES DE ICONOS)', config),
            _buildIconPacksSection(config, accent),
            const SizedBox(height: 24),

            // 4. Android Home Launcher & Permissions
            _buildSectionHeader('4. SISTEMA ANDROID Y PERMISOS', config),
            _buildCard(
              config: config,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: accent,
                    title: Text(
                      'Modo Inmersivo (Ocultar Barras del Sistema)',
                      style: AppTheme.mono(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: config.textPrimaryColor,
                      ),
                    ),
                    subtitle: Text(
                      'Oculta la barra de estado y navegación mostrando gestos transitorios al deslizar.',
                      style: AppTheme.mono(
                        fontSize: 11.5,
                        color: config.textSecondaryColor,
                      ),
                    ),
                    value: config.immersiveMode,
                    onChanged: (val) async {
                      await notifier.setImmersiveMode(val);
                      await ref.read(deviceServiceProvider).setImmersiveMode(val);
                      ref.invalidate(monitorStatsProvider);
                    },
                  ),
                  Divider(color: config.borderColor, height: 24),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildActionButton(
                        config: config,
                        icon: Icons.home_rounded,
                        label: 'Launcher Predeterminado',
                        color: accent,
                        onTap: () =>
                            ref.read(deviceServiceProvider).openHomeSettings(),
                      ),
                      _buildActionButton(
                        config: config,
                        icon: Icons.history_rounded,
                        label: 'Permiso de Uso (Recientes)',
                        color: secondary,
                        onTap: () => ref
                            .read(deviceServiceProvider)
                            .openUsageAccessSettings(),
                      ),
                      _buildActionButton(
                        config: config,
                        icon: Icons.notifications_none_rounded,
                        label: 'Acceso a Notificaciones',
                        color: accent,
                        onTap: () => ref
                            .read(deviceServiceProvider)
                            .openNotificationAccessSettings(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 5. Density & Clock Format
            _buildSectionHeader('5. ESCALA DE INTERFAZ Y FORMATO DE HORA', config),
            _buildCard(
              config: config,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Densidad de Elementos',
                    style: AppTheme.mono(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: config.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildDensityBtn(
                        config: config,
                        label: 'Compacta',
                        density: CyberdeckDensity.compact,
                        current: config.density,
                        accent: accent,
                        onTap: () => notifier.setDensity(CyberdeckDensity.compact),
                      ),
                      const SizedBox(width: 8),
                      _buildDensityBtn(
                        config: config,
                        label: 'Estándar',
                        density: CyberdeckDensity.standard,
                        current: config.density,
                        accent: accent,
                        onTap: () => notifier.setDensity(CyberdeckDensity.standard),
                      ),
                      const SizedBox(width: 8),
                      _buildDensityBtn(
                        config: config,
                        label: 'Amplia',
                        density: CyberdeckDensity.comfort,
                        current: config.density,
                        accent: accent,
                        onTap: () => notifier.setDensity(CyberdeckDensity.comfort),
                      ),
                    ],
                  ),
                  Divider(color: config.borderColor, height: 24),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: accent,
                    title: Text(
                      'Formato de 24 Horas',
                      style: AppTheme.mono(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: config.textPrimaryColor,
                      ),
                    ),
                    subtitle: Text(
                      'Desactívalo para utilizar el formato de 12 horas (AM / PM).',
                      style: AppTheme.mono(
                        fontSize: 11.5,
                        color: config.textSecondaryColor,
                      ),
                    ),
                    value: config.use24HourFormat,
                    onChanged: (val) => notifier.setTimeFormat(use24h: val),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: accent,
                    title: Text(
                      'Mostrar Segundos Destacados en el Reloj',
                      style: AppTheme.mono(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: config.textPrimaryColor,
                      ),
                    ),
                    value: config.showSeconds,
                    onChanged: (val) => notifier.setTimeFormat(showSeconds: val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 6. Show / Hide & Reorder Modules
            _buildSectionHeader('6. MÓDULOS DE LA PANTALLA PRINCIPAL', config),
            _buildCard(
              config: config,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selecciona los paneles visibles y ajusta su orden en el escritorio:',
                    style: AppTheme.mono(
                      fontSize: 11.5,
                      color: config.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(config.moduleOrder.length, (idx) {
                    final key = config.moduleOrder[idx];
                    final isVis = config.visibleModules[key] ?? true;
                    final label = _moduleNames[key] ?? key;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: config.surfaceSecondaryColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isVis
                              ? accent.withValues(alpha: 0.35)
                              : config.borderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isVis,
                            activeColor: accent,
                            checkColor: Colors.white,
                            onChanged: (val) {
                              if (val != null) {
                                notifier.toggleModuleVisibility(key, val);
                              }
                            },
                          ),
                          Expanded(
                            child: Text(
                              label,
                              style: AppTheme.mono(
                                fontSize: 12.5,
                                fontWeight:
                                    isVis ? FontWeight.w600 : FontWeight.w400,
                                color: isVis
                                    ? config.textPrimaryColor
                                    : config.textSecondaryColor,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_up_rounded,
                              size: 20,
                              color: idx > 0
                                  ? config.textPrimaryColor
                                  : config.textSecondaryColor.withValues(alpha: 0.3),
                            ),
                            onPressed: idx > 0
                                ? () => notifier.moveModule(key, -1)
                                : null,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 20,
                              color: idx < config.moduleOrder.length - 1
                                  ? config.textPrimaryColor
                                  : config.textSecondaryColor.withValues(alpha: 0.3),
                            ),
                            onPressed: idx < config.moduleOrder.length - 1
                                ? () => notifier.moveModule(key, 1)
                                : null,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 7. Default File Manager
            _buildSectionHeader('7. APLICACIÓN DE ARCHIVOS PREDETERMINADA', config),
            _buildFileManagerSelector(config, notifier, accent),
          ],
        ),
      ),
    );
  }

  Widget _buildTypographySection(
    CyberdeckConfig config,
    CyberdeckConfigNotifier notifier,
    Color accent,
  ) {
    return _buildCard(
      config: config,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Familia Tipográfica',
            style: AppTheme.mono(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: config.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Aplica la fuente seleccionada al reloj principal de gran formato y a toda la interfaz.',
            style: AppTheme.mono(
              fontSize: 11.5,
              color: config.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 260,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 74,
            ),
            itemCount: _fontOptions.length,
            itemBuilder: (context, idx) {
              final opt = _fontOptions[idx];
              final isSelected = config.fontFamily == opt.family;

              return CyberTapTarget(
                onTap: () => notifier.setFontFamily(opt.family),
                pressColor: accent,
                fillWidth: true,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? accent.withValues(alpha: 0.14)
                        : config.surfaceSecondaryColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? accent : config.borderColor,
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              opt.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.mono(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? accent
                                    : config.textPrimaryColor,
                                fontOverride: opt.family,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              opt.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.mono(
                                fontSize: 10,
                                color: config.textSecondaryColor,
                                fontOverride: CyberdeckFontFamily.inter,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              opt.sample,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.mono(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: config.highlightAccent,
                                fontOverride: opt.family,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isSelected
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        size: 18,
                        color: isSelected ? accent : config.textSecondaryColor,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColorSwatchChip({
    required CyberdeckConfig config,
    required String name,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return CyberTapTarget(
      onTap: onTap,
      pressColor: color,
      semanticLabel: name,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.15)
              : config.surfaceSecondaryColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : config.borderColor,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: AppTheme.mono(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? color : config.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconPacksSection(CyberdeckConfig config, Color accent) {
    final iconPacksAsync = ref.watch(installedIconPacksProvider);
    final selectedPack = config.selectedIconPack;

    return _buildCard(
      config: config,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Paquetes de Iconos Instalados',
                      style: AppTheme.mono(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: config.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Compatible con iWhite OS (com.italiano.iwhite) y paquetes ADW / Nova / Lawnchair.',
                      style: AppTheme.mono(
                        fontSize: 11.5,
                        color: config.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (_applyingIconPack)
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: accent,
                    ),
                  ),
                )
              else
                IconButton(
                  tooltip: 'Buscar nuevos paquetes instalados',
                  onPressed: () => ref.invalidate(installedIconPacksProvider),
                  icon: Icon(
                    Icons.refresh_rounded,
                    size: 20,
                    color: config.textSecondaryColor,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),

          // Option 0: System Default Icons
          _buildIconPackTile(
            config: config,
            accent: accent,
            title: 'Iconos Originales del Sistema',
            subtitle: 'Iconos nativos de cada aplicación',
            iconBytes: null,
            isSelected: selectedPack == null || selectedPack.isEmpty,
            isFeatured: false,
            onTap: () => _selectIconPack(null, 'Originales'),
          ),

          const SizedBox(height: 8),

          iconPacksAsync.when(
            data: (packs) {
              if (packs.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: config.surfaceSecondaryColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: config.borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 18,
                        color: config.textSecondaryColor,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'No se detectaron paquetes de iconos externos instalados. Instala "iWhite OS Icon Pack" (com.italiano.iwhite) o cualquier icon pack compatible y aparecerá aquí automáticamente.',
                          style: AppTheme.mono(
                            fontSize: 11.5,
                            color: config.textSecondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: packs.map((IconPackInfo pack) {
                  final isSelected = selectedPack == pack.packageName;
                  final isIWhite = pack.packageName == 'com.italiano.iwhite';
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _buildIconPackTile(
                      config: config,
                      accent: accent,
                      title: pack.name,
                      subtitle: pack.packageName,
                      iconBytes: pack.icon,
                      isSelected: isSelected,
                      isFeatured: isIWhite,
                      onTap: () => _selectIconPack(pack.packageName, pack.name),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 2, color: accent),
              ),
            ),
            error: (_, _) => Text(
              'No fue posible consultar los paquetes de iconos.',
              style: AppTheme.mono(fontSize: 12, color: AppTheme.error),
            ),
          ),

          Divider(color: config.borderColor, height: 24),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            activeThumbColor: accent,
            title: Text(
              'Icon Masking para aplicaciones sin icono personalizado',
              style: AppTheme.mono(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: config.textPrimaryColor,
              ),
            ),
            subtitle: Text(
              'Adapta automáticamente los iconos no incluidos en el paquete usando la máscara y estética del paquete activo.',
              style: AppTheme.mono(
                fontSize: 11,
                color: config.textSecondaryColor,
              ),
            ),
            value: config.maskUnthemedIcons,
            onChanged: _toggleIconMasking,
          ),
        ],
      ),
    );
  }

  Widget _buildIconPackTile({
    required CyberdeckConfig config,
    required Color accent,
    required String title,
    required String subtitle,
    required dynamic iconBytes,
    required bool isSelected,
    required bool isFeatured,
    required VoidCallback onTap,
  }) {
    return CyberTapTarget(
      onTap: onTap,
      pressColor: accent,
      fillWidth: true,
      semanticLabel: title,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? accent.withValues(alpha: 0.12)
              : config.surfaceSecondaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? accent : config.borderColor,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: config.panelColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: config.borderColor),
              ),
              child: iconBytes != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.memory(
                        iconBytes,
                        width: 42,
                        height: 42,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      Icons.apps_rounded,
                      size: 22,
                      color: isSelected ? accent : config.textSecondaryColor,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: AppTheme.mono(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: config.textPrimaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isFeatured) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: config.highlightAccent.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'RECOMENDADO',
                            style: AppTheme.codeMono(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: config.highlightAccent,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTheme.codeMono(
                      fontSize: 10.5,
                      color: config.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              isSelected
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              size: 20,
              color: isSelected ? accent : config.textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeOption({
    required CyberdeckConfig config,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool selected,
    required Color accent,
    required VoidCallback onTap,
  }) {
    return CyberTapTarget(
      onTap: onTap,
      pressColor: accent,
      fillWidth: true,
      semanticLabel: title,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? accent.withValues(alpha: 0.12)
              : config.surfaceSecondaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? accent : config.borderColor,
            width: selected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: selected ? accent : config.textSecondaryColor,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.mono(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: config.textPrimaryColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTheme.mono(
                      fontSize: 10.5,
                      color: config.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(Icons.check_circle_rounded, size: 18, color: accent),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required CyberdeckConfig config,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return CyberTapTarget(
      onTap: onTap,
      pressColor: color,
      semanticLabel: label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: config.surfaceSecondaryColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: config.borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTheme.mono(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: config.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, CyberdeckConfig config) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 2),
      child: Text(
        title,
        style: AppTheme.codeMono(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: config.textSecondaryColor,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildCard({required CyberdeckConfig config, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: config.panelColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: config.borderColor),
      ),
      child: child,
    );
  }

  Widget _buildPresetChip({
    required CyberdeckConfig config,
    required String label,
    required CyberdeckThemePreset preset,
    required CyberdeckThemePreset current,
    required Color color,
    required VoidCallback onTap,
  }) {
    final selected = preset == current;
    return CyberTapTarget(
      onTap: onTap,
      pressColor: color,
      semanticLabel: label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? color.withValues(alpha: 0.14)
              : config.surfaceSecondaryColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? color : config.borderColor,
            width: selected ? 1.5 : 1.0,
          ),
        ),
        child: Text(
          label,
          style: AppTheme.mono(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? color : config.textPrimaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildDensityBtn({
    required CyberdeckConfig config,
    required String label,
    required CyberdeckDensity density,
    required CyberdeckDensity current,
    required Color accent,
    required VoidCallback onTap,
  }) {
    final selected = density == current;
    return Expanded(
      child: CyberTapTarget(
        onTap: onTap,
        pressColor: accent,
        fillWidth: true,
        semanticLabel: label,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? accent.withValues(alpha: 0.14)
                : config.surfaceSecondaryColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? accent : config.borderColor,
              width: selected ? 1.5 : 1.0,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTheme.mono(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected ? accent : config.textPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileManagerSelector(
    CyberdeckConfig config,
    CyberdeckConfigNotifier notifier,
    Color accent,
  ) {
    final appsAsync = ref.watch(installedAppsProvider);

    return _buildCard(
      config: config,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gestor de Archivos Predeterminado',
            style: AppTheme.mono(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: config.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Aplicación que se abrirá al pulsar "Archivos" en el Dock o en el Centro de Control.',
            style: AppTheme.mono(
              fontSize: 11.5,
              color: config.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 12),
          appsAsync.when(
            data: (apps) {
              return DropdownButtonFormField<String>(
                initialValue: config.defaultFileManager != null &&
                        apps.any((a) => a.packageName == config.defaultFileManager)
                    ? config.defaultFileManager
                    : null,
                dropdownColor: config.panelColor,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: config.surfaceSecondaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: config.borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: config.borderColor),
                  ),
                ),
                hint: Text(
                  'Automático (Archivos del sistema)...',
                  style: AppTheme.mono(
                    fontSize: 12,
                    color: config.textSecondaryColor,
                  ),
                ),
                items: apps.map((app) {
                  return DropdownMenuItem(
                    value: app.packageName,
                    child: Text(
                      app.name,
                      style: AppTheme.mono(
                        fontSize: 12.5,
                        color: config.textPrimaryColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    notifier.setDefaultFileManager(val);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Gestor de archivos actualizado'),
                      ),
                    );
                  }
                },
              );
            },
            loading: () => CircularProgressIndicator(color: accent),
            error: (_, _) => Text(
              'Error al cargar aplicaciones',
              style: AppTheme.mono(color: AppTheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
