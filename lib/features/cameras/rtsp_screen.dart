import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/rtsp_surveillance_panel.dart';

class RtspScreen extends ConsumerWidget {
  const RtspScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(cyberdeckConfigProvider);
    final accent = config.primaryAccent;

    return Scaffold(
      backgroundColor: config.backgroundColor,
      appBar: AppBar(
        title: Text(
          'SURV_NET // VIGILANCIA RTSP CCTV',
          style: AppTheme.mono(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: accent,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: config.panelColor,
        elevation: 0,
        iconTheme: IconThemeData(color: accent),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: RtspSurveillancePanel(),
        ),
      ),
    );
  }
}

