import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/health_target_model.dart';
import '../services/probe_service.dart';

const String _kHealthTargetsKey = 'cyberdeck_health_targets_v1';
const String _kAutoProbeIntervalKey = 'cyberdeck_autoprobe_interval';

class HealthTargetsNotifier extends Notifier<List<HealthTargetModel>> {
  Timer? _pollingTimer;

  @override
  List<HealthTargetModel> build() {
    ref.onDispose(() {
      _pollingTimer?.cancel();
    });

    // Reactive listener: automatically restarts timer whenever auto-probe interval changes
    ref.listen(autoProbeIntervalProvider, (prev, next) {
      _restartPollingTimer(next);
      if (next > 0) {
        probeAll();
      }
    });

    _loadFromStorage();
    return [];
  }

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_kHealthTargetsKey);

    if (rawList != null && rawList.isNotEmpty) {
      state = rawList.map((str) => HealthTargetModel.fromJson(str)).toList();
    } else {
      // Default tactical health check presets
      state = [
        const HealthTargetModel(
          id: 'tgt_dns_cf',
          name: 'Cloudflare DNS',
          protocol: ProbeProtocol.udp,
          host: '1.1.1.1',
          port: 53,
          timeoutMs: 1800,
        ),
        const HealthTargetModel(
          id: 'tgt_google_tcp',
          name: 'Google Edge SSL',
          protocol: ProbeProtocol.tcp,
          host: '8.8.8.8',
          port: 443,
          timeoutMs: 2000,
        ),
        const HealthTargetModel(
          id: 'tgt_gateway_http',
          name: 'Gateway / Router Local',
          protocol: ProbeProtocol.http,
          host: '192.168.1.1',
          port: 80,
          path: '/',
          timeoutMs: 2000,
        ),
        const HealthTargetModel(
          id: 'tgt_cloudflare_web',
          name: 'Cloudflare HTTPS',
          protocol: ProbeProtocol.http,
          host: 'cloudflare.com',
          port: 443,
          path: '/',
          timeoutMs: 2500,
        ),
      ];
      await _saveToStorage();
    }

    // Start timer with current interval and trigger initial probe
    _restartPollingTimer(ref.read(autoProbeIntervalProvider));
    probeAll();
  }

  void _restartPollingTimer(int intervalSeconds) {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    if (intervalSeconds > 0) {
      _pollingTimer = Timer.periodic(Duration(seconds: intervalSeconds), (_) {
        probeAll();
      });
    }
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final list = state.map((t) => t.toJson()).toList();
    await prefs.setStringList(_kHealthTargetsKey, list);
  }

  void addTarget(HealthTargetModel target) {
    state = [...state, target];
    _saveToStorage();
    probeTarget(target.id);
  }

  void updateTarget(HealthTargetModel updated) {
    state = state.map((t) => t.id == updated.id ? updated : t).toList();
    _saveToStorage();
    probeTarget(updated.id);
  }

  void deleteTarget(String id) {
    state = state.where((t) => t.id != id).toList();
    _saveToStorage();
  }

  void toggleTargetEnabled(String id) {
    state = state.map((t) {
      if (t.id == id) {
        return t.copyWith(isEnabled: !t.isEnabled);
      }
      return t;
    }).toList();
    _saveToStorage();
  }

  Future<void> probeTarget(String id) async {
    final target = state.firstWhere((t) => t.id == id, orElse: () => throw Exception('Not found'));
    if (!target.isEnabled) return;

    // Set status to probing
    state = state.map((t) {
      if (t.id == id) {
        return t.copyWith(status: ProbeStatus.probing);
      }
      return t;
    }).toList();

    final result = await ProbeService.testProbe(target);
    final now = DateTime.now();

    final history = List<int>.from(target.latencyHistory);
    if (result.status == ProbeStatus.online || result.status == ProbeStatus.degraded) {
      history.add(result.latencyMs);
      if (history.length > 8) history.removeAt(0);
    } else {
      history.add(0);
      if (history.length > 8) history.removeAt(0);
    }

    final success = (result.status == ProbeStatus.online || result.status == ProbeStatus.degraded);

    state = state.map((t) {
      if (t.id == id) {
        return t.copyWith(
          status: result.status,
          lastLatencyMs: result.latencyMs,
          latencyHistory: history,
          lastChecked: now,
          statusMessage: result.message,
          successCount: t.successCount + (success ? 1 : 0),
          failCount: t.failCount + (success ? 0 : 1),
        );
      }
      return t;
    }).toList();

    // Update global last check timestamp
    ref.read(lastGlobalCheckProvider.notifier).setLastCheck(now);
    _saveToStorage();
  }

  Future<void> probeAll() async {
    final enabledTargets = state.where((t) => t.isEnabled).toList();
    if (enabledTargets.isEmpty) return;

    ref.read(isProbingAllProvider.notifier).setProbing(true);

    try {
      // Execute all probes in parallel
      await Future.wait(
        enabledTargets.map((t) => probeTarget(t.id)),
      );
      ref.read(lastGlobalCheckProvider.notifier).setLastCheck(DateTime.now());
    } finally {
      ref.read(isProbingAllProvider.notifier).setProbing(false);
    }
  }

  void resetMetrics(String id) {
    state = state.map((t) {
      if (t.id == id) {
        return t.copyWith(
          successCount: 0,
          failCount: 0,
          latencyHistory: const [],
        );
      }
      return t;
    }).toList();
    _saveToStorage();
  }
}

class AutoProbeIntervalNotifier extends Notifier<int> {
  @override
  int build() {
    _loadInterval();
    return 10; // Default 10 seconds
  }

  Future<void> _loadInterval() async {
    final prefs = await SharedPreferences.getInstance();
    final val = prefs.getInt(_kAutoProbeIntervalKey);
    if (val != null && val != state) {
      state = val;
    }
  }

  Future<void> setInterval(int seconds) async {
    state = seconds;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kAutoProbeIntervalKey, seconds);
  }
}

class IsProbingAllNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setProbing(bool value) => state = value;
}

class LastGlobalCheckNotifier extends Notifier<DateTime?> {
  @override
  DateTime? build() => null;

  void setLastCheck(DateTime time) => state = time;
}

final healthTargetsProvider = NotifierProvider<HealthTargetsNotifier, List<HealthTargetModel>>(() {
  return HealthTargetsNotifier();
});

final autoProbeIntervalProvider = NotifierProvider<AutoProbeIntervalNotifier, int>(() {
  return AutoProbeIntervalNotifier();
});

final isProbingAllProvider = NotifierProvider<IsProbingAllNotifier, bool>(() {
  return IsProbingAllNotifier();
});

final lastGlobalCheckProvider = NotifierProvider<LastGlobalCheckNotifier, DateTime?>(() {
  return LastGlobalCheckNotifier();
});
