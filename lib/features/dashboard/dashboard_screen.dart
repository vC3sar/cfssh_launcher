import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/cyber_tap_target.dart';
import '../apps/app_drawer_screen.dart';
import '../apps/apps_provider.dart';
import '../monitor/monitor_screen.dart';
import '../network/ping_screen.dart';
import '../settings/settings_screen.dart';
import '../vpn/vpn_screen.dart';
import '../cameras/rtsp_screen.dart';
import 'widgets/app_grid_widget.dart';
import 'widgets/calendar_activity_module.dart';
import 'widgets/clock_module_widget.dart';
import 'widgets/device_info_panel.dart';
import 'widgets/quick_actions_module_widget.dart';
import 'widgets/top_header_widget.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (HardwareKeyboard.instance.isControlPressed &&
          event.logicalKey == LogicalKeyboardKey.space) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AppDrawerScreen()),
        );
      }
    }
  }

  Widget? _buildModuleByKey(String key, CyberdeckConfig config) {
    if (config.visibleModules[key] == false) return null;
    switch (key) {
      case 'clock':
        return const ClockModuleWidget();
      case 'favorites':
        return const AppGridWidget();
      case 'quick_actions':
        return const QuickActionsModuleWidget();
      case 'system_monitor':
        return const SystemMonitorModule();
      case 'network':
        return const NetworkModuleWidget();
      case 'calendar':
        return const CalendarModuleWidget();
      case 'activity':
        return const ActivityFeedModuleWidget();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(cyberdeckConfigProvider);

    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        backgroundColor: config.backgroundColor,
        body: MediaQuery.removePadding(
          context: context,
          removeTop: config.immersiveMode,
          removeBottom: config.immersiveMode,
          child: ColoredBox(
            color: config.backgroundColor,
            child: Column(
              children: [
                const TopHeaderWidget(),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isLandscape = constraints.maxWidth >= 780;
                      final isWideDeck = constraints.maxWidth >= 1060;

                      if (isLandscape) {
                        return _buildLandscapeCyberdeck(
                          config,
                          isWideDeck: isWideDeck,
                        );
                      } else {
                        return _buildPortraitCyberdeck(config);
                      }
                    },
                  ),
                ),
                _buildCyberdeckDock(config),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLandscapeCyberdeck(
    CyberdeckConfig config, {
    required bool isWideDeck,
  }) {
    final pad = 12.0 * config.paddingScale;

    final mainKeys = {'clock', 'favorites', 'quick_actions'};
    final sysKeys = {'system_monitor', 'network'};
    final actKeys = {'calendar', 'activity'};

    final mainWidgets = <Widget>[];
    final sysWidgets = <Widget>[];
    final actWidgets = <Widget>[];

    for (final k in config.moduleOrder) {
      final w = _buildModuleByKey(k, config);
      if (w == null) continue;
      if (mainKeys.contains(k)) {
        mainWidgets.add(Padding(padding: EdgeInsets.only(bottom: pad), child: w));
      } else if (sysKeys.contains(k)) {
        sysWidgets.add(Padding(padding: EdgeInsets.only(bottom: pad), child: w));
      } else if (actKeys.contains(k)) {
        actWidgets.add(Padding(padding: EdgeInsets.only(bottom: pad), child: w));
      }
    }

    if (isWideDeck) {
      return Padding(
        padding: EdgeInsets.fromLTRB(pad, pad, pad, 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 46,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: mainWidgets),
              ),
            ),
            SizedBox(width: pad),
            Expanded(
              flex: 28,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: sysWidgets),
              ),
            ),
            SizedBox(width: pad),
            Expanded(
              flex: 26,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: actWidgets),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(pad, pad, pad, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 55,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: mainWidgets),
            ),
          ),
          SizedBox(width: pad),
          Expanded(
            flex: 45,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ...sysWidgets,
                  ...actWidgets,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortraitCyberdeck(CyberdeckConfig config) {
    final pad = 12.0 * config.paddingScale;
    final orderedWidgets = <Widget>[];

    for (final k in config.moduleOrder) {
      final w = _buildModuleByKey(k, config);
      if (w != null) {
        orderedWidgets.add(
          Padding(
            padding: EdgeInsets.only(bottom: pad),
            child: w,
          ),
        );
      }
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: orderedWidgets,
      ),
    );
  }

  Widget _buildCyberdeckDock(CyberdeckConfig config) {
    final accent = config.primaryAccent;
    final secondary = config.secondaryAccent;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 14 * config.paddingScale,
        vertical: 8 * config.paddingScale,
      ),
      decoration: BoxDecoration(
        color: config.panelColor,
        border: Border(
          top: BorderSide(color: config.borderColor, width: 1),
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDockButton(
                config: config,
                label: 'Aplicaciones',
                icon: Icons.grid_view_rounded,
                color: accent,
                isPrimary: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AppDrawerScreen()),
                  );
                },
              ),
              const SizedBox(width: 8),
              _buildDockButton(
                config: config,
                label: 'Terminal',
                icon: Icons.terminal_rounded,
                color: accent,
                onTap: () async {
                  ref
                      .read(cyberdeckConfigProvider.notifier)
                      .logAction('DOCK', 'Abrir cliente SSH / Terminal');
                  final ok = await ref
                      .read(deviceServiceProvider)
                      .launchAppByKeyword('cfssh_client');
                  if (!ok && mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PingScreen()),
                    );
                  }
                },
              ),
              const SizedBox(width: 8),
              _buildDockButton(
                config: config,
                label: 'Archivos',
                icon: Icons.folder_outlined,
                color: secondary,
                onTap: () {
                  ref
                      .read(cyberdeckConfigProvider.notifier)
                      .logAction('DOCK', 'Abrir Archivos');
                  ref.read(deviceServiceProvider).openFileManager(
                        packageName: config.defaultFileManager,
                      );
                },
              ),
              const SizedBox(width: 8),
              _buildDockButton(
                config: config,
                label: 'Navegador',
                icon: Icons.public_rounded,
                color: secondary,
                onTap: () {
                  ref
                      .read(cyberdeckConfigProvider.notifier)
                      .logAction('DOCK', 'Abrir Navegador');
                  ref.read(deviceServiceProvider).openBrowser();
                },
              ),
              const SizedBox(width: 8),
              _buildDockButton(
                config: config,
                label: 'Ping / Red',
                icon: Icons.network_check_rounded,
                color: accent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PingScreen()),
                  );
                },
              ),
              const SizedBox(width: 8),
              _buildDockButton(
                config: config,
                label: 'Monitor',
                icon: Icons.insights_rounded,
                color: secondary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MonitorScreen()),
                  );
                },
              ),
              const SizedBox(width: 8),
              _buildDockButton(
                config: config,
                label: 'VPN',
                icon: Icons.shield_outlined,
                color: secondary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const VpnScreen()),
                  );
                },
              ),
              const SizedBox(width: 8),
              _buildDockButton(
                config: config,
                label: 'Cámaras',
                icon: Icons.videocam_outlined,
                color: accent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RtspScreen()),
                  );
                },
              ),
              const SizedBox(width: 8),
              _buildDockButton(
                config: config,
                label: 'Ajustes',
                icon: Icons.tune_rounded,
                color: secondary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDockButton({
    required CyberdeckConfig config,
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return CyberTapTarget(
      onTap: onTap,
      pressColor: color,
      semanticLabel: label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        decoration: BoxDecoration(
          color: isPrimary ? color : config.surfaceSecondaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isPrimary ? color : config.borderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isPrimary ? Colors.white : color,
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: AppTheme.mono(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isPrimary ? Colors.white : config.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
