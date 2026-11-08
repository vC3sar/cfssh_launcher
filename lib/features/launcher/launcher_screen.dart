import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import '../apps/app_drawer_screen.dart';
import '../apps/apps_provider.dart';
import '../dashboard/dashboard_screen.dart';
import '../dashboard/widgets/cyberdeck_panel.dart';
import '../dashboard/widgets/top_header_widget.dart';
import '../monitor/monitor_screen.dart';
import '../network/ping_screen.dart';
import '../cameras/widgets/rtsp_surveillance_panel.dart';
import '../health_checker/widgets/health_checker_panel.dart';

class LauncherScreen extends ConsumerStatefulWidget {
  const LauncherScreen({super.key});

  @override
  ConsumerState<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends ConsumerState<LauncherScreen>
    with WidgetsBindingObserver {
  final PageController _pageController = PageController(initialPage: 1);
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _enforceImmersiveMode();
  }

  Future<void> _enforceImmersiveMode() async {
    final config = ref.read(cyberdeckConfigProvider);
    final immersive = config.immersiveMode;
    final iconBrightness =
        config.isDarkMode ? Brightness.light : Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: config.panelColor,
        statusBarIconBrightness: iconBrightness,
        systemNavigationBarIconBrightness: iconBrightness,
      ),
    );
    if (immersive) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      await ref.read(deviceServiceProvider).setImmersiveMode(true);
    } else {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      await ref.read(deviceServiceProvider).setImmersiveMode(false);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _enforceImmersiveMode();
      // Incremental package & icon pack synchronization on resume from background
      ref.read(installedAppsProvider.notifier).syncApps();
      ref.invalidate(installedIconPacksProvider);
      ref.invalidate(monitorStatsProvider);
      ref.invalidate(usageRecentsProvider);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(cyberdeckConfigProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _currentPage != 1) {
          _pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
          );
        }
      },
      child: Scaffold(
        backgroundColor: config.backgroundColor,
        body: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (idx) => setState(() => _currentPage = idx),
          children: [
            _buildTacticalConsolePage(config),
            const DashboardScreen(),
            const AppDrawerScreen(),
          ],
        ),
      ),
    );
  }

  Widget _buildTacticalConsolePage(CyberdeckConfig config) {
    final accent = config.primaryAccent;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: config.backgroundColor,
      child: Column(
        children: [
          const TopHeaderWidget(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const RtspSurveillancePanel(),
                  const SizedBox(height: 16),
                  const HealthCheckerPanel(),
                  const SizedBox(height: 16),
                  CyberdeckPanel(
                    moduleCode: 'SYS-LOG',
                    title: 'Consola de Diagnóstico y Actividad',
                    accentColor: accent,
                    panelColor: config.panelColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Eventos recientes del sistema (${config.activityLog.length})',
                          style: AppTheme.mono(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: config.textSecondaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: config.surfaceSecondaryColor,
                            border: Border.all(color: config.borderColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: config.activityLog.map((entry) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                child: Text(
                                  '[${entry.timestamp}] ${entry.category}: ${entry.message}',
                                  style: AppTheme.codeMono(
                                    fontSize: 11,
                                    color: config.textPrimaryColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accent,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                minimumSize: const Size(140, 46),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const PingScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.terminal_rounded, size: 16),
                              label: Text(
                                'Herramienta Ping',
                                style: AppTheme.mono(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(140, 46),
                                side: BorderSide(color: config.borderColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                _pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 240),
                                  curve: Curves.easeOutCubic,
                                );
                              },
                              icon: Icon(
                                Icons.dashboard_outlined,
                                size: 16,
                                color: config.textPrimaryColor,
                              ),
                              label: Text(
                                'Ir al Inicio',
                                style: AppTheme.mono(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: config.textPrimaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
