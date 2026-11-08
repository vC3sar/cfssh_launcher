import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/cyberdeck_config_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/launcher/launcher_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(
    const ProviderScope(
      child: CFSSHLauncherApp(),
    ),
  );
}

class CFSSHLauncherApp extends ConsumerWidget {
  const CFSSHLauncherApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(cyberdeckConfigProvider);

    return MaterialApp(
      title: 'CFSSH Cyberdeck OS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.buildCyberdeckTheme(config),
      home: const LauncherScreen(),
    );
  }
}
