import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/rtsp_camera_model.dart';
import '../services/camera_scanner_service.dart';

class CamerasNotifier extends Notifier<List<RtspCameraModel>> {
  static const String _prefKey = 'cyberdeck_rtsp_cameras';

  @override
  List<RtspCameraModel> build() {
    _loadFromPrefs();
    // Default preset with the user's example so it works out of the box
    return const [
      RtspCameraModel(
        id: 'cam_default_01',
        name: 'CAM-01 // VIGILANCIA CCTV',
        url: 'rtsp://admin:admin123@192.168.1.85:554/live/ch00_1',
        user: 'admin',
        password: 'admin123',
        ip: '192.168.1.85',
        port: 554,
        path: '/live/ch00_1',
        isMuted: true,
      ),
    ];
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList(_prefKey);
      if (jsonList != null && jsonList.isNotEmpty) {
        final loaded = jsonList
            .map((s) => RtspCameraModel.fromMap(json.decode(s) as Map<String, dynamic>))
            .toList();
        if (loaded.isNotEmpty) {
          state = loaded;
        }
      }
    } catch (_) {}
  }

  Future<void> _saveToPrefs(List<RtspCameraModel> cameras) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = cameras.map((c) => json.encode(c.toMap())).toList();
      await prefs.setStringList(_prefKey, jsonList);
    } catch (_) {}
  }

  Future<void> addCamera(RtspCameraModel camera) async {
    final updated = [...state, camera];
    state = updated;
    await _saveToPrefs(updated);
  }

  Future<void> updateCamera(RtspCameraModel camera) async {
    final updated = state.map((c) => c.id == camera.id ? camera : c).toList();
    state = updated;
    await _saveToPrefs(updated);
  }

  Future<void> deleteCamera(String id) async {
    final updated = state.where((c) => c.id != id).toList();
    state = updated;
    await _saveToPrefs(updated);
  }

  Future<void> toggleMute(String id) async {
    final updated = state.map((c) {
      if (c.id == id) {
        return c.copyWith(isMuted: !c.isMuted);
      }
      return c;
    }).toList();
    state = updated;
    await _saveToPrefs(updated);
  }
}

final camerasProvider = NotifierProvider<CamerasNotifier, List<RtspCameraModel>>(
  CamerasNotifier.new,
);

class ActiveCameraIdNotifier extends Notifier<String?> {
  @override
  String? build() {
    final cameras = ref.watch(camerasProvider);
    if (cameras.isNotEmpty) {
      return cameras.first.id;
    }
    return null;
  }

  void selectCamera(String id) {
    state = id;
  }
}

final activeCameraIdProvider = NotifierProvider<ActiveCameraIdNotifier, String?>(
  ActiveCameraIdNotifier.new,
);

final activeCameraProvider = Provider<RtspCameraModel?>((ref) {
  final cameras = ref.watch(camerasProvider);
  final activeId = ref.watch(activeCameraIdProvider);
  if (cameras.isEmpty) return null;
  return cameras.where((c) => c.id == activeId).firstOrNull ?? cameras.first;
});

class ScanResultsNotifier extends Notifier<List<DiscoveredCamera>> {
  @override
  List<DiscoveredCamera> build() => [];

  void setResults(List<DiscoveredCamera> list) => state = list;
  void addResult(DiscoveredCamera cam) => state = [...state, cam];
  void clear() => state = [];
}

final cameraScanResultsProvider = NotifierProvider<ScanResultsNotifier, List<DiscoveredCamera>>(
  ScanResultsNotifier.new,
);
