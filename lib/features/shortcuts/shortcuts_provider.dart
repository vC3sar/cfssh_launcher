import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/database_service.dart';
import 'shortcut_model.dart';

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

final shortcutsProvider = FutureProvider<List<ShortcutModel>>((ref) async {
  final dbService = ref.read(databaseServiceProvider);
  return await dbService.getShortcuts();
});
