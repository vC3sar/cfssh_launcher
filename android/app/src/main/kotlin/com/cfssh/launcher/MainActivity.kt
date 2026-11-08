package com.cfssh.launcher

import android.Manifest
import android.app.ActivityManager
import android.app.AppOpsManager
import android.app.usage.UsageStatsManager
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.content.ContentUris
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import android.media.AudioManager
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.net.Uri
import android.net.wifi.WifiManager
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.os.Handler
import android.os.Looper
import android.os.Process
import android.os.StatFs
import android.os.SystemClock
import android.provider.CalendarContract
import android.provider.MediaStore
import android.provider.Settings
import android.view.KeyEvent
import android.view.View
import android.view.WindowInsets
import android.view.WindowInsetsController
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.net.Inet4Address
import java.net.NetworkInterface
import java.util.concurrent.Executors

class MainActivity : FlutterActivity() {
    private val CHANNEL = "CFSSH_DEVICE"
    private val executor = Executors.newSingleThreadExecutor()
    private val handler = Handler(Looper.getMainLooper())
    private var torchEnabled = false
    private var immersiveEnabled = true
    private var methodChannel: MethodChannel? = null
    private lateinit var iconPackManager: IconPackManager
    private lateinit var packageSyncManager: PackageSyncManager

    companion object {
        private const val REQ_CALENDAR = 1001
        private const val REQ_LOCATION = 1002
        private const val REQ_BT_CONNECT = 1003
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (!::iconPackManager.isInitialized) {
            iconPackManager = IconPackManager(applicationContext)
        }
        if (!::packageSyncManager.isInitialized) {
            packageSyncManager = PackageSyncManager(
                context = applicationContext,
                iconPackManager = iconPackManager,
                executor = executor,
                onPackageEvent = { payload ->
                    methodChannel?.invokeMethod("onPackageEvent", payload)
                }
            )
            packageSyncManager.register()
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            window.attributes.layoutInDisplayCutoutMode =
                WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES
        }
        applyImmersiveMode(immersiveEnabled)
    }

    override fun onDestroy() {
        if (::packageSyncManager.isInitialized) {
            packageSyncManager.unregister()
        }
        super.onDestroy()
    }

    override fun onResume() {
        super.onResume()
        if (immersiveEnabled) {
            applyImmersiveMode(true)
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus && immersiveEnabled) {
            applyImmersiveMode(true)
        }
    }

    private fun applyImmersiveMode(enable: Boolean) {
        immersiveEnabled = enable
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                window.setDecorFitsSystemWindows(!enable)
                val controller = window.insetsController
                if (controller != null) {
                    if (enable) {
                        controller.hide(WindowInsets.Type.statusBars() or WindowInsets.Type.navigationBars())
                        controller.systemBarsBehavior =
                            WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
                    } else {
                        controller.show(WindowInsets.Type.statusBars() or WindowInsets.Type.navigationBars())
                    }
                }
            } else {
                @Suppress("DEPRECATION")
                if (enable) {
                    window.decorView.systemUiVisibility = (
                        View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
                            or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                            or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                            or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                            or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                            or View.SYSTEM_UI_FLAG_FULLSCREEN
                    )
                } else {
                    window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_VISIBLE
                }
            }
        } catch (_: Exception) {
        }
    }

    private fun getImmersiveStateMap(): Map<String, Any> {
        var statusBarVisible = false
        var navBarVisible = false
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                val insets = window.decorView.rootWindowInsets
                if (insets != null) {
                    statusBarVisible = insets.isVisible(WindowInsets.Type.statusBars())
                    navBarVisible = insets.isVisible(WindowInsets.Type.navigationBars())
                }
            } else {
                @Suppress("DEPRECATION")
                val vis = window.decorView.systemUiVisibility
                statusBarVisible = (vis and View.SYSTEM_UI_FLAG_FULLSCREEN) == 0
                navBarVisible = (vis and View.SYSTEM_UI_FLAG_HIDE_NAVIGATION) == 0
            }
        } catch (_: Exception) {
        }
        val isOneUi = Build.MANUFACTURER.equals("samsung", ignoreCase = true)
        return mapOf(
            "immersiveRequested" to immersiveEnabled,
            "statusBarVisible" to statusBarVisible,
            "navBarVisible" to navBarVisible,
            "sdkInt" to Build.VERSION.SDK_INT,
            "isOneUi" to isOneUi
        )
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        if (!::iconPackManager.isInitialized) {
            iconPackManager = IconPackManager(applicationContext)
        }
        if (!::packageSyncManager.isInitialized) {
            packageSyncManager = PackageSyncManager(
                context = applicationContext,
                iconPackManager = iconPackManager,
                executor = executor,
                onPackageEvent = { payload ->
                    methodChannel?.invokeMethod("onPackageEvent", payload)
                }
            )
            packageSyncManager.register()
        }

        val ch = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        methodChannel = ch
        ch.setMethodCallHandler { call, result ->
            when (call.method) {
                "getInstalledApps" -> {
                    val forceRefresh = call.argument<Boolean>("forceRefresh") ?: false
                    executor.execute {
                        try {
                            val apps = packageSyncManager.getInstalledAppsList(forceClearCache = forceRefresh)
                            handler.post { result.success(apps) }
                        } catch (e: Exception) {
                            handler.post { result.error("ERROR", e.message, null) }
                        }
                    }
                }
                "getSingleApp" -> {
                    val packageName = call.argument<String>("packageName")
                    if (packageName != null) {
                        executor.execute {
                            try {
                                val app = packageSyncManager.querySingleLaunchableApp(packageName)
                                handler.post { result.success(app) }
                            } catch (e: Exception) {
                                handler.post { result.error("ERROR", e.message, null) }
                            }
                        }
                    } else {
                        result.error("INVALID_ARGS", "Package null", null)
                    }
                }
                "getInstalledIconPacks" -> {
                    executor.execute {
                        try {
                            val packs = iconPackManager.getInstalledIconPacks()
                            handler.post { result.success(packs) }
                        } catch (e: Exception) {
                            handler.post { result.error("ICON_PACKS_ERROR", e.message, null) }
                        }
                    }
                }
                "getSelectedIconPack" -> {
                    result.success(
                        mapOf(
                            "selectedIconPack" to iconPackManager.getSelectedIconPack(),
                            "maskUnthemed" to iconPackManager.isMaskingEnabled()
                        )
                    )
                }
                "setSelectedIconPack" -> {
                    val packPkg = call.argument<String>("packageName")
                    executor.execute {
                        try {
                            val ok = iconPackManager.setSelectedIconPack(packPkg)
                            handler.post { result.success(ok) }
                        } catch (e: Exception) {
                            handler.post { result.error("SET_PACK_ERROR", e.message, null) }
                        }
                    }
                }
                "setIconMasking" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: true
                    executor.execute {
                        try {
                            iconPackManager.setMaskingEnabled(enabled)
                            handler.post { result.success(true) }
                        } catch (e: Exception) {
                            handler.post { result.error("MASK_ERROR", e.message, null) }
                        }
                    }
                }
                "getAlternativeIcons" -> {
                    val packageName = call.argument<String>("packageName") ?: ""
                    val appLabel = call.argument<String>("appLabel") ?: ""
                    executor.execute {
                        try {
                            val list = iconPackManager.getAlternativeIconsForApp(packageName, appLabel)
                            handler.post { result.success(list) }
                        } catch (e: Exception) {
                            handler.post { result.success(emptyList<Map<String, Any>>()) }
                        }
                    }
                }
                "setCustomAppIcon" -> {
                    val packageName = call.argument<String>("packageName")
                    val drawableName = call.argument<String>("drawableName")
                    if (packageName != null) {
                        executor.execute {
                            try {
                                iconPackManager.setCustomAppIcon(packageName, drawableName)
                                val updatedApp = packageSyncManager.querySingleLaunchableApp(packageName)
                                handler.post { result.success(updatedApp) }
                            } catch (e: Exception) {
                                handler.post { result.error("CUSTOM_ICON_ERROR", e.message, null) }
                            }
                        }
                    } else {
                        result.error("INVALID_ARGS", "Package null", null)
                    }
                }
                "uninstallApp" -> {
                    val packageName = call.argument<String>("packageName")
                    if (packageName != null) {
                        try {
                            val intent = Intent(Intent.ACTION_DELETE, Uri.parse("package:$packageName")).apply {
                                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            }
                            startActivity(intent)
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("UNINSTALL_ERROR", e.message, null)
                        }
                    } else {
                        result.error("INVALID_ARGS", "Package null", null)
                    }
                }
                "launchApp" -> {
                    val packageName = call.argument<String>("packageName")
                    if (packageName != null) {
                        val launchIntent = packageManager.getLaunchIntentForPackage(packageName)
                        if (launchIntent != null) {
                            try {
                                launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                                startActivity(launchIntent)
                                result.success(true)
                            } catch (e: Exception) {
                                result.error("LAUNCH_FAILED", e.message, null)
                            }
                        } else {
                            result.error("NOT_FOUND", "App not found", null)
                        }
                    } else {
                        result.error("INVALID_ARGS", "Package null", null)
                    }
                }
                "openVpnSettings" -> {
                    try {
                        val intent = Intent("android.settings.VPN_SETTINGS")
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("VPN_ERROR", e.message, null)
                    }
                }
                "openWifiSettings" -> {
                    try {
                        val intent = Intent(Settings.ACTION_WIFI_SETTINGS)
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("WIFI_ERROR", e.message, null)
                    }
                }
                "openBluetoothSettings" -> {
                    try {
                        val intent = Intent(Settings.ACTION_BLUETOOTH_SETTINGS)
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("BT_ERROR", e.message, null)
                    }
                }
                "openDisplaySettings" -> {
                    try {
                        val intent = Intent(Settings.ACTION_DISPLAY_SETTINGS)
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("DISP_ERROR", e.message, null)
                    }
                }
                "openSystemSettings" -> {
                    try {
                        val intent = Intent(Settings.ACTION_SETTINGS)
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("SETTINGS_ERROR", e.message, null)
                    }
                }
                "openHomeSettings" -> {
                    try {
                        val intent = Intent(Settings.ACTION_HOME_SETTINGS)
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        openSystemSettingsFallback(result)
                    }
                }
                "openBrowser" -> {
                    val url = call.argument<String>("url") ?: "https://www.google.com"
                    try {
                        val parsed = if (url.startsWith("http://") || url.startsWith("https://")) {
                            url
                        } else {
                            "https://$url"
                        }
                        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(parsed))
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("BROWSER_ERROR", e.message, null)
                    }
                }
                "openCamera" -> {
                    try {
                        val intent = Intent(MediaStore.INTENT_ACTION_STILL_IMAGE_CAMERA)
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        if (intent.resolveActivity(packageManager) != null) {
                            startActivity(intent)
                            result.success(true)
                        } else {
                            val secCamera = packageManager.getLaunchIntentForPackage("com.sec.android.app.camera")
                                ?: packageManager.getLaunchIntentForPackage("com.android.camera")
                                ?: packageManager.getLaunchIntentForPackage("com.android.camera2")
                            if (secCamera != null) {
                                secCamera.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                                startActivity(secCamera)
                                result.success(true)
                            } else {
                                val fallback = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
                                fallback.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                                startActivity(fallback)
                                result.success(true)
                            }
                        }
                    } catch (e: Exception) {
                        result.error("CAMERA_ERROR", e.message, null)
                    }
                }
                "openFileManager" -> {
                    val preferredPkg = call.argument<String>("packageName")
                    try {
                        if (!preferredPkg.isNullOrBlank()) {
                            val customIntent = packageManager.getLaunchIntentForPackage(preferredPkg)
                            if (customIntent != null) {
                                customIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                                startActivity(customIntent)
                                result.success(true)
                                return@setMethodCallHandler
                            }
                        }
                        // Try Samsung My Files or Android DocumentsUI
                        val candidates = listOf(
                            "com.sec.android.app.myfiles",
                            "com.google.android.documentsui",
                            "com.android.documentsui",
                            "com.google.android.apps.nbu.files"
                        )
                        var launched = false
                        for (pkg in candidates) {
                            val launch = packageManager.getLaunchIntentForPackage(pkg)
                            if (launch != null) {
                                launch.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                                startActivity(launch)
                                launched = true
                                break
                            }
                        }
                        if (!launched) {
                            val docIntent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
                                addCategory(Intent.CATEGORY_OPENABLE)
                                type = "*/*"
                                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            }
                            startActivity(docIntent)
                        }
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("FILE_ERROR", e.message, null)
                    }
                }
                "toggleFlashlight" -> {
                    try {
                        val camManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
                        var flashCamId: String? = null
                        for (id in camManager.cameraIdList) {
                            val chars = camManager.getCameraCharacteristics(id)
                            val hasFlash = chars.get(CameraCharacteristics.FLASH_INFO_AVAILABLE) == true
                            if (hasFlash) {
                                flashCamId = id
                                break
                            }
                        }
                        if (flashCamId != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                            torchEnabled = !torchEnabled
                            camManager.setTorchMode(flashCamId, torchEnabled)
                            result.success(
                                mapOf(
                                    "hasHardwareFlash" to true,
                                    "enabled" to torchEnabled
                                )
                            )
                        } else {
                            // Galaxy Tab A7 Lite (SM-T220/T225) does not have a rear LED flash
                            result.success(
                                mapOf(
                                    "hasHardwareFlash" to false,
                                    "enabled" to false
                                )
                            )
                        }
                    } catch (e: Exception) {
                        result.success(
                            mapOf(
                                "hasHardwareFlash" to false,
                                "enabled" to false,
                                "error" to (e.message ?: "Unavailable")
                            )
                        )
                    }
                }
                "mediaControl" -> {
                    val action = call.argument<String>("action") ?: "play_pause"
                    try {
                        val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                        when (action) {
                            "play_pause" -> sendMediaButton(audioManager, KeyEvent.KEYCODE_MEDIA_PLAY_PAUSE)
                            "next" -> sendMediaButton(audioManager, KeyEvent.KEYCODE_MEDIA_NEXT)
                            "previous" -> sendMediaButton(audioManager, KeyEvent.KEYCODE_MEDIA_PREVIOUS)
                            "vol_up" -> audioManager.adjustStreamVolume(
                                AudioManager.STREAM_MUSIC,
                                AudioManager.ADJUST_RAISE,
                                AudioManager.FLAG_SHOW_UI
                            )
                            "vol_down" -> audioManager.adjustStreamVolume(
                                AudioManager.STREAM_MUSIC,
                                AudioManager.ADJUST_LOWER,
                                AudioManager.FLAG_SHOW_UI
                            )
                            "mute" -> {
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                                    audioManager.adjustStreamVolume(
                                        AudioManager.STREAM_MUSIC,
                                        AudioManager.ADJUST_TOGGLE_MUTE,
                                        AudioManager.FLAG_SHOW_UI
                                    )
                                }
                            }
                        }
                        val currentVol = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC)
                        val maxVol = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC).coerceAtLeast(1)
                        result.success(
                            mapOf(
                                "volumePercent" to ((currentVol * 100) / maxVol),
                                "isMusicActive" to audioManager.isMusicActive
                            )
                        )
                    } catch (e: Exception) {
                        result.error("MEDIA_ERROR", e.message, null)
                    }
                }
                "setImmersiveMode" -> {
                    val enable = call.argument<Boolean>("enable") ?: true
                    applyImmersiveMode(enable)
                    result.success(getImmersiveStateMap())
                }
                "getImmersiveStatus" -> {
                    result.success(getImmersiveStateMap())
                }
                "getMonitorStats" -> {
                    try {
                        val stats = getSystemStats()
                        result.success(stats)
                    } catch (e: Exception) {
                        result.error("MONITOR_ERROR", e.message, null)
                    }
                }
                "getAppIcon" -> {
                    val packageName = call.argument<String>("packageName")
                    if (packageName != null) {
                        executor.execute {
                            try {
                                val appMap = packageSyncManager.querySingleLaunchableApp(packageName)
                                val iconBytes = appMap?.get("icon") as? ByteArray
                                    ?: iconPackManager.resolveAppIcon(
                                        packageName = packageName,
                                        activityName = packageName,
                                        versionCode = 0L,
                                        lastUpdateTime = 0L,
                                        originalIconLoader = { packageManager.getApplicationIcon(packageName) }
                                    )
                                handler.post { result.success(iconBytes) }
                            } catch (e: Exception) {
                                handler.post { result.error("ICON_ERROR", e.message, null) }
                            }
                        }
                    } else {
                        result.error("INVALID_ARGS", "Package null", null)
                    }
                }
                "openAppInfo" -> {
                    val packageName = call.argument<String>("packageName")
                    if (packageName != null) {
                        try {
                            val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
                            intent.data = Uri.parse("package:$packageName")
                            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            startActivity(intent)
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("INFO_ERROR", e.message, null)
                        }
                    } else {
                        result.error("INVALID_ARGS", "Package null", null)
                    }
                }
                "getCalendarEvents" -> {
                    executor.execute {
                        try {
                            val events = queryUpcomingCalendarEvents()
                            handler.post { result.success(events) }
                        } catch (e: Exception) {
                            handler.post { result.success(mapOf("authorized" to false, "events" to emptyList<Any>())) }
                        }
                    }
                }
                "requestCalendarPermission" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        requestPermissions(arrayOf(Manifest.permission.READ_CALENDAR), REQ_CALENDAR)
                    }
                    result.success(true)
                }
                "requestLocationPermission" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        requestPermissions(
                            arrayOf(
                                Manifest.permission.ACCESS_FINE_LOCATION,
                                Manifest.permission.ACCESS_COARSE_LOCATION
                            ),
                            REQ_LOCATION
                        )
                    }
                    result.success(true)
                }
                "getUsageRecentApps" -> {
                    executor.execute {
                        try {
                            val recents = queryRecentUsageApps()
                            handler.post { result.success(recents) }
                        } catch (e: Exception) {
                            handler.post { result.success(mapOf("authorized" to false, "packages" to emptyList<String>())) }
                        }
                    }
                }
                "openUsageAccessSettings" -> {
                    try {
                        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("USAGE_ERROR", e.message, null)
                    }
                }
                "getActiveNotifications" -> {
                    try {
                        val authorized = isNotificationServiceEnabled()
                        val list = if (authorized) CyberdeckNotificationListener.getCurrentNotifications() else emptyList()
                        result.success(
                            mapOf(
                                "authorized" to authorized,
                                "notifications" to list
                            )
                        )
                    } catch (e: Exception) {
                        result.success(mapOf("authorized" to false, "notifications" to emptyList<Any>()))
                    }
                }
                "openNotificationAccessSettings" -> {
                    try {
                        val intent = Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS)
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("NOTIF_ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun openSystemSettingsFallback(result: MethodChannel.Result) {
        try {
            val intent = Intent(Settings.ACTION_SETTINGS)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
            result.success(true)
        } catch (e: Exception) {
            result.error("SETTINGS_ERROR", e.message, null)
        }
    }

    private fun sendMediaButton(audioManager: AudioManager, keyCode: Int) {
        val now = SystemClock.uptimeMillis()
        val downEvent = KeyEvent(now, now, KeyEvent.ACTION_DOWN, keyCode, 0)
        val upEvent = KeyEvent(now, now, KeyEvent.ACTION_UP, keyCode, 0)
        audioManager.dispatchMediaKeyEvent(downEvent)
        audioManager.dispatchMediaKeyEvent(upEvent)
    }

    private fun getSystemStats(): Map<String, Any> {
        val stats = mutableMapOf<String, Any>()

        // 1. RAM Memory (ActivityManager)
        val actManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val memInfo = ActivityManager.MemoryInfo()
        actManager.getMemoryInfo(memInfo)
        stats["ramTotal"] = memInfo.totalMem
        stats["ramAvailable"] = memInfo.availMem
        stats["ramLowMemory"] = memInfo.lowMemory

        // 2. Internal Storage (StatFs)
        try {
            val statFs = StatFs(Environment.getDataDirectory().path)
            val totalStorage = statFs.blockCountLong * statFs.blockSizeLong
            val availStorage = statFs.availableBlocksLong * statFs.blockSizeLong
            stats["storageTotal"] = totalStorage
            stats["storageAvailable"] = availStorage
            stats["storageUsed"] = (totalStorage - availStorage).coerceAtLeast(0L)
        } catch (_: Exception) {
            stats["storageTotal"] = 0L
            stats["storageAvailable"] = 0L
            stats["storageUsed"] = 0L
        }

        // 3. Battery Status (BatteryManager & Sticky Intent)
        val batteryStatus: Intent? = IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { ifilter ->
            context.registerReceiver(null, ifilter)
        }
        var batteryPct = -1.0f
        var isCharging = false
        var chargingSource = "BATTERY"
        var batteryTemp = 0.0f
        var batteryVoltage = 0
        var batteryHealthStr = "GOOD"

        if (batteryStatus != null) {
            val level = batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
            val scale = batteryStatus.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
            if (level >= 0 && scale > 0) {
                batteryPct = (level * 100f) / scale.toFloat()
            }
            val status = batteryStatus.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
            isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                status == BatteryManager.BATTERY_STATUS_FULL

            val chargePlug = batteryStatus.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1)
            chargingSource = when (chargePlug) {
                BatteryManager.BATTERY_PLUGGED_AC -> "AC"
                BatteryManager.BATTERY_PLUGGED_USB -> "USB"
                BatteryManager.BATTERY_PLUGGED_WIRELESS -> "WIRELESS"
                else -> if (isCharging) "CHARGING" else "DISCHARGING"
            }

            val tempTenths = batteryStatus.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, 0)
            batteryTemp = tempTenths / 10.0f
            batteryVoltage = batteryStatus.getIntExtra(BatteryManager.EXTRA_VOLTAGE, 0)

            val health = batteryStatus.getIntExtra(BatteryManager.EXTRA_HEALTH, BatteryManager.BATTERY_HEALTH_GOOD)
            batteryHealthStr = when (health) {
                BatteryManager.BATTERY_HEALTH_GOOD -> "NOMINAL"
                BatteryManager.BATTERY_HEALTH_OVERHEAT -> "OVERHEAT"
                BatteryManager.BATTERY_HEALTH_DEAD -> "CRITICAL"
                BatteryManager.BATTERY_HEALTH_OVER_VOLTAGE -> "OVERVOLT"
                else -> "NOMINAL"
            }
        }
        stats["battery"] = batteryPct
        stats["isCharging"] = isCharging
        stats["chargingSource"] = chargingSource
        stats["batteryTemp"] = batteryTemp
        stats["batteryVoltage"] = batteryVoltage
        stats["batteryHealth"] = batteryHealthStr

        // 4. Airplane Mode
        val airplaneMode = try {
            Settings.Global.getInt(contentResolver, Settings.Global.AIRPLANE_MODE_ON, 0) != 0
        } catch (_: Exception) {
            false
        }
        stats["airplaneMode"] = airplaneMode

        // 5. Connectivity & Wi-Fi
        var isConnected = false
        var connectionType = "OFFLINE"
        var vpnActive = false
        var wifiEnabled = false
        var wifiSsid = "N/A"
        var wifiRssi = -100
        var wifiSignalLevel = 0
        var wifiLinkSpeed = 0

        try {
            val cm = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val wifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
            wifiEnabled = wifiManager.isWifiEnabled

            val activeNetwork = cm.activeNetwork
            val caps = if (activeNetwork != null) cm.getNetworkCapabilities(activeNetwork) else null
            if (caps != null) {
                isConnected = caps.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
                vpnActive = caps.hasTransport(NetworkCapabilities.TRANSPORT_VPN)
                connectionType = when {
                    caps.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> "WIFI"
                    caps.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> "ETHERNET"
                    caps.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> "CELLULAR"
                    else -> if (isConnected) "ONLINE" else "OFFLINE"
                }
            }

            if (wifiEnabled) {
                @Suppress("DEPRECATION")
                val wifiInfo = wifiManager.connectionInfo
                if (wifiInfo != null && wifiInfo.networkId != -1) {
                    wifiRssi = wifiInfo.rssi
                    @Suppress("DEPRECATION")
                    wifiSignalLevel = WifiManager.calculateSignalLevel(wifiRssi, 5)
                    wifiLinkSpeed = wifiInfo.linkSpeed
                    val rawSsid = wifiInfo.ssid?.replace("\"", "") ?: ""
                    wifiSsid = if (rawSsid.isBlank() || rawSsid == "<unknown ssid>") {
                        "WLAN_ACTIVE"
                    } else {
                        rawSsid
                    }
                }
            }
        } catch (_: Exception) {
        }

        stats["isConnected"] = isConnected
        stats["connectionType"] = connectionType
        stats["vpnActive"] = vpnActive
        stats["wifiEnabled"] = wifiEnabled
        stats["wifiSsid"] = wifiSsid
        stats["wifiRssi"] = wifiRssi
        stats["wifiSignalLevel"] = wifiSignalLevel
        stats["wifiLinkSpeed"] = wifiLinkSpeed
        stats["localIp"] = getLocalIpAddress()

        // 6. Bluetooth State
        var btSupported = false
        var btEnabled = false
        var btState = "OFF"
        try {
            val btManager = getSystemService(Context.BLUETOOTH_SERVICE) as? BluetoothManager
            val adapter: BluetoothAdapter? = btManager?.adapter
            if (adapter != null) {
                btSupported = true
                btEnabled = adapter.isEnabled
                btState = when (adapter.state) {
                    BluetoothAdapter.STATE_ON -> "ON"
                    BluetoothAdapter.STATE_TURNING_ON -> "INIT"
                    BluetoothAdapter.STATE_TURNING_OFF -> "STOP"
                    else -> "OFF"
                }
            }
        } catch (_: SecurityException) {
            btSupported = true
            btState = "RESTRICTED"
        } catch (_: Exception) {
        }
        stats["bluetoothSupported"] = btSupported
        stats["bluetoothEnabled"] = btEnabled
        stats["bluetoothState"] = btState

        // 7. Audio / Media State
        try {
            val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
            val currentVol = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC)
            val maxVol = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC).coerceAtLeast(1)
            stats["volumePercent"] = (currentVol * 100) / maxVol
            stats["isMusicActive"] = audioManager.isMusicActive
        } catch (_: Exception) {
            stats["volumePercent"] = 50
            stats["isMusicActive"] = false
        }

        // 8. Hardware & OS Info
        stats["manufacturer"] = Build.MANUFACTURER.uppercase()
        stats["model"] = Build.MODEL
        stats["device"] = Build.DEVICE
        stats["androidVersion"] = Build.VERSION.RELEASE
        stats["sdkInt"] = Build.VERSION.SDK_INT
        stats["securityPatch"] = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            Build.VERSION.SECURITY_PATCH ?: "N/A"
        } else {
            "N/A"
        }
        stats["uptimeMillis"] = SystemClock.elapsedRealtime()
        stats["cpuCores"] = Runtime.getRuntime().availableProcessors()
        stats["isOneUi"] = Build.MANUFACTURER.equals("samsung", ignoreCase = true)
        stats["hasHardwareFlash"] = hasHardwareFlash()
        stats["torchEnabled"] = torchEnabled

        // 9. Immersive status
        val immersiveMap = getImmersiveStateMap()
        stats["statusBarVisible"] = immersiveMap["statusBarVisible"] ?: false
        stats["immersiveRequested"] = immersiveMap["immersiveRequested"] ?: true

        return stats
    }

    private fun hasHardwareFlash(): Boolean {
        return try {
            val camManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
            camManager.cameraIdList.any { id ->
                camManager.getCameraCharacteristics(id)
                    .get(CameraCharacteristics.FLASH_INFO_AVAILABLE) == true
            }
        } catch (_: Exception) {
            false
        }
    }

    private fun getLocalIpAddress(): String {
        try {
            val interfaces = NetworkInterface.getNetworkInterfaces() ?: return "127.0.0.1"
            for (intf in interfaces) {
                if (!intf.isUp || intf.isLoopback) continue
                for (addr in intf.inetAddresses) {
                    if (!addr.isLoopbackAddress && addr is Inet4Address) {
                        return addr.hostAddress ?: "127.0.0.1"
                    }
                }
            }
        } catch (_: Exception) {
        }
        return "0.0.0.0"
    }

    private fun queryUpcomingCalendarEvents(): Map<String, Any> {
        val hasPerm = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            checkSelfPermission(Manifest.permission.READ_CALENDAR) == PackageManager.PERMISSION_GRANTED
        } else {
            true
        }
        if (!hasPerm) {
            return mapOf("authorized" to false, "events" to emptyList<Any>())
        }

        val events = mutableListOf<Map<String, Any>>()
        try {
            val now = System.currentTimeMillis()
            val endOfWindow = now + 7L * 24L * 60L * 60L * 1000L // Next 7 days

            val builder = CalendarContract.Instances.CONTENT_URI.buildUpon()
            ContentUris.appendId(builder, now - 2L * 60L * 60L * 1000L)
            ContentUris.appendId(builder, endOfWindow)

            val projection = arrayOf(
                CalendarContract.Instances.EVENT_ID,
                CalendarContract.Instances.TITLE,
                CalendarContract.Instances.BEGIN,
                CalendarContract.Instances.END,
                CalendarContract.Instances.ALL_DAY,
                CalendarContract.Instances.EVENT_LOCATION
            )

            val cursor = contentResolver.query(
                builder.build(),
                projection,
                null,
                null,
                "${CalendarContract.Instances.BEGIN} ASC"
            )

            cursor?.use { c ->
                val titleIdx = c.getColumnIndex(CalendarContract.Instances.TITLE)
                val beginIdx = c.getColumnIndex(CalendarContract.Instances.BEGIN)
                val endIdx = c.getColumnIndex(CalendarContract.Instances.END)
                val allDayIdx = c.getColumnIndex(CalendarContract.Instances.ALL_DAY)
                val locIdx = c.getColumnIndex(CalendarContract.Instances.EVENT_LOCATION)

                while (c.moveToNext() && events.size < 12) {
                    val title = (if (titleIdx >= 0) c.getString(titleIdx) else null) ?: "EVENTO SIN TÍTULO"
                    val begin = if (beginIdx >= 0) c.getLong(beginIdx) else now
                    val end = if (endIdx >= 0) c.getLong(endIdx) else begin
                    val allDay = if (allDayIdx >= 0) c.getInt(allDayIdx) == 1 else false
                    val location = (if (locIdx >= 0) c.getString(locIdx) else null) ?: ""

                    events.add(
                        mapOf(
                            "title" to title,
                            "begin" to begin,
                            "end" to end,
                            "allDay" to allDay,
                            "location" to location
                        )
                    )
                }
            }
        } catch (_: Exception) {
        }

        return mapOf(
            "authorized" to true,
            "events" to events
        )
    }

    private fun hasUsageStatsPermission(): Boolean {
        return try {
            val appOps = getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
            val mode = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                appOps.unsafeCheckOpNoThrow(
                    AppOpsManager.OPSTR_GET_USAGE_STATS,
                    Process.myUid(),
                    packageName
                )
            } else {
                @Suppress("DEPRECATION")
                appOps.checkOpNoThrow(
                    AppOpsManager.OPSTR_GET_USAGE_STATS,
                    Process.myUid(),
                    packageName
                )
            }
            mode == AppOpsManager.MODE_ALLOWED
        } catch (_: Exception) {
            false
        }
    }

    private fun queryRecentUsageApps(): Map<String, Any> {
        if (!hasUsageStatsPermission()) {
            return mapOf("authorized" to false, "packages" to emptyList<String>())
        }
        return try {
            val usm = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
            val now = System.currentTimeMillis()
            val stats = usm.queryUsageStats(
                UsageStatsManager.INTERVAL_DAILY,
                now - 24L * 60L * 60L * 1000L,
                now
            )
            val recentPackages = stats
                ?.filter { it.lastTimeUsed > 0 && it.packageName != packageName }
                ?.sortedByDescending { it.lastTimeUsed }
                ?.map { it.packageName }
                ?.distinct()
                ?.filter { pkg -> packageManager.getLaunchIntentForPackage(pkg) != null }
                ?.take(12)
                ?: emptyList()

            mapOf(
                "authorized" to true,
                "packages" to recentPackages
            )
        } catch (_: Exception) {
            mapOf("authorized" to false, "packages" to emptyList<String>())
        }
    }

    private fun isNotificationServiceEnabled(): Boolean {
        return try {
            val enabledListeners = Settings.Secure.getString(
                contentResolver,
                "enabled_notification_listeners"
            ) ?: return false
            enabledListeners.contains(packageName)
        } catch (_: Exception) {
            false
        }
    }
}
