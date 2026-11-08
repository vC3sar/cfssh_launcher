import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import '../apps/apps_provider.dart';

class VpnScreen extends ConsumerWidget {
  const VpnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(cyberdeckConfigProvider);
    final accent = config.primaryAccent;

    return Scaffold(
      backgroundColor: config.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Conexiones VPN',
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
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 380),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: config.panelColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: config.borderColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.vpn_lock_rounded, size: 42, color: accent),
              ),
              const SizedBox(height: 16),
              Text(
                'Gestión de Túneles VPN',
                style: AppTheme.mono(
                  color: config.textPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Configura o administra tus perfiles VPN directamente desde los ajustes de red de Android.',
                textAlign: TextAlign.center,
                style: AppTheme.mono(
                  color: config.textSecondaryColor,
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(deviceServiceProvider).openVpnSettings();
                },
                icon: const Icon(Icons.settings_outlined, size: 18),
                label: Text(
                  'Abrir Ajustes de VPN',
                  style: AppTheme.mono(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
