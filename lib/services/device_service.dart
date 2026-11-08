import 'dart:async';
import 'package:flutter/services.dart';

class InstalledApp {
  final String packageName;
  final String activityName;
  final String name;
  final int versionCode;
  final int lastUpdateTime;
  final bool isSystemApp;
  final Uint8List? icon;

  const InstalledApp({
    required this.packageName,
    this.activityName = '',
    required this.name,
    this.versionCode = 0,
    this.lastUpdateTime = 0,
    this.isSystemApp = false,
    this.icon,
  });

  factory InstalledApp.fromMap(Map<dynamic, dynamic> map) {
    return InstalledApp(
      packageName: (map['packageName'] as String?) ?? '',
      activityName: (map['activityName'] as String?) ?? '',
      name: (map['name'] as String?) ?? '',
      versionCode: (map['versionCode'] as num?)?.toInt() ?? 0,
      lastUpdateTime: (map['lastUpdateTime'] as num?)?.toInt() ?? 0,
      isSystemApp: (map['isSystemApp'] as bool?) ?? false,
      icon: map['icon'] as Uint8List?,
    );
  }

  InstalledApp copyWith({
    String? packageName,
    String? activityName,
    String? name,
    int? versionCode,
    int? lastUpdateTime,
    bool? isSystemApp,
    Uint8List? icon,
  }) {
    return InstalledApp(
      packageName: packageName ?? this.packageName,
      activityName: activityName ?? this.activityName,
      name: name ?? this.name,
      versionCode: versionCode ?? this.versionCode,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      isSystemApp: isSystemApp ?? this.isSystemApp,
      icon: icon ?? this.icon,
    );
  }
}

class IconPackInfo {
  final String packageName;
  final String name;
  final Uint8List? icon;
  final bool isSelected;
  final bool isIWhite;

  const IconPackInfo({
    required this.packageName,
    required this.name,
    this.icon,
    this.isSelected = false,
    this.isIWhite = false,
  });

  factory IconPackInfo.fromMap(Map<dynamic, dynamic> map) {
    final pkg = (map['packageName'] as String?) ?? '';
    return IconPackInfo(
      packageName: pkg,
      name: (map['name'] as String?) ?? pkg,
      icon: map['icon'] as Uint8List?,
      isSelected: (map['isSelected'] as bool?) ?? false,
      isIWhite: (map['isIWhite'] as bool?) ?? (pkg == 'com.italiano.iwhite'),
    );
  }
}

class AlternativeIconItem {
  final String drawableName;
  final Uint8List icon;

  const AlternativeIconItem({
    required this.drawableName,
    required this.icon,
  });

  factory AlternativeIconItem.fromMap(Map<dynamic, dynamic> map) {
    return AlternativeIconItem(
      drawableName: (map['drawableName'] as String?) ?? '',
      icon: (map['icon'] as Uint8List?) ?? Uint8List(0),
    );
  }
}

class PackageChangeEvent {
  final String type; // 'added' | 'removed' | 'updated' | 'changed'
  final String packageName;
  final bool isReplacing;
  final InstalledApp? app;
  final bool isIconPack;
  final String? selectedIconPack;

  const PackageChangeEvent({
    required this.type,
    required this.packageName,
    required this.isReplacing,
    this.app,
    this.isIconPack = false,
    this.selectedIconPack,
  });

  factory PackageChangeEvent.fromMap(Map<dynamic, dynamic> map) {
    final rawApp = map['app'];
    return PackageChangeEvent(
      type: (map['type'] as String?) ?? 'changed',
      packageName: (map['packageName'] as String?) ?? '',
      isReplacing: (map['isReplacing'] as bool?) ?? false,
      app: rawApp is Map ? InstalledApp.fromMap(rawApp) : null,
      isIconPack: (map['isIconPack'] as bool?) ?? false,
      selectedIconPack: map['selectedIconPack'] as String?,
    );
  }
}

class CalendarEventItem {
  final String title;
  final DateTime begin;
  final DateTime end;
  final bool allDay;
  final String location;

  const CalendarEventItem({
    required this.title,
    required this.begin,
    required this.end,
    required this.allDay,
    required this.location,
  });

  factory CalendarEventItem.fromMap(Map<dynamic, dynamic> map) {
    return CalendarEventItem(
      title: (map['title'] as String?) ?? 'Evento',
      begin: DateTime.fromMillisecondsSinceEpoch((map['begin'] as num?)?.toInt() ?? 0),
      end: DateTime.fromMillisecondsSinceEpoch((map['end'] as num?)?.toInt() ?? 0),
      allDay: (map['allDay'] as bool?) ?? false,
      location: (map['location'] as String?) ?? '',
    );
  }
}

class SystemNotificationItem {
  final String key;
  final String packageName;
  final String title;
  final String text;
  final DateTime postTime;

  const SystemNotificationItem({
    required this.key,
    required this.packageName,
    required this.title,
    required this.text,
    required this.postTime,
  });

  factory SystemNotificationItem.fromMap(Map<dynamic, dynamic> map) {
    return SystemNotificationItem(
      key: (map['key'] as String?) ?? '',
      packageName: (map['packageName'] as String?) ?? '',
      title: (map['title'] as String?) ?? '',
      text: (map['text'] as String?) ?? '',
      postTime: DateTime.fromMillisecondsSinceEpoch((map['postTime'] as num?)?.toInt() ?? 0),
    );
  }
}

class DeviceService {
  static const MethodChannel _channel = MethodChannel('CFSSH_DEVICE');
  static final StreamController<PackageChangeEvent> _packageEventsController =
      StreamController<PackageChangeEvent>.broadcast();
  static bool _handlerInitialized = false;

  DeviceService() {
    _ensureMethodCallHandler();
  }

  static void _ensureMethodCallHandler() {
    if (_handlerInitialized) return;
    _handlerInitialized = true;
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onPackageEvent' && call.arguments is Map) {
        final event = PackageChangeEvent.fromMap(call.arguments as Map<dynamic, dynamic>);
        _packageEventsController.add(event);
      }
      return null;
    });
  }

  Stream<PackageChangeEvent> get packageEvents => _packageEventsController.stream;

  Future<List<InstalledApp>> getInstalledApps({bool forceRefresh = false}) async {
    try {
      final List<dynamic>? result = await _channel.invokeMethod(
        'getInstalledApps',
        {'forceRefresh': forceRefresh},
      );
      if (result == null) return [];

      return result
          .map((item) => InstalledApp.fromMap(item as Map<dynamic, dynamic>))
          .where((app) => app.packageName.isNotEmpty)
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<InstalledApp?> getSingleApp(String packageName) async {
    try {
      final Map<dynamic, dynamic>? res = await _channel.invokeMethod(
        'getSingleApp',
        {'packageName': packageName},
      );
      if (res == null) return null;
      return InstalledApp.fromMap(res);
    } catch (_) {
      return null;
    }
  }

  Future<List<IconPackInfo>> getInstalledIconPacks() async {
    try {
      final List<dynamic>? res = await _channel.invokeMethod('getInstalledIconPacks');
      if (res == null) return [];
      return res
          .map((item) => IconPackInfo.fromMap(item as Map<dynamic, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<({String? selectedIconPack, bool maskUnthemed})> getSelectedIconPackInfo() async {
    try {
      final Map<dynamic, dynamic>? res =
          await _channel.invokeMethod('getSelectedIconPack');
      if (res == null) return (selectedIconPack: null, maskUnthemed: true);
      return (
        selectedIconPack: res['selectedIconPack'] as String?,
        maskUnthemed: (res['maskUnthemed'] as bool?) ?? true,
      );
    } catch (_) {
      return (selectedIconPack: null, maskUnthemed: true);
    }
  }

  Future<bool> setSelectedIconPack(String? packageName) async {
    try {
      final bool? ok = await _channel.invokeMethod(
        'setSelectedIconPack',
        {'packageName': packageName},
      );
      return ok ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> setIconMasking(bool enabled) async {
    try {
      final bool? ok = await _channel.invokeMethod(
        'setIconMasking',
        {'enabled': enabled},
      );
      return ok ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<List<AlternativeIconItem>> getAlternativeIcons(
    String packageName,
    String appLabel,
  ) async {
    try {
      final List<dynamic>? res = await _channel.invokeMethod(
        'getAlternativeIcons',
        {'packageName': packageName, 'appLabel': appLabel},
      );
      if (res == null) return [];
      return res
          .map((e) => AlternativeIconItem.fromMap(e as Map<dynamic, dynamic>))
          .where((e) => e.drawableName.isNotEmpty && e.icon.isNotEmpty)
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<InstalledApp?> setCustomAppIcon(
    String packageName,
    String? drawableName,
  ) async {
    try {
      final Map<dynamic, dynamic>? res = await _channel.invokeMethod(
        'setCustomAppIcon',
        {'packageName': packageName, 'drawableName': drawableName},
      );
      if (res == null) return null;
      return InstalledApp.fromMap(res);
    } catch (_) {
      return null;
    }
  }

  Future<bool> uninstallApp(String packageName) async {
    try {
      return await _channel.invokeMethod(
            'uninstallApp',
            {'packageName': packageName},
          ) ??
          false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> launchApp(String packageName) async {
    try {
      final bool? result =
          await _channel.invokeMethod('launchApp', {'packageName': packageName});
      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> launchAppByKeyword(String keyword) async {
    final apps = await getInstalledApps();
    final lowerKeyword = keyword.toLowerCase();
    for (var app in apps) {
      if (app.name.toLowerCase().contains(lowerKeyword) ||
          app.packageName.toLowerCase().contains(lowerKeyword)) {
        return await launchApp(app.packageName);
      }
    }
    return false;
  }

  Future<Uint8List?> getAppIcon(String packageName) async {
    try {
      final iconBytes = await _channel
          .invokeMethod<Uint8List>('getAppIcon', {'packageName': packageName});
      return iconBytes;
    } catch (e) {
      return null;
    }
  }

  Future<bool> openAppInfo(String packageName) async {
    try {
      return await _channel
              .invokeMethod('openAppInfo', {'packageName': packageName}) ??
          false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> openVpnSettings() async {
    try {
      return await _channel.invokeMethod('openVpnSettings') ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> openWifiSettings() async {
    try {
      return await _channel.invokeMethod('openWifiSettings') ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> openBluetoothSettings() async {
    try {
      return await _channel.invokeMethod('openBluetoothSettings') ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> openDisplaySettings() async {
    try {
      return await _channel.invokeMethod('openDisplaySettings') ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> openSystemSettings() async {
    try {
      return await _channel.invokeMethod('openSystemSettings') ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> openHomeSettings() async {
    try {
      return await _channel.invokeMethod('openHomeSettings') ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> openBrowser({String? url}) async {
    try {
      return await _channel.invokeMethod(
            'openBrowser',
            url != null ? {'url': url} : null,
          ) ??
          false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> openCamera() async {
    try {
      return await _channel.invokeMethod('openCamera') ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> openFileManager({String? packageName}) async {
    try {
      return await _channel.invokeMethod(
            'openFileManager',
            packageName != null ? {'packageName': packageName} : null,
          ) ??
          false;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> toggleFlashlight() async {
    try {
      final res = await _channel.invokeMethod<Map<dynamic, dynamic>>('toggleFlashlight');
      if (res != null) {
        return Map<String, dynamic>.from(res);
      }
      return {'hasHardwareFlash': false, 'enabled': false};
    } catch (e) {
      return {'hasHardwareFlash': false, 'enabled': false};
    }
  }

  Future<Map<String, dynamic>> mediaControl(String action) async {
    try {
      final res = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'mediaControl',
        {'action': action},
      );
      if (res != null) {
        return Map<String, dynamic>.from(res);
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  Future<Map<String, dynamic>> setImmersiveMode(bool enable) async {
    try {
      final res = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'setImmersiveMode',
        {'enable': enable},
      );
      if (res != null) {
        return Map<String, dynamic>.from(res);
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  Future<Map<String, dynamic>> getImmersiveStatus() async {
    try {
      final res = await _channel.invokeMethod<Map<dynamic, dynamic>>('getImmersiveStatus');
      if (res != null) {
        return Map<String, dynamic>.from(res);
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  Future<Map<String, dynamic>> getMonitorStats() async {
    try {
      final Map<dynamic, dynamic>? result =
          await _channel.invokeMethod('getMonitorStats');
      if (result != null) {
        return Map<String, dynamic>.from(result);
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  Future<({bool authorized, List<CalendarEventItem> events})> getCalendarEvents() async {
    try {
      final Map<dynamic, dynamic>? res =
          await _channel.invokeMethod('getCalendarEvents');
      if (res == null) return (authorized: false, events: <CalendarEventItem>[]);
      final authorized = (res['authorized'] as bool?) ?? false;
      final rawList = (res['events'] as List<dynamic>?) ?? const [];
      final events = rawList
          .map((e) => CalendarEventItem.fromMap(e as Map<dynamic, dynamic>))
          .toList();
      return (authorized: authorized, events: events);
    } catch (_) {
      return (authorized: false, events: <CalendarEventItem>[]);
    }
  }

  Future<bool> requestCalendarPermission() async {
    try {
      return await _channel.invokeMethod('requestCalendarPermission') ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> requestLocationPermission() async {
    try {
      return await _channel.invokeMethod('requestLocationPermission') ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<({bool authorized, List<String> packages})> getUsageRecentApps() async {
    try {
      final Map<dynamic, dynamic>? res =
          await _channel.invokeMethod('getUsageRecentApps');
      if (res == null) return (authorized: false, packages: <String>[]);
      final authorized = (res['authorized'] as bool?) ?? false;
      final rawList = (res['packages'] as List<dynamic>?) ?? const [];
      final packages = rawList.map((e) => e.toString()).toList();
      return (authorized: authorized, packages: packages);
    } catch (_) {
      return (authorized: false, packages: <String>[]);
    }
  }

  Future<bool> openUsageAccessSettings() async {
    try {
      return await _channel.invokeMethod('openUsageAccessSettings') ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<({bool authorized, List<SystemNotificationItem> notifications})>
      getActiveNotifications() async {
    try {
      final Map<dynamic, dynamic>? res =
          await _channel.invokeMethod('getActiveNotifications');
      if (res == null) {
        return (authorized: false, notifications: <SystemNotificationItem>[]);
      }
      final authorized = (res['authorized'] as bool?) ?? false;
      final rawList = (res['notifications'] as List<dynamic>?) ?? const [];
      final items = rawList
          .map((e) => SystemNotificationItem.fromMap(e as Map<dynamic, dynamic>))
          .toList();
      return (authorized: authorized, notifications: items);
    } catch (_) {
      return (authorized: false, notifications: <SystemNotificationItem>[]);
    }
  }

  Future<bool> openNotificationAccessSettings() async {
    try {
      return await _channel.invokeMethod('openNotificationAccessSettings') ?? false;
    } catch (_) {
      return false;
    }
  }
}
