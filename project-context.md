This file is a merged representation of the entire codebase, combined into a single document by Repomix.
The content has been processed where empty lines have been removed, content has been compressed (code blocks are separated by ⋮---- delimiter).

# File Summary

## Purpose
This file contains a packed representation of the entire repository's contents.
It is designed to be easily consumable by AI systems for analysis, code review,
or other automated processes.

## File Format
The content is organized as follows:
1. This summary section
2. Repository information
3. Directory structure
4. Repository files (if enabled)
5. Multiple file entries, each consisting of:
  a. A header with the file path (## File: path/to/file)
  b. The full contents of the file in a code block

## Usage Guidelines
- This file should be treated as read-only. Any changes should be made to the
  original repository files, not this packed version.
- When processing this file, use the file path to distinguish
  between different files in the repository.
- Be aware that this file may contain sensitive information. Handle it with
  the same level of security as you would the original repository.

## Notes
- Some files may have been excluded based on .gitignore rules and Repomix's configuration
- Binary files are not included in this packed representation. Please refer to the Repository Structure section for a complete list of file paths, including binary files
- Files matching patterns in .gitignore are excluded
- Files matching default ignore patterns are excluded
- Empty lines have been removed from all files
- Content has been compressed - code blocks are separated by ⋮---- delimiter
- Files are sorted by Git change count (files with more changes are at the bottom)

# Directory Structure
```
android/
  app/
    src/
      debug/
        AndroidManifest.xml
      main/
        kotlin/
          com/
            cfssh/
              launcher/
                CyberdeckNotificationListener.kt
                IconCache.kt
                IconPackManager.kt
                IconPackParser.kt
                IconResolver.kt
                MainActivity.kt
                PackageSyncManager.kt
        res/
          drawable/
            launch_background.xml
          drawable-v21/
            launch_background.xml
          mipmap-hdpi/
            ic_launcher.png
          mipmap-mdpi/
            ic_launcher.png
          mipmap-xhdpi/
            ic_launcher.png
          mipmap-xxhdpi/
            ic_launcher.png
          mipmap-xxxhdpi/
            ic_launcher.png
          values/
            strings.xml
            styles.xml
          values-night/
            styles.xml
          xml/
            device_admin.xml
        AndroidManifest.xml
      profile/
        AndroidManifest.xml
    build.gradle.kts
  gradle/
    wrapper/
      gradle-wrapper.properties
  .gitignore
  build.gradle.kts
  gradle.properties
  settings.gradle.kts
assets/
  images/
    logo.png
    wallpaper.png
ios/
  Flutter/
    AppFrameworkInfo.plist
    Debug.xcconfig
    Release.xcconfig
  Runner/
    Assets.xcassets/
      AppIcon.appiconset/
        Contents.json
        Icon-App-1024x1024@1x.png
        Icon-App-20x20@1x.png
        Icon-App-20x20@2x.png
        Icon-App-20x20@3x.png
        Icon-App-29x29@1x.png
        Icon-App-29x29@2x.png
        Icon-App-29x29@3x.png
        Icon-App-40x40@1x.png
        Icon-App-40x40@2x.png
        Icon-App-40x40@3x.png
        Icon-App-60x60@2x.png
        Icon-App-60x60@3x.png
        Icon-App-76x76@1x.png
        Icon-App-76x76@2x.png
        Icon-App-83.5x83.5@2x.png
      LaunchImage.imageset/
        Contents.json
        LaunchImage.png
        LaunchImage@2x.png
        LaunchImage@3x.png
        README.md
    Base.lproj/
      LaunchScreen.storyboard
      Main.storyboard
    AppDelegate.swift
    Info.plist
    Runner-Bridging-Header.h
    SceneDelegate.swift
  Runner.xcodeproj/
    project.xcworkspace/
      xcshareddata/
        IDEWorkspaceChecks.plist
        WorkspaceSettings.xcsettings
      contents.xcworkspacedata
    xcshareddata/
      xcschemes/
        Runner.xcscheme
    project.pbxproj
  Runner.xcworkspace/
    xcshareddata/
      IDEWorkspaceChecks.plist
      WorkspaceSettings.xcsettings
    contents.xcworkspacedata
  RunnerTests/
    RunnerTests.swift
  .gitignore
lib/
  core/
    config/
      cyberdeck_config_provider.dart
    theme/
      app_theme.dart
    widgets/
      cyber_tap_target.dart
  features/
    apps/
      app_drawer_screen.dart
      apps_provider.dart
    cameras/
      models/
        rtsp_camera_model.dart
      providers/
        cameras_provider.dart
      services/
        camera_scanner_service.dart
      widgets/
        camera_modal_dialog.dart
        camera_scanner_dialog.dart
        rtsp_player_widget.dart
        rtsp_surveillance_panel.dart
      rtsp_screen.dart
    dashboard/
      widgets/
        app_grid_widget.dart
        calendar_activity_module.dart
        clock_module_widget.dart
        cyberdeck_panel.dart
        device_info_panel.dart
        quick_actions_module_widget.dart
        top_header_widget.dart
      dashboard_screen.dart
      weather_provider.dart
    health_checker/
      models/
        health_target_model.dart
      providers/
        health_checker_provider.dart
      services/
        probe_service.dart
      widgets/
        health_checker_panel.dart
        target_modal_dialog.dart
    launcher/
      launcher_screen.dart
    monitor/
      monitor_screen.dart
    network/
      ping_screen.dart
    settings/
      settings_screen.dart
    shortcuts/
      shortcut_dialog.dart
      shortcut_model.dart
      shortcuts_provider.dart
    tools/
      tools_screen.dart
    vpn/
      vpn_screen.dart
  services/
    database_service.dart
    device_service.dart
  main.dart
linux/
  flutter/
    CMakeLists.txt
    generated_plugin_registrant.cc
    generated_plugin_registrant.h
    generated_plugins.cmake
  runner/
    CMakeLists.txt
    main.cc
    my_application.cc
    my_application.h
  .gitignore
  CMakeLists.txt
macos/
  Flutter/
    Flutter-Debug.xcconfig
    Flutter-Release.xcconfig
    GeneratedPluginRegistrant.swift
  Runner/
    Assets.xcassets/
      AppIcon.appiconset/
        app_icon_1024.png
        app_icon_128.png
        app_icon_16.png
        app_icon_256.png
        app_icon_32.png
        app_icon_512.png
        app_icon_64.png
        Contents.json
    Base.lproj/
      MainMenu.xib
    Configs/
      AppInfo.xcconfig
      Debug.xcconfig
      Release.xcconfig
      Warnings.xcconfig
    AppDelegate.swift
    DebugProfile.entitlements
    Info.plist
    MainFlutterWindow.swift
    Release.entitlements
  Runner.xcodeproj/
    project.xcworkspace/
      xcshareddata/
        IDEWorkspaceChecks.plist
    xcshareddata/
      xcschemes/
        Runner.xcscheme
    project.pbxproj
  Runner.xcworkspace/
    xcshareddata/
      IDEWorkspaceChecks.plist
    contents.xcworkspacedata
  RunnerTests/
    RunnerTests.swift
  .gitignore
web/
  icons/
    Icon-192.png
    Icon-512.png
    Icon-maskable-192.png
    Icon-maskable-512.png
  favicon.png
  index.html
  manifest.json
windows/
  flutter/
    CMakeLists.txt
    generated_plugin_registrant.cc
    generated_plugin_registrant.h
    generated_plugins.cmake
  runner/
    resources/
      app_icon.ico
    CMakeLists.txt
    flutter_window.cpp
    flutter_window.h
    main.cpp
    resource.h
    runner.exe.manifest
    Runner.rc
    utils.cpp
    utils.h
    win32_window.cpp
    win32_window.h
  .gitignore
  CMakeLists.txt
.gitignore
.metadata
analysis_options.yaml
hud_tap.png
modal_test.png
prefs_new.xml
prefs.xml
pubspec.lock
pubspec.yaml
README.md
screenshot_cfg_modal.png
screenshot_console_fixed.png
screenshot_console.png
screenshot_health_checker.png
screenshot_health_final.png
screenshot_health2.png
screenshot_live_console.png
screenshot_live_console2.png
screenshot_modal_add_cam.png
screenshot_modal_add_cam2.png
screenshot_modal_cfg.png
screenshot_modal.png
screenshot_recheck_sheet.png
screenshot_rtsp_screen.png
screenshot_rtsp_screen2.png
screenshot_rtsp_tcp.png
screenshot_rtsp_tcp2.png
screenshot_rtsp_watchdog.png
screenshot_sheet_open.png
screenshot_tablet.png
screenshot_unlocked.png
set_substream.py
tap_test.png
```

# Files

## File: android/app/src/debug/AndroidManifest.xml
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- The INTERNET permission is required for development. Specifically,
         the Flutter tool needs it to communicate with the running application
         to allow setting breakpoints, to provide hot reload, etc.
    -->
    <uses-permission android:name="android.permission.INTERNET"/>
</manifest>
```

## File: android/app/src/main/kotlin/com/cfssh/launcher/CyberdeckNotificationListener.kt
```kotlin
package com.cfssh.launcher
import android.app.Notification
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
class CyberdeckNotificationListener : NotificationListenerService() {
    companion object {
        @Volatile
        var instance: CyberdeckNotificationListener? = null
            private set
        fun getCurrentNotifications(): List<Map<String, Any>> {
            val service = instance ?: return emptyList()
            return try {
                val active = service.activeNotifications ?: return emptyList()
                active
                    .filter { sbn ->
                        val extras = sbn.notification.extras
                        val title = extras.getCharSequence(Notification.EXTRA_TITLE)?.toString() ?: ""
                        val text = extras.getCharSequence(Notification.EXTRA_TEXT)?.toString() ?: ""
                        title.isNotBlank() || text.isNotBlank()
                    }
                    .sortedByDescending { it.postTime }
                    .take(12)
                    .map { sbn ->
                        val extras = sbn.notification.extras
                        val title = extras.getCharSequence(Notification.EXTRA_TITLE)?.toString() ?: sbn.packageName
                        val text = extras.getCharSequence(Notification.EXTRA_TEXT)?.toString() ?: ""
                        mapOf(
                            "key" to sbn.key,
                            "packageName" to sbn.packageName,
                            "title" to title,
                            "text" to text,
                            "postTime" to sbn.postTime,
                            "isClearable" to sbn.isClearable
                        )
                    }
            } catch (e: Exception) {
                emptyList()
            }
        }
    }
    override fun onListenerConnected() {
        super.onListenerConnected()
        instance = this
    }
    override fun onListenerDisconnected() {
        super.onListenerDisconnected()
        if (instance == this) {
            instance = null
        }
    }
    override fun onNotificationPosted(sbn: StatusBarNotification?) {
        super.onNotificationPosted(sbn)
    }
    override fun onNotificationRemoved(sbn: StatusBarNotification?) {
        super.onNotificationRemoved(sbn)
    }
}
```

## File: android/app/src/main/kotlin/com/cfssh/launcher/IconCache.kt
```kotlin
package com.cfssh.launcher
import android.content.Context
import android.util.LruCache
import java.io.File
import java.security.MessageDigest
/**
 * Two-tier (RAM LruCache + Disk) cache for resolved application icon PNG bytes.
 * Properly invalidates entries when apps are updated, uninstalled, or when the active Icon Pack changes.
 */
class IconCache(context: Context) {
    private val cacheDir = File(context.cacheDir, "icon_cache_v2").apply {
        if (!exists()) mkdirs()
    }
    // 16 MB in-memory LRU cache
    private val memoryCache = object : LruCache<String, ByteArray>(16 * 1024 * 1024) {
        override fun sizeOf(key: String, value: ByteArray): Int {
            return value.size.coerceAtLeast(1)
        }
    }
    // Tracks which cache keys belong to a given packageName for instant targeted invalidation
    private val packageKeyIndex = HashMap<String, MutableSet<String>>()
    @Synchronized
    fun buildKey(
        packageName: String,
        activityName: String,
        versionCode: Long,
        lastUpdateTime: Long,
        iconPackPackage: String?,
        maskUnthemed: Boolean,
        customDrawable: String?
    ): String {
        val packPart = iconPackPackage ?: "system"
        val customPart = customDrawable ?: "auto"
        return "${packPart}|${maskUnthemed}|${packageName}|${activityName}|${versionCode}|${lastUpdateTime}|${customPart}"
    }
    @Synchronized
    fun get(packageName: String, key: String): ByteArray? {
        memoryCache.get(key)?.let { return it }
        val diskFile = File(cacheDir, hashKey(key, packageName))
        if (diskFile.exists()) {
            return try {
                val bytes = diskFile.readBytes()
                if (bytes.isNotEmpty()) {
                    memoryCache.put(key, bytes)
                    indexKey(packageName, key)
                    bytes
                } else {
                    diskFile.delete()
                    null
                }
            } catch (_: Exception) {
                null
            }
        }
        return null
    }
    @Synchronized
    fun put(packageName: String, key: String, bytes: ByteArray) {
        if (bytes.isEmpty()) return
        memoryCache.put(key, bytes)
        indexKey(packageName, key)
        try {
            val diskFile = File(cacheDir, hashKey(key, packageName))
            diskFile.writeBytes(bytes)
        } catch (_: Exception) {
        }
    }
    @Synchronized
    fun invalidatePackage(packageName: String) {
        val keys = packageKeyIndex.remove(packageName)
        keys?.forEach { k ->
            memoryCache.remove(k)
        }
        // Also remove any matching files on disk prefixed with sanitized packageName
        val prefix = sanitizePkg(packageName) + "_"
        cacheDir.listFiles()?.forEach { file ->
            if (file.name.startsWith(prefix)) {
                try {
                    file.delete()
                } catch (_: Exception) {
                }
            }
        }
    }
    @Synchronized
    fun invalidateAll() {
        memoryCache.evictAll()
        packageKeyIndex.clear()
        cacheDir.listFiles()?.forEach { file ->
            try {
                file.delete()
            } catch (_: Exception) {
            }
        }
    }
    private fun indexKey(packageName: String, key: String) {
        val set = packageKeyIndex.getOrPut(packageName) { mutableSetOf() }
        set.add(key)
    }
    private fun sanitizePkg(packageName: String): String {
        return packageName.replace(Regex("[^a-zA-Z0-9._-]"), "_")
    }
    private fun hashKey(key: String, packageName: String): String {
        val md = MessageDigest.getInstance("MD5")
        val digest = md.digest(key.toByteArray(Charsets.UTF_8))
        val hex = digest.joinToString("") { "%02x".format(it) }
        return "${sanitizePkg(packageName)}_${hex}.png"
    }
}
```

## File: android/app/src/main/kotlin/com/cfssh/launcher/IconPackManager.kt
```kotlin
package com.cfssh.launcher
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.content.res.Resources
import android.graphics.drawable.Drawable
import org.json.JSONObject
/**
 * Manages discovery, selection, parsing, caching, and resolution of Android Icon Packs.
 * Specifically verified for `com.italiano.iwhite` (iWhite OS Icon Pack) and all ADW/Nova/Apex/Lawnchair packs.
 */
class IconPackManager(private val context: Context) {
    private val packageManager: PackageManager = context.packageManager
    private val prefs = context.getSharedPreferences("cyberdeck_icon_pack_prefs", Context.MODE_PRIVATE)
    val iconCache = IconCache(context)
    private val parser = IconPackParser(packageManager)
    private val resolver = IconResolver(packageManager)
    @Volatile
    private var selectedPackPackage: String? = prefs.getString("selected_icon_pack", null)?.takeIf { it.isNotBlank() }
    @Volatile
    private var maskUnthemedIcons: Boolean = prefs.getBoolean("mask_unthemed_icons", true)
    @Volatile
    private var activePackData: ParsedIconPackData? = null
    @Volatile
    private var activePackResources: Resources? = null
    private val customAppDrawables = HashMap<String, String>()
    companion object {
        const val IWHITE_PACKAGE = "com.italiano.iwhite"
        private val ICON_PACK_INTENT_ACTIONS = listOf(
            "org.adw.launcher.THEMES",
            "com.novalauncher.THEME",
            "com.anddoes.launcher.THEME",
            "com.teslacoilsw.launcher.THEME",
            "com.gau.go.launcherex.theme",
            "org.adw.launcher.icons.ACTION_PICK_ICON",
            "ch.deletescape.lawnchair.ICONPACK",
            "com.fede.launcher.THEME_ICONPACK",
            "com.lge.launcher2.theme",
            "ginlemon.smartlauncher.THEMES"
        )
    }
    init {
        loadCustomOverrides()
        ensureActivePackLoaded()
    }
    @Synchronized
    private fun loadCustomOverrides() {
        customAppDrawables.clear()
        val rawJson = prefs.getString("custom_app_drawables", null) ?: return
        try {
            val obj = JSONObject(rawJson)
            val keys = obj.keys()
            while (keys.hasNext()) {
                val k = keys.next()
                val v = obj.optString(k, "")
                if (v.isNotBlank()) {
                    customAppDrawables[k] = v
                }
            }
        } catch (_: Exception) {
        }
    }
    @Synchronized
    private fun saveCustomOverrides() {
        try {
            val obj = JSONObject()
            for ((k, v) in customAppDrawables) {
                obj.put(k, v)
            }
            prefs.edit().putString("custom_app_drawables", obj.toString()).apply()
        } catch (_: Exception) {
        }
    }
    @Synchronized
    fun ensureActivePackLoaded() {
        val pkg = selectedPackPackage
        if (pkg.isNullOrBlank()) {
            activePackData = null
            activePackResources = null
            return
        }
        if (!isPackageInstalled(pkg)) {
            // Selected icon pack was uninstalled; gracefully revert to original icons
            selectedPackPackage = null
            activePackData = null
            activePackResources = null
            prefs.edit().remove("selected_icon_pack").apply()
            iconCache.invalidateAll()
            return
        }
        if (activePackData?.packageName == pkg && activePackResources != null) {
            return
        }
        try {
            activePackResources = packageManager.getResourcesForApplication(pkg)
            activePackData = parser.parse(pkg)
        } catch (_: Exception) {
            activePackData = null
            activePackResources = null
        }
    }
    fun getSelectedIconPack(): String? {
        ensureActivePackLoaded()
        return selectedPackPackage
    }
    fun isMaskingEnabled(): Boolean = maskUnthemedIcons
    @Synchronized
    fun setMaskingEnabled(enabled: Boolean) {
        if (maskUnthemedIcons != enabled) {
            maskUnthemedIcons = enabled
            prefs.edit().putBoolean("mask_unthemed_icons", enabled).apply()
            iconCache.invalidateAll()
        }
    }
    @Synchronized
    fun setSelectedIconPack(iconPackPackage: String?): Boolean {
        val normalized = iconPackPackage?.trim()?.takeIf { it.isNotEmpty() }
        if (normalized != null && !isPackageInstalled(normalized)) {
            return false
        }
        if (selectedPackPackage == normalized && (normalized == null || activePackData != null)) {
            return true
        }
        selectedPackPackage = normalized
        if (normalized == null) {
            prefs.edit().remove("selected_icon_pack").apply()
            activePackData = null
            activePackResources = null
        } else {
            prefs.edit().putString("selected_icon_pack", normalized).apply()
            try {
                activePackResources = packageManager.getResourcesForApplication(normalized)
                activePackData = parser.parse(normalized)
            } catch (_: Exception) {
                activePackData = null
                activePackResources = null
                return false
            }
        }
        iconCache.invalidateAll()
        return true
    }
    @Synchronized
    fun setCustomAppIcon(packageName: String, drawableName: String?) {
        if (drawableName.isNullOrBlank()) {
            customAppDrawables.remove(packageName)
        } else {
            customAppDrawables[packageName] = drawableName.trim()
        }
        saveCustomOverrides()
        iconCache.invalidatePackage(packageName)
    }
    @Synchronized
    fun getCustomAppIcon(packageName: String): String? = customAppDrawables[packageName]
    /**
     * Discovers all installed icon packs on the device, including `com.italiano.iwhite`
     * and any package declaring standard icon pack intents or bundling an `appfilter.xml`.
     */
    fun getInstalledIconPacks(): List<Map<String, Any>> {
        val discoveredPackages = LinkedHashSet<String>()
        // 1. Query standard Icon Pack intent actions
        for (action in ICON_PACK_INTENT_ACTIONS) {
            try {
                val intent = Intent(action)
                val resolveInfos = packageManager.queryIntentActivities(intent, PackageManager.GET_META_DATA)
                for (ri in resolveInfos) {
                    val pkg = ri.activityInfo?.packageName
                    if (!pkg.isNullOrBlank() && pkg != context.packageName) {
                        discoveredPackages.add(pkg)
                    }
                }
            } catch (_: Exception) {
            }
        }
        // 2. Explicitly check iWhite OS Icon Pack (com.italiano.iwhite)
        if (isPackageInstalled(IWHITE_PACKAGE)) {
            discoveredPackages.add(IWHITE_PACKAGE)
        }
        // 3. Scan installed non-system packages for `appfilter.xml` (catches dashboard-less icon packs)
        try {
            val installedApps = packageManager.getInstalledApplications(0)
            for (appInfo in installedApps) {
                val pkg = appInfo.packageName
                if (pkg == context.packageName || discoveredPackages.contains(pkg)) continue
                val isSystemOnly = (appInfo.flags and ApplicationInfo.FLAG_SYSTEM) != 0 &&
                        (appInfo.flags and ApplicationInfo.FLAG_UPDATED_SYSTEM_APP) == 0
                if (isSystemOnly) continue
                if (hasAppFilterResource(pkg)) {
                    discoveredPackages.add(pkg)
                }
            }
        } catch (_: Exception) {
        }
        val result = mutableListOf<Map<String, Any>>()
        for (pkg in discoveredPackages) {
            try {
                val appInfo = packageManager.getApplicationInfo(pkg, 0)
                val label = packageManager.getApplicationLabel(appInfo).toString()
                val iconDrawable = packageManager.getApplicationIcon(appInfo)
                val iconBytes = resolver.bitmapToPngBytes(resolver.drawableToBitmap(iconDrawable, 96))
                val map = mutableMapOf<String, Any>(
                    "packageName" to pkg,
                    "name" to label,
                    "isSelected" to (pkg == selectedPackPackage),
                    "isIWhite" to (pkg == IWHITE_PACKAGE)
                )
                if (iconBytes != null) {
                    map["icon"] = iconBytes
                }
                result.add(map)
            } catch (_: Exception) {
            }
        }
        // Sort with iWhite first if installed, then alphabetically
        result.sortWith(
            compareByDescending<Map<String, Any>> { it["packageName"] == IWHITE_PACKAGE }
                .thenBy { (it["name"] as? String)?.lowercase() ?: "" }
        )
        return result
    }
    /**
     * Resolves an app's icon with caching, active icon pack matching, masking, and fallback.
     */
    fun resolveAppIcon(
        packageName: String,
        activityName: String,
        versionCode: Long,
        lastUpdateTime: Long,
        originalIconLoader: () -> Drawable?
    ): ByteArray? {
        ensureActivePackLoaded()
        val packData = activePackData
        val packRes = activePackResources
        val customDrawable = customAppDrawables[packageName]
        val cacheKey = iconCache.buildKey(
            packageName = packageName,
            activityName = activityName,
            versionCode = versionCode,
            lastUpdateTime = lastUpdateTime,
            iconPackPackage = packData?.packageName,
            maskUnthemed = maskUnthemedIcons,
            customDrawable = customDrawable
        )
        iconCache.get(packageName, cacheKey)?.let { return it }
        val componentName = ComponentName(packageName, activityName.ifBlank { packageName })
        val resolvedBytes = resolver.resolveAppIconBytes(
            componentName = componentName,
            originalIconLoader = originalIconLoader,
            packData = packData,
            packResources = packRes,
            maskUnthemed = maskUnthemedIcons,
            customDrawableName = customDrawable
        )
        if (resolvedBytes != null && resolvedBytes.isNotEmpty()) {
            iconCache.put(packageName, cacheKey, resolvedBytes)
        }
        return resolvedBytes
    }
    /**
     * Returns alternative icons from the active icon pack for the given package.
     */
    fun getAlternativeIconsForApp(packageName: String, appLabel: String): List<Map<String, Any>> {
        ensureActivePackLoaded()
        val packData = activePackData ?: return emptyList()
        val packRes = activePackResources ?: return emptyList()
        return resolver.getAlternativeIcons(packData, packRes, packageName, appLabel)
    }
    /**
     * Called when a package is added, updated, or removed so caches and active icon packs stay consistent.
     */
    @Synchronized
    fun onPackageChanged(packageName: String, isRemoved: Boolean): Boolean {
        iconCache.invalidatePackage(packageName)
        if (isRemoved) {
            customAppDrawables.remove(packageName)
            saveCustomOverrides()
        }
        // Check if the affected package is the active icon pack or an icon pack
        if (packageName == selectedPackPackage) {
            if (isRemoved) {
                selectedPackPackage = null
                activePackData = null
                activePackResources = null
                prefs.edit().remove("selected_icon_pack").apply()
            } else {
                // Active icon pack was updated: reload its resources and appfilter.xml
                activePackData = null
                activePackResources = null
                ensureActivePackLoaded()
            }
            iconCache.invalidateAll()
            return true
        }
        return hasAppFilterResource(packageName)
    }
    private fun hasAppFilterResource(packageName: String): Boolean {
        return try {
            val res = packageManager.getResourcesForApplication(packageName)
            val xmlId = res.getIdentifier("appfilter", "xml", packageName)
            if (xmlId != 0) return true
            val rawId = res.getIdentifier("appfilter", "raw", packageName)
            if (rawId != 0) return true
            val assetList = res.assets.list("") ?: emptyArray()
            assetList.contains("appfilter.xml")
        } catch (_: Exception) {
            false
        }
    }
    private fun isPackageInstalled(packageName: String): Boolean {
        return try {
            packageManager.getPackageInfo(packageName, 0)
            true
        } catch (_: Exception) {
            false
        }
    }
}
```

## File: android/app/src/main/kotlin/com/cfssh/launcher/IconPackParser.kt
```kotlin
package com.cfssh.launcher
import android.content.ComponentName
import android.content.pm.PackageManager
import android.content.res.Resources
import org.xmlpull.v1.XmlPullParser
import org.xmlpull.v1.XmlPullParserFactory
import java.io.InputStream
data class ParsedIconPackData(
    val packageName: String,
    val componentDrawables: Map<String, String>,
    val packageDrawables: Map<String, List<String>>,
    val calendarPrefixes: Map<String, String>,
    val iconBackList: List<String>,
    val iconMaskList: List<String>,
    val iconUponList: List<String>,
    val scaleFactor: Float,
    val allDrawables: Set<String>
)
/**
 * Parses `appfilter.xml` and `drawable.xml` from an installed Android Icon Pack
 * (supporting both compiled `res/xml/` and raw `assets/` XML formats, used by iWhite OS and ADW/Nova packs).
 */
class IconPackParser(private val packageManager: PackageManager) {
    fun parse(iconPackPackage: String): ParsedIconPackData? {
        val packResources: Resources = try {
            packageManager.getResourcesForApplication(iconPackPackage)
        } catch (e: Exception) {
            return null
        }
        val componentDrawables = HashMap<String, String>(2048)
        val packageDrawables = HashMap<String, MutableList<String>>(1024)
        val calendarPrefixes = HashMap<String, String>()
        val iconBackList = mutableListOf<String>()
        val iconMaskList = mutableListOf<String>()
        val iconUponList = mutableListOf<String>()
        val allDrawables = LinkedHashSet<String>(2048)
        var scaleFactor = 1.0f
        var hasExplicitScale = false
        fun parseAppFilterStream(parser: XmlPullParser) {
            var eventType = parser.eventType
            while (eventType != XmlPullParser.END_DOCUMENT) {
                if (eventType == XmlPullParser.START_TAG) {
                    when (parser.name.lowercase()) {
                        "item" -> {
                            val rawComp = parser.getAttributeValue(null, "component")
                            val drawable = parser.getAttributeValue(null, "drawable")
                            if (!rawComp.isNullOrBlank() && !drawable.isNullOrBlank()) {
                                val dTrim = drawable.trim()
                                allDrawables.add(dTrim)
                                val parsed = parseComponentInfo(rawComp)
                                if (parsed != null) {
                                    val (pkg, fullCls, rawSlash) = parsed
                                    componentDrawables.putIfAbsent("$pkg/$fullCls", dTrim)
                                    componentDrawables.putIfAbsent(rawSlash, dTrim)
                                    val pkgList = packageDrawables.getOrPut(pkg) { mutableListOf() }
                                    if (!pkgList.contains(dTrim)) {
                                        pkgList.add(dTrim)
                                    }
                                }
                            }
                        }
                        "calendar" -> {
                            val rawComp = parser.getAttributeValue(null, "component")
                            val prefix = parser.getAttributeValue(null, "prefix")
                            if (!rawComp.isNullOrBlank() && !prefix.isNullOrBlank()) {
                                val parsed = parseComponentInfo(rawComp)
                                if (parsed != null) {
                                    val (pkg, fullCls, rawSlash) = parsed
                                    calendarPrefixes["$pkg/$fullCls"] = prefix.trim()
                                    calendarPrefixes[rawSlash] = prefix.trim()
                                    calendarPrefixes[pkg] = prefix.trim()
                                }
                            }
                        }
                        "iconback" -> {
                            for (i in 0 until parser.attributeCount) {
                                val attrName = parser.getAttributeName(i)
                                if (attrName.startsWith("img")) {
                                    val v = parser.getAttributeValue(i)?.trim()
                                    if (!v.isNullOrEmpty()) iconBackList.add(v)
                                }
                            }
                        }
                        "iconmask" -> {
                            for (i in 0 until parser.attributeCount) {
                                val attrName = parser.getAttributeName(i)
                                if (attrName.startsWith("img")) {
                                    val v = parser.getAttributeValue(i)?.trim()
                                    if (!v.isNullOrEmpty()) iconMaskList.add(v)
                                }
                            }
                        }
                        "iconupon" -> {
                            for (i in 0 until parser.attributeCount) {
                                val attrName = parser.getAttributeName(i)
                                if (attrName.startsWith("img")) {
                                    val v = parser.getAttributeValue(i)?.trim()
                                    if (!v.isNullOrEmpty()) iconUponList.add(v)
                                }
                            }
                        }
                        "scale" -> {
                            val factorStr = parser.getAttributeValue(null, "factor")
                            val parsedScale = factorStr?.toFloatOrNull()
                            if (parsedScale != null && parsedScale in 0.1f..2.0f) {
                                scaleFactor = parsedScale
                                hasExplicitScale = true
                            }
                        }
                    }
                }
                eventType = parser.next()
            }
        }
        // 1. Try compiled res/xml/appfilter.xml first
        var parsedAny = false
        try {
            val xmlId = packResources.getIdentifier("appfilter", "xml", iconPackPackage)
            if (xmlId != 0) {
                packResources.getXml(xmlId).use { xmlParser ->
                    parseAppFilterStream(xmlParser)
                    parsedAny = true
                }
            }
        } catch (_: Exception) {
        }
        // 2. Fallback or supplement with assets/appfilter.xml
        if (!parsedAny || componentDrawables.isEmpty()) {
            try {
                val assetStream: InputStream = packResources.assets.open("appfilter.xml")
                assetStream.use { stream ->
                    val factory = XmlPullParserFactory.newInstance()
                    factory.isNamespaceAware = true
                    val parser = factory.newPullParser()
                    parser.setInput(stream, "UTF-8")
                    parseAppFilterStream(parser)
                    parsedAny = true
                }
            } catch (_: Exception) {
            }
        }
        // 3. Also check res/raw/appfilter.xml if neither res/xml nor assets had it
        if (!parsedAny || componentDrawables.isEmpty()) {
            try {
                val rawId = packResources.getIdentifier("appfilter", "raw", iconPackPackage)
                if (rawId != 0) {
                    packResources.openRawResource(rawId).use { stream ->
                        val factory = XmlPullParserFactory.newInstance()
                        val parser = factory.newPullParser()
                        parser.setInput(stream, "UTF-8")
                        parseAppFilterStream(parser)
                    }
                }
            } catch (_: Exception) {
            }
        }
        if (!hasExplicitScale && iconBackList.isNotEmpty()) {
            // Default standard scale when iconback is present without explicit <scale> tag
            scaleFactor = 0.80f
        }
        return ParsedIconPackData(
            packageName = iconPackPackage,
            componentDrawables = componentDrawables,
            packageDrawables = packageDrawables,
            calendarPrefixes = calendarPrefixes,
            iconBackList = iconBackList,
            iconMaskList = iconMaskList,
            iconUponList = iconUponList,
            scaleFactor = scaleFactor,
            allDrawables = allDrawables
        )
    }
    /**
     * Parses `ComponentInfo{com.package.name/com.package.name.MainActivity}` or
     * `ComponentInfo{com.package.name/.MainActivity}` into `(pkg, normalizedClass, rawSlash)`.
     */
    fun parseComponentInfo(raw: String): Triple<String, String, String>? {
        val trimmed = raw.trim()
        val inner = if (trimmed.startsWith("ComponentInfo{") && trimmed.endsWith("}")) {
            trimmed.substring("ComponentInfo{".length, trimmed.length - 1)
        } else {
            trimmed
        }
        val slashIndex = inner.indexOf('/')
        if (slashIndex <= 0 || slashIndex >= inner.length - 1) return null
        val pkg = inner.substring(0, slashIndex).trim()
        val cls = inner.substring(slashIndex + 1).trim()
        if (pkg.isEmpty() || cls.isEmpty()) return null
        val fullCls = if (cls.startsWith(".")) {
            "$pkg$cls"
        } else if (!cls.contains(".")) {
            "$pkg.$cls"
        } else {
            cls
        }
        return Triple(pkg, fullCls, "$pkg/$cls")
    }
    fun formatComponentKey(componentName: ComponentName): String {
        return "${componentName.packageName}/${componentName.className}"
    }
}
```

## File: android/app/src/main/kotlin/com/cfssh/launcher/IconResolver.kt
```kotlin
package com.cfssh.launcher
import android.content.ComponentName
import android.content.pm.PackageManager
import android.content.res.Resources
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Path
import android.graphics.PorterDuff
import android.graphics.PorterDuffXfermode
import android.graphics.RectF
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import androidx.core.content.res.ResourcesCompat
import java.io.ByteArrayOutputStream
import java.util.Calendar
import kotlin.math.abs
/**
 * Resolves application icons using the active Icon Pack (with full support for `appfilter.xml`,
 * ComponentName matching, drawable/mipmap loading, dynamic calendar icons, alternative icons,
 * icon masking for unthemed apps, and fallback to the original system icon).
 */
class IconResolver(private val packageManager: PackageManager) {
    companion object {
        const val TARGET_ICON_SIZE = 128
    }
    /**
     * Resolves an application's icon as PNG bytes.
     */
    fun resolveAppIconBytes(
        componentName: ComponentName,
        originalIconLoader: () -> Drawable?,
        packData: ParsedIconPackData?,
        packResources: Resources?,
        maskUnthemed: Boolean = true,
        customDrawableName: String? = null
    ): ByteArray? {
        val pkg = componentName.packageName
        val fullKey = "${componentName.packageName}/${componentName.className}"
        if (packData != null && packResources != null) {
            val packPkg = packData.packageName
            // 1. User-selected custom alternative drawable override
            if (!customDrawableName.isNullOrBlank()) {
                loadPackDrawable(packResources, packPkg, customDrawableName)?.let { d ->
                    return bitmapToPngBytes(drawableToBitmap(d, TARGET_ICON_SIZE))
                }
            }
            // 2. Dynamic Calendar icon support (<calendar prefix="..." />)
            val calPrefix = packData.calendarPrefixes[fullKey] ?: packData.calendarPrefixes[pkg]
            if (!calPrefix.isNullOrBlank()) {
                val dayOfMonth = Calendar.getInstance().get(Calendar.DAY_OF_MONTH)
                val calDrawableName = "$calPrefix$dayOfMonth"
                loadPackDrawable(packResources, packPkg, calDrawableName)?.let { d ->
                    return bitmapToPngBytes(drawableToBitmap(d, TARGET_ICON_SIZE))
                }
            }
            // 3. Exact ComponentName match in appfilter.xml
            val exactDrawableName = packData.componentDrawables[fullKey]
            if (!exactDrawableName.isNullOrBlank()) {
                loadPackDrawable(packResources, packPkg, exactDrawableName)?.let { d ->
                    return bitmapToPngBytes(drawableToBitmap(d, TARGET_ICON_SIZE))
                }
            }
            // 4. Package-level fallback match from appfilter.xml (handles updated activity names)
            val pkgDrawables = packData.packageDrawables[pkg]
            if (!pkgDrawables.isNullOrEmpty()) {
                for (candidate in pkgDrawables) {
                    loadPackDrawable(packResources, packPkg, candidate)?.let { d ->
                        return bitmapToPngBytes(drawableToBitmap(d, TARGET_ICON_SIZE))
                    }
                }
            }
            // 5. Direct resource name heuristic in drawable / mipmap
            val heuristicCandidates = buildHeuristicNames(pkg, componentName.className)
            for (candidate in heuristicCandidates) {
                loadPackDrawable(packResources, packPkg, candidate)?.let { d ->
                    return bitmapToPngBytes(drawableToBitmap(d, TARGET_ICON_SIZE))
                }
            }
            // 6. Icon Masking for unthemed apps
            val origDrawable = try {
                originalIconLoader()
            } catch (_: Exception) {
                null
            }
            if (origDrawable != null) {
                val origBitmap = drawableToBitmap(origDrawable, TARGET_ICON_SIZE)
                val finalBitmap = if (maskUnthemed) {
                    applyIconPackMasking(origBitmap, pkg, packData, packResources)
                } else {
                    origBitmap
                }
                return bitmapToPngBytes(finalBitmap)
            }
        }
        // 7. Default Fallback: Original system icon
        val origDrawable = try {
            originalIconLoader()
        } catch (_: Exception) {
            null
        } ?: return null
        return bitmapToPngBytes(drawableToBitmap(origDrawable, TARGET_ICON_SIZE))
    }
    /**
     * Loads a Drawable from an icon pack's `drawable` or `mipmap` resources.
     */
    fun loadPackDrawable(packResources: Resources, packPackage: String, resourceName: String): Drawable? {
        val cleanName = resourceName.trim()
        if (cleanName.isEmpty()) return null
        try {
            var resId = packResources.getIdentifier(cleanName, "drawable", packPackage)
            if (resId == 0) {
                resId = packResources.getIdentifier(cleanName, "mipmap", packPackage)
            }
            if (resId != 0) {
                return ResourcesCompat.getDrawable(packResources, resId, null)
            }
        } catch (_: Exception) {
        }
        return null
    }
    /**
     * Applies `<iconback>`, `<iconmask>`, `<iconupon>`, and `<scale>` from the icon pack
     * to an unthemed application icon. If the pack doesn't define explicit mask images,
     * applies a clean iOS/iWhite squircle container so all icons look visually uniform.
     */
    private fun applyIconPackMasking(
        originalBitmap: Bitmap,
        packageName: String,
        packData: ParsedIconPackData,
        packResources: Resources
    ): Bitmap {
        val size = TARGET_ICON_SIZE
        val packPkg = packData.packageName
        val backDrawable = if (packData.iconBackList.isNotEmpty()) {
            val idx = abs(packageName.hashCode()) % packData.iconBackList.size
            loadPackDrawable(packResources, packPkg, packData.iconBackList[idx])
        } else null
        val maskDrawable = if (packData.iconMaskList.isNotEmpty()) {
            val idx = abs(packageName.hashCode()) % packData.iconMaskList.size
            loadPackDrawable(packResources, packPkg, packData.iconMaskList[idx])
        } else null
        val uponDrawable = if (packData.iconUponList.isNotEmpty()) {
            val idx = abs(packageName.hashCode()) % packData.iconUponList.size
            loadPackDrawable(packResources, packPkg, packData.iconUponList[idx])
        } else null
        // If the pack provides at least one of iconback / iconmask / iconupon, composite using standard ADW/Nova pipeline
        if (backDrawable != null || maskDrawable != null || uponDrawable != null) {
            val output = Bitmap.createBitmap(size, size, Bitmap.Config.ARGB_8888)
            val canvas = Canvas(output)
            val paint = Paint(Paint.ANTI_ALIAS_FLAG or Paint.FILTER_BITMAP_FLAG)
            // Layer 1: Scaled original icon + mask on an intermediate layer
            val iconLayer = Bitmap.createBitmap(size, size, Bitmap.Config.ARGB_8888)
            val iconCanvas = Canvas(iconLayer)
            val scale = packData.scaleFactor.coerceIn(0.4f, 1.2f)
            val scaledSize = (size * scale).toInt().coerceAtLeast(1)
            val offset = (size - scaledSize) / 2f
            val scaledOrig = Bitmap.createScaledBitmap(originalBitmap, scaledSize, scaledSize, true)
            iconCanvas.drawBitmap(scaledOrig, offset, offset, paint)
            if (maskDrawable != null) {
                val maskBmp = drawableToBitmap(maskDrawable, size)
                val maskPaint = Paint(Paint.ANTI_ALIAS_FLAG or Paint.FILTER_BITMAP_FLAG).apply {
                    xfermode = PorterDuffXfermode(PorterDuff.Mode.DST_OUT)
                }
                iconCanvas.drawBitmap(maskBmp, 0f, 0f, maskPaint)
            }
            // Draw iconback first
            if (backDrawable != null) {
                val backBmp = drawableToBitmap(backDrawable, size)
                canvas.drawBitmap(backBmp, 0f, 0f, paint)
            }
            // Draw masked original icon on top of iconback
            canvas.drawBitmap(iconLayer, 0f, 0f, paint)
            // Draw iconupon overlay
            if (uponDrawable != null) {
                val uponBmp = drawableToBitmap(uponDrawable, size)
                canvas.drawBitmap(uponBmp, 0f, 0f, paint)
            }
            return output
        }
        // Fallback uniform squircle masking (ideal for iWhite OS / iOS-style icon packs)
        val output = Bitmap.createBitmap(size, size, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(output)
        val paint = Paint(Paint.ANTI_ALIAS_FLAG or Paint.FILTER_BITMAP_FLAG)
        val pad = size * 0.06f
        val rect = RectF(pad, pad, size - pad, size - pad)
        val cornerRadius = size * 0.225f
        val path = Path().apply {
            addRoundRect(rect, cornerRadius, cornerRadius, Path.Direction.CW)
        }
        // Subtle white/neutral plate behind unthemed icons for iWhite / clean packs
        val platePaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            color = if (packPkg.contains("iwhite", ignoreCase = true)) {
                Color.WHITE
            } else {
                Color.argb(255, 245, 245, 247)
            }
            style = Paint.Style.FILL
        }
        canvas.drawPath(path, platePaint)
        canvas.save()
        canvas.clipPath(path)
        val innerScale = 0.76f
        val scaledSize = (size * innerScale).toInt().coerceAtLeast(1)
        val offset = (size - scaledSize) / 2f
        val scaledOrig = Bitmap.createScaledBitmap(originalBitmap, scaledSize, scaledSize, true)
        canvas.drawBitmap(scaledOrig, offset, offset, paint)
        canvas.restore()
        return output
    }
    /**
     * Finds alternative drawables in the active icon pack for a given package/app name.
     */
    fun getAlternativeIcons(
        packData: ParsedIconPackData,
        packResources: Resources,
        packageName: String,
        appLabel: String,
        limit: Int = 24
    ): List<Map<String, Any>> {
        val results = mutableListOf<Map<String, Any>>()
        val candidates = LinkedHashSet<String>()
        // 1. All drawables explicitly mapped to this package in appfilter.xml
        packData.packageDrawables[packageName]?.let { candidates.addAll(it) }
        // 2. Search allDrawables for keywords matching appLabel or packageName segments
        val labelToken = appLabel.lowercase().replace(Regex("[^a-z0-9]"), "")
        val pkgTokens = packageName.lowercase().split('.').filter {
            it.length >= 3 && it !in setOf("com", "org", "net", "android", "app", "apps", "google", "sec")
        }
        for (drawableName in packData.allDrawables) {
            if (candidates.size >= limit) break
            val dLower = drawableName.lowercase()
            if (labelToken.length >= 3 && dLower.contains(labelToken)) {
                candidates.add(drawableName)
            } else if (pkgTokens.any { token -> dLower.contains(token) }) {
                candidates.add(drawableName)
            }
        }
        for (drawableName in candidates.take(limit)) {
            val drawable = loadPackDrawable(packResources, packData.packageName, drawableName) ?: continue
            val bytes = bitmapToPngBytes(drawableToBitmap(drawable, 96)) ?: continue
            results.add(
                mapOf(
                    "drawableName" to drawableName,
                    "icon" to bytes
                )
            )
        }
        return results
    }
    private fun buildHeuristicNames(packageName: String, className: String): List<String> {
        val list = mutableListOf<String>()
        val underscoredPkg = packageName.lowercase().replace('.', '_')
        list.add(underscoredPkg)
        val segments = packageName.lowercase().split('.')
        if (segments.isNotEmpty()) {
            val lastSeg = segments.last()
            if (lastSeg.length >= 3 && lastSeg !in setOf("app", "main", "android", "client")) {
                list.add(lastSeg)
            }
        }
        return list
    }
    fun drawableToBitmap(drawable: Drawable, targetSize: Int = TARGET_ICON_SIZE): Bitmap {
        if (drawable is BitmapDrawable && drawable.bitmap != null) {
            val src = drawable.bitmap
            return if (src.width != targetSize || src.height != targetSize) {
                Bitmap.createScaledBitmap(src, targetSize, targetSize, true)
            } else {
                src
            }
        }
        val bmp = Bitmap.createBitmap(targetSize, targetSize, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bmp)
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)
        return bmp
    }
    fun bitmapToPngBytes(bitmap: Bitmap): ByteArray? {
        return try {
            val stream = ByteArrayOutputStream()
            bitmap.compress(Bitmap.CompressFormat.PNG, 92, stream)
            stream.toByteArray()
        } catch (_: Exception) {
            null
        }
    }
}
```

## File: android/app/src/main/kotlin/com/cfssh/launcher/MainActivity.kt
```kotlin
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
```

## File: android/app/src/main/kotlin/com/cfssh/launcher/PackageSyncManager.kt
```kotlin
package com.cfssh.launcher
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.content.pm.ResolveInfo
import android.os.Build
import android.os.Handler
import android.os.Looper
import java.util.concurrent.ExecutorService
/**
 * Robust Android PackageManager Synchronization Engine.
 * Listens to all system package lifecycle broadcasts:
 * - ACTION_PACKAGE_ADDED
 * - ACTION_PACKAGE_REMOVED
 * - ACTION_PACKAGE_REPLACED
 * - ACTION_PACKAGE_CHANGED
 * - ACTION_PACKAGE_FULLY_REMOVED
 * - ACTION_PACKAGE_DATA_CLEARED
 *
 * Performs targeted cache invalidation and incremental package queries,
 * notifying Flutter in real time without rebuilding the entire UI.
 */
class PackageSyncManager(
    private val context: Context,
    private val iconPackManager: IconPackManager,
    private val executor: ExecutorService,
    private val onPackageEvent: (Map<String, Any?>) -> Unit
) {
    private val packageManager: PackageManager = context.packageManager
    private val mainHandler = Handler(Looper.getMainLooper())
    private var isRegistered = false
    private val packageReceiver = object : BroadcastReceiver() {
        override fun onReceive(ctx: Context?, intent: Intent?) {
            if (intent == null) return
            val action = intent.action ?: return
            val pkgName = intent.data?.schemeSpecificPart ?: return
            if (pkgName.isBlank() || pkgName == context.packageName) return
            val isReplacing = intent.getBooleanExtra(Intent.EXTRA_REPLACING, false)
            executor.execute {
                handlePackageBroadcast(action, pkgName, isReplacing)
            }
        }
    }
    fun register() {
        if (isRegistered) return
        val filter = IntentFilter().apply {
            addAction(Intent.ACTION_PACKAGE_ADDED)
            addAction(Intent.ACTION_PACKAGE_REMOVED)
            addAction(Intent.ACTION_PACKAGE_REPLACED)
            addAction(Intent.ACTION_PACKAGE_CHANGED)
            addAction(Intent.ACTION_PACKAGE_FULLY_REMOVED)
            addAction(Intent.ACTION_PACKAGE_DATA_CLEARED)
            addDataScheme("package")
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            context.registerReceiver(packageReceiver, filter, Context.RECEIVER_EXPORTED)
        } else {
            context.registerReceiver(packageReceiver, filter)
        }
        isRegistered = true
    }
    fun unregister() {
        if (!isRegistered) return
        try {
            context.unregisterReceiver(packageReceiver)
        } catch (_: Exception) {
        }
        isRegistered = false
    }
    private fun handlePackageBroadcast(action: String, packageName: String, isReplacing: Boolean) {
        when (action) {
            Intent.ACTION_PACKAGE_REMOVED -> {
                if (isReplacing) {
                    // Intermediate step of an app update; wait for ACTION_PACKAGE_ADDED / REPLACED
                    iconPackManager.iconCache.invalidatePackage(packageName)
                    return
                }
                // True uninstallation
                val wasIconPack = iconPackManager.onPackageChanged(packageName, isRemoved = true)
                emitEvent(
                    mapOf(
                        "type" to "removed",
                        "packageName" to packageName,
                        "isReplacing" to false,
                        "isIconPack" to wasIconPack,
                        "selectedIconPack" to iconPackManager.getSelectedIconPack()
                    )
                )
            }
            Intent.ACTION_PACKAGE_FULLY_REMOVED -> {
                val wasIconPack = iconPackManager.onPackageChanged(packageName, isRemoved = true)
                emitEvent(
                    mapOf(
                        "type" to "removed",
                        "packageName" to packageName,
                        "isReplacing" to false,
                        "isIconPack" to wasIconPack,
                        "selectedIconPack" to iconPackManager.getSelectedIconPack()
                    )
                )
            }
            Intent.ACTION_PACKAGE_ADDED -> {
                val isIconPack = iconPackManager.onPackageChanged(packageName, isRemoved = false)
                val appMap = querySingleLaunchableApp(packageName)
                val eventType = if (isReplacing) "updated" else "added"
                emitEvent(
                    mapOf(
                        "type" to eventType,
                        "packageName" to packageName,
                        "isReplacing" to isReplacing,
                        "app" to appMap,
                        "isIconPack" to isIconPack,
                        "selectedIconPack" to iconPackManager.getSelectedIconPack()
                    )
                )
            }
            Intent.ACTION_PACKAGE_REPLACED -> {
                val isIconPack = iconPackManager.onPackageChanged(packageName, isRemoved = false)
                val appMap = querySingleLaunchableApp(packageName)
                emitEvent(
                    mapOf(
                        "type" to "updated",
                        "packageName" to packageName,
                        "isReplacing" to true,
                        "app" to appMap,
                        "isIconPack" to isIconPack,
                        "selectedIconPack" to iconPackManager.getSelectedIconPack()
                    )
                )
            }
            Intent.ACTION_PACKAGE_CHANGED,
            Intent.ACTION_PACKAGE_DATA_CLEARED -> {
                val isIconPack = iconPackManager.onPackageChanged(packageName, isRemoved = false)
                val appMap = querySingleLaunchableApp(packageName)
                if (appMap != null) {
                    emitEvent(
                        mapOf(
                            "type" to "changed",
                            "packageName" to packageName,
                            "isReplacing" to false,
                            "app" to appMap,
                            "isIconPack" to isIconPack,
                            "selectedIconPack" to iconPackManager.getSelectedIconPack()
                        )
                    )
                } else {
                    // Package was disabled or no longer exposes a launchable MAIN/LAUNCHER activity
                    emitEvent(
                        mapOf(
                            "type" to "removed",
                            "packageName" to packageName,
                            "isReplacing" to false,
                            "isIconPack" to isIconPack,
                            "selectedIconPack" to iconPackManager.getSelectedIconPack()
                        )
                    )
                }
            }
        }
    }
    private fun emitEvent(payload: Map<String, Any?>) {
        mainHandler.post {
            onPackageEvent(payload)
        }
    }
    /**
     * Queries a single package to build its launchable app entry (or returns null if uninstalled,
     * disabled, or without a launchable MAIN/LAUNCHER activity).
     */
    fun querySingleLaunchableApp(packageName: String): Map<String, Any>? {
        if (packageName == context.packageName) return null
        return try {
            val pkgInfo = getPackageInfoCompat(packageName) ?: return null
            val appInfo = pkgInfo.applicationInfo ?: return null
            if (!appInfo.enabled) return null
            val intent = Intent(Intent.ACTION_MAIN, null).apply {
                addCategory(Intent.CATEGORY_LAUNCHER)
                setPackage(packageName)
            }
            val resolveList = queryIntentActivitiesCompat(intent)
            val resolveInfo = resolveList.firstOrNull { it.activityInfo?.enabled != false } ?: return null
            buildAppMap(resolveInfo, pkgInfo)
        } catch (_: Exception) {
            null
        }
    }
    /**
     * Queries all currently installed and enabled launchable applications, deduplicated by packageName.
     */
    fun getInstalledAppsList(forceClearCache: Boolean = false): List<Map<String, Any>> {
        if (forceClearCache) {
            iconPackManager.iconCache.invalidateAll()
        }
        val intent = Intent(Intent.ACTION_MAIN, null).apply {
            addCategory(Intent.CATEGORY_LAUNCHER)
        }
        val resolveInfoList = queryIntentActivitiesCompat(intent)
        val seenPackages = HashSet<String>(resolveInfoList.size)
        val apps = ArrayList<Map<String, Any>>(resolveInfoList.size)
        for (resolveInfo in resolveInfoList) {
            val activityInfo = resolveInfo.activityInfo ?: continue
            val pkgName = activityInfo.packageName ?: continue
            if (pkgName == context.packageName) continue
            if (!activityInfo.enabled || !activityInfo.applicationInfo.enabled) continue
            // Prevent duplicate entries for the same package
            if (!seenPackages.add(pkgName)) continue
            val pkgInfo = getPackageInfoCompat(pkgName) ?: continue
            val appMap = buildAppMap(resolveInfo, pkgInfo)
            apps.add(appMap)
        }
        apps.sortBy { (it["name"] as? String)?.lowercase() ?: "" }
        return apps
    }
    private fun buildAppMap(resolveInfo: ResolveInfo, pkgInfo: PackageInfo): Map<String, Any> {
        val activityInfo = resolveInfo.activityInfo
        val pkgName = activityInfo.packageName
        val activityName = activityInfo.name ?: pkgName
        val appName = resolveInfo.loadLabel(packageManager)?.toString()?.trim()
            ?.takeIf { it.isNotEmpty() }
            ?: packageManager.getApplicationLabel(activityInfo.applicationInfo).toString()
        val versionCode = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            pkgInfo.longVersionCode
        } else {
            @Suppress("DEPRECATION")
            pkgInfo.versionCode.toLong()
        }
        val lastUpdateTime = pkgInfo.lastUpdateTime
        val isSystemApp = (activityInfo.applicationInfo.flags and android.content.pm.ApplicationInfo.FLAG_SYSTEM) != 0
        val iconBytes = iconPackManager.resolveAppIcon(
            packageName = pkgName,
            activityName = activityName,
            versionCode = versionCode,
            lastUpdateTime = lastUpdateTime,
            originalIconLoader = {
                try {
                    resolveInfo.loadIcon(packageManager)
                } catch (_: Exception) {
                    packageManager.getApplicationIcon(pkgName)
                }
            }
        )
        val map = HashMap<String, Any>(8)
        map["packageName"] = pkgName
        map["activityName"] = activityName
        map["name"] = appName
        map["versionCode"] = versionCode
        map["lastUpdateTime"] = lastUpdateTime
        map["isSystemApp"] = isSystemApp
        if (iconBytes != null) {
            map["icon"] = iconBytes
        }
        return map
    }
    private fun queryIntentActivitiesCompat(intent: Intent): List<ResolveInfo> {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                packageManager.queryIntentActivities(
                    intent,
                    PackageManager.ResolveInfoFlags.of(0L)
                )
            } else {
                @Suppress("DEPRECATION")
                packageManager.queryIntentActivities(intent, 0)
            }
        } catch (_: Exception) {
            emptyList()
        }
    }
    private fun getPackageInfoCompat(packageName: String): PackageInfo? {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                packageManager.getPackageInfo(
                    packageName,
                    PackageManager.PackageInfoFlags.of(0L)
                )
            } else {
                @Suppress("DEPRECATION")
                packageManager.getPackageInfo(packageName, 0)
            }
        } catch (_: Exception) {
            null
        }
    }
}
```

## File: android/app/src/main/res/drawable/launch_background.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<!-- Modify this file to customize your launch splash screen -->
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:drawable="@android:color/white" />
    <!-- You can insert your own image assets here -->
    <!-- <item>
        <bitmap
            android:gravity="center"
            android:src="@mipmap/launch_image" />
    </item> -->
</layer-list>
```

## File: android/app/src/main/res/drawable-v21/launch_background.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<!-- Modify this file to customize your launch splash screen -->
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:drawable="?android:colorBackground" />
    <!-- You can insert your own image assets here -->
    <!-- <item>
        <bitmap
            android:gravity="center"
            android:src="@mipmap/launch_image" />
    </item> -->
</layer-list>
```

## File: android/app/src/main/res/values/strings.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">CFSSH Sysadmin Launcher</string>
    <string name="app_description">Launcher especializado para administradores de sistemas.</string>
</resources>
```

## File: android/app/src/main/res/values/styles.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources xmlns:tools="http://schemas.android.com/tools">
    <!-- Theme applied to the Android Window while the process is starting -->
    <style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar.Fullscreen">
        <item name="android:windowBackground">@drawable/launch_background</item>
        <item name="android:windowFullscreen">true</item>
        <item name="android:windowContentOverlay">@null</item>
        <item name="android:windowLayoutInDisplayCutoutMode" tools:targetApi="o_mr1">shortEdges</item>
    </style>
    <!-- Theme applied to the Android Window while Flutter UI is running -->
    <style name="NormalTheme" parent="@android:style/Theme.Black.NoTitleBar.Fullscreen">
        <item name="android:windowBackground">@android:color/black</item>
        <item name="android:windowFullscreen">true</item>
        <item name="android:windowContentOverlay">@null</item>
        <item name="android:windowLayoutInDisplayCutoutMode" tools:targetApi="o_mr1">shortEdges</item>
    </style>
</resources>
```

## File: android/app/src/main/res/values-night/styles.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources xmlns:tools="http://schemas.android.com/tools">
    <!-- Theme applied to the Android Window while the process is starting when Dark Mode is on -->
    <style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar.Fullscreen">
        <item name="android:windowBackground">@drawable/launch_background</item>
        <item name="android:windowFullscreen">true</item>
        <item name="android:windowContentOverlay">@null</item>
        <item name="android:windowLayoutInDisplayCutoutMode" tools:targetApi="o_mr1">shortEdges</item>
    </style>
    <!-- Theme applied to the Android Window while Flutter UI is running -->
    <style name="NormalTheme" parent="@android:style/Theme.Black.NoTitleBar.Fullscreen">
        <item name="android:windowBackground">@android:color/black</item>
        <item name="android:windowFullscreen">true</item>
        <item name="android:windowContentOverlay">@null</item>
        <item name="android:windowLayoutInDisplayCutoutMode" tools:targetApi="o_mr1">shortEdges</item>
    </style>
</resources>
```

## File: android/app/src/main/res/xml/device_admin.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<device-admin xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-policies>
        <limit-password />
        <watch-login />
        <reset-password />
        <force-lock />
        <wipe-data />
        <expire-password />
        <encrypted-storage />
        <disable-camera />
    </uses-policies>
</device-admin>
```

## File: android/app/src/main/AndroidManifest.xml
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">
    <!-- Core Launcher & Network Permissions -->
    <uses-permission android:name="android.permission.QUERY_ALL_PACKAGES"
        tools:ignore="QueryAllPackagesPermission" />
    <uses-permission android:name="android.permission.REQUEST_DELETE_PACKAGES" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <!-- Bluetooth status read permissions (API <=30 & API 31+) -->
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
    <!-- Optional Location for SSID on Android 10+ (only if user grants it) -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <!-- Optional Calendar read permission (only used when user authorizes Calendar Module) -->
    <uses-permission android:name="android.permission.READ_CALENDAR" />
    <!-- Optional Usage Stats for real system recent apps (only used if authorized in Settings) -->
    <uses-permission android:name="android.permission.PACKAGE_USAGE_STATS"
        tools:ignore="ProtectedPermissions" />
    <application
        android:label="CFSSH Cyberdeck"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTask"
            android:stateNotNeeded="true"
            android:clearTaskOnLaunch="true"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme" />
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.HOME" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
        <!-- Optional Notification Listener Service for Cyberdeck Activity Panel -->
        <service
            android:name=".CyberdeckNotificationListener"
            android:label="CFSSH Cyberdeck HUD Notifications"
            android:permission="android.permission.BIND_NOTIFICATION_LISTENER_SERVICE"
            android:exported="true">
            <intent-filter>
                <action android:name="android.service.notification.NotificationListenerService" />
            </intent-filter>
        </service>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
        <meta-data
            android:name="io.flutter.embedding.android.EnableImpeller"
            android:value="false" />
    </application>
    <queries>
        <package android:name="com.italiano.iwhite" />
        <intent>
            <action android:name="android.intent.action.MAIN" />
            <category android:name="android.intent.category.LAUNCHER" />
        </intent>
        <intent>
            <action android:name="org.adw.launcher.THEMES" />
        </intent>
        <intent>
            <action android:name="com.novalauncher.THEME" />
        </intent>
        <intent>
            <action android:name="com.anddoes.launcher.THEME" />
        </intent>
        <intent>
            <action android:name="com.teslacoilsw.launcher.THEME" />
        </intent>
        <intent>
            <action android:name="com.gau.go.launcherex.theme" />
        </intent>
        <intent>
            <action android:name="org.adw.launcher.icons.ACTION_PICK_ICON" />
        </intent>
        <intent>
            <action android:name="ch.deletescape.lawnchair.ICONPACK" />
        </intent>
        <intent>
            <action android:name="com.fede.launcher.THEME_ICONPACK" />
        </intent>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT" />
            <data android:mimeType="text/plain" />
        </intent>
        <intent>
            <action android:name="android.media.action.STILL_IMAGE_CAMERA" />
        </intent>
        <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="https" />
        </intent>
    </queries>
</manifest>
```

## File: android/app/src/profile/AndroidManifest.xml
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- The INTERNET permission is required for development. Specifically,
         the Flutter tool needs it to communicate with the running application
         to allow setting breakpoints, to provide hot reload, etc.
    -->
    <uses-permission android:name="android.permission.INTERNET"/>
</manifest>
```

## File: android/app/build.gradle.kts
```kotlin
plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.cfssh.launcher"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.cfssh.launcher"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

// Force RTSP RTP-over-TCP to prevent stream stalling after 1 second
tasks.register("patchRtspTcpTransport") {
    doLast {
        val pubCache = System.getenv("LOCALAPPDATA")?.let { "/Pub/Cache/hosted/pub.dev" }
        if (pubCache != null) {
            val pubDir = file(pubCache)
            if (pubDir.exists()) {
                pubDir.listFiles()?.filter { it.name.startsWith("video_player_android") }?.forEach { pluginDir ->
                    val rtspFile = file("/android/src/main/java/io/flutter/plugins/videoplayer/RtspVideoAsset.java")
                    if (rtspFile.exists()) {
                        val content = rtspFile.readText()
                        if (content.contains("new RtspMediaSource.Factory()") && !content.contains("setForceUseRtpTcp(true)")) {
                            val patched = content.replace(
                                "return new RtspMediaSource.Factory();",
                                "return new RtspMediaSource.Factory().setForceUseRtpTcp(true).setDebugLoggingEnabled(true).setTimeoutMs(10000);"
                            )
                            rtspFile.writeText(patched)
                            println("[Cyberdeck] Patched RtspVideoAsset.java for TCP transport in: ")
                        }
                    }
                }
            }
        }
    }
}

tasks.matching { it.name.startsWith("preBuild") || it.name.startsWith("compile") }.configureEach {
    dependsOn("patchRtspTcpTransport")
}
```

## File: android/gradle/wrapper/gradle-wrapper.properties
```
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-9.3.1-all.zip
```

## File: android/.gitignore
```
gradle-wrapper.jar
/.gradle
/captures/
/gradlew
/gradlew.bat
/local.properties
GeneratedPluginRegistrant.java
.cxx/

# Remember to never publicly share your keystore.
# See https://flutter.dev/to/reference-keystore
key.properties
**/*.keystore
**/*.jks
```

## File: android/build.gradle.kts
```kotlin
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
```

## File: android/gradle.properties
```
org.gradle.jvmargs=-Xmx8G -XX:MaxMetaspaceSize=4G -XX:ReservedCodeCacheSize=512m -XX:+HeapDumpOnOutOfMemoryError
android.useAndroidX=true
# This newDsl flag was added by the Flutter template
android.newDsl=false
# This builtInKotlin flag was added by the Flutter template
android.builtInKotlin=false
```

## File: android/settings.gradle.kts
```kotlin
pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.1.0" apply false
    id("org.jetbrains.kotlin.android") version "2.4.0" apply false
}

include(":app")
```

## File: ios/Flutter/AppFrameworkInfo.plist
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleDevelopmentRegion</key>
  <string>en</string>
  <key>CFBundleExecutable</key>
  <string>App</string>
  <key>CFBundleIdentifier</key>
  <string>io.flutter.flutter.app</string>
  <key>CFBundleInfoDictionaryVersion</key>
  <string>6.0</string>
  <key>CFBundleName</key>
  <string>App</string>
  <key>CFBundlePackageType</key>
  <string>FMWK</string>
  <key>CFBundleShortVersionString</key>
  <string>1.0</string>
  <key>CFBundleSignature</key>
  <string>????</string>
  <key>CFBundleVersion</key>
  <string>1.0</string>
</dict>
</plist>
```

## File: ios/Flutter/Debug.xcconfig
```
#include "Generated.xcconfig"
```

## File: ios/Flutter/Release.xcconfig
```
#include "Generated.xcconfig"
```

## File: ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json
```json
{
  "images" : [
    {
      "size" : "20x20",
      "idiom" : "iphone",
      "filename" : "Icon-App-20x20@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "20x20",
      "idiom" : "iphone",
      "filename" : "Icon-App-20x20@3x.png",
      "scale" : "3x"
    },
    {
      "size" : "29x29",
      "idiom" : "iphone",
      "filename" : "Icon-App-29x29@1x.png",
      "scale" : "1x"
    },
    {
      "size" : "29x29",
      "idiom" : "iphone",
      "filename" : "Icon-App-29x29@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "29x29",
      "idiom" : "iphone",
      "filename" : "Icon-App-29x29@3x.png",
      "scale" : "3x"
    },
    {
      "size" : "40x40",
      "idiom" : "iphone",
      "filename" : "Icon-App-40x40@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "40x40",
      "idiom" : "iphone",
      "filename" : "Icon-App-40x40@3x.png",
      "scale" : "3x"
    },
    {
      "size" : "60x60",
      "idiom" : "iphone",
      "filename" : "Icon-App-60x60@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "60x60",
      "idiom" : "iphone",
      "filename" : "Icon-App-60x60@3x.png",
      "scale" : "3x"
    },
    {
      "size" : "20x20",
      "idiom" : "ipad",
      "filename" : "Icon-App-20x20@1x.png",
      "scale" : "1x"
    },
    {
      "size" : "20x20",
      "idiom" : "ipad",
      "filename" : "Icon-App-20x20@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "29x29",
      "idiom" : "ipad",
      "filename" : "Icon-App-29x29@1x.png",
      "scale" : "1x"
    },
    {
      "size" : "29x29",
      "idiom" : "ipad",
      "filename" : "Icon-App-29x29@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "40x40",
      "idiom" : "ipad",
      "filename" : "Icon-App-40x40@1x.png",
      "scale" : "1x"
    },
    {
      "size" : "40x40",
      "idiom" : "ipad",
      "filename" : "Icon-App-40x40@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "76x76",
      "idiom" : "ipad",
      "filename" : "Icon-App-76x76@1x.png",
      "scale" : "1x"
    },
    {
      "size" : "76x76",
      "idiom" : "ipad",
      "filename" : "Icon-App-76x76@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "83.5x83.5",
      "idiom" : "ipad",
      "filename" : "Icon-App-83.5x83.5@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "1024x1024",
      "idiom" : "ios-marketing",
      "filename" : "Icon-App-1024x1024@1x.png",
      "scale" : "1x"
    }
  ],
  "info" : {
    "version" : 1,
    "author" : "xcode"
  }
}
```

## File: ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json
```json
{
  "images" : [
    {
      "idiom" : "universal",
      "filename" : "LaunchImage.png",
      "scale" : "1x"
    },
    {
      "idiom" : "universal",
      "filename" : "LaunchImage@2x.png",
      "scale" : "2x"
    },
    {
      "idiom" : "universal",
      "filename" : "LaunchImage@3x.png",
      "scale" : "3x"
    }
  ],
  "info" : {
    "version" : 1,
    "author" : "xcode"
  }
}
```

## File: ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
```markdown
# Launch Screen Assets

You can customize the launch screen with your own desired assets by replacing the image files in this directory.

You can also do it by opening your Flutter project's Xcode project with `open ios/Runner.xcworkspace`, selecting `Runner/Assets.xcassets` in the Project Navigator and dropping in the desired images.
```

## File: ios/Runner/Base.lproj/LaunchScreen.storyboard
```
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="12121" systemVersion="16G29" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" launchScreen="YES" colorMatched="YES" initialViewController="01J-lp-oVM">
    <dependencies>
        <deployment identifier="iOS"/>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="12089"/>
    </dependencies>
    <scenes>
        <!--View Controller-->
        <scene sceneID="EHf-IW-A2E">
            <objects>
                <viewController id="01J-lp-oVM" sceneMemberID="viewController">
                    <layoutGuides>
                        <viewControllerLayoutGuide type="top" id="Ydg-fD-yQy"/>
                        <viewControllerLayoutGuide type="bottom" id="xbc-2k-c8Z"/>
                    </layoutGuides>
                    <view key="view" contentMode="scaleToFill" id="Ze5-6b-2t3">
                        <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                        <subviews>
                            <imageView opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" image="LaunchImage" translatesAutoresizingMaskIntoConstraints="NO" id="YRO-k0-Ey4">
                            </imageView>
                        </subviews>
                        <color key="backgroundColor" red="1" green="1" blue="1" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
                        <constraints>
                            <constraint firstItem="YRO-k0-Ey4" firstAttribute="centerX" secondItem="Ze5-6b-2t3" secondAttribute="centerX" id="1a2-6s-vTC"/>
                            <constraint firstItem="YRO-k0-Ey4" firstAttribute="centerY" secondItem="Ze5-6b-2t3" secondAttribute="centerY" id="4X2-HB-R7a"/>
                        </constraints>
                    </view>
                </viewController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="iYj-Kq-Ea1" userLabel="First Responder" sceneMemberID="firstResponder"/>
            </objects>
            <point key="canvasLocation" x="53" y="375"/>
        </scene>
    </scenes>
    <resources>
        <image name="LaunchImage" width="168" height="185"/>
    </resources>
</document>
```

## File: ios/Runner/Base.lproj/Main.storyboard
```
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="10117" systemVersion="15F34" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" initialViewController="BYZ-38-t0r">
    <dependencies>
        <deployment identifier="iOS"/>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="10085"/>
    </dependencies>
    <scenes>
        <!--Flutter View Controller-->
        <scene sceneID="tne-QT-ifu">
            <objects>
                <viewController id="BYZ-38-t0r" customClass="FlutterViewController" sceneMemberID="viewController">
                    <layoutGuides>
                        <viewControllerLayoutGuide type="top" id="y3c-jy-aDJ"/>
                        <viewControllerLayoutGuide type="bottom" id="wfy-db-euE"/>
                    </layoutGuides>
                    <view key="view" contentMode="scaleToFill" id="8bC-Xf-vdC">
                        <rect key="frame" x="0.0" y="0.0" width="600" height="600"/>
                        <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                        <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
                    </view>
                </viewController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="dkx-z0-nzr" sceneMemberID="firstResponder"/>
            </objects>
        </scene>
    </scenes>
</document>
```

## File: ios/Runner/AppDelegate.swift
```swift
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
override func application(
⋮----
func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
```

## File: ios/Runner/Info.plist
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CADisableMinimumFrameDurationOnPhone</key>
	<true/>
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleDisplayName</key>
	<string>Launcher</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>launcher</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>$(FLUTTER_BUILD_NAME)</string>
	<key>CFBundleSignature</key>
	<string>????</string>
	<key>CFBundleVersion</key>
	<string>$(FLUTTER_BUILD_NUMBER)</string>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UIApplicationSceneManifest</key>
	<dict>
		<key>UIApplicationSupportsMultipleScenes</key>
		<false/>
		<key>UISceneConfigurations</key>
		<dict>
			<key>UIWindowSceneSessionRoleApplication</key>
			<array>
				<dict>
					<key>UISceneClassName</key>
					<string>UIWindowScene</string>
					<key>UISceneConfigurationName</key>
					<string>flutter</string>
					<key>UISceneDelegateClassName</key>
					<string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
					<key>UISceneStoryboardFile</key>
					<string>Main</string>
				</dict>
			</array>
		</dict>
	</dict>
	<key>UIApplicationSupportsIndirectInputEvents</key>
	<true/>
	<key>UILaunchStoryboardName</key>
	<string>LaunchScreen</string>
	<key>UIMainStoryboardFile</key>
	<string>Main</string>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
</dict>
</plist>
```

## File: ios/Runner/Runner-Bridging-Header.h
```c

```

## File: ios/Runner/SceneDelegate.swift
```swift
class SceneDelegate: FlutterSceneDelegate {
```

## File: ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>IDEDidComputeMac32BitWarning</key>
	<true/>
</dict>
</plist>
```

## File: ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>PreviewsEnabled</key>
	<false/>
</dict>
</plist>
```

## File: ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata
```
<?xml version="1.0" encoding="UTF-8"?>
<Workspace
   version = "1.0">
   <FileRef
      location = "self:">
   </FileRef>
</Workspace>
```

## File: ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme
```
<?xml version="1.0" encoding="UTF-8"?>
<Scheme
   LastUpgradeVersion = "1510"
   version = "1.3">
   <BuildAction
      parallelizeBuildables = "YES"
      buildImplicitDependencies = "YES">
      <PreActions>
         <ExecutionAction
            ActionType = "Xcode.IDEStandardExecutionActionsCore.ExecutionActionType.ShellScriptAction">
            <ActionContent
               title = "Run Prepare Flutter Framework Script"
               scriptText = "/bin/sh &quot;$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh&quot; prepare&#10;">
               <EnvironmentBuildable>
                  <BuildableReference
                     BuildableIdentifier = "primary"
                     BlueprintIdentifier = "97C146ED1CF9000F007C117D"
                     BuildableName = "Runner.app"
                     BlueprintName = "Runner"
                     ReferencedContainer = "container:Runner.xcodeproj">
                  </BuildableReference>
               </EnvironmentBuildable>
            </ActionContent>
         </ExecutionAction>
      </PreActions>
      <BuildActionEntries>
         <BuildActionEntry
            buildForTesting = "YES"
            buildForRunning = "YES"
            buildForProfiling = "YES"
            buildForArchiving = "YES"
            buildForAnalyzing = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "97C146ED1CF9000F007C117D"
               BuildableName = "Runner.app"
               BlueprintName = "Runner"
               ReferencedContainer = "container:Runner.xcodeproj">
            </BuildableReference>
         </BuildActionEntry>
      </BuildActionEntries>
   </BuildAction>
   <TestAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      customLLDBInitFile = "$(SRCROOT)/Flutter/ephemeral/flutter_lldbinit"
      shouldUseLaunchSchemeArgsEnv = "YES">
      <MacroExpansion>
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "97C146ED1CF9000F007C117D"
            BuildableName = "Runner.app"
            BlueprintName = "Runner"
            ReferencedContainer = "container:Runner.xcodeproj">
         </BuildableReference>
      </MacroExpansion>
      <Testables>
         <TestableReference
            skipped = "NO"
            parallelizable = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "331C8080294A63A400263BE5"
               BuildableName = "RunnerTests.xctest"
               BlueprintName = "RunnerTests"
               ReferencedContainer = "container:Runner.xcodeproj">
            </BuildableReference>
         </TestableReference>
      </Testables>
   </TestAction>
   <LaunchAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      customLLDBInitFile = "$(SRCROOT)/Flutter/ephemeral/flutter_lldbinit"
      launchStyle = "0"
      useCustomWorkingDirectory = "NO"
      ignoresPersistentStateOnLaunch = "NO"
      debugDocumentVersioning = "YES"
      debugServiceExtension = "internal"
      enableGPUValidationMode = "1"
      allowLocationSimulation = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "97C146ED1CF9000F007C117D"
            BuildableName = "Runner.app"
            BlueprintName = "Runner"
            ReferencedContainer = "container:Runner.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </LaunchAction>
   <ProfileAction
      buildConfiguration = "Profile"
      shouldUseLaunchSchemeArgsEnv = "YES"
      savedToolIdentifier = ""
      useCustomWorkingDirectory = "NO"
      debugDocumentVersioning = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "97C146ED1CF9000F007C117D"
            BuildableName = "Runner.app"
            BlueprintName = "Runner"
            ReferencedContainer = "container:Runner.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </ProfileAction>
   <AnalyzeAction
      buildConfiguration = "Debug">
   </AnalyzeAction>
   <ArchiveAction
      buildConfiguration = "Release"
      revealArchiveInOrganizer = "YES">
   </ArchiveAction>
</Scheme>
```

## File: ios/Runner.xcodeproj/project.pbxproj
```
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 54;
	objects = {

/* Begin PBXBuildFile section */
		1498D2341E8E89220040F4C2 /* GeneratedPluginRegistrant.m in Sources */ = {isa = PBXBuildFile; fileRef = 1498D2331E8E89220040F4C2 /* GeneratedPluginRegistrant.m */; };
		331C808B294A63AB00263BE5 /* RunnerTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 331C807B294A618700263BE5 /* RunnerTests.swift */; };
		3B3967161E833CAA004F5970 /* AppFrameworkInfo.plist in Resources */ = {isa = PBXBuildFile; fileRef = 3B3967151E833CAA004F5970 /* AppFrameworkInfo.plist */; };
		74858FAF1ED2DC5600515810 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 74858FAE1ED2DC5600515810 /* AppDelegate.swift */; };
		7884E8682EC3CC0700C636F2 /* SceneDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 7884E8672EC3CC0400C636F2 /* SceneDelegate.swift */; };
		78A318202AECB46A00862997 /* FlutterGeneratedPluginSwiftPackage in Frameworks */ = {isa = PBXBuildFile; productRef = 78A3181F2AECB46A00862997 /* FlutterGeneratedPluginSwiftPackage */; };
		97C146FC1CF9000F007C117D /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 97C146FA1CF9000F007C117D /* Main.storyboard */; };
		97C146FE1CF9000F007C117D /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 97C146FD1CF9000F007C117D /* Assets.xcassets */; };
		97C147011CF9000F007C117D /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 97C146FF1CF9000F007C117D /* LaunchScreen.storyboard */; };
/* End PBXBuildFile section */

/* Begin PBXContainerItemProxy section */
		331C8085294A63A400263BE5 /* PBXContainerItemProxy */ = {
			isa = PBXContainerItemProxy;
			containerPortal = 97C146E61CF9000F007C117D /* Project object */;
			proxyType = 1;
			remoteGlobalIDString = 97C146ED1CF9000F007C117D;
			remoteInfo = Runner;
		};
/* End PBXContainerItemProxy section */

/* Begin PBXCopyFilesBuildPhase section */
		9705A1C41CF9048500538489 /* Embed Frameworks */ = {
			isa = PBXCopyFilesBuildPhase;
			buildActionMask = 2147483647;
			dstPath = "";
			dstSubfolderSpec = 10;
			files = (
			);
			name = "Embed Frameworks";
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXCopyFilesBuildPhase section */

/* Begin PBXFileReference section */
		1498D2321E8E86230040F4C2 /* GeneratedPluginRegistrant.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = GeneratedPluginRegistrant.h; sourceTree = "<group>"; };
		1498D2331E8E89220040F4C2 /* GeneratedPluginRegistrant.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; path = GeneratedPluginRegistrant.m; sourceTree = "<group>"; };
		331C807B294A618700263BE5 /* RunnerTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = RunnerTests.swift; sourceTree = "<group>"; };
		331C8081294A63A400263BE5 /* RunnerTests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = RunnerTests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
		3B3967151E833CAA004F5970 /* AppFrameworkInfo.plist */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = text.plist.xml; name = AppFrameworkInfo.plist; path = Flutter/AppFrameworkInfo.plist; sourceTree = "<group>"; };
		74858FAD1ED2DC5600515810 /* Runner-Bridging-Header.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = "Runner-Bridging-Header.h"; sourceTree = "<group>"; };
		74858FAE1ED2DC5600515810 /* AppDelegate.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "<group>"; };
		7884E8672EC3CC0400C636F2 /* SceneDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SceneDelegate.swift; sourceTree = "<group>"; };
		78E0A7A72DC9AD7400C4905E /* FlutterGeneratedPluginSwiftPackage */ = {isa = PBXFileReference; lastKnownFileType = wrapper; name = FlutterGeneratedPluginSwiftPackage; path = Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage; sourceTree = "<group>"; };
		7AFA3C8E1D35360C0083082E /* Release.xcconfig */ = {isa = PBXFileReference; lastKnownFileType = text.xcconfig; name = Release.xcconfig; path = Flutter/Release.xcconfig; sourceTree = "<group>"; };
		9740EEB21CF90195004384FC /* Debug.xcconfig */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = text.xcconfig; name = Debug.xcconfig; path = Flutter/Debug.xcconfig; sourceTree = "<group>"; };
		9740EEB31CF90195004384FC /* Generated.xcconfig */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = text.xcconfig; name = Generated.xcconfig; path = Flutter/Generated.xcconfig; sourceTree = "<group>"; };
		97C146EE1CF9000F007C117D /* Runner.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = Runner.app; sourceTree = BUILT_PRODUCTS_DIR; };
		97C146FB1CF9000F007C117D /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "<group>"; };
		97C146FD1CF9000F007C117D /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
		97C147001CF9000F007C117D /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "<group>"; };
		97C147021CF9000F007C117D /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		97C146EB1CF9000F007C117D /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
				78A318202AECB46A00862997 /* FlutterGeneratedPluginSwiftPackage in Frameworks */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		331C8082294A63A400263BE5 /* RunnerTests */ = {
			isa = PBXGroup;
			children = (
				331C807B294A618700263BE5 /* RunnerTests.swift */,
			);
			path = RunnerTests;
			sourceTree = "<group>";
		};
		9740EEB11CF90186004384FC /* Flutter */ = {
			isa = PBXGroup;
			children = (
				78E0A7A72DC9AD7400C4905E /* FlutterGeneratedPluginSwiftPackage */,
				3B3967151E833CAA004F5970 /* AppFrameworkInfo.plist */,
				9740EEB21CF90195004384FC /* Debug.xcconfig */,
				7AFA3C8E1D35360C0083082E /* Release.xcconfig */,
				9740EEB31CF90195004384FC /* Generated.xcconfig */,
			);
			name = Flutter;
			sourceTree = "<group>";
		};
		97C146E51CF9000F007C117D = {
			isa = PBXGroup;
			children = (
				9740EEB11CF90186004384FC /* Flutter */,
				97C146F01CF9000F007C117D /* Runner */,
				97C146EF1CF9000F007C117D /* Products */,
				331C8082294A63A400263BE5 /* RunnerTests */,
			);
			sourceTree = "<group>";
		};
		97C146EF1CF9000F007C117D /* Products */ = {
			isa = PBXGroup;
			children = (
				97C146EE1CF9000F007C117D /* Runner.app */,
				331C8081294A63A400263BE5 /* RunnerTests.xctest */,
			);
			name = Products;
			sourceTree = "<group>";
		};
		97C146F01CF9000F007C117D /* Runner */ = {
			isa = PBXGroup;
			children = (
				97C146FA1CF9000F007C117D /* Main.storyboard */,
				97C146FD1CF9000F007C117D /* Assets.xcassets */,
				97C146FF1CF9000F007C117D /* LaunchScreen.storyboard */,
				97C147021CF9000F007C117D /* Info.plist */,
				1498D2321E8E86230040F4C2 /* GeneratedPluginRegistrant.h */,
				1498D2331E8E89220040F4C2 /* GeneratedPluginRegistrant.m */,
				74858FAE1ED2DC5600515810 /* AppDelegate.swift */,
				7884E8672EC3CC0400C636F2 /* SceneDelegate.swift */,
				74858FAD1ED2DC5600515810 /* Runner-Bridging-Header.h */,
			);
			path = Runner;
			sourceTree = "<group>";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		331C8080294A63A400263BE5 /* RunnerTests */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 331C8087294A63A400263BE5 /* Build configuration list for PBXNativeTarget "RunnerTests" */;
			buildPhases = (
				331C807D294A63A400263BE5 /* Sources */,
				331C807F294A63A400263BE5 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
				331C8086294A63A400263BE5 /* PBXTargetDependency */,
			);
			name = RunnerTests;
			productName = RunnerTests;
			productReference = 331C8081294A63A400263BE5 /* RunnerTests.xctest */;
			productType = "com.apple.product-type.bundle.unit-test";
		};
		97C146ED1CF9000F007C117D /* Runner */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 97C147051CF9000F007C117D /* Build configuration list for PBXNativeTarget "Runner" */;
			buildPhases = (
				9740EEB61CF901F6004384FC /* Run Script */,
				97C146EA1CF9000F007C117D /* Sources */,
				97C146EB1CF9000F007C117D /* Frameworks */,
				97C146EC1CF9000F007C117D /* Resources */,
				9705A1C41CF9048500538489 /* Embed Frameworks */,
				3B06AD1E1E4923F5004D2608 /* Thin Binary */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = Runner;
			packageProductDependencies = (
				78A3181F2AECB46A00862997 /* FlutterGeneratedPluginSwiftPackage */,
			);
			productName = Runner;
			productReference = 97C146EE1CF9000F007C117D /* Runner.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		97C146E61CF9000F007C117D /* Project object */ = {
			isa = PBXProject;
			attributes = {
				BuildIndependentTargetsInParallel = YES;
				LastUpgradeCheck = 1510;
				ORGANIZATIONNAME = "";
				TargetAttributes = {
					331C8080294A63A400263BE5 = {
						CreatedOnToolsVersion = 14.0;
						TestTargetID = 97C146ED1CF9000F007C117D;
					};
					97C146ED1CF9000F007C117D = {
						CreatedOnToolsVersion = 7.3.1;
						LastSwiftMigration = 1100;
					};
				};
			};
			buildConfigurationList = 97C146E91CF9000F007C117D /* Build configuration list for PBXProject "Runner" */;
			compatibilityVersion = "Xcode 9.3";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = 97C146E51CF9000F007C117D;
			packageReferences = (
				781AD8BC2B33823900A9FFBB /* XCLocalSwiftPackageReference "Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage" */,
			);
			productRefGroup = 97C146EF1CF9000F007C117D /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				97C146ED1CF9000F007C117D /* Runner */,
				331C8080294A63A400263BE5 /* RunnerTests */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		331C807F294A63A400263BE5 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		97C146EC1CF9000F007C117D /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				97C147011CF9000F007C117D /* LaunchScreen.storyboard in Resources */,
				3B3967161E833CAA004F5970 /* AppFrameworkInfo.plist in Resources */,
				97C146FE1CF9000F007C117D /* Assets.xcassets in Resources */,
				97C146FC1CF9000F007C117D /* Main.storyboard in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXShellScriptBuildPhase section */
		3B06AD1E1E4923F5004D2608 /* Thin Binary */ = {
			isa = PBXShellScriptBuildPhase;
			alwaysOutOfDate = 1;
			buildActionMask = 2147483647;
			files = (
			);
			inputPaths = (
				"${TARGET_BUILD_DIR}/${INFOPLIST_PATH}",
			);
			name = "Thin Binary";
			outputPaths = (
			);
			runOnlyForDeploymentPostprocessing = 0;
			shellPath = /bin/sh;
			shellScript = "/bin/sh \"$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh\" embed_and_thin";
		};
		9740EEB61CF901F6004384FC /* Run Script */ = {
			isa = PBXShellScriptBuildPhase;
			alwaysOutOfDate = 1;
			buildActionMask = 2147483647;
			files = (
			);
			inputPaths = (
			);
			name = "Run Script";
			outputPaths = (
			);
			runOnlyForDeploymentPostprocessing = 0;
			shellPath = /bin/sh;
			shellScript = "/bin/sh \"$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh\" build";
		};
/* End PBXShellScriptBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		331C807D294A63A400263BE5 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				331C808B294A63AB00263BE5 /* RunnerTests.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		97C146EA1CF9000F007C117D /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				74858FAF1ED2DC5600515810 /* AppDelegate.swift in Sources */,
				1498D2341E8E89220040F4C2 /* GeneratedPluginRegistrant.m in Sources */,
				7884E8682EC3CC0700C636F2 /* SceneDelegate.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXTargetDependency section */
		331C8086294A63A400263BE5 /* PBXTargetDependency */ = {
			isa = PBXTargetDependency;
			target = 97C146ED1CF9000F007C117D /* Runner */;
			targetProxy = 331C8085294A63A400263BE5 /* PBXContainerItemProxy */;
		};
/* End PBXTargetDependency section */

/* Begin PBXVariantGroup section */
		97C146FA1CF9000F007C117D /* Main.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				97C146FB1CF9000F007C117D /* Base */,
			);
			name = Main.storyboard;
			sourceTree = "<group>";
		};
		97C146FF1CF9000F007C117D /* LaunchScreen.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				97C147001CF9000F007C117D /* Base */,
			);
			name = LaunchScreen.storyboard;
			sourceTree = "<group>";
		};
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
		249021D3217E4FDB00AE95B9 /* Profile */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++0x";
				CLANG_CXX_LIBRARY = "libc++";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = NO;
				GCC_C_LANGUAGE_STANDARD = gnu99;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 15.0;
				MTL_ENABLE_DEBUG_INFO = NO;
				SDKROOT = iphoneos;
				STRING_CATALOG_GENERATE_SYMBOLS = YES;
				SUPPORTED_PLATFORMS = iphoneos;
				TARGETED_DEVICE_FAMILY = "1,2";
				VALIDATE_PRODUCT = YES;
			};
			name = Profile;
		};
		249021D4217E4FDB00AE95B9 /* Profile */ = {
			isa = XCBuildConfiguration;
			baseConfigurationReference = 7AFA3C8E1D35360C0083082E /* Release.xcconfig */;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CLANG_ENABLE_MODULES = YES;
				CURRENT_PROJECT_VERSION = "$(FLUTTER_BUILD_NUMBER)";
				ENABLE_BITCODE = NO;
				INFOPLIST_FILE = Runner/Info.plist;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				PRODUCT_BUNDLE_IDENTIFIER = com.cfssh.launcher;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_OBJC_BRIDGING_HEADER = "Runner/Runner-Bridging-Header.h";
				SWIFT_VERSION = 5.0;
				VERSIONING_SYSTEM = "apple-generic";
			};
			name = Profile;
		};
		331C8088294A63A400263BE5 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				BUNDLE_LOADER = "$(TEST_HOST)";
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				GENERATE_INFOPLIST_FILE = YES;
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.cfssh.launcher.RunnerTests;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
				SWIFT_VERSION = 5.0;
				TEST_HOST = "$(BUILT_PRODUCTS_DIR)/Runner.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/Runner";
			};
			name = Debug;
		};
		331C8089294A63A400263BE5 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				BUNDLE_LOADER = "$(TEST_HOST)";
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				GENERATE_INFOPLIST_FILE = YES;
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.cfssh.launcher.RunnerTests;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_VERSION = 5.0;
				TEST_HOST = "$(BUILT_PRODUCTS_DIR)/Runner.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/Runner";
			};
			name = Release;
		};
		331C808A294A63A400263BE5 /* Profile */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				BUNDLE_LOADER = "$(TEST_HOST)";
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				GENERATE_INFOPLIST_FILE = YES;
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.cfssh.launcher.RunnerTests;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_VERSION = 5.0;
				TEST_HOST = "$(BUILT_PRODUCTS_DIR)/Runner.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/Runner";
			};
			name = Profile;
		};
		97C147031CF9000F007C117D /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++0x";
				CLANG_CXX_LIBRARY = "libc++";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = NO;
				GCC_C_LANGUAGE_STANDARD = gnu99;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 15.0;
				MTL_ENABLE_DEBUG_INFO = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				STRING_CATALOG_GENERATE_SYMBOLS = YES;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		97C147041CF9000F007C117D /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++0x";
				CLANG_CXX_LIBRARY = "libc++";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = NO;
				GCC_C_LANGUAGE_STANDARD = gnu99;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 15.0;
				MTL_ENABLE_DEBUG_INFO = NO;
				SDKROOT = iphoneos;
				STRING_CATALOG_GENERATE_SYMBOLS = YES;
				SUPPORTED_PLATFORMS = iphoneos;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_OPTIMIZATION_LEVEL = "-O";
				TARGETED_DEVICE_FAMILY = "1,2";
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		97C147061CF9000F007C117D /* Debug */ = {
			isa = XCBuildConfiguration;
			baseConfigurationReference = 9740EEB21CF90195004384FC /* Debug.xcconfig */;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CLANG_ENABLE_MODULES = YES;
				CURRENT_PROJECT_VERSION = "$(FLUTTER_BUILD_NUMBER)";
				ENABLE_BITCODE = NO;
				INFOPLIST_FILE = Runner/Info.plist;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				PRODUCT_BUNDLE_IDENTIFIER = com.cfssh.launcher;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_OBJC_BRIDGING_HEADER = "Runner/Runner-Bridging-Header.h";
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
				SWIFT_VERSION = 5.0;
				VERSIONING_SYSTEM = "apple-generic";
			};
			name = Debug;
		};
		97C147071CF9000F007C117D /* Release */ = {
			isa = XCBuildConfiguration;
			baseConfigurationReference = 7AFA3C8E1D35360C0083082E /* Release.xcconfig */;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CLANG_ENABLE_MODULES = YES;
				CURRENT_PROJECT_VERSION = "$(FLUTTER_BUILD_NUMBER)";
				ENABLE_BITCODE = NO;
				INFOPLIST_FILE = Runner/Info.plist;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				PRODUCT_BUNDLE_IDENTIFIER = com.cfssh.launcher;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_OBJC_BRIDGING_HEADER = "Runner/Runner-Bridging-Header.h";
				SWIFT_VERSION = 5.0;
				VERSIONING_SYSTEM = "apple-generic";
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		331C8087294A63A400263BE5 /* Build configuration list for PBXNativeTarget "RunnerTests" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				331C8088294A63A400263BE5 /* Debug */,
				331C8089294A63A400263BE5 /* Release */,
				331C808A294A63A400263BE5 /* Profile */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		97C146E91CF9000F007C117D /* Build configuration list for PBXProject "Runner" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				97C147031CF9000F007C117D /* Debug */,
				97C147041CF9000F007C117D /* Release */,
				249021D3217E4FDB00AE95B9 /* Profile */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		97C147051CF9000F007C117D /* Build configuration list for PBXNativeTarget "Runner" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				97C147061CF9000F007C117D /* Debug */,
				97C147071CF9000F007C117D /* Release */,
				249021D4217E4FDB00AE95B9 /* Profile */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */

/* Begin XCLocalSwiftPackageReference section */
		781AD8BC2B33823900A9FFBB /* XCLocalSwiftPackageReference "Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage" */ = {
			isa = XCLocalSwiftPackageReference;
			relativePath = Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage;
		};
/* End XCLocalSwiftPackageReference section */

/* Begin XCSwiftPackageProductDependency section */
		78A3181F2AECB46A00862997 /* FlutterGeneratedPluginSwiftPackage */ = {
			isa = XCSwiftPackageProductDependency;
			productName = FlutterGeneratedPluginSwiftPackage;
		};
/* End XCSwiftPackageProductDependency section */
	};
	rootObject = 97C146E61CF9000F007C117D /* Project object */;
}
```

## File: ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>IDEDidComputeMac32BitWarning</key>
	<true/>
</dict>
</plist>
```

## File: ios/Runner.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>PreviewsEnabled</key>
	<false/>
</dict>
</plist>
```

## File: ios/Runner.xcworkspace/contents.xcworkspacedata
```
<?xml version="1.0" encoding="UTF-8"?>
<Workspace
   version = "1.0">
   <FileRef
      location = "group:Runner.xcodeproj">
   </FileRef>
</Workspace>
```

## File: ios/RunnerTests/RunnerTests.swift
```swift
class RunnerTests: XCTestCase {
⋮----
func testExample() {
// If you add code to the Runner application, consider adding tests here.
// See https://developer.apple.com/documentation/xctest for more information about using XCTest.
```

## File: ios/.gitignore
```
**/dgph
*.mode1v3
*.mode2v3
*.moved-aside
*.pbxuser
*.perspectivev3
**/*sync/
.sconsign.dblite
.tags*
**/.vagrant/
**/DerivedData/
Icon?
**/Pods/
**/.symlinks/
profile
xcuserdata
**/.generated/
Flutter/App.framework
Flutter/Flutter.framework
Flutter/Flutter.podspec
Flutter/Generated.xcconfig
Flutter/ephemeral/
Flutter/app.flx
Flutter/app.zip
Flutter/flutter_assets/
Flutter/flutter_export_environment.sh
ServiceDefinitions.json
Runner/GeneratedPluginRegistrant.*

# Exceptions to above rules.
!default.mode1v3
!default.mode2v3
!default.pbxuser
!default.perspectivev3
```

## File: lib/core/config/cyberdeck_config_provider.dart
```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
⋮----
enum CyberdeckThemePreset {
phosphorMatrix,  // Esmeralda Matrix / Forest Pro
tacticalCyan,    // Azul Cupertino / Ocean Pro
amberTerminal,   // Ámbar Solar / Dune Pro
stealthGraphite, // Grafito Studio / Violet Pro
⋮----
enum CyberdeckFontFamily {
inter,          // Inter (UI Moderna / Apple)
dotNothing,     // Nothing Dot (Matriz de Puntos)
ttHovesPro,     // TT Hoves Pro (Geométrica Técnica)
ttBluescreens,  // TT Bluescreens (Condensada Display)
openSans,       // Open Sans (Humanista Limpia)
nunito,         // Nunito (Redondeada Suave)
minecraft,      // Minecraft Pixel (Pixel Art Block)
jetBrainsMono,  // JetBrains Mono (Terminal Código)
⋮----
enum CyberdeckDensity {
⋮----
class ActivityLogEntry {
⋮----
const ActivityLogEntry({
    required this.timestamp,
    required this.category,
    required this.message,
  });
⋮----
Map<String, dynamic> toMap() => {
⋮----
factory ActivityLogEntry.fromMap(Map<String, dynamic> map) {
⋮----
class CyberdeckConfig {
⋮----
const CyberdeckConfig({
    this.themePreset = CyberdeckThemePreset.tacticalCyan,
    this.isDarkMode = true,
    this.customAccentColorValue = 0xFF0A84FF,
    this.customHighlightColorValue = 0xFFFF9F0A,
    this.sentinelAccentColorValue = 0xFF6366F1,
    this.fontFamily = CyberdeckFontFamily.inter,
    this.use24HourFormat = true,
    this.showSeconds = false,
    this.density = CyberdeckDensity.standard,
    this.enableVisualEffects = false,
    this.immersiveMode = true,
    this.selectedIconPack,
    this.maskUnthemedIcons = true,
    this.visibleModules = const {
      'clock': true,
      'favorites': true,
      'quick_actions': true,
      'system_monitor': true,
      'network': true,
      'calendar': true,
      'activity': true,
    },
    this.moduleOrder = const [
      'clock',
      'favorites',
      'quick_actions',
      'system_monitor',
      'network',
      'calendar',
      'activity',
    ],
    this.favoritePackages = const [],
    this.recentPackages = const [],
    this.activityLog = const [],
    this.tacticalNotes = const [],
    this.defaultFileManager,
    this.operatorCallsign = 'Cyberdeck Pro',
  });
⋮----
/// Primary interactive accent color
Color get primaryAccent => Color(customAccentColorValue);
⋮----
/// Spotlight / Highlight color for focal elements (Today badge, starred items, key metrics)
Color get highlightAccent => Color(customHighlightColorValue);
⋮----
/// Dedicated brand accent for Sentinel Live Health Checker
Color get sentinelAccent => Color(sentinelAccentColorValue);
⋮----
/// Harmonious secondary accent derived from the active theme preset
Color get secondaryAccent {
⋮----
/// Solid, clean background color tinted subtly by the active theme preset (Zero Glassmorphism)
Color get backgroundColor {
⋮----
return const Color(0xFF090E0C); // Deep Forest Black
⋮----
return const Color(0xFF0A0D14); // Deep Ocean Slate
⋮----
return const Color(0xFF100D0A); // Warm Obsidian
⋮----
return const Color(0xFF0C0C12); // Deep Studio Graphite
⋮----
/// 100% Solid primary surface for cards, panels, and dock
Color get panelColor {
⋮----
/// Solid secondary surface for nested tiles, inputs, and pills
Color get surfaceSecondaryColor {
⋮----
/// Discrete 1px solid border color
Color get borderColor {
⋮----
Color get textPrimaryColor {
⋮----
Color get textSecondaryColor {
⋮----
double get paddingScale {
⋮----
CyberdeckConfig copyWith({
⋮----
class CyberdeckConfigNotifier extends Notifier<CyberdeckConfig> {
⋮----
CyberdeckConfig build() {
⋮----
static String _nowStr() {
⋮----
Future<void> _loadFromPrefs() async {
⋮----
Future<void> setDarkMode(bool isDark) async {
⋮----
Future<void> setThemePreset(CyberdeckThemePreset preset) async {
⋮----
defaultAccent = 0xFF10B981;    // Emerald
defaultHighlight = 0xFFF59E0B; // Warm Amber spotlight
⋮----
defaultAccent = 0xFF0A84FF;    // System Blue
defaultHighlight = 0xFF38BDF8; // Sky Cyan spotlight
⋮----
defaultAccent = 0xFFF59E0B;    // Solar Amber
defaultHighlight = 0xFF10B981; // Emerald contrast spotlight
⋮----
defaultAccent = 0xFF8B5CF6;    // Studio Violet
defaultHighlight = 0xFFEC4899; // Rose Pink spotlight
⋮----
Future<void> setAccentColor(int colorValue) async {
⋮----
Future<void> setHighlightColor(int colorValue) async {
⋮----
Future<void> setSentinelAccentColor(int colorValue) async {
⋮----
Future<void> setFontFamily(CyberdeckFontFamily family) async {
⋮----
Future<void> setSelectedIconPackConfig(String? packageName) async {
⋮----
Future<void> setMaskUnthemedIcons(bool enabled) async {
⋮----
Future<void> setTimeFormat({bool? use24h, bool? showSeconds}) async {
⋮----
Future<void> setDensity(CyberdeckDensity density) async {
⋮----
Future<void> setVisualEffects(bool enabled) async {
⋮----
Future<void> setImmersiveMode(bool enabled) async {
⋮----
Future<void> toggleModuleVisibility(String moduleKey, bool visible) async {
⋮----
Future<void> reorderModules(int oldIndex, int newIndex) async {
⋮----
Future<void> moveModule(String moduleKey, int delta) async {
⋮----
Future<void> toggleFavoriteApp(String packageName, {String? appName}) async {
⋮----
/// Purges all references to an uninstalled or disabled package so ghost apps never persist.
Future<void> purgeUninstalledPackage(String packageName) async {
⋮----
/// Reconciles stored favorites, recents, and file manager with the real set of installed packages.
Future<void> reconcileWithInstalledPackages(
⋮----
Future<void> recordAppLaunch(String packageName, {String? appName}) async {
⋮----
Future<void> logAction(String category, String message) async {
⋮----
Future<void> addTacticalNote(String note) async {
⋮----
Future<void> removeTacticalNote(int index) async {
⋮----
Future<void> setDefaultFileManager(String packageName) async {
⋮----
Future<void> setOperatorCallsign(String callsign) async {
```

## File: lib/core/theme/app_theme.dart
```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/cyberdeck_config_provider.dart';
⋮----
class AppTheme {
⋮----
static bool get isDark => _isDark;
static CyberdeckFontFamily get activeFont => _activeFont;
⋮----
// Solid Neutral Surfaces
⋮----
// Semantic & Accent Palette
static const Color phosphorGreen = Color(0xFF10B981); // Emerald
static const Color electricCyan = Color(0xFF0A84FF);  // System Blue
static const Color amberAlert = Color(0xFFF59E0B);    // Warm Amber
static const Color primaryBlue = Color(0xFF007AFF);   // Cupertino Blue
static const Color cyan = Color(0xFF06B6D4);          // Cyan
⋮----
// Sentinel Health Checker Dedicated Palette
static const Color sentinelOnline = Color(0xFF10B981);   // Emerald Online
static const Color sentinelDegraded = Color(0xFFF59E0B); // Amber Degraded
static const Color sentinelOffline = Color(0xFFF43F5E);  // Rose Offline
static const Color sentinelProbing = Color(0xFF38BDF8);  // Sky Probing
static const Color sentinelTcp = Color(0xFF3B82F6);      // Royal Blue TCP
static const Color sentinelHttp = Color(0xFF8B5CF6);     // Violet HTTP
static const Color sentinelUdp = Color(0xFF14B8A6);      // Teal UDP
⋮----
// Dynamic Adaptive Typography & Surface Colors (Light & Dark Modes)
static Color get textPrimary =>
⋮----
static Color get textSecondary =>
⋮----
static Color get textDim =>
⋮----
static const Color error = Color(0xFFF43F5E);   // Rose Red
static const Color warning = Color(0xFFF59E0B); // Warm Amber
static const Color success = Color(0xFF10B981); // Emerald Green
⋮----
// Solid Opaque Surfaces (Zero Glassmorphism)
static Color get cardBackground =>
⋮----
static Color get surfaceSecondary =>
⋮----
static Color get cardBorder =>
⋮----
/// Primary UI typography that adapts to the user's selected font family
/// (Inter, Nothing Dot, TT Hoves Pro, TT Bluescreens, Open Sans, Nunito, Minecraft, JetBrains Mono).
static TextStyle mono({
⋮----
/// Extra-large hero clock display style that scales properly for every font family.
static TextStyle clockHero({
⋮----
/// Technical monospace font reserved for terminal output, IP addresses, and metrics.
static TextStyle codeMono({
⋮----
static ThemeData get darkTheme => buildCyberdeckTheme(const CyberdeckConfig());
⋮----
static ThemeData buildCyberdeckTheme(CyberdeckConfig config) {
⋮----
static TextTheme _buildTextTheme(
```

## File: lib/core/widgets/cyber_tap_target.dart
```dart
import 'package:flutter/material.dart';
⋮----
/// Minimum touch target recommended by Material / Android accessibility (48x48 dp).
⋮----
/// Reusable touch wrapper for every interactive Cyberdeck element.
/// Guarantees >= 48x48 dp touch area and smooth, responsive tactile visual feedback.
class CyberTapTarget extends StatefulWidget {
⋮----
const CyberTapTarget({
    super.key,
    required this.child,
    required this.onTap,
    this.onLongPress,
    this.pressColor = const Color(0xFF0A84FF),
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.minWidth = kCyberMinTouchTarget,
    this.minHeight = kCyberMinTouchTarget,
    this.alignment = Alignment.center,
    this.tooltip,
    this.semanticLabel,
    this.fillWidth = false,
  });
⋮----
State<CyberTapTarget> createState() => _CyberTapTargetState();
⋮----
class _CyberTapTargetState extends State<CyberTapTarget> {
⋮----
void _setPressed(bool value) {
⋮----
Widget build(BuildContext context) {
⋮----
/// Small icon action with a full 48x48 dp touch target.
class CyberIconAction extends StatelessWidget {
⋮----
const CyberIconAction({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.tooltip,
    this.iconSize = 18,
  });
```

## File: lib/features/apps/app_drawer_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/cyber_tap_target.dart';
import '../../services/device_service.dart';
import '../settings/settings_screen.dart';
import 'apps_provider.dart';
⋮----
class AppDrawerScreen extends ConsumerStatefulWidget {
const AppDrawerScreen({super.key});
⋮----
ConsumerState<AppDrawerScreen> createState() => _AppDrawerScreenState();
⋮----
class _AppDrawerScreenState extends ConsumerState<AppDrawerScreen> {
⋮----
void dispose() {
⋮----
Future<void> _triggerManualSync() async {
⋮----
Widget build(BuildContext context) {
⋮----
// Clean Spotlight-style Header Bar
⋮----
// Filter Favorites Toggle
⋮----
// Manual Package Sync Button
⋮----
// Active Icon Pack Status Bar
⋮----
// Applications Grid
⋮----
Widget _buildAppTile({
⋮----
void _showAppActionSheet(
⋮----
// App Header in Bottom Sheet
⋮----
void _showAlternativeIconPicker(
```

## File: lib/features/apps/apps_provider.dart
```dart
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../services/device_service.dart';
⋮----
class InstalledAppsNotifier extends AsyncNotifier<List<InstalledApp>> {
⋮----
Future<List<InstalledApp>> build() async {
⋮----
// Reconcile stored favorites/recents so no ghost apps survive across restarts
⋮----
void _handlePackageEvent(PackageChangeEvent event) {
⋮----
// If an icon pack was installed, updated, or removed, refresh the icon packs list
⋮----
// 'added', 'updated', or 'changed'
⋮----
// Package exists in system but has no launchable activity (or was disabled)
⋮----
/// Synchronizes the app list with PackageManager incrementally, updating state
/// only if packages or metadata changed.
Future<void> syncApps({bool forceRefresh = false}) async {
⋮----
/// Applies an icon pack (or null for original system icons) and refreshes all icons immediately.
Future<bool> applyIconPack(String? iconPackPackage) async {
⋮----
/// Toggles icon masking for unthemed apps and refreshes icons immediately.
Future<void> setIconMasking(bool enabled) async {
⋮----
/// Sets or resets a custom alternative icon for a single package.
Future<void> updateSingleAppCustomIcon(
⋮----
List<InstalledApp> _deduplicateAndSort(List<InstalledApp> raw) {
⋮----
bool _hasDifferences(List<InstalledApp> a, List<InstalledApp> b) {
```

## File: lib/features/cameras/models/rtsp_camera_model.dart
```dart
class RtspCameraModel {
⋮----
const RtspCameraModel({
    required this.id,
    required this.name,
    required this.url,
    this.user = 'admin',
    this.password = '',
    this.ip = '192.168.1.176',
    this.port = 554,
    this.path = '/live/ch00_0',
    this.isMuted = true,
  });
⋮----
/// Builds a standard RTSP URL string:
/// rtsp://user:password@ip:port/path
static String buildUrl({
⋮----
/// Parses an existing RTSP URL into components
static ({String user, String password, String ip, int port, String path}) parseUrl(String fullUrl) {
⋮----
/// Returns masked URL for security in HUD (hides password)
String get maskedUrl {
⋮----
RtspCameraModel copyWith({
⋮----
Map<String, dynamic> toMap() {
⋮----
factory RtspCameraModel.fromMap(Map<String, dynamic> map) {
```

## File: lib/features/cameras/providers/cameras_provider.dart
```dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/rtsp_camera_model.dart';
import '../services/camera_scanner_service.dart';
⋮----
class CamerasNotifier extends Notifier<List<RtspCameraModel>> {
⋮----
List<RtspCameraModel> build() {
⋮----
// Default preset with the user's example so it works out of the box
⋮----
Future<void> _loadFromPrefs() async {
⋮----
Future<void> _saveToPrefs(List<RtspCameraModel> cameras) async {
⋮----
Future<void> addCamera(RtspCameraModel camera) async {
⋮----
Future<void> updateCamera(RtspCameraModel camera) async {
⋮----
Future<void> deleteCamera(String id) async {
⋮----
Future<void> toggleMute(String id) async {
⋮----
class ActiveCameraIdNotifier extends Notifier<String?> {
⋮----
String? build() {
⋮----
void selectCamera(String id) {
⋮----
class ScanResultsNotifier extends Notifier<List<DiscoveredCamera>> {
⋮----
List<DiscoveredCamera> build() => [];
⋮----
void setResults(List<DiscoveredCamera> list) => state = list;
void addResult(DiscoveredCamera cam) => state = [...state, cam];
void clear() => state = [];
```

## File: lib/features/cameras/services/camera_scanner_service.dart
```dart
import 'dart:async';
import 'dart:io';
⋮----
class DiscoveredCamera {
⋮----
const DiscoveredCamera({
    required this.ip,
    required this.port,
    required this.latencyMs,
    required this.label,
  });
⋮----
class CameraScannerService {
/// Extracts the base subnet prefix from an IPv4 string (e.g. "192.168.1.45" -> "192.168.1")
static String extractSubnet(String ip) {
⋮----
/// Quickly tests if a specific IP & port accepts TCP connections.
/// Returns the latency in milliseconds or -1 if unreachable.
static Future<int> testConnection(String ip, int port, {Duration timeout = const Duration(milliseconds: 700)}) async {
⋮----
/// Scans a local subnet (e.g. "192.168.1") on target ports (default RTSP 554)
/// using non-blocking concurrent batch processing.
static Stream<({double progress, DiscoveredCamera? found, String status})> scanSubnet({
⋮----
static Future<DiscoveredCamera?> _probeIp(String ip, int port, Duration timeout) async {
```

## File: lib/features/cameras/widgets/camera_modal_dialog.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../models/rtsp_camera_model.dart';
import '../providers/cameras_provider.dart';
import '../services/camera_scanner_service.dart';
⋮----
class CameraModalDialog extends ConsumerStatefulWidget {
⋮----
const CameraModalDialog({
    super.key,
    this.camera,
    this.initialIp,
    this.initialPort,
  });
⋮----
ConsumerState<CameraModalDialog> createState() => _CameraModalDialogState();
⋮----
class _CameraModalDialogState extends ConsumerState<CameraModalDialog> {
⋮----
void initState() {
⋮----
void _syncFromModularFields() {
⋮----
void _syncFromFullUrl() {
⋮----
void dispose() {
⋮----
Future<void> _testConnection() async {
⋮----
void _saveCamera() {
⋮----
Widget build(BuildContext context) {
⋮----
// Header
⋮----
// Camera Tag / Name
⋮----
// Mode Selector Tabs
⋮----
// Modular Builder: User, Password, IP, Port, Path
⋮----
// Quick Brand Path Templates
⋮----
// Manual URL Input
⋮----
// Live URL Preview Box
⋮----
// Test Connection Status
⋮----
InputDecoration _buildInputDecoration(
```

## File: lib/features/cameras/widgets/camera_scanner_dialog.dart
```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../monitor/monitor_screen.dart';
import '../services/camera_scanner_service.dart';
import 'camera_modal_dialog.dart';
⋮----
class CameraScannerDialog extends ConsumerStatefulWidget {
const CameraScannerDialog({super.key});
⋮----
ConsumerState<CameraScannerDialog> createState() =>
⋮----
class _CameraScannerDialogState extends ConsumerState<CameraScannerDialog> {
⋮----
void initState() {
⋮----
void dispose() {
⋮----
void _startScan() {
⋮----
void _stopScan() {
⋮----
Widget build(BuildContext context) {
⋮----
// Header
⋮----
// Inputs for Subnet & Port
⋮----
// Progress bar & radar status text
⋮----
// Results Header
⋮----
// List of discovered cameras
⋮----
// Bottom Cancel
```

## File: lib/features/cameras/widgets/rtsp_player_widget.dart
```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../models/rtsp_camera_model.dart';
import '../providers/cameras_provider.dart';
import 'camera_modal_dialog.dart';
⋮----
class RtspPlayerWidget extends ConsumerStatefulWidget {
⋮----
const RtspPlayerWidget({
    super.key,
    required this.camera,
    this.isFullscreen = false,
  });
⋮----
ConsumerState<RtspPlayerWidget> createState() => _RtspPlayerWidgetState();
⋮----
class _RtspPlayerWidgetState extends ConsumerState<RtspPlayerWidget> {
⋮----
// Watchdog and Auto-reconnection state
⋮----
void initState() {
⋮----
void didUpdateWidget(covariant RtspPlayerWidget oldWidget) {
⋮----
void _startTicker() {
⋮----
/// Watchdog that inspects stream health:
⋮----
/// Detects fatal controller errors and dropped sockets to trigger recovery.
void _startWatchdog() {
⋮----
// Check for player error
⋮----
Future<void> _triggerAutoReconnect({required String reason}) async {
⋮----
// Incremental backoff: 1.5s, 2.5s, up to 4s
⋮----
Future<void> _initializePlayer({bool isRetry = false}) async {
⋮----
// Schedule next automatic retry if not yet connected
⋮----
void _onPlayerStateChanged() {
⋮----
void _disposePlayer() {
⋮----
void dispose() {
⋮----
void _toggleAudio() {
⋮----
void _togglePlayPause() {
⋮----
void _toggleStreamProfile() {
⋮----
void _openFullscreen(BuildContext context) {
⋮----
Widget build(BuildContext context) {
⋮----
// 1. Video Layer or Fallback Placeholder
⋮----
// 2. Cyberdeck Tactical HUD Reticle Overlay
⋮----
// 3. Top HUD Status Bar
⋮----
// Camera Tag & IP badge
⋮----
// Live REC / Reconnecting Status LED & Timecode
⋮----
// 4. Bottom HUD Controls Bar
⋮----
// Codec / Stream details + Quick Profile Switcher
⋮----
// Interactive Controls Row
⋮----
// Audio Mute / Unmute Button
⋮----
// Play / Pause Toggle
⋮----
// Reconnect / Refresh Button
⋮----
// Edit Camera Config Button
⋮----
// Fullscreen Toggle Button
⋮----
Widget _buildAutoReconnectingHud(CyberdeckConfig config, Color accent, Color secondary) {
⋮----
Widget _buildBufferingHud(CyberdeckConfig config, Color accent, Color secondary) {
⋮----
Widget _buildOfflineHud(CyberdeckConfig config, Color accent, Color secondary) {
⋮----
class _SurveillanceReticlePainter extends CustomPainter {
⋮----
const _SurveillanceReticlePainter({required this.accentColor});
⋮----
void paint(Canvas canvas, Size size) {
⋮----
// Center crosshairs
⋮----
bool shouldRepaint(covariant _SurveillanceReticlePainter oldDelegate) {
```

## File: lib/features/cameras/widgets/rtsp_surveillance_panel.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../../dashboard/widgets/cyberdeck_panel.dart';
import '../models/rtsp_camera_model.dart';
import '../providers/cameras_provider.dart';
import 'camera_modal_dialog.dart';
import 'camera_scanner_dialog.dart';
import 'rtsp_player_widget.dart';
⋮----
class RtspSurveillancePanel extends ConsumerWidget {
const RtspSurveillancePanel({super.key});
⋮----
void _showAddCamera(BuildContext context) {
⋮----
void _showScanner(BuildContext context) {
⋮----
void _confirmDelete(
⋮----
Widget build(BuildContext context, WidgetRef ref) {
⋮----
// Scan Button
⋮----
// Add Camera Button
⋮----
// Active Stream Viewport
⋮----
// Empty State
```

## File: lib/features/cameras/rtsp_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/rtsp_surveillance_panel.dart';
⋮----
class RtspScreen extends ConsumerWidget {
const RtspScreen({super.key});
⋮----
Widget build(BuildContext context, WidgetRef ref) {
```

## File: lib/features/dashboard/widgets/app_grid_widget.dart
```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../../../services/device_service.dart';
import '../../apps/app_drawer_screen.dart';
import '../../apps/apps_provider.dart';
import '../../shortcuts/shortcut_dialog.dart';
import '../../shortcuts/shortcut_model.dart';
import '../../shortcuts/shortcuts_provider.dart';
import 'cyberdeck_panel.dart';
⋮----
class AppGridWidget extends ConsumerWidget {
const AppGridWidget({super.key});
⋮----
Future<void> _executeShortcut(
⋮----
void _runCommandDialog(
⋮----
void _showShortcutOptions(
⋮----
void _showFavoriteAppsSelector(
⋮----
Widget build(BuildContext context, WidgetRef ref) {
⋮----
// 1. Shortcuts Section (SSH / URL / CMD)
⋮----
// 2. Favorite & Pinned Applications Grid
⋮----
Widget _buildShortcutChip(
⋮----
Widget _buildAddShortcutChip(
⋮----
Widget _buildAppItem(
```

## File: lib/features/dashboard/widgets/calendar_activity_module.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../../../services/device_service.dart';
import '../../apps/apps_provider.dart';
import '../../monitor/monitor_screen.dart';
import 'cyberdeck_panel.dart';
⋮----
class CalendarModuleWidget extends ConsumerWidget {
const CalendarModuleWidget({super.key});
⋮----
void _showAddTacticalNoteDialog(BuildContext context, WidgetRef ref) {
⋮----
Widget build(BuildContext context, WidgetRef ref) {
⋮----
// System Calendar Events Section
⋮----
// Daily Notes
⋮----
class _TextLinkAction extends StatelessWidget {
⋮----
const _TextLinkAction({
    required this.label,
    required this.color,
    required this.onTap,
  });
⋮----
Widget build(BuildContext context) {
⋮----
class ActivityFeedModuleWidget extends ConsumerWidget {
const ActivityFeedModuleWidget({super.key});
⋮----
// 1. Recent Applications Strip
⋮----
// Only match against genuinely installed apps -> zero ghost apps
⋮----
// 2. Authorized System Notifications Section
⋮----
// 3. Activity Log
```

## File: lib/features/dashboard/widgets/clock_module_widget.dart
```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import 'cyberdeck_panel.dart';
⋮----
class ClockModuleWidget extends ConsumerStatefulWidget {
const ClockModuleWidget({super.key});
⋮----
ConsumerState<ClockModuleWidget> createState() => _ClockModuleWidgetState();
⋮----
class _ClockModuleWidgetState extends ConsumerState<ClockModuleWidget> {
⋮----
void initState() {
⋮----
void dispose() {
⋮----
String _contextualGreeting(int hour) {
⋮----
Widget build(BuildContext context) {
⋮----
// Generate 7-day strip starting Monday of current week
⋮----
// Top Greeting & Full Date Bar
⋮----
// Hero Digital Clock (Extra Large & High-Visibility)
⋮----
// 7-Day Minimalist Calendar Strip with Spotlight Highlight for Today
```

## File: lib/features/dashboard/widgets/cyberdeck_panel.dart
```dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
⋮----
class CyberdeckPanel extends StatelessWidget {
⋮----
const CyberdeckPanel({
    super.key,
    required this.moduleCode,
    required this.title,
    required this.child,
    required this.accentColor,
    this.panelColor,
    this.statusColor,
    this.statusLabel,
    this.actions,
    this.padding = const EdgeInsets.all(14),
    this.showVisualEffects = false,
  });
⋮----
Widget build(BuildContext context) {
⋮----
// Clean Minimalist Module Header Bar (48dp touch height)
⋮----
// Discrete status dot (no neon glow)
⋮----
// Subtle Cyberdeck module code pill
⋮----
class CyberdeckSegmentedBar extends StatelessWidget {
final double value; // 0.0 to 1.0
⋮----
const CyberdeckSegmentedBar({
    super.key,
    required this.value,
    required this.activeColor,
    this.segments = 16,
    this.height = 6,
  });
```

## File: lib/features/dashboard/widgets/device_info_panel.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../../apps/apps_provider.dart';
import '../../monitor/monitor_screen.dart';
import '../../network/ping_screen.dart';
import '../../vpn/vpn_screen.dart';
import 'cyberdeck_panel.dart';
⋮----
class SystemMonitorModule extends ConsumerWidget {
const SystemMonitorModule({super.key});
⋮----
Widget build(BuildContext context, WidgetRef ref) {
⋮----
// 1. Battery Telemetry
⋮----
// 2. RAM Telemetry
⋮----
// 3. Internal Storage Telemetry
⋮----
// 4. Device Hardware Identity Footer
⋮----
Widget _buildMetricHeader({
⋮----
class NetworkModuleWidget extends ConsumerWidget {
const NetworkModuleWidget({super.key});
⋮----
// Primary Network Row
⋮----
// Secondary Row: Bluetooth, Airplane, VPN
⋮----
// Network Tools Row (Ping & VPN Settings)
⋮----
Widget _buildNetStatBox({
⋮----
Widget _buildMiniBadge({
⋮----
/// Wrapper combining System Monitor & Network
class DeviceInfoPanel extends StatelessWidget {
const DeviceInfoPanel({super.key});
⋮----
Widget build(BuildContext context) {
```

## File: lib/features/dashboard/widgets/quick_actions_module_widget.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../../apps/apps_provider.dart';
import '../../monitor/monitor_screen.dart';
import '../../settings/settings_screen.dart';
import '../../tools/tools_screen.dart';
import 'cyberdeck_panel.dart';
⋮----
class QuickActionsModuleWidget extends ConsumerStatefulWidget {
const QuickActionsModuleWidget({super.key});
⋮----
ConsumerState<QuickActionsModuleWidget> createState() =>
⋮----
class _QuickActionsModuleWidgetState
⋮----
Future<void> _handleFlashlightTap(BuildContext context) async {
⋮----
void _showScreenTorchDialog(BuildContext context) {
⋮----
Widget build(BuildContext context) {
⋮----
// Media & Audio Controller Card
⋮----
// Quick Settings Row
⋮----
Widget _buildActionTile({
⋮----
Widget _buildMediaBtn(
```

## File: lib/features/dashboard/widgets/top_header_widget.dart
```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../../apps/apps_provider.dart';
import '../../monitor/monitor_screen.dart';
import '../../settings/settings_screen.dart';
import '../weather_provider.dart';
⋮----
class TopHeaderWidget extends ConsumerWidget {
const TopHeaderWidget({super.key});
⋮----
Widget build(BuildContext context, WidgetRef ref) {
⋮----
// Left Cluster: Callsign + High-Visibility Clock + Date
⋮----
// Right Cluster: Clean System Status Pills & Quick Controls
⋮----
// Wi-Fi / Network Pill
⋮----
// Bluetooth Status
⋮----
// Battery Percentage
⋮----
// Light / Dark Mode Quick Toggle
⋮----
// Settings Button
⋮----
class _HeaderClockTicker extends StatefulWidget {
⋮----
const _HeaderClockTicker({
    required this.use24Hour,
    required this.textColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.borderColor,
    required this.compact,
  });
⋮----
State<_HeaderClockTicker> createState() => _HeaderClockTickerState();
⋮----
class _HeaderClockTickerState extends State<_HeaderClockTicker> {
⋮----
void initState() {
⋮----
void dispose() {
⋮----
Widget build(BuildContext context) {
⋮----
class _StatusPill extends StatelessWidget {
⋮----
const _StatusPill({
    required this.icon,
    required this.label,
    required this.color,
    required this.surfaceColor,
    required this.borderColor,
    this.highlighted = false,
    this.onTap,
  });
```

## File: lib/features/dashboard/dashboard_screen.dart
```dart
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
⋮----
class DashboardScreen extends ConsumerStatefulWidget {
const DashboardScreen({super.key});
⋮----
ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
⋮----
class _DashboardScreenState extends ConsumerState<DashboardScreen> {
⋮----
void initState() {
⋮----
void dispose() {
⋮----
void _handleKeyEvent(KeyEvent event) {
⋮----
Widget? _buildModuleByKey(String key, CyberdeckConfig config) {
⋮----
Widget build(BuildContext context) {
⋮----
Widget _buildLandscapeCyberdeck(
⋮----
Widget _buildPortraitCyberdeck(CyberdeckConfig config) {
⋮----
Widget _buildCyberdeckDock(CyberdeckConfig config) {
⋮----
Widget _buildDockButton({
```

## File: lib/features/dashboard/weather_provider.dart
```dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
⋮----
class WeatherData {
⋮----
WeatherData({required this.temperature, required this.weatherCode});
⋮----
// 1. Get Location based on IP
⋮----
// 2. Get Weather from Open-Meteo
```

## File: lib/features/health_checker/models/health_target_model.dart
```dart
import 'dart:convert';
import 'package:intl/intl.dart';
⋮----
enum ProbeProtocol {
⋮----
String get displayName => name.toUpperCase();
⋮----
enum ProbeStatus {
⋮----
String get label {
⋮----
class HealthTargetModel {
⋮----
const HealthTargetModel({
    required this.id,
    required this.name,
    required this.protocol,
    required this.host,
    this.port = 80,
    this.path = '/',
    this.expectedStatusCode = 200,
    this.timeoutMs = 2500,
    this.isEnabled = true,
    this.status = ProbeStatus.unknown,
    this.lastLatencyMs,
    this.latencyHistory = const [],
    this.lastChecked,
    this.statusMessage,
    this.successCount = 0,
    this.failCount = 0,
  });
⋮----
String get endpointLabel {
⋮----
double get uptimePercentage {
⋮----
String get formattedLastChecked {
⋮----
String get relativeLastChecked {
⋮----
HealthTargetModel copyWith({
⋮----
Map<String, dynamic> toMap() {
⋮----
factory HealthTargetModel.fromMap(Map<String, dynamic> map) {
⋮----
String toJson() => jsonEncode(toMap());
factory HealthTargetModel.fromJson(String source) =>
```

## File: lib/features/health_checker/providers/health_checker_provider.dart
```dart
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/health_target_model.dart';
import '../services/probe_service.dart';
⋮----
class HealthTargetsNotifier extends Notifier<List<HealthTargetModel>> {
⋮----
List<HealthTargetModel> build() {
⋮----
// Reactive listener: automatically restarts timer whenever auto-probe interval changes
⋮----
Future<void> _loadFromStorage() async {
⋮----
// Default tactical health check presets
⋮----
// Start timer with current interval and trigger initial probe
⋮----
void _restartPollingTimer(int intervalSeconds) {
⋮----
Future<void> _saveToStorage() async {
⋮----
void addTarget(HealthTargetModel target) {
⋮----
void updateTarget(HealthTargetModel updated) {
⋮----
void deleteTarget(String id) {
⋮----
void toggleTargetEnabled(String id) {
⋮----
Future<void> probeTarget(String id) async {
⋮----
// Set status to probing
⋮----
// Update global last check timestamp
⋮----
Future<void> probeAll() async {
⋮----
// Execute all probes in parallel
⋮----
void resetMetrics(String id) {
⋮----
class AutoProbeIntervalNotifier extends Notifier<int> {
⋮----
int build() {
⋮----
return 10; // Default 10 seconds
⋮----
Future<void> _loadInterval() async {
⋮----
Future<void> setInterval(int seconds) async {
⋮----
class IsProbingAllNotifier extends Notifier<bool> {
⋮----
bool build() => false;
⋮----
void setProbing(bool value) => state = value;
⋮----
class LastGlobalCheckNotifier extends Notifier<DateTime?> {
⋮----
DateTime? build() => null;
⋮----
void setLastCheck(DateTime time) => state = time;
```

## File: lib/features/health_checker/services/probe_service.dart
```dart
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/health_target_model.dart';
⋮----
class ProbeResult {
⋮----
const ProbeResult({
    required this.status,
    required this.latencyMs,
    required this.message,
  });
⋮----
factory ProbeResult.online(int latencyMs, [String? msg]) {
⋮----
factory ProbeResult.offline(String error) {
⋮----
class ProbeService {
/// Probes any health target according to its protocol (TCP, HTTP, UDP).
static Future<ProbeResult> testProbe(HealthTargetModel target) async {
⋮----
/// TCP Socket probe
static Future<ProbeResult> _probeTcp(String host, int port, int timeoutMs) async {
⋮----
/// HTTP / HTTPS probe
static Future<ProbeResult> _probeHttp(
⋮----
// Strip any path attached to host
⋮----
// Handle custom port in host if present
⋮----
/// UDP Datagram probe
/// For port 53 (DNS), sends a lightweight DNS query for 'google.com' (A record).
/// For other ports, sends a small heartbeat datagram.
static Future<ProbeResult> _probeUdp(String host, int port, int timeoutMs) async {
⋮----
// Standard DNS query header + question for 'google.com'
⋮----
0xAA, 0xBB, // ID
0x01, 0x00, // Flags (recursion desired)
0x00, 0x01, // QDCOUNT = 1
0x00, 0x00, // ANCOUNT = 0
0x00, 0x00, // NSCOUNT = 0
0x00, 0x00, // ARCOUNT = 0
// 6 'google' 3 'com' 0
⋮----
0x00, 0x01, // QTYPE = A
0x00, 0x01, // QCLASS = IN
⋮----
// Echo / Heartbeat ping packet
⋮----
// For non-DNS UDP (where remote servers often don't reply directly due to firewall),
// if packet was dispatched to reachable host, we mark as host reachable
```

## File: lib/features/health_checker/widgets/health_checker_panel.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../../dashboard/widgets/cyberdeck_panel.dart';
import '../models/health_target_model.dart';
import '../providers/health_checker_provider.dart';
import 'target_modal_dialog.dart';
⋮----
class HealthCheckerPanel extends ConsumerWidget {
const HealthCheckerPanel({super.key});
⋮----
void _showAddModal(BuildContext context) {
⋮----
void _showEditModal(BuildContext context, HealthTargetModel target) {
⋮----
void _confirmDelete(
⋮----
void _showIntervalAndPaletteSheet(BuildContext context, WidgetRef ref) {
⋮----
// Sentinel Custom Color Swatches
⋮----
Widget build(BuildContext context, WidgetRef ref) {
⋮----
// Sentinel uses its own dedicated brand accent & semantic palette
⋮----
// Calculate Summary Stats
⋮----
// Global Last Check formatting
⋮----
// Auto Polling Interval & Palette Button
⋮----
// Probe All Now Button
⋮----
// Add Target Button
⋮----
// Telemetry Summary KPI Bar with Sentinel Semantic Pills
⋮----
// Last Check Spotlight Pill
⋮----
// Target Endpoints Cards List
⋮----
Widget _buildKpiBadge({
⋮----
Widget _buildTargetCard(
⋮----
// Target Header Row
⋮----
// Distinct Protocol Pill (TCP / HTTP / UDP)
⋮----
// Target Name & Endpoint address
⋮----
// Semantic Status Badge & Latency
⋮----
// Telemetry and Color-Coded Controls Row
⋮----
// Mini Latency History Sparkline, Last Check & Diagnostic Message
⋮----
// Last Check Badge per target
⋮----
// Dedicated Color-Coded Action Controls
⋮----
// 1. Single Probe Now (Sky Blue)
⋮----
// 2. Toggle Enable/Disable (Amber when pausing / Emerald when resuming)
⋮----
// 3. Edit Target (Sentinel Brand Accent)
⋮----
// 4. Delete Target (Rose Coral)
⋮----
Widget _buildTargetActionBtn({
⋮----
Widget _buildSparklineBar(int? latencyMs, CyberdeckConfig config) {
⋮----
Widget _buildEmptyState(
⋮----
static Color _getStatusColor(ProbeStatus status) {
⋮----
static Color _getProtocolColor(ProbeProtocol proto) {
```

## File: lib/features/health_checker/widgets/target_modal_dialog.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../models/health_target_model.dart';
import '../providers/health_checker_provider.dart';
import '../services/probe_service.dart';
⋮----
class TargetModalDialog extends ConsumerStatefulWidget {
⋮----
const TargetModalDialog({super.key, this.target});
⋮----
ConsumerState<TargetModalDialog> createState() => _TargetModalDialogState();
⋮----
class _TargetModalDialogState extends ConsumerState<TargetModalDialog> {
⋮----
void initState() {
⋮----
void dispose() {
⋮----
void _applyPreset(
⋮----
HealthTargetModel _buildModel() {
⋮----
Future<void> _runConnectionTest() async {
⋮----
void _saveTarget() {
⋮----
Widget build(BuildContext context) {
⋮----
// Header
⋮----
// Presets selector
⋮----
// Protocol Selector
⋮----
// Target Name
⋮----
// Host & Port
⋮----
// HTTP specific fields
⋮----
// Timeout
⋮----
// Live Connectivity Test Button & Result
⋮----
// Bottom Actions
⋮----
Widget _buildTextField({
⋮----
static Color _getProtocolColor(ProbeProtocol proto) {
⋮----
static Widget _buildProtocolBadge(ProbeProtocol proto) {
```

## File: lib/features/launcher/launcher_screen.dart
```dart
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
⋮----
class LauncherScreen extends ConsumerStatefulWidget {
const LauncherScreen({super.key});
⋮----
ConsumerState<LauncherScreen> createState() => _LauncherScreenState();
⋮----
class _LauncherScreenState extends ConsumerState<LauncherScreen>
⋮----
void initState() {
⋮----
Future<void> _enforceImmersiveMode() async {
⋮----
void didChangeAppLifecycleState(AppLifecycleState state) {
⋮----
// Incremental package & icon pack synchronization on resume from background
⋮----
void dispose() {
⋮----
Widget build(BuildContext context) {
⋮----
Widget _buildTacticalConsolePage(CyberdeckConfig config) {
```

## File: lib/features/monitor/monitor_screen.dart
```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../services/device_service.dart';
import '../apps/apps_provider.dart';
⋮----
/// Periodic lightweight system telemetry provider (updates every 6s when active)
⋮----
class MonitorScreen extends ConsumerWidget {
const MonitorScreen({super.key});
⋮----
Widget build(BuildContext context, WidgetRef ref) {
⋮----
Widget _buildSpecRow(
⋮----
Widget _buildTelemetryCard({
```

## File: lib/features/network/ping_screen.dart
```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
⋮----
class PingScreen extends ConsumerStatefulWidget {
const PingScreen({super.key});
⋮----
ConsumerState<PingScreen> createState() => _PingScreenState();
⋮----
class _PingScreenState extends ConsumerState<PingScreen> {
⋮----
Future<void> _runPing() async {
⋮----
void dispose() {
⋮----
Widget build(BuildContext context) {
```

## File: lib/features/settings/settings_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/cyber_tap_target.dart';
import '../../services/device_service.dart';
import '../apps/apps_provider.dart';
import '../monitor/monitor_screen.dart';
⋮----
class SettingsScreen extends ConsumerStatefulWidget {
const SettingsScreen({super.key});
⋮----
ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
⋮----
class _SettingsScreenState extends ConsumerState<SettingsScreen> {
⋮----
Future<void> _selectIconPack(String? packageName, String label) async {
⋮----
Future<void> _toggleIconMasking(bool enabled) async {
⋮----
Widget build(BuildContext context) {
⋮----
// 1. Apariencia, Paleta de Tema, Acento Primario y Color de Destacado Puntual
⋮----
// 2. Tipografía del Sistema y del Reloj
⋮----
// 3. Icon Packs Section
⋮----
// 4. Android Home Launcher & Permissions
⋮----
// 5. Density & Clock Format
⋮----
// 6. Show / Hide & Reorder Modules
⋮----
// 7. Default File Manager
⋮----
Widget _buildTypographySection(
⋮----
Widget _buildColorSwatchChip({
⋮----
Widget _buildIconPacksSection(CyberdeckConfig config, Color accent) {
⋮----
// Option 0: System Default Icons
⋮----
Widget _buildIconPackTile({
⋮----
Widget _buildModeOption({
⋮----
Widget _buildActionButton({
⋮----
Widget _buildSectionHeader(String title, CyberdeckConfig config) {
⋮----
Widget _buildCard({required CyberdeckConfig config, required Widget child}) {
⋮----
Widget _buildPresetChip({
⋮----
Widget _buildDensityBtn({
⋮----
Widget _buildFileManagerSelector(
```

## File: lib/features/shortcuts/shortcut_dialog.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import 'shortcut_model.dart';
import 'shortcuts_provider.dart';
⋮----
class ShortcutDialog extends ConsumerStatefulWidget {
⋮----
const ShortcutDialog({super.key, this.shortcut});
⋮----
ConsumerState<ShortcutDialog> createState() => _ShortcutDialogState();
⋮----
class _ShortcutDialogState extends ConsumerState<ShortcutDialog> {
⋮----
void initState() {
⋮----
void _applyPreset(String presetTitle) {
⋮----
void dispose() {
⋮----
void _save() async {
⋮----
Widget build(BuildContext context) {
```

## File: lib/features/shortcuts/shortcut_model.dart
```dart
class ShortcutModel {
⋮----
final String type; // 'url', 'ssh', 'cmd', 'app'
final String value; // e.g. 'https://...', 'user@ip', 'docker ps'
⋮----
ShortcutModel({
    this.id,
    required this.title,
    required this.type,
    required this.value,
    this.iconData,
  });
⋮----
Map<String, dynamic> toMap() {
⋮----
factory ShortcutModel.fromMap(Map<String, dynamic> map) {
```

## File: lib/features/shortcuts/shortcuts_provider.dart
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/database_service.dart';
import 'shortcut_model.dart';
```

## File: lib/features/tools/tools_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/cyber_tap_target.dart';
import '../apps/apps_provider.dart';
⋮----
class ToolsScreen extends ConsumerWidget {
const ToolsScreen({super.key});
⋮----
Widget build(BuildContext context, WidgetRef ref) {
⋮----
Widget _buildToolItem({
```

## File: lib/features/vpn/vpn_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import '../apps/apps_provider.dart';
⋮----
class VpnScreen extends ConsumerWidget {
const VpnScreen({super.key});
⋮----
Widget build(BuildContext context, WidgetRef ref) {
```

## File: lib/services/database_service.dart
```dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../features/shortcuts/shortcut_model.dart';
⋮----
class DatabaseService {
⋮----
Future<Database> get database async {
⋮----
Future<Database> _initDB() async {
⋮----
version: 3, // upgraded version
⋮----
Future<void> _createShortcutsTable(Database db) async {
⋮----
Future<int> insertShortcut(ShortcutModel shortcut) async {
⋮----
Future<void> deleteShortcut(int id) async {
⋮----
Future<List<ShortcutModel>> getShortcuts() async {
```

## File: lib/services/device_service.dart
```dart
import 'dart:async';
import 'package:flutter/services.dart';
⋮----
class InstalledApp {
⋮----
const InstalledApp({
    required this.packageName,
    this.activityName = '',
    required this.name,
    this.versionCode = 0,
    this.lastUpdateTime = 0,
    this.isSystemApp = false,
    this.icon,
  });
⋮----
factory InstalledApp.fromMap(Map<dynamic, dynamic> map) {
⋮----
InstalledApp copyWith({
⋮----
class IconPackInfo {
⋮----
const IconPackInfo({
    required this.packageName,
    required this.name,
    this.icon,
    this.isSelected = false,
    this.isIWhite = false,
  });
⋮----
factory IconPackInfo.fromMap(Map<dynamic, dynamic> map) {
⋮----
class AlternativeIconItem {
⋮----
const AlternativeIconItem({
    required this.drawableName,
    required this.icon,
  });
⋮----
factory AlternativeIconItem.fromMap(Map<dynamic, dynamic> map) {
⋮----
class PackageChangeEvent {
final String type; // 'added' | 'removed' | 'updated' | 'changed'
⋮----
const PackageChangeEvent({
    required this.type,
    required this.packageName,
    required this.isReplacing,
    this.app,
    this.isIconPack = false,
    this.selectedIconPack,
  });
⋮----
factory PackageChangeEvent.fromMap(Map<dynamic, dynamic> map) {
⋮----
class CalendarEventItem {
⋮----
const CalendarEventItem({
    required this.title,
    required this.begin,
    required this.end,
    required this.allDay,
    required this.location,
  });
⋮----
factory CalendarEventItem.fromMap(Map<dynamic, dynamic> map) {
⋮----
class SystemNotificationItem {
⋮----
const SystemNotificationItem({
    required this.key,
    required this.packageName,
    required this.title,
    required this.text,
    required this.postTime,
  });
⋮----
factory SystemNotificationItem.fromMap(Map<dynamic, dynamic> map) {
⋮----
class DeviceService {
⋮----
DeviceService() {
⋮----
static void _ensureMethodCallHandler() {
⋮----
Stream<PackageChangeEvent> get packageEvents => _packageEventsController.stream;
⋮----
Future<List<InstalledApp>> getInstalledApps({bool forceRefresh = false}) async {
⋮----
Future<InstalledApp?> getSingleApp(String packageName) async {
⋮----
Future<List<IconPackInfo>> getInstalledIconPacks() async {
⋮----
Future<({String? selectedIconPack, bool maskUnthemed})> getSelectedIconPackInfo() async {
⋮----
Future<bool> setSelectedIconPack(String? packageName) async {
⋮----
Future<bool> setIconMasking(bool enabled) async {
⋮----
Future<List<AlternativeIconItem>> getAlternativeIcons(
⋮----
Future<InstalledApp?> setCustomAppIcon(
⋮----
Future<bool> uninstallApp(String packageName) async {
⋮----
Future<bool> launchApp(String packageName) async {
⋮----
Future<bool> launchAppByKeyword(String keyword) async {
⋮----
Future<Uint8List?> getAppIcon(String packageName) async {
⋮----
Future<bool> openAppInfo(String packageName) async {
⋮----
Future<bool> openVpnSettings() async {
⋮----
Future<bool> openWifiSettings() async {
⋮----
Future<bool> openBluetoothSettings() async {
⋮----
Future<bool> openDisplaySettings() async {
⋮----
Future<bool> openSystemSettings() async {
⋮----
Future<bool> openHomeSettings() async {
⋮----
Future<bool> openBrowser({String? url}) async {
⋮----
Future<bool> openCamera() async {
⋮----
Future<bool> openFileManager({String? packageName}) async {
⋮----
Future<Map<String, dynamic>> toggleFlashlight() async {
⋮----
Future<Map<String, dynamic>> mediaControl(String action) async {
⋮----
Future<Map<String, dynamic>> setImmersiveMode(bool enable) async {
⋮----
Future<Map<String, dynamic>> getImmersiveStatus() async {
⋮----
Future<Map<String, dynamic>> getMonitorStats() async {
⋮----
Future<({bool authorized, List<CalendarEventItem> events})> getCalendarEvents() async {
⋮----
Future<bool> requestCalendarPermission() async {
⋮----
Future<bool> requestLocationPermission() async {
⋮----
Future<({bool authorized, List<String> packages})> getUsageRecentApps() async {
⋮----
Future<bool> openUsageAccessSettings() async {
⋮----
getActiveNotifications() async {
⋮----
Future<bool> openNotificationAccessSettings() async {
```

## File: lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/cyberdeck_config_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/launcher/launcher_screen.dart';
⋮----
void main() async {
⋮----
class CFSSHLauncherApp extends ConsumerWidget {
const CFSSHLauncherApp({super.key});
⋮----
Widget build(BuildContext context, WidgetRef ref) {
```

## File: linux/flutter/CMakeLists.txt
```
# This file controls Flutter-level build steps. It should not be edited.
cmake_minimum_required(VERSION 3.10)

set(EPHEMERAL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/ephemeral")

# Configuration provided via flutter tool.
include(${EPHEMERAL_DIR}/generated_config.cmake)

# TODO: Move the rest of this into files in ephemeral. See
# https://github.com/flutter/flutter/issues/57146.

# Serves the same purpose as list(TRANSFORM ... PREPEND ...),
# which isn't available in 3.10.
function(list_prepend LIST_NAME PREFIX)
    set(NEW_LIST "")
    foreach(element ${${LIST_NAME}})
        list(APPEND NEW_LIST "${PREFIX}${element}")
    endforeach(element)
    set(${LIST_NAME} "${NEW_LIST}" PARENT_SCOPE)
endfunction()

# === Flutter Library ===
# System-level dependencies.
find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK REQUIRED IMPORTED_TARGET gtk+-3.0)
pkg_check_modules(GLIB REQUIRED IMPORTED_TARGET glib-2.0)
pkg_check_modules(GIO REQUIRED IMPORTED_TARGET gio-2.0)

set(FLUTTER_LIBRARY "${EPHEMERAL_DIR}/libflutter_linux_gtk.so")

# Published to parent scope for install step.
set(FLUTTER_LIBRARY ${FLUTTER_LIBRARY} PARENT_SCOPE)
set(FLUTTER_ICU_DATA_FILE "${EPHEMERAL_DIR}/icudtl.dat" PARENT_SCOPE)
set(PROJECT_BUILD_DIR "${PROJECT_DIR}/build/" PARENT_SCOPE)
set(AOT_LIBRARY "${PROJECT_DIR}/build/lib/libapp.so" PARENT_SCOPE)

list(APPEND FLUTTER_LIBRARY_HEADERS
  "fl_basic_message_channel.h"
  "fl_binary_codec.h"
  "fl_binary_messenger.h"
  "fl_dart_project.h"
  "fl_engine.h"
  "fl_json_message_codec.h"
  "fl_json_method_codec.h"
  "fl_message_codec.h"
  "fl_method_call.h"
  "fl_method_channel.h"
  "fl_method_codec.h"
  "fl_method_response.h"
  "fl_plugin_registrar.h"
  "fl_plugin_registry.h"
  "fl_standard_message_codec.h"
  "fl_standard_method_codec.h"
  "fl_string_codec.h"
  "fl_value.h"
  "fl_view.h"
  "flutter_linux.h"
)
list_prepend(FLUTTER_LIBRARY_HEADERS "${EPHEMERAL_DIR}/flutter_linux/")
add_library(flutter INTERFACE)
target_include_directories(flutter INTERFACE
  "${EPHEMERAL_DIR}"
)
target_link_libraries(flutter INTERFACE "${FLUTTER_LIBRARY}")
target_link_libraries(flutter INTERFACE
  PkgConfig::GTK
  PkgConfig::GLIB
  PkgConfig::GIO
)
add_dependencies(flutter flutter_assemble)

# === Flutter tool backend ===
# _phony_ is a non-existent file to force this command to run every time,
# since currently there's no way to get a full input/output list from the
# flutter tool.
add_custom_command(
  OUTPUT ${FLUTTER_LIBRARY} ${FLUTTER_LIBRARY_HEADERS}
    ${CMAKE_CURRENT_BINARY_DIR}/_phony_
  COMMAND ${CMAKE_COMMAND} -E env
    ${FLUTTER_TOOL_ENVIRONMENT}
    "${FLUTTER_ROOT}/packages/flutter_tools/bin/tool_backend.sh"
      ${FLUTTER_TARGET_PLATFORM} ${CMAKE_BUILD_TYPE}
  VERBATIM
)
add_custom_target(flutter_assemble DEPENDS
  "${FLUTTER_LIBRARY}"
  ${FLUTTER_LIBRARY_HEADERS}
)
```

## File: linux/flutter/generated_plugin_registrant.cc
```cpp
//
//  Generated file. Do not edit.
//
// clang-format off
#include "generated_plugin_registrant.h"
void fl_register_plugins(FlPluginRegistry* registry) {
}
```

## File: linux/flutter/generated_plugin_registrant.h
```c
//
//  Generated file. Do not edit.
⋮----
// clang-format off
⋮----
// Registers Flutter plugins.
void fl_register_plugins(FlPluginRegistry* registry);
⋮----
#endif  // GENERATED_PLUGIN_REGISTRANT_
```

## File: linux/flutter/generated_plugins.cmake
```cmake
#
# Generated file, do not edit.
#

list(APPEND FLUTTER_PLUGIN_LIST
)

list(APPEND FLUTTER_FFI_PLUGIN_LIST
  jni
)

set(PLUGIN_BUNDLED_LIBRARIES)

foreach(plugin ${FLUTTER_PLUGIN_LIST})
  add_subdirectory(flutter/ephemeral/.plugin_symlinks/${plugin}/linux plugins/${plugin})
  target_link_libraries(${BINARY_NAME} PRIVATE ${plugin}_plugin)
  list(APPEND PLUGIN_BUNDLED_LIBRARIES $<TARGET_FILE:${plugin}_plugin>)
  list(APPEND PLUGIN_BUNDLED_LIBRARIES ${${plugin}_bundled_libraries})
endforeach(plugin)

foreach(ffi_plugin ${FLUTTER_FFI_PLUGIN_LIST})
  add_subdirectory(flutter/ephemeral/.plugin_symlinks/${ffi_plugin}/linux plugins/${ffi_plugin})
  list(APPEND PLUGIN_BUNDLED_LIBRARIES ${${ffi_plugin}_bundled_libraries})
endforeach(ffi_plugin)
```

## File: linux/runner/CMakeLists.txt
```
cmake_minimum_required(VERSION 3.13)
project(runner LANGUAGES CXX)

# Define the application target. To change its name, change BINARY_NAME in the
# top-level CMakeLists.txt, not the value here, or `flutter run` will no longer
# work.
#
# Any new source files that you add to the application should be added here.
add_executable(${BINARY_NAME}
  "main.cc"
  "my_application.cc"
  "${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc"
)

# Apply the standard set of build settings. This can be removed for applications
# that need different build settings.
apply_standard_settings(${BINARY_NAME})

# Add preprocessor definitions for the application ID.
add_definitions(-DAPPLICATION_ID="${APPLICATION_ID}")

# Add dependency libraries. Add any application-specific dependencies here.
target_link_libraries(${BINARY_NAME} PRIVATE flutter)
target_link_libraries(${BINARY_NAME} PRIVATE PkgConfig::GTK)

target_include_directories(${BINARY_NAME} PRIVATE "${CMAKE_SOURCE_DIR}")
```

## File: linux/runner/main.cc
```cpp
#include "my_application.h"
int main(int argc, char** argv) {
  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
```

## File: linux/runner/my_application.cc
```cpp
#include "my_application.h"
#include <flutter_linux/flutter_linux.h>
#ifdef GDK_WINDOWING_X11
#include <gdk/gdkx.h>
#endif
#include "flutter/generated_plugin_registrant.h"
struct _MyApplication {
  GtkApplication parent_instance;
  char** dart_entrypoint_arguments;
};
G_DEFINE_TYPE(MyApplication, my_application, GTK_TYPE_APPLICATION)
// Called when first Flutter frame received.
static void first_frame_cb(MyApplication* self, FlView* view) {
  gtk_widget_show(gtk_widget_get_toplevel(GTK_WIDGET(view)));
}
// Implements GApplication::activate.
static void my_application_activate(GApplication* application) {
  MyApplication* self = MY_APPLICATION(application);
  GtkWindow* window =
      GTK_WINDOW(gtk_application_window_new(GTK_APPLICATION(application)));
  // Use a header bar when running in GNOME as this is the common style used
  // by applications and is the setup most users will be using (e.g. Ubuntu
  // desktop).
  // If running on X and not using GNOME then just use a traditional title bar
  // in case the window manager does more exotic layout, e.g. tiling.
  // If running on Wayland assume the header bar will work (may need changing
  // if future cases occur).
  gboolean use_header_bar = TRUE;
#ifdef GDK_WINDOWING_X11
  GdkScreen* screen = gtk_window_get_screen(window);
  if (GDK_IS_X11_SCREEN(screen)) {
    const gchar* wm_name = gdk_x11_screen_get_window_manager_name(screen);
    if (g_strcmp0(wm_name, "GNOME Shell") != 0) {
      use_header_bar = FALSE;
    }
  }
#endif
  if (use_header_bar) {
    GtkHeaderBar* header_bar = GTK_HEADER_BAR(gtk_header_bar_new());
    gtk_widget_show(GTK_WIDGET(header_bar));
    gtk_header_bar_set_title(header_bar, "launcher");
    gtk_header_bar_set_show_close_button(header_bar, TRUE);
    gtk_window_set_titlebar(window, GTK_WIDGET(header_bar));
  } else {
    gtk_window_set_title(window, "launcher");
  }
  gtk_window_set_default_size(window, 1280, 720);
  g_autoptr(FlDartProject) project = fl_dart_project_new();
  fl_dart_project_set_dart_entrypoint_arguments(
      project, self->dart_entrypoint_arguments);
  FlView* view = fl_view_new(project);
  GdkRGBA background_color;
  // Background defaults to black, override it here if necessary, e.g. #00000000
  // for transparent.
  gdk_rgba_parse(&background_color, "#000000");
  fl_view_set_background_color(view, &background_color);
  gtk_widget_show(GTK_WIDGET(view));
  gtk_container_add(GTK_CONTAINER(window), GTK_WIDGET(view));
  // Show the window when Flutter renders.
  // Requires the view to be realized so we can start rendering.
  g_signal_connect_swapped(view, "first-frame", G_CALLBACK(first_frame_cb),
                           self);
  gtk_widget_realize(GTK_WIDGET(view));
  fl_register_plugins(FL_PLUGIN_REGISTRY(view));
  gtk_widget_grab_focus(GTK_WIDGET(view));
}
// Implements GApplication::local_command_line.
static gboolean my_application_local_command_line(GApplication* application,
                                                  gchar*** arguments,
                                                  int* exit_status) {
  MyApplication* self = MY_APPLICATION(application);
  // Strip out the first argument as it is the binary name.
  self->dart_entrypoint_arguments = g_strdupv(*arguments + 1);
  g_autoptr(GError) error = nullptr;
  if (!g_application_register(application, nullptr, &error)) {
    g_warning("Failed to register: %s", error->message);
    *exit_status = 1;
    return TRUE;
  }
  g_application_activate(application);
  *exit_status = 0;
  return TRUE;
}
// Implements GApplication::startup.
static void my_application_startup(GApplication* application) {
  // MyApplication* self = MY_APPLICATION(object);
  // Perform any actions required at application startup.
  G_APPLICATION_CLASS(my_application_parent_class)->startup(application);
}
// Implements GApplication::shutdown.
static void my_application_shutdown(GApplication* application) {
  // MyApplication* self = MY_APPLICATION(object);
  // Perform any actions required at application shutdown.
  G_APPLICATION_CLASS(my_application_parent_class)->shutdown(application);
}
// Implements GObject::dispose.
static void my_application_dispose(GObject* object) {
  MyApplication* self = MY_APPLICATION(object);
  g_clear_pointer(&self->dart_entrypoint_arguments, g_strfreev);
  G_OBJECT_CLASS(my_application_parent_class)->dispose(object);
}
static void my_application_class_init(MyApplicationClass* klass) {
  G_APPLICATION_CLASS(klass)->activate = my_application_activate;
  G_APPLICATION_CLASS(klass)->local_command_line =
      my_application_local_command_line;
  G_APPLICATION_CLASS(klass)->startup = my_application_startup;
  G_APPLICATION_CLASS(klass)->shutdown = my_application_shutdown;
  G_OBJECT_CLASS(klass)->dispose = my_application_dispose;
}
static void my_application_init(MyApplication* self) {}
MyApplication* my_application_new() {
  // Set the program name to the application ID, which helps various systems
  // like GTK and desktop environments map this running application to its
  // corresponding .desktop file. This ensures better integration by allowing
  // the application to be recognized beyond its binary name.
  g_set_prgname(APPLICATION_ID);
  return MY_APPLICATION(g_object_new(my_application_get_type(),
                                     "application-id", APPLICATION_ID, "flags",
                                     G_APPLICATION_NON_UNIQUE, nullptr));
}
```

## File: linux/runner/my_application.h
```c
/**
 * my_application_new:
 *
 * Creates a new Flutter-based application.
 *
 * Returns: a new #MyApplication.
 */
MyApplication* my_application_new();
⋮----
#endif  // FLUTTER_MY_APPLICATION_H_
```

## File: linux/.gitignore
```
flutter/ephemeral
```

## File: linux/CMakeLists.txt
```
# Project-level configuration.
cmake_minimum_required(VERSION 3.13)
project(runner LANGUAGES CXX)

# The name of the executable created for the application. Change this to change
# the on-disk name of your application.
set(BINARY_NAME "launcher")
# The unique GTK application identifier for this application. See:
# https://wiki.gnome.org/HowDoI/ChooseApplicationID
set(APPLICATION_ID "com.cfssh.launcher")

# Explicitly opt in to modern CMake behaviors to avoid warnings with recent
# versions of CMake.
cmake_policy(SET CMP0063 NEW)

# Load bundled libraries from the lib/ directory relative to the binary.
set(CMAKE_INSTALL_RPATH "$ORIGIN/lib")

# Root filesystem for cross-building.
if(FLUTTER_TARGET_PLATFORM_SYSROOT)
  set(CMAKE_SYSROOT ${FLUTTER_TARGET_PLATFORM_SYSROOT})
  set(CMAKE_FIND_ROOT_PATH ${CMAKE_SYSROOT})
  set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
  set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
  set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
  set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
endif()

# Define build configuration options.
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE "Debug" CACHE
    STRING "Flutter build mode" FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
    "Debug" "Profile" "Release")
endif()

# Compilation settings that should be applied to most targets.
#
# Be cautious about adding new options here, as plugins use this function by
# default. In most cases, you should add new options to specific targets instead
# of modifying this function.
function(APPLY_STANDARD_SETTINGS TARGET)
  target_compile_features(${TARGET} PUBLIC cxx_std_14)
  target_compile_options(${TARGET} PRIVATE -Wall -Werror)
  target_compile_options(${TARGET} PRIVATE "$<$<NOT:$<CONFIG:Debug>>:-O3>")
  target_compile_definitions(${TARGET} PRIVATE "$<$<NOT:$<CONFIG:Debug>>:NDEBUG>")
endfunction()

# Flutter library and tool build rules.
set(FLUTTER_MANAGED_DIR "${CMAKE_CURRENT_SOURCE_DIR}/flutter")
add_subdirectory(${FLUTTER_MANAGED_DIR})

# System-level dependencies.
find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK REQUIRED IMPORTED_TARGET gtk+-3.0)

# Application build; see runner/CMakeLists.txt.
add_subdirectory("runner")

# Run the Flutter tool portions of the build. This must not be removed.
add_dependencies(${BINARY_NAME} flutter_assemble)

# Only the install-generated bundle's copy of the executable will launch
# correctly, since the resources must in the right relative locations. To avoid
# people trying to run the unbundled copy, put it in a subdirectory instead of
# the default top-level location.
set_target_properties(${BINARY_NAME}
  PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/intermediates_do_not_run"
)


# Generated plugin build rules, which manage building the plugins and adding
# them to the application.
include(flutter/generated_plugins.cmake)


# === Installation ===
# By default, "installing" just makes a relocatable bundle in the build
# directory.
set(BUILD_BUNDLE_DIR "${PROJECT_BINARY_DIR}/bundle")
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "${BUILD_BUNDLE_DIR}" CACHE PATH "..." FORCE)
endif()

# Start with a clean build bundle directory every time.
install(CODE "
  file(REMOVE_RECURSE \"${BUILD_BUNDLE_DIR}/\")
  " COMPONENT Runtime)

set(INSTALL_BUNDLE_DATA_DIR "${CMAKE_INSTALL_PREFIX}/data")
set(INSTALL_BUNDLE_LIB_DIR "${CMAKE_INSTALL_PREFIX}/lib")

install(TARGETS ${BINARY_NAME} RUNTIME DESTINATION "${CMAKE_INSTALL_PREFIX}"
  COMPONENT Runtime)

install(FILES "${FLUTTER_ICU_DATA_FILE}" DESTINATION "${INSTALL_BUNDLE_DATA_DIR}"
  COMPONENT Runtime)

install(FILES "${FLUTTER_LIBRARY}" DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
  COMPONENT Runtime)

foreach(bundled_library ${PLUGIN_BUNDLED_LIBRARIES})
  install(FILES "${bundled_library}"
    DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
    COMPONENT Runtime)
endforeach(bundled_library)

# Copy the native assets provided by the build.dart from all packages.
set(NATIVE_ASSETS_DIR "${PROJECT_BUILD_DIR}native_assets/linux/")
install(DIRECTORY "${NATIVE_ASSETS_DIR}"
   DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
   COMPONENT Runtime)

# Fully re-copy the assets directory on each build to avoid having stale files
# from a previous install.
set(FLUTTER_ASSET_DIR_NAME "flutter_assets")
install(CODE "
  file(REMOVE_RECURSE \"${INSTALL_BUNDLE_DATA_DIR}/${FLUTTER_ASSET_DIR_NAME}\")
  " COMPONENT Runtime)
install(DIRECTORY "${PROJECT_BUILD_DIR}/${FLUTTER_ASSET_DIR_NAME}"
  DESTINATION "${INSTALL_BUNDLE_DATA_DIR}" COMPONENT Runtime)

# Install the AOT library on non-Debug builds only.
if(NOT CMAKE_BUILD_TYPE MATCHES "Debug")
  install(FILES "${AOT_LIBRARY}" DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
    COMPONENT Runtime)
endif()
```

## File: macos/Flutter/Flutter-Debug.xcconfig
```
#include "ephemeral/Flutter-Generated.xcconfig"
```

## File: macos/Flutter/Flutter-Release.xcconfig
```
#include "ephemeral/Flutter-Generated.xcconfig"
```

## File: macos/Flutter/GeneratedPluginRegistrant.swift
```swift
//
//  Generated file. Do not edit.
⋮----
func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
```

## File: macos/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json
```json
{
  "images" : [
    {
      "size" : "16x16",
      "idiom" : "mac",
      "filename" : "app_icon_16.png",
      "scale" : "1x"
    },
    {
      "size" : "16x16",
      "idiom" : "mac",
      "filename" : "app_icon_32.png",
      "scale" : "2x"
    },
    {
      "size" : "32x32",
      "idiom" : "mac",
      "filename" : "app_icon_32.png",
      "scale" : "1x"
    },
    {
      "size" : "32x32",
      "idiom" : "mac",
      "filename" : "app_icon_64.png",
      "scale" : "2x"
    },
    {
      "size" : "128x128",
      "idiom" : "mac",
      "filename" : "app_icon_128.png",
      "scale" : "1x"
    },
    {
      "size" : "128x128",
      "idiom" : "mac",
      "filename" : "app_icon_256.png",
      "scale" : "2x"
    },
    {
      "size" : "256x256",
      "idiom" : "mac",
      "filename" : "app_icon_256.png",
      "scale" : "1x"
    },
    {
      "size" : "256x256",
      "idiom" : "mac",
      "filename" : "app_icon_512.png",
      "scale" : "2x"
    },
    {
      "size" : "512x512",
      "idiom" : "mac",
      "filename" : "app_icon_512.png",
      "scale" : "1x"
    },
    {
      "size" : "512x512",
      "idiom" : "mac",
      "filename" : "app_icon_1024.png",
      "scale" : "2x"
    }
  ],
  "info" : {
    "version" : 1,
    "author" : "xcode"
  }
}
```

## File: macos/Runner/Base.lproj/MainMenu.xib
```
<?xml version="1.0" encoding="UTF-8"?>
<document type="com.apple.InterfaceBuilder3.Cocoa.XIB" version="3.0" toolsVersion="14490.70" targetRuntime="MacOSX.Cocoa" propertyAccessControl="none" useAutolayout="YES" customObjectInstantitationMethod="direct">
    <dependencies>
        <deployment identifier="macosx"/>
        <plugIn identifier="com.apple.InterfaceBuilder.CocoaPlugin" version="14490.70"/>
        <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
    </dependencies>
    <objects>
        <customObject id="-2" userLabel="File's Owner" customClass="NSApplication">
            <connections>
                <outlet property="delegate" destination="Voe-Tx-rLC" id="GzC-gU-4Uq"/>
            </connections>
        </customObject>
        <customObject id="-1" userLabel="First Responder" customClass="FirstResponder"/>
        <customObject id="-3" userLabel="Application" customClass="NSObject"/>
        <customObject id="Voe-Tx-rLC" customClass="AppDelegate" customModule="Runner" customModuleProvider="target">
            <connections>
                <outlet property="applicationMenu" destination="uQy-DD-JDr" id="XBo-yE-nKs"/>
                <outlet property="mainFlutterWindow" destination="QvC-M9-y7g" id="gIp-Ho-8D9"/>
            </connections>
        </customObject>
        <customObject id="YLy-65-1bz" customClass="NSFontManager"/>
        <menu title="Main Menu" systemMenu="main" id="AYu-sK-qS6">
            <items>
                <menuItem title="APP_NAME" id="1Xt-HY-uBw">
                    <modifierMask key="keyEquivalentModifierMask"/>
                    <menu key="submenu" title="APP_NAME" systemMenu="apple" id="uQy-DD-JDr">
                        <items>
                            <menuItem title="About APP_NAME" id="5kV-Vb-QxS">
                                <modifierMask key="keyEquivalentModifierMask"/>
                                <connections>
                                    <action selector="orderFrontStandardAboutPanel:" target="-1" id="Exp-CZ-Vem"/>
                                </connections>
                            </menuItem>
                            <menuItem isSeparatorItem="YES" id="VOq-y0-SEH"/>
                            <menuItem title="Preferences…" keyEquivalent="," id="BOF-NM-1cW"/>
                            <menuItem isSeparatorItem="YES" id="wFC-TO-SCJ"/>
                            <menuItem title="Services" id="NMo-om-nkz">
                                <modifierMask key="keyEquivalentModifierMask"/>
                                <menu key="submenu" title="Services" systemMenu="services" id="hz9-B4-Xy5"/>
                            </menuItem>
                            <menuItem isSeparatorItem="YES" id="4je-JR-u6R"/>
                            <menuItem title="Hide APP_NAME" keyEquivalent="h" id="Olw-nP-bQN">
                                <connections>
                                    <action selector="hide:" target="-1" id="PnN-Uc-m68"/>
                                </connections>
                            </menuItem>
                            <menuItem title="Hide Others" keyEquivalent="h" id="Vdr-fp-XzO">
                                <modifierMask key="keyEquivalentModifierMask" option="YES" command="YES"/>
                                <connections>
                                    <action selector="hideOtherApplications:" target="-1" id="VT4-aY-XCT"/>
                                </connections>
                            </menuItem>
                            <menuItem title="Show All" id="Kd2-mp-pUS">
                                <modifierMask key="keyEquivalentModifierMask"/>
                                <connections>
                                    <action selector="unhideAllApplications:" target="-1" id="Dhg-Le-xox"/>
                                </connections>
                            </menuItem>
                            <menuItem isSeparatorItem="YES" id="kCx-OE-vgT"/>
                            <menuItem title="Quit APP_NAME" keyEquivalent="q" id="4sb-4s-VLi">
                                <connections>
                                    <action selector="terminate:" target="-1" id="Te7-pn-YzF"/>
                                </connections>
                            </menuItem>
                        </items>
                    </menu>
                </menuItem>
                <menuItem title="Edit" id="5QF-Oa-p0T">
                    <modifierMask key="keyEquivalentModifierMask"/>
                    <menu key="submenu" title="Edit" id="W48-6f-4Dl">
                        <items>
                            <menuItem title="Undo" keyEquivalent="z" id="dRJ-4n-Yzg">
                                <connections>
                                    <action selector="undo:" target="-1" id="M6e-cu-g7V"/>
                                </connections>
                            </menuItem>
                            <menuItem title="Redo" keyEquivalent="Z" id="6dh-zS-Vam">
                                <connections>
                                    <action selector="redo:" target="-1" id="oIA-Rs-6OD"/>
                                </connections>
                            </menuItem>
                            <menuItem isSeparatorItem="YES" id="WRV-NI-Exz"/>
                            <menuItem title="Cut" keyEquivalent="x" id="uRl-iY-unG">
                                <connections>
                                    <action selector="cut:" target="-1" id="YJe-68-I9s"/>
                                </connections>
                            </menuItem>
                            <menuItem title="Copy" keyEquivalent="c" id="x3v-GG-iWU">
                                <connections>
                                    <action selector="copy:" target="-1" id="G1f-GL-Joy"/>
                                </connections>
                            </menuItem>
                            <menuItem title="Paste" keyEquivalent="v" id="gVA-U4-sdL">
                                <connections>
                                    <action selector="paste:" target="-1" id="UvS-8e-Qdg"/>
                                </connections>
                            </menuItem>
                            <menuItem title="Paste and Match Style" keyEquivalent="V" id="WeT-3V-zwk">
                                <modifierMask key="keyEquivalentModifierMask" option="YES" command="YES"/>
                                <connections>
                                    <action selector="pasteAsPlainText:" target="-1" id="cEh-KX-wJQ"/>
                                </connections>
                            </menuItem>
                            <menuItem title="Delete" id="pa3-QI-u2k">
                                <modifierMask key="keyEquivalentModifierMask"/>
                                <connections>
                                    <action selector="delete:" target="-1" id="0Mk-Ml-PaM"/>
                                </connections>
                            </menuItem>
                            <menuItem title="Select All" keyEquivalent="a" id="Ruw-6m-B2m">
                                <connections>
                                    <action selector="selectAll:" target="-1" id="VNm-Mi-diN"/>
                                </connections>
                            </menuItem>
                            <menuItem isSeparatorItem="YES" id="uyl-h8-XO2"/>
                            <menuItem title="Find" id="4EN-yA-p0u">
                                <modifierMask key="keyEquivalentModifierMask"/>
                                <menu key="submenu" title="Find" id="1b7-l0-nxx">
                                    <items>
                                        <menuItem title="Find…" tag="1" keyEquivalent="f" id="Xz5-n4-O0W">
                                            <connections>
                                                <action selector="performFindPanelAction:" target="-1" id="cD7-Qs-BN4"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Find and Replace…" tag="12" keyEquivalent="f" id="YEy-JH-Tfz">
                                            <modifierMask key="keyEquivalentModifierMask" option="YES" command="YES"/>
                                            <connections>
                                                <action selector="performFindPanelAction:" target="-1" id="WD3-Gg-5AJ"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Find Next" tag="2" keyEquivalent="g" id="q09-fT-Sye">
                                            <connections>
                                                <action selector="performFindPanelAction:" target="-1" id="NDo-RZ-v9R"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Find Previous" tag="3" keyEquivalent="G" id="OwM-mh-QMV">
                                            <connections>
                                                <action selector="performFindPanelAction:" target="-1" id="HOh-sY-3ay"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Use Selection for Find" tag="7" keyEquivalent="e" id="buJ-ug-pKt">
                                            <connections>
                                                <action selector="performFindPanelAction:" target="-1" id="U76-nv-p5D"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Jump to Selection" keyEquivalent="j" id="S0p-oC-mLd">
                                            <connections>
                                                <action selector="centerSelectionInVisibleArea:" target="-1" id="IOG-6D-g5B"/>
                                            </connections>
                                        </menuItem>
                                    </items>
                                </menu>
                            </menuItem>
                            <menuItem title="Spelling and Grammar" id="Dv1-io-Yv7">
                                <modifierMask key="keyEquivalentModifierMask"/>
                                <menu key="submenu" title="Spelling" id="3IN-sU-3Bg">
                                    <items>
                                        <menuItem title="Show Spelling and Grammar" keyEquivalent=":" id="HFo-cy-zxI">
                                            <connections>
                                                <action selector="showGuessPanel:" target="-1" id="vFj-Ks-hy3"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Check Document Now" keyEquivalent=";" id="hz2-CU-CR7">
                                            <connections>
                                                <action selector="checkSpelling:" target="-1" id="fz7-VC-reM"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem isSeparatorItem="YES" id="bNw-od-mp5"/>
                                        <menuItem title="Check Spelling While Typing" id="rbD-Rh-wIN">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="toggleContinuousSpellChecking:" target="-1" id="7w6-Qz-0kB"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Check Grammar With Spelling" id="mK6-2p-4JG">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="toggleGrammarChecking:" target="-1" id="muD-Qn-j4w"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Correct Spelling Automatically" id="78Y-hA-62v">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="toggleAutomaticSpellingCorrection:" target="-1" id="2lM-Qi-WAP"/>
                                            </connections>
                                        </menuItem>
                                    </items>
                                </menu>
                            </menuItem>
                            <menuItem title="Substitutions" id="9ic-FL-obx">
                                <modifierMask key="keyEquivalentModifierMask"/>
                                <menu key="submenu" title="Substitutions" id="FeM-D8-WVr">
                                    <items>
                                        <menuItem title="Show Substitutions" id="z6F-FW-3nz">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="orderFrontSubstitutionsPanel:" target="-1" id="oku-mr-iSq"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem isSeparatorItem="YES" id="gPx-C9-uUO"/>
                                        <menuItem title="Smart Copy/Paste" id="9yt-4B-nSM">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="toggleSmartInsertDelete:" target="-1" id="3IJ-Se-DZD"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Smart Quotes" id="hQb-2v-fYv">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="toggleAutomaticQuoteSubstitution:" target="-1" id="ptq-xd-QOA"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Smart Dashes" id="rgM-f4-ycn">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="toggleAutomaticDashSubstitution:" target="-1" id="oCt-pO-9gS"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Smart Links" id="cwL-P1-jid">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="toggleAutomaticLinkDetection:" target="-1" id="Gip-E3-Fov"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Data Detectors" id="tRr-pd-1PS">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="toggleAutomaticDataDetection:" target="-1" id="R1I-Nq-Kbl"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Text Replacement" id="HFQ-gK-NFA">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="toggleAutomaticTextReplacement:" target="-1" id="DvP-Fe-Py6"/>
                                            </connections>
                                        </menuItem>
                                    </items>
                                </menu>
                            </menuItem>
                            <menuItem title="Transformations" id="2oI-Rn-ZJC">
                                <modifierMask key="keyEquivalentModifierMask"/>
                                <menu key="submenu" title="Transformations" id="c8a-y6-VQd">
                                    <items>
                                        <menuItem title="Make Upper Case" id="vmV-6d-7jI">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="uppercaseWord:" target="-1" id="sPh-Tk-edu"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Make Lower Case" id="d9M-CD-aMd">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="lowercaseWord:" target="-1" id="iUZ-b5-hil"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Capitalize" id="UEZ-Bs-lqG">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="capitalizeWord:" target="-1" id="26H-TL-nsh"/>
                                            </connections>
                                        </menuItem>
                                    </items>
                                </menu>
                            </menuItem>
                            <menuItem title="Speech" id="xrE-MZ-jX0">
                                <modifierMask key="keyEquivalentModifierMask"/>
                                <menu key="submenu" title="Speech" id="3rS-ZA-NoH">
                                    <items>
                                        <menuItem title="Start Speaking" id="Ynk-f8-cLZ">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="startSpeaking:" target="-1" id="654-Ng-kyl"/>
                                            </connections>
                                        </menuItem>
                                        <menuItem title="Stop Speaking" id="Oyz-dy-DGm">
                                            <modifierMask key="keyEquivalentModifierMask"/>
                                            <connections>
                                                <action selector="stopSpeaking:" target="-1" id="dX8-6p-jy9"/>
                                            </connections>
                                        </menuItem>
                                    </items>
                                </menu>
                            </menuItem>
                        </items>
                    </menu>
                </menuItem>
                <menuItem title="View" id="H8h-7b-M4v">
                    <modifierMask key="keyEquivalentModifierMask"/>
                    <menu key="submenu" title="View" id="HyV-fh-RgO">
                        <items>
                            <menuItem title="Enter Full Screen" keyEquivalent="f" id="4J7-dP-txa">
                                <modifierMask key="keyEquivalentModifierMask" control="YES" command="YES"/>
                                <connections>
                                    <action selector="toggleFullScreen:" target="-1" id="dU3-MA-1Rq"/>
                                </connections>
                            </menuItem>
                        </items>
                    </menu>
                </menuItem>
                <menuItem title="Window" id="aUF-d1-5bR">
                    <modifierMask key="keyEquivalentModifierMask"/>
                    <menu key="submenu" title="Window" systemMenu="window" id="Td7-aD-5lo">
                        <items>
                            <menuItem title="Minimize" keyEquivalent="m" id="OY7-WF-poV">
                                <connections>
                                    <action selector="performMiniaturize:" target="-1" id="VwT-WD-YPe"/>
                                </connections>
                            </menuItem>
                            <menuItem title="Zoom" id="R4o-n2-Eq4">
                                <modifierMask key="keyEquivalentModifierMask"/>
                                <connections>
                                    <action selector="performZoom:" target="-1" id="DIl-cC-cCs"/>
                                </connections>
                            </menuItem>
                            <menuItem isSeparatorItem="YES" id="eu3-7i-yIM"/>
                            <menuItem title="Bring All to Front" id="LE2-aR-0XJ">
                                <modifierMask key="keyEquivalentModifierMask"/>
                                <connections>
                                    <action selector="arrangeInFront:" target="-1" id="DRN-fu-gQh"/>
                                </connections>
                            </menuItem>
                        </items>
                    </menu>
                </menuItem>
                <menuItem title="Help" id="EPT-qC-fAb">
                    <modifierMask key="keyEquivalentModifierMask"/>
                    <menu key="submenu" title="Help" systemMenu="help" id="rJ0-wn-3NY"/>
                </menuItem>
            </items>
            <point key="canvasLocation" x="142" y="-258"/>
        </menu>
        <window title="APP_NAME" allowsToolTipsWhenApplicationIsInactive="NO" autorecalculatesKeyViewLoop="NO" releasedWhenClosed="NO" animationBehavior="default" id="QvC-M9-y7g" customClass="MainFlutterWindow" customModule="Runner" customModuleProvider="target">
            <windowStyleMask key="styleMask" titled="YES" closable="YES" miniaturizable="YES" resizable="YES"/>
            <rect key="contentRect" x="335" y="390" width="800" height="600"/>
            <rect key="screenRect" x="0.0" y="0.0" width="2560" height="1577"/>
            <view key="contentView" wantsLayer="YES" id="EiT-Mj-1SZ">
                <rect key="frame" x="0.0" y="0.0" width="800" height="600"/>
                <autoresizingMask key="autoresizingMask"/>
            </view>
        </window>
    </objects>
</document>
```

## File: macos/Runner/Configs/AppInfo.xcconfig
```
// Application-level settings for the Runner target.
//
// This may be replaced with something auto-generated from metadata (e.g., pubspec.yaml) in the
// future. If not, the values below would default to using the project name when this becomes a
// 'flutter create' template.

// The application's name. By default this is also the title of the Flutter window.
PRODUCT_NAME = launcher

// The application's bundle identifier
PRODUCT_BUNDLE_IDENTIFIER = com.cfssh.launcher

// The copyright displayed in application information
PRODUCT_COPYRIGHT = Copyright © 2026 com.cfssh. All rights reserved.
```

## File: macos/Runner/Configs/Debug.xcconfig
```
#include "../../Flutter/Flutter-Debug.xcconfig"
#include "Warnings.xcconfig"
```

## File: macos/Runner/Configs/Release.xcconfig
```
#include "../../Flutter/Flutter-Release.xcconfig"
#include "Warnings.xcconfig"
```

## File: macos/Runner/Configs/Warnings.xcconfig
```
WARNING_CFLAGS = -Wall -Wconditional-uninitialized -Wnullable-to-nonnull-conversion -Wmissing-method-return-type -Woverlength-strings
GCC_WARN_UNDECLARED_SELECTOR = YES
CLANG_UNDEFINED_BEHAVIOR_SANITIZER_NULLABILITY = YES
CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE
CLANG_WARN__DUPLICATE_METHOD_MATCH = YES
CLANG_WARN_PRAGMA_PACK = YES
CLANG_WARN_STRICT_PROTOTYPES = YES
CLANG_WARN_COMMA = YES
GCC_WARN_STRICT_SELECTOR_MATCH = YES
CLANG_WARN_OBJC_REPEATED_USE_OF_WEAK = YES
CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES
GCC_WARN_SHADOW = YES
CLANG_WARN_UNREACHABLE_CODE = YES
```

## File: macos/Runner/AppDelegate.swift
```swift
class AppDelegate: FlutterAppDelegate {
override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
⋮----
override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
```

## File: macos/Runner/DebugProfile.entitlements
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>com.apple.security.app-sandbox</key>
	<true/>
	<key>com.apple.security.cs.allow-jit</key>
	<true/>
	<key>com.apple.security.network.server</key>
	<true/>
</dict>
</plist>
```

## File: macos/Runner/Info.plist
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIconFile</key>
	<string></string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>$(PRODUCT_NAME)</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>$(FLUTTER_BUILD_NAME)</string>
	<key>CFBundleVersion</key>
	<string>$(FLUTTER_BUILD_NUMBER)</string>
	<key>LSMinimumSystemVersion</key>
	<string>$(MACOSX_DEPLOYMENT_TARGET)</string>
	<key>NSHumanReadableCopyright</key>
	<string>$(PRODUCT_COPYRIGHT)</string>
	<key>NSMainNibFile</key>
	<string>MainMenu</string>
	<key>NSPrincipalClass</key>
	<string>NSApplication</string>
</dict>
</plist>
```

## File: macos/Runner/MainFlutterWindow.swift
```swift
class MainFlutterWindow: NSWindow {
override func awakeFromNib() {
let flutterViewController = FlutterViewController()
let windowFrame = self.frame
```

## File: macos/Runner/Release.entitlements
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>com.apple.security.app-sandbox</key>
	<true/>
</dict>
</plist>
```

## File: macos/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>IDEDidComputeMac32BitWarning</key>
	<true/>
</dict>
</plist>
```

## File: macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme
```
<?xml version="1.0" encoding="UTF-8"?>
<Scheme
   LastUpgradeVersion = "1510"
   version = "1.3">
   <BuildAction
      parallelizeBuildables = "YES"
      buildImplicitDependencies = "YES">
      <PreActions>
         <ExecutionAction
            ActionType = "Xcode.IDEStandardExecutionActionsCore.ExecutionActionType.ShellScriptAction">
            <ActionContent
               title = "Run Prepare Flutter Framework Script"
               scriptText = "&quot;$FLUTTER_ROOT&quot;/packages/flutter_tools/bin/macos_assemble.sh prepare&#10;">
               <EnvironmentBuildable>
                  <BuildableReference
                     BuildableIdentifier = "primary"
                     BlueprintIdentifier = "33CC10EC2044A3C60003C045"
                     BuildableName = "launcher.app"
                     BlueprintName = "Runner"
                     ReferencedContainer = "container:Runner.xcodeproj">
                  </BuildableReference>
               </EnvironmentBuildable>
            </ActionContent>
         </ExecutionAction>
      </PreActions>
      <BuildActionEntries>
         <BuildActionEntry
            buildForTesting = "YES"
            buildForRunning = "YES"
            buildForProfiling = "YES"
            buildForArchiving = "YES"
            buildForAnalyzing = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "33CC10EC2044A3C60003C045"
               BuildableName = "launcher.app"
               BlueprintName = "Runner"
               ReferencedContainer = "container:Runner.xcodeproj">
            </BuildableReference>
         </BuildActionEntry>
      </BuildActionEntries>
   </BuildAction>
   <TestAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      shouldUseLaunchSchemeArgsEnv = "YES">
      <MacroExpansion>
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "33CC10EC2044A3C60003C045"
            BuildableName = "launcher.app"
            BlueprintName = "Runner"
            ReferencedContainer = "container:Runner.xcodeproj">
         </BuildableReference>
      </MacroExpansion>
      <Testables>
         <TestableReference
            skipped = "NO"
            parallelizable = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "331C80D4294CF70F00263BE5"
               BuildableName = "RunnerTests.xctest"
               BlueprintName = "RunnerTests"
               ReferencedContainer = "container:Runner.xcodeproj">
            </BuildableReference>
         </TestableReference>
      </Testables>
   </TestAction>
   <LaunchAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      launchStyle = "0"
      useCustomWorkingDirectory = "NO"
      ignoresPersistentStateOnLaunch = "NO"
      debugDocumentVersioning = "YES"
      debugServiceExtension = "internal"
      enableGPUValidationMode = "1"
      allowLocationSimulation = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "33CC10EC2044A3C60003C045"
            BuildableName = "launcher.app"
            BlueprintName = "Runner"
            ReferencedContainer = "container:Runner.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </LaunchAction>
   <ProfileAction
      buildConfiguration = "Profile"
      shouldUseLaunchSchemeArgsEnv = "YES"
      savedToolIdentifier = ""
      useCustomWorkingDirectory = "NO"
      debugDocumentVersioning = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "33CC10EC2044A3C60003C045"
            BuildableName = "launcher.app"
            BlueprintName = "Runner"
            ReferencedContainer = "container:Runner.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </ProfileAction>
   <AnalyzeAction
      buildConfiguration = "Debug">
   </AnalyzeAction>
   <ArchiveAction
      buildConfiguration = "Release"
      revealArchiveInOrganizer = "YES">
   </ArchiveAction>
</Scheme>
```

## File: macos/Runner.xcodeproj/project.pbxproj
```
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 54;
	objects = {

/* Begin PBXAggregateTarget section */
		33CC111A2044C6BA0003C045 /* Flutter Assemble */ = {
			isa = PBXAggregateTarget;
			buildConfigurationList = 33CC111B2044C6BA0003C045 /* Build configuration list for PBXAggregateTarget "Flutter Assemble" */;
			buildPhases = (
				33CC111E2044C6BF0003C045 /* ShellScript */,
			);
			dependencies = (
			);
			name = "Flutter Assemble";
			productName = FLX;
		};
/* End PBXAggregateTarget section */

/* Begin PBXBuildFile section */
		331C80D8294CF71000263BE5 /* RunnerTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 331C80D7294CF71000263BE5 /* RunnerTests.swift */; };
		335BBD1B22A9A15E00E9071D /* GeneratedPluginRegistrant.swift in Sources */ = {isa = PBXBuildFile; fileRef = 335BBD1A22A9A15E00E9071D /* GeneratedPluginRegistrant.swift */; };
		33CC10F12044A3C60003C045 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 33CC10F02044A3C60003C045 /* AppDelegate.swift */; };
		33CC10F32044A3C60003C045 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 33CC10F22044A3C60003C045 /* Assets.xcassets */; };
		33CC10F62044A3C60003C045 /* MainMenu.xib in Resources */ = {isa = PBXBuildFile; fileRef = 33CC10F42044A3C60003C045 /* MainMenu.xib */; };
		33CC11132044BFA00003C045 /* MainFlutterWindow.swift in Sources */ = {isa = PBXBuildFile; fileRef = 33CC11122044BFA00003C045 /* MainFlutterWindow.swift */; };
		78A318202AECB46A00862997 /* FlutterGeneratedPluginSwiftPackage in Frameworks */ = {isa = PBXBuildFile; productRef = 78A3181F2AECB46A00862997 /* FlutterGeneratedPluginSwiftPackage */; };
/* End PBXBuildFile section */

/* Begin PBXContainerItemProxy section */
		331C80D9294CF71000263BE5 /* PBXContainerItemProxy */ = {
			isa = PBXContainerItemProxy;
			containerPortal = 33CC10E52044A3C60003C045 /* Project object */;
			proxyType = 1;
			remoteGlobalIDString = 33CC10EC2044A3C60003C045;
			remoteInfo = Runner;
		};
		33CC111F2044C79F0003C045 /* PBXContainerItemProxy */ = {
			isa = PBXContainerItemProxy;
			containerPortal = 33CC10E52044A3C60003C045 /* Project object */;
			proxyType = 1;
			remoteGlobalIDString = 33CC111A2044C6BA0003C045;
			remoteInfo = FLX;
		};
/* End PBXContainerItemProxy section */

/* Begin PBXCopyFilesBuildPhase section */
		33CC110E2044A8840003C045 /* Bundle Framework */ = {
			isa = PBXCopyFilesBuildPhase;
			buildActionMask = 2147483647;
			dstPath = "";
			dstSubfolderSpec = 10;
			files = (
			);
			name = "Bundle Framework";
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXCopyFilesBuildPhase section */

/* Begin PBXFileReference section */
		331C80D5294CF71000263BE5 /* RunnerTests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = RunnerTests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
		331C80D7294CF71000263BE5 /* RunnerTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = RunnerTests.swift; sourceTree = "<group>"; };
		333000ED22D3DE5D00554162 /* Warnings.xcconfig */ = {isa = PBXFileReference; lastKnownFileType = text.xcconfig; path = Warnings.xcconfig; sourceTree = "<group>"; };
		335BBD1A22A9A15E00E9071D /* GeneratedPluginRegistrant.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = GeneratedPluginRegistrant.swift; sourceTree = "<group>"; };
		33CC10ED2044A3C60003C045 /* launcher.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "launcher.app"; sourceTree = BUILT_PRODUCTS_DIR; };
		33CC10F02044A3C60003C045 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "<group>"; };
		33CC10F22044A3C60003C045 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; name = Assets.xcassets; path = Runner/Assets.xcassets; sourceTree = "<group>"; };
		33CC10F52044A3C60003C045 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.xib; name = Base; path = Base.lproj/MainMenu.xib; sourceTree = "<group>"; };
		33CC10F72044A3C60003C045 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; name = Info.plist; path = Runner/Info.plist; sourceTree = "<group>"; };
		33CC11122044BFA00003C045 /* MainFlutterWindow.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = MainFlutterWindow.swift; sourceTree = "<group>"; };
		33CEB47222A05771004F2AC0 /* Flutter-Debug.xcconfig */ = {isa = PBXFileReference; lastKnownFileType = text.xcconfig; path = "Flutter-Debug.xcconfig"; sourceTree = "<group>"; };
		33CEB47422A05771004F2AC0 /* Flutter-Release.xcconfig */ = {isa = PBXFileReference; lastKnownFileType = text.xcconfig; path = "Flutter-Release.xcconfig"; sourceTree = "<group>"; };
		33CEB47722A0578A004F2AC0 /* Flutter-Generated.xcconfig */ = {isa = PBXFileReference; lastKnownFileType = text.xcconfig; name = "Flutter-Generated.xcconfig"; path = "ephemeral/Flutter-Generated.xcconfig"; sourceTree = "<group>"; };
		33E51913231747F40026EE4D /* DebugProfile.entitlements */ = {isa = PBXFileReference; lastKnownFileType = text.plist.entitlements; path = DebugProfile.entitlements; sourceTree = "<group>"; };
		33E51914231749380026EE4D /* Release.entitlements */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = text.plist.entitlements; path = Release.entitlements; sourceTree = "<group>"; };
		33E5194F232828860026EE4D /* AppInfo.xcconfig */ = {isa = PBXFileReference; lastKnownFileType = text.xcconfig; path = AppInfo.xcconfig; sourceTree = "<group>"; };
		78E0A7A72DC9AD7400C4905E /* FlutterGeneratedPluginSwiftPackage */ = {isa = PBXFileReference; lastKnownFileType = wrapper; name = FlutterGeneratedPluginSwiftPackage; path = ephemeral/Packages/FlutterGeneratedPluginSwiftPackage; sourceTree = "<group>"; };
		7AFA3C8E1D35360C0083082E /* Release.xcconfig */ = {isa = PBXFileReference; lastKnownFileType = text.xcconfig; path = Release.xcconfig; sourceTree = "<group>"; };
		9740EEB21CF90195004384FC /* Debug.xcconfig */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = text.xcconfig; path = Debug.xcconfig; sourceTree = "<group>"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		331C80D2294CF70F00263BE5 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		33CC10EA2044A3C60003C045 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
				78A318202AECB46A00862997 /* FlutterGeneratedPluginSwiftPackage in Frameworks */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		331C80D6294CF71000263BE5 /* RunnerTests */ = {
			isa = PBXGroup;
			children = (
				331C80D7294CF71000263BE5 /* RunnerTests.swift */,
			);
			path = RunnerTests;
			sourceTree = "<group>";
		};
		33BA886A226E78AF003329D5 /* Configs */ = {
			isa = PBXGroup;
			children = (
				33E5194F232828860026EE4D /* AppInfo.xcconfig */,
				9740EEB21CF90195004384FC /* Debug.xcconfig */,
				7AFA3C8E1D35360C0083082E /* Release.xcconfig */,
				333000ED22D3DE5D00554162 /* Warnings.xcconfig */,
			);
			path = Configs;
			sourceTree = "<group>";
		};
		33CC10E42044A3C60003C045 = {
			isa = PBXGroup;
			children = (
				33FAB671232836740065AC1E /* Runner */,
				33CEB47122A05771004F2AC0 /* Flutter */,
				331C80D6294CF71000263BE5 /* RunnerTests */,
				33CC10EE2044A3C60003C045 /* Products */,
				D73912EC22F37F3D000D13A0 /* Frameworks */,
			);
			sourceTree = "<group>";
		};
		33CC10EE2044A3C60003C045 /* Products */ = {
			isa = PBXGroup;
			children = (
				33CC10ED2044A3C60003C045 /* launcher.app */,
				331C80D5294CF71000263BE5 /* RunnerTests.xctest */,
			);
			name = Products;
			sourceTree = "<group>";
		};
		33CC11242044D66E0003C045 /* Resources */ = {
			isa = PBXGroup;
			children = (
				33CC10F22044A3C60003C045 /* Assets.xcassets */,
				33CC10F42044A3C60003C045 /* MainMenu.xib */,
				33CC10F72044A3C60003C045 /* Info.plist */,
			);
			name = Resources;
			path = ..;
			sourceTree = "<group>";
		};
		33CEB47122A05771004F2AC0 /* Flutter */ = {
			isa = PBXGroup;
			children = (
				78E0A7A72DC9AD7400C4905E /* FlutterGeneratedPluginSwiftPackage */,
				335BBD1A22A9A15E00E9071D /* GeneratedPluginRegistrant.swift */,
				33CEB47222A05771004F2AC0 /* Flutter-Debug.xcconfig */,
				33CEB47422A05771004F2AC0 /* Flutter-Release.xcconfig */,
				33CEB47722A0578A004F2AC0 /* Flutter-Generated.xcconfig */,
			);
			path = Flutter;
			sourceTree = "<group>";
		};
		33FAB671232836740065AC1E /* Runner */ = {
			isa = PBXGroup;
			children = (
				33CC10F02044A3C60003C045 /* AppDelegate.swift */,
				33CC11122044BFA00003C045 /* MainFlutterWindow.swift */,
				33E51913231747F40026EE4D /* DebugProfile.entitlements */,
				33E51914231749380026EE4D /* Release.entitlements */,
				33CC11242044D66E0003C045 /* Resources */,
				33BA886A226E78AF003329D5 /* Configs */,
			);
			path = Runner;
			sourceTree = "<group>";
		};
		D73912EC22F37F3D000D13A0 /* Frameworks */ = {
			isa = PBXGroup;
			children = (
			);
			name = Frameworks;
			sourceTree = "<group>";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		331C80D4294CF70F00263BE5 /* RunnerTests */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 331C80DE294CF71000263BE5 /* Build configuration list for PBXNativeTarget "RunnerTests" */;
			buildPhases = (
				331C80D1294CF70F00263BE5 /* Sources */,
				331C80D2294CF70F00263BE5 /* Frameworks */,
				331C80D3294CF70F00263BE5 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
				331C80DA294CF71000263BE5 /* PBXTargetDependency */,
			);
			name = RunnerTests;
			productName = RunnerTests;
			productReference = 331C80D5294CF71000263BE5 /* RunnerTests.xctest */;
			productType = "com.apple.product-type.bundle.unit-test";
		};
		33CC10EC2044A3C60003C045 /* Runner */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 33CC10FB2044A3C60003C045 /* Build configuration list for PBXNativeTarget "Runner" */;
			buildPhases = (
				33CC10E92044A3C60003C045 /* Sources */,
				33CC10EA2044A3C60003C045 /* Frameworks */,
				33CC10EB2044A3C60003C045 /* Resources */,
				33CC110E2044A8840003C045 /* Bundle Framework */,
				3399D490228B24CF009A79C7 /* ShellScript */,
			);
			buildRules = (
			);
			dependencies = (
				33CC11202044C79F0003C045 /* PBXTargetDependency */,
			);
			name = Runner;
			packageProductDependencies = (
				78A3181F2AECB46A00862997 /* FlutterGeneratedPluginSwiftPackage */,
			);
			productName = Runner;
			productReference = 33CC10ED2044A3C60003C045 /* launcher.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		33CC10E52044A3C60003C045 /* Project object */ = {
			isa = PBXProject;
			attributes = {
				BuildIndependentTargetsInParallel = YES;
				LastSwiftUpdateCheck = 0920;
				LastUpgradeCheck = 1510;
				ORGANIZATIONNAME = "";
				TargetAttributes = {
					331C80D4294CF70F00263BE5 = {
						CreatedOnToolsVersion = 14.0;
						TestTargetID = 33CC10EC2044A3C60003C045;
					};
					33CC10EC2044A3C60003C045 = {
						CreatedOnToolsVersion = 9.2;
						LastSwiftMigration = 1100;
						ProvisioningStyle = Automatic;
						SystemCapabilities = {
							com.apple.Sandbox = {
								enabled = 1;
							};
						};
					};
					33CC111A2044C6BA0003C045 = {
						CreatedOnToolsVersion = 9.2;
						ProvisioningStyle = Manual;
					};
				};
			};
			buildConfigurationList = 33CC10E82044A3C60003C045 /* Build configuration list for PBXProject "Runner" */;
			compatibilityVersion = "Xcode 9.3";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = 33CC10E42044A3C60003C045;
			packageReferences = (
				781AD8BC2B33823900A9FFBB /* XCLocalSwiftPackageReference "Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage" */,
			);
			productRefGroup = 33CC10EE2044A3C60003C045 /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				33CC10EC2044A3C60003C045 /* Runner */,
				331C80D4294CF70F00263BE5 /* RunnerTests */,
				33CC111A2044C6BA0003C045 /* Flutter Assemble */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		331C80D3294CF70F00263BE5 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		33CC10EB2044A3C60003C045 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				33CC10F32044A3C60003C045 /* Assets.xcassets in Resources */,
				33CC10F62044A3C60003C045 /* MainMenu.xib in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXShellScriptBuildPhase section */
		3399D490228B24CF009A79C7 /* ShellScript */ = {
			isa = PBXShellScriptBuildPhase;
			alwaysOutOfDate = 1;
			buildActionMask = 2147483647;
			files = (
			);
			inputFileListPaths = (
			);
			inputPaths = (
			);
			outputFileListPaths = (
			);
			outputPaths = (
			);
			runOnlyForDeploymentPostprocessing = 0;
			shellPath = /bin/sh;
			shellScript = "echo \"$PRODUCT_NAME.app\" > \"$PROJECT_DIR\"/Flutter/ephemeral/.app_filename && \"$FLUTTER_ROOT\"/packages/flutter_tools/bin/macos_assemble.sh embed\n";
		};
		33CC111E2044C6BF0003C045 /* ShellScript */ = {
			isa = PBXShellScriptBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			inputFileListPaths = (
				Flutter/ephemeral/FlutterInputs.xcfilelist,
			);
			inputPaths = (
				Flutter/ephemeral/tripwire,
			);
			outputFileListPaths = (
				Flutter/ephemeral/FlutterOutputs.xcfilelist,
			);
			outputPaths = (
			);
			runOnlyForDeploymentPostprocessing = 0;
			shellPath = /bin/sh;
			shellScript = "\"$FLUTTER_ROOT\"/packages/flutter_tools/bin/macos_assemble.sh && touch Flutter/ephemeral/tripwire";
		};
/* End PBXShellScriptBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		331C80D1294CF70F00263BE5 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				331C80D8294CF71000263BE5 /* RunnerTests.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		33CC10E92044A3C60003C045 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				33CC11132044BFA00003C045 /* MainFlutterWindow.swift in Sources */,
				33CC10F12044A3C60003C045 /* AppDelegate.swift in Sources */,
				335BBD1B22A9A15E00E9071D /* GeneratedPluginRegistrant.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXTargetDependency section */
		331C80DA294CF71000263BE5 /* PBXTargetDependency */ = {
			isa = PBXTargetDependency;
			target = 33CC10EC2044A3C60003C045 /* Runner */;
			targetProxy = 331C80D9294CF71000263BE5 /* PBXContainerItemProxy */;
		};
		33CC11202044C79F0003C045 /* PBXTargetDependency */ = {
			isa = PBXTargetDependency;
			target = 33CC111A2044C6BA0003C045 /* Flutter Assemble */;
			targetProxy = 33CC111F2044C79F0003C045 /* PBXContainerItemProxy */;
		};
/* End PBXTargetDependency section */

/* Begin PBXVariantGroup section */
		33CC10F42044A3C60003C045 /* MainMenu.xib */ = {
			isa = PBXVariantGroup;
			children = (
				33CC10F52044A3C60003C045 /* Base */,
			);
			name = MainMenu.xib;
			path = Runner;
			sourceTree = "<group>";
		};
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
		331C80DB294CF71000263BE5 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				BUNDLE_LOADER = "$(TEST_HOST)";
				CURRENT_PROJECT_VERSION = 1;
				GENERATE_INFOPLIST_FILE = YES;
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.cfssh.launcher.RunnerTests;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_VERSION = 5.0;
				TEST_HOST = "$(BUILT_PRODUCTS_DIR)/launcher.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/launcher";
			};
			name = Debug;
		};
		331C80DC294CF71000263BE5 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				BUNDLE_LOADER = "$(TEST_HOST)";
				CURRENT_PROJECT_VERSION = 1;
				GENERATE_INFOPLIST_FILE = YES;
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.cfssh.launcher.RunnerTests;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_VERSION = 5.0;
				TEST_HOST = "$(BUILT_PRODUCTS_DIR)/launcher.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/launcher";
			};
			name = Release;
		};
		331C80DD294CF71000263BE5 /* Profile */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				BUNDLE_LOADER = "$(TEST_HOST)";
				CURRENT_PROJECT_VERSION = 1;
				GENERATE_INFOPLIST_FILE = YES;
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.cfssh.launcher.RunnerTests;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_VERSION = 5.0;
				TEST_HOST = "$(BUILT_PRODUCTS_DIR)/launcher.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/launcher";
			};
			name = Profile;
		};
		338D0CE9231458BD00FA5F75 /* Profile */ = {
			isa = XCBuildConfiguration;
			baseConfigurationReference = 7AFA3C8E1D35360C0083082E /* Release.xcconfig */;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++14";
				CLANG_CXX_LIBRARY = "libc++";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CODE_SIGN_IDENTITY = "-";
				COPY_PHASE_STRIP = NO;
				DEAD_CODE_STRIPPING = YES;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = NO;
				GCC_C_LANGUAGE_STANDARD = gnu11;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				MACOSX_DEPLOYMENT_TARGET = 12.0;
				MTL_ENABLE_DEBUG_INFO = NO;
				SDKROOT = macosx;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_OPTIMIZATION_LEVEL = "-O";
			};
			name = Profile;
		};
		338D0CEA231458BD00FA5F75 /* Profile */ = {
			isa = XCBuildConfiguration;
			baseConfigurationReference = 33E5194F232828860026EE4D /* AppInfo.xcconfig */;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CLANG_ENABLE_MODULES = YES;
				CODE_SIGN_ENTITLEMENTS = Runner/DebugProfile.entitlements;
				CODE_SIGN_STYLE = Automatic;
				COMBINE_HIDPI_IMAGES = YES;
				INFOPLIST_FILE = Runner/Info.plist;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/../Frameworks",
				);
				PROVISIONING_PROFILE_SPECIFIER = "";
				SWIFT_VERSION = 5.0;
			};
			name = Profile;
		};
		338D0CEB231458BD00FA5F75 /* Profile */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				CODE_SIGN_STYLE = Manual;
				PRODUCT_NAME = "$(TARGET_NAME)";
			};
			name = Profile;
		};
		33CC10F92044A3C60003C045 /* Debug */ = {
			isa = XCBuildConfiguration;
			baseConfigurationReference = 9740EEB21CF90195004384FC /* Debug.xcconfig */;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++14";
				CLANG_CXX_LIBRARY = "libc++";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CODE_SIGN_IDENTITY = "-";
				COPY_PHASE_STRIP = NO;
				DEAD_CODE_STRIPPING = YES;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = NO;
				GCC_C_LANGUAGE_STANDARD = gnu11;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				MACOSX_DEPLOYMENT_TARGET = 12.0;
				MTL_ENABLE_DEBUG_INFO = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = macosx;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
			};
			name = Debug;
		};
		33CC10FA2044A3C60003C045 /* Release */ = {
			isa = XCBuildConfiguration;
			baseConfigurationReference = 7AFA3C8E1D35360C0083082E /* Release.xcconfig */;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++14";
				CLANG_CXX_LIBRARY = "libc++";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CODE_SIGN_IDENTITY = "-";
				COPY_PHASE_STRIP = NO;
				DEAD_CODE_STRIPPING = YES;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = NO;
				GCC_C_LANGUAGE_STANDARD = gnu11;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				MACOSX_DEPLOYMENT_TARGET = 12.0;
				MTL_ENABLE_DEBUG_INFO = NO;
				SDKROOT = macosx;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_OPTIMIZATION_LEVEL = "-O";
			};
			name = Release;
		};
		33CC10FC2044A3C60003C045 /* Debug */ = {
			isa = XCBuildConfiguration;
			baseConfigurationReference = 33E5194F232828860026EE4D /* AppInfo.xcconfig */;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CLANG_ENABLE_MODULES = YES;
				CODE_SIGN_ENTITLEMENTS = Runner/DebugProfile.entitlements;
				CODE_SIGN_STYLE = Automatic;
				COMBINE_HIDPI_IMAGES = YES;
				INFOPLIST_FILE = Runner/Info.plist;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/../Frameworks",
				);
				PROVISIONING_PROFILE_SPECIFIER = "";
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
				SWIFT_VERSION = 5.0;
			};
			name = Debug;
		};
		33CC10FD2044A3C60003C045 /* Release */ = {
			isa = XCBuildConfiguration;
			baseConfigurationReference = 33E5194F232828860026EE4D /* AppInfo.xcconfig */;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CLANG_ENABLE_MODULES = YES;
				CODE_SIGN_ENTITLEMENTS = Runner/Release.entitlements;
				CODE_SIGN_STYLE = Automatic;
				COMBINE_HIDPI_IMAGES = YES;
				INFOPLIST_FILE = Runner/Info.plist;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/../Frameworks",
				);
				PROVISIONING_PROFILE_SPECIFIER = "";
				SWIFT_VERSION = 5.0;
			};
			name = Release;
		};
		33CC111C2044C6BA0003C045 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				CODE_SIGN_STYLE = Manual;
				PRODUCT_NAME = "$(TARGET_NAME)";
			};
			name = Debug;
		};
		33CC111D2044C6BA0003C045 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				CODE_SIGN_STYLE = Automatic;
				PRODUCT_NAME = "$(TARGET_NAME)";
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		331C80DE294CF71000263BE5 /* Build configuration list for PBXNativeTarget "RunnerTests" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				331C80DB294CF71000263BE5 /* Debug */,
				331C80DC294CF71000263BE5 /* Release */,
				331C80DD294CF71000263BE5 /* Profile */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		33CC10E82044A3C60003C045 /* Build configuration list for PBXProject "Runner" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				33CC10F92044A3C60003C045 /* Debug */,
				33CC10FA2044A3C60003C045 /* Release */,
				338D0CE9231458BD00FA5F75 /* Profile */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		33CC10FB2044A3C60003C045 /* Build configuration list for PBXNativeTarget "Runner" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				33CC10FC2044A3C60003C045 /* Debug */,
				33CC10FD2044A3C60003C045 /* Release */,
				338D0CEA231458BD00FA5F75 /* Profile */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		33CC111B2044C6BA0003C045 /* Build configuration list for PBXAggregateTarget "Flutter Assemble" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				33CC111C2044C6BA0003C045 /* Debug */,
				33CC111D2044C6BA0003C045 /* Release */,
				338D0CEB231458BD00FA5F75 /* Profile */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */

/* Begin XCLocalSwiftPackageReference section */
		781AD8BC2B33823900A9FFBB /* XCLocalSwiftPackageReference "Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage" */ = {
			isa = XCLocalSwiftPackageReference;
			relativePath = Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage;
		};
/* End XCLocalSwiftPackageReference section */

/* Begin XCSwiftPackageProductDependency section */
		78A3181F2AECB46A00862997 /* FlutterGeneratedPluginSwiftPackage */ = {
			isa = XCSwiftPackageProductDependency;
			productName = FlutterGeneratedPluginSwiftPackage;
		};
/* End XCSwiftPackageProductDependency section */
	};
	rootObject = 33CC10E52044A3C60003C045 /* Project object */;
}
```

## File: macos/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>IDEDidComputeMac32BitWarning</key>
	<true/>
</dict>
</plist>
```

## File: macos/Runner.xcworkspace/contents.xcworkspacedata
```
<?xml version="1.0" encoding="UTF-8"?>
<Workspace
   version = "1.0">
   <FileRef
      location = "group:Runner.xcodeproj">
   </FileRef>
</Workspace>
```

## File: macos/RunnerTests/RunnerTests.swift
```swift
class RunnerTests: XCTestCase {
⋮----
func testExample() {
// If you add code to the Runner application, consider adding tests here.
// See https://developer.apple.com/documentation/xctest for more information about using XCTest.
```

## File: macos/.gitignore
```
# Flutter-related
**/Flutter/ephemeral/
**/Pods/

# Xcode-related
**/dgph
**/xcuserdata/
```

## File: web/index.html
```html
<!DOCTYPE html>
<html>
<head>
  <!--
    If you are serving your web app in a path other than the root, change the
    href value below to reflect the base path you are serving from.
    The path provided below has to start and end with a slash "/" in order for
    it to work correctly.
    For more details:
    * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base
    This is a placeholder for base href that will be replaced by the value of
    the `--base-href` argument provided to `flutter build`.
  -->
  <base href="$FLUTTER_BASE_HREF">
  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <meta name="description" content="A new Flutter project.">
  <!-- iOS meta tags & icons -->
  <meta name="mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="launcher">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">
  <!-- Favicon -->
  <link rel="icon" type="image/png" href="favicon.png"/>
  <title>launcher</title>
  <link rel="manifest" href="manifest.json">
</head>
<body>
  <!--
    You can customize the "flutter_bootstrap.js" script.
    This is useful to provide a custom configuration to the Flutter loader
    or to give the user feedback during the initialization process.
    For more details:
    * https://docs.flutter.dev/platform-integration/web/initialization
  -->
  <script src="flutter_bootstrap.js" async></script>
</body>
</html>
```

## File: web/manifest.json
```json
{
    "name": "launcher",
    "short_name": "launcher",
    "start_url": ".",
    "display": "standalone",
    "background_color": "#0175C2",
    "theme_color": "#0175C2",
    "description": "A new Flutter project.",
    "orientation": "portrait-primary",
    "prefer_related_applications": false,
    "icons": [
        {
            "src": "icons/Icon-192.png",
            "sizes": "192x192",
            "type": "image/png"
        },
        {
            "src": "icons/Icon-512.png",
            "sizes": "512x512",
            "type": "image/png"
        },
        {
            "src": "icons/Icon-maskable-192.png",
            "sizes": "192x192",
            "type": "image/png",
            "purpose": "maskable"
        },
        {
            "src": "icons/Icon-maskable-512.png",
            "sizes": "512x512",
            "type": "image/png",
            "purpose": "maskable"
        }
    ]
}
```

## File: windows/flutter/CMakeLists.txt
```
# This file controls Flutter-level build steps. It should not be edited.
cmake_minimum_required(VERSION 3.14)

set(EPHEMERAL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/ephemeral")

# Configuration provided via flutter tool.
include(${EPHEMERAL_DIR}/generated_config.cmake)

# TODO: Move the rest of this into files in ephemeral. See
# https://github.com/flutter/flutter/issues/57146.
set(WRAPPER_ROOT "${EPHEMERAL_DIR}/cpp_client_wrapper")

# Set fallback configurations for older versions of the flutter tool.
if (NOT DEFINED FLUTTER_TARGET_PLATFORM)
  set(FLUTTER_TARGET_PLATFORM "windows-x64")
endif()

# === Flutter Library ===
set(FLUTTER_LIBRARY "${EPHEMERAL_DIR}/flutter_windows.dll")

# Published to parent scope for install step.
set(FLUTTER_LIBRARY ${FLUTTER_LIBRARY} PARENT_SCOPE)
set(FLUTTER_ICU_DATA_FILE "${EPHEMERAL_DIR}/icudtl.dat" PARENT_SCOPE)
set(PROJECT_BUILD_DIR "${PROJECT_DIR}/build/" PARENT_SCOPE)
set(AOT_LIBRARY "${PROJECT_DIR}/build/windows/app.so" PARENT_SCOPE)

list(APPEND FLUTTER_LIBRARY_HEADERS
  "flutter_export.h"
  "flutter_windows.h"
  "flutter_messenger.h"
  "flutter_plugin_registrar.h"
  "flutter_texture_registrar.h"
)
list(TRANSFORM FLUTTER_LIBRARY_HEADERS PREPEND "${EPHEMERAL_DIR}/")
add_library(flutter INTERFACE)
target_include_directories(flutter INTERFACE
  "${EPHEMERAL_DIR}"
)
target_link_libraries(flutter INTERFACE "${FLUTTER_LIBRARY}.lib")
add_dependencies(flutter flutter_assemble)

# === Wrapper ===
list(APPEND CPP_WRAPPER_SOURCES_CORE
  "core_implementations.cc"
  "standard_codec.cc"
)
list(TRANSFORM CPP_WRAPPER_SOURCES_CORE PREPEND "${WRAPPER_ROOT}/")
list(APPEND CPP_WRAPPER_SOURCES_PLUGIN
  "plugin_registrar.cc"
)
list(TRANSFORM CPP_WRAPPER_SOURCES_PLUGIN PREPEND "${WRAPPER_ROOT}/")
list(APPEND CPP_WRAPPER_SOURCES_APP
  "flutter_engine.cc"
  "flutter_view_controller.cc"
)
list(TRANSFORM CPP_WRAPPER_SOURCES_APP PREPEND "${WRAPPER_ROOT}/")

# Wrapper sources needed for a plugin.
add_library(flutter_wrapper_plugin STATIC
  ${CPP_WRAPPER_SOURCES_CORE}
  ${CPP_WRAPPER_SOURCES_PLUGIN}
)
apply_standard_settings(flutter_wrapper_plugin)
set_target_properties(flutter_wrapper_plugin PROPERTIES
  POSITION_INDEPENDENT_CODE ON)
set_target_properties(flutter_wrapper_plugin PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_link_libraries(flutter_wrapper_plugin PUBLIC flutter)
target_include_directories(flutter_wrapper_plugin PUBLIC
  "${WRAPPER_ROOT}/include"
)
add_dependencies(flutter_wrapper_plugin flutter_assemble)

# Wrapper sources needed for the runner.
add_library(flutter_wrapper_app STATIC
  ${CPP_WRAPPER_SOURCES_CORE}
  ${CPP_WRAPPER_SOURCES_APP}
)
apply_standard_settings(flutter_wrapper_app)
target_link_libraries(flutter_wrapper_app PUBLIC flutter)
target_include_directories(flutter_wrapper_app PUBLIC
  "${WRAPPER_ROOT}/include"
)
add_dependencies(flutter_wrapper_app flutter_assemble)

# === Flutter tool backend ===
# _phony_ is a non-existent file to force this command to run every time,
# since currently there's no way to get a full input/output list from the
# flutter tool.
set(PHONY_OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/_phony_")
set_source_files_properties("${PHONY_OUTPUT}" PROPERTIES SYMBOLIC TRUE)
add_custom_command(
  OUTPUT ${FLUTTER_LIBRARY} ${FLUTTER_LIBRARY_HEADERS}
    ${CPP_WRAPPER_SOURCES_CORE} ${CPP_WRAPPER_SOURCES_PLUGIN}
    ${CPP_WRAPPER_SOURCES_APP}
    ${PHONY_OUTPUT}
  COMMAND ${CMAKE_COMMAND} -E env
    ${FLUTTER_TOOL_ENVIRONMENT}
    "${FLUTTER_ROOT}/packages/flutter_tools/bin/tool_backend.bat"
      ${FLUTTER_TARGET_PLATFORM} $<CONFIG>
  VERBATIM
)
add_custom_target(flutter_assemble DEPENDS
  "${FLUTTER_LIBRARY}"
  ${FLUTTER_LIBRARY_HEADERS}
  ${CPP_WRAPPER_SOURCES_CORE}
  ${CPP_WRAPPER_SOURCES_PLUGIN}
  ${CPP_WRAPPER_SOURCES_APP}
)
```

## File: windows/flutter/generated_plugin_registrant.cc
```cpp
//
//  Generated file. Do not edit.
//
// clang-format off
#include "generated_plugin_registrant.h"
void RegisterPlugins(flutter::PluginRegistry* registry) {
}
```

## File: windows/flutter/generated_plugin_registrant.h
```c
//
//  Generated file. Do not edit.
⋮----
// clang-format off
⋮----
// Registers Flutter plugins.
void RegisterPlugins(flutter::PluginRegistry* registry);
⋮----
#endif  // GENERATED_PLUGIN_REGISTRANT_
```

## File: windows/flutter/generated_plugins.cmake
```cmake
#
# Generated file, do not edit.
#

list(APPEND FLUTTER_PLUGIN_LIST
)

list(APPEND FLUTTER_FFI_PLUGIN_LIST
  jni
)

set(PLUGIN_BUNDLED_LIBRARIES)

foreach(plugin ${FLUTTER_PLUGIN_LIST})
  add_subdirectory(flutter/ephemeral/.plugin_symlinks/${plugin}/windows plugins/${plugin})
  target_link_libraries(${BINARY_NAME} PRIVATE ${plugin}_plugin)
  list(APPEND PLUGIN_BUNDLED_LIBRARIES $<TARGET_FILE:${plugin}_plugin>)
  list(APPEND PLUGIN_BUNDLED_LIBRARIES ${${plugin}_bundled_libraries})
endforeach(plugin)

foreach(ffi_plugin ${FLUTTER_FFI_PLUGIN_LIST})
  add_subdirectory(flutter/ephemeral/.plugin_symlinks/${ffi_plugin}/windows plugins/${ffi_plugin})
  list(APPEND PLUGIN_BUNDLED_LIBRARIES ${${ffi_plugin}_bundled_libraries})
endforeach(ffi_plugin)
```

## File: windows/runner/CMakeLists.txt
```
cmake_minimum_required(VERSION 3.14)
project(runner LANGUAGES CXX)

# Define the application target. To change its name, change BINARY_NAME in the
# top-level CMakeLists.txt, not the value here, or `flutter run` will no longer
# work.
#
# Any new source files that you add to the application should be added here.
add_executable(${BINARY_NAME} WIN32
  "flutter_window.cpp"
  "main.cpp"
  "utils.cpp"
  "win32_window.cpp"
  "${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc"
  "Runner.rc"
  "runner.exe.manifest"
)

# Apply the standard set of build settings. This can be removed for applications
# that need different build settings.
apply_standard_settings(${BINARY_NAME})

# Add preprocessor definitions for the build version.
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION=\"${FLUTTER_VERSION}\"")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MAJOR=${FLUTTER_VERSION_MAJOR}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MINOR=${FLUTTER_VERSION_MINOR}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_PATCH=${FLUTTER_VERSION_PATCH}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_BUILD=${FLUTTER_VERSION_BUILD}")

# Disable Windows macros that collide with C++ standard library functions.
target_compile_definitions(${BINARY_NAME} PRIVATE "NOMINMAX")

# Add dependency libraries and include directories. Add any application-specific
# dependencies here.
target_link_libraries(${BINARY_NAME} PRIVATE flutter flutter_wrapper_app)
target_link_libraries(${BINARY_NAME} PRIVATE "dwmapi.lib")
target_include_directories(${BINARY_NAME} PRIVATE "${CMAKE_SOURCE_DIR}")

# Run the Flutter tool portions of the build. This must not be removed.
add_dependencies(${BINARY_NAME} flutter_assemble)
```

## File: windows/runner/flutter_window.cpp
```cpp
FlutterWindow::FlutterWindow(const flutter::DartProject& project)
⋮----
bool FlutterWindow::OnCreate() {
⋮----
// The size here must match the window dimensions to avoid unnecessary surface
// creation / destruction in the startup path.
⋮----
// Ensure that basic setup of the controller was successful.
⋮----
// Flutter can complete the first frame before the "show window" callback is
// registered. The following call ensures a frame is pending to ensure the
// window is shown. It is a no-op if the first frame hasn't completed yet.
⋮----
void FlutterWindow::OnDestroy() {
⋮----
FlutterWindow::MessageHandler(HWND hwnd, UINT const message,
⋮----
// Give Flutter, including plugins, an opportunity to handle window messages.
```

## File: windows/runner/flutter_window.h
```c
// A window that does nothing but host a Flutter view.
⋮----
// Creates a new FlutterWindow hosting a Flutter view running |project|.
explicit FlutterWindow(const flutter::DartProject& project);
virtual ~FlutterWindow();
⋮----
// Win32Window:
bool OnCreate() override;
void OnDestroy() override;
LRESULT MessageHandler(HWND window, UINT const message, WPARAM const wparam,
⋮----
// The project to run.
⋮----
// The Flutter instance hosted by this window.
⋮----
#endif  // RUNNER_FLUTTER_WINDOW_H_
```

## File: windows/runner/main.cpp
```cpp
int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
⋮----
// Attach to console when present (e.g., 'flutter run') or create a
// new console when running with a debugger.
⋮----
// Initialize COM, so that it is available for use in the library and/or
// plugins.
⋮----
FlutterWindow window(project);
```

## File: windows/runner/resource.h
```c
//{{NO_DEPENDENCIES}}
// Microsoft Visual C++ generated include file.
// Used by Runner.rc
//
⋮----
// Next default values for new objects
```

## File: windows/runner/runner.exe.manifest
```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">
  <application xmlns="urn:schemas-microsoft-com:asm.v3">
    <windowsSettings>
      <dpiAwareness xmlns="http://schemas.microsoft.com/SMI/2016/WindowsSettings">PerMonitorV2</dpiAwareness>
    </windowsSettings>
  </application>
  <compatibility xmlns="urn:schemas-microsoft-com:compatibility.v1">
    <application>
      <!-- Windows 10 and Windows 11 -->
      <supportedOS Id="{8e0f7a12-bfb3-4fe8-b9a5-48fd50a15a9a}"/>
    </application>
  </compatibility>
</assembly>
```

## File: windows/runner/Runner.rc
```
// Microsoft Visual C++ generated resource script.
//
#pragma code_page(65001)
#include "resource.h"

#define APSTUDIO_READONLY_SYMBOLS
/////////////////////////////////////////////////////////////////////////////
//
// Generated from the TEXTINCLUDE 2 resource.
//
#include "winres.h"

/////////////////////////////////////////////////////////////////////////////
#undef APSTUDIO_READONLY_SYMBOLS

/////////////////////////////////////////////////////////////////////////////
// English (United States) resources

#if !defined(AFX_RESOURCE_DLL) || defined(AFX_TARG_ENU)
LANGUAGE LANG_ENGLISH, SUBLANG_ENGLISH_US

#ifdef APSTUDIO_INVOKED
/////////////////////////////////////////////////////////////////////////////
//
// TEXTINCLUDE
//

1 TEXTINCLUDE
BEGIN
    "resource.h\0"
END

2 TEXTINCLUDE
BEGIN
    "#include ""winres.h""\r\n"
    "\0"
END

3 TEXTINCLUDE
BEGIN
    "\r\n"
    "\0"
END

#endif    // APSTUDIO_INVOKED


/////////////////////////////////////////////////////////////////////////////
//
// Icon
//

// Icon with lowest ID value placed first to ensure application icon
// remains consistent on all systems.
IDI_APP_ICON            ICON                    "resources\\app_icon.ico"


/////////////////////////////////////////////////////////////////////////////
//
// Version
//

#if defined(FLUTTER_VERSION_MAJOR) && defined(FLUTTER_VERSION_MINOR) && defined(FLUTTER_VERSION_PATCH) && defined(FLUTTER_VERSION_BUILD)
#define VERSION_AS_NUMBER FLUTTER_VERSION_MAJOR,FLUTTER_VERSION_MINOR,FLUTTER_VERSION_PATCH,FLUTTER_VERSION_BUILD
#else
#define VERSION_AS_NUMBER 1,0,0,0
#endif

#if defined(FLUTTER_VERSION)
#define VERSION_AS_STRING FLUTTER_VERSION
#else
#define VERSION_AS_STRING "1.0.0"
#endif

VS_VERSION_INFO VERSIONINFO
 FILEVERSION VERSION_AS_NUMBER
 PRODUCTVERSION VERSION_AS_NUMBER
 FILEFLAGSMASK VS_FFI_FILEFLAGSMASK
#ifdef _DEBUG
 FILEFLAGS VS_FF_DEBUG
#else
 FILEFLAGS 0x0L
#endif
 FILEOS VOS__WINDOWS32
 FILETYPE VFT_APP
 FILESUBTYPE 0x0L
BEGIN
    BLOCK "StringFileInfo"
    BEGIN
        BLOCK "040904e4"
        BEGIN
            VALUE "CompanyName", "com.cfssh" "\0"
            VALUE "FileDescription", "launcher" "\0"
            VALUE "FileVersion", VERSION_AS_STRING "\0"
            VALUE "InternalName", "launcher" "\0"
            VALUE "LegalCopyright", "Copyright (C) 2026 com.cfssh. All rights reserved." "\0"
            VALUE "OriginalFilename", "launcher.exe" "\0"
            VALUE "ProductName", "launcher" "\0"
            VALUE "ProductVersion", VERSION_AS_STRING "\0"
        END
    END
    BLOCK "VarFileInfo"
    BEGIN
        VALUE "Translation", 0x409, 1252
    END
END

#endif    // English (United States) resources
/////////////////////////////////////////////////////////////////////////////



#ifndef APSTUDIO_INVOKED
/////////////////////////////////////////////////////////////////////////////
//
// Generated from the TEXTINCLUDE 3 resource.
//


/////////////////////////////////////////////////////////////////////////////
#endif    // not APSTUDIO_INVOKED
```

## File: windows/runner/utils.cpp
```cpp
void CreateAndAttachConsole() {
⋮----
std::vector<std::string> GetCommandLineArguments() {
// Convert the UTF-16 command line arguments to UTF-8 for the Engine to use.
⋮----
// Skip the first argument as it's the binary name.
⋮----
std::string Utf8FromUtf16(const wchar_t* utf16_string) {
⋮----
// First, find the length of the string with a safe upper bound (CWE-126).
// UNICODE_STRING_MAX_CHARS (32767) is the maximum length of a UNICODE_STRING.
⋮----
// Now use that bounded length to determine the required buffer size.
// When an explicit length is passed, WideCharToMultiByte does not include
// the null terminator in its returned size.
```

## File: windows/runner/utils.h
```c
// Creates a console for the process, and redirects stdout and stderr to
// it for both the runner and the Flutter library.
void CreateAndAttachConsole();
⋮----
// Takes a null-terminated wchar_t* encoded in UTF-16 and returns a std::string
// encoded in UTF-8. Returns an empty std::string on failure.
std::string Utf8FromUtf16(const wchar_t* utf16_string);
⋮----
// Gets the command line arguments passed in as a std::vector<std::string>,
// encoded in UTF-8. Returns an empty std::vector<std::string> on failure.
⋮----
#endif  // RUNNER_UTILS_H_
```

## File: windows/runner/win32_window.cpp
```cpp
/// Window attribute that enables dark mode window decorations.
///
/// Redefined in case the developer's machine has a Windows SDK older than
/// version 10.0.22000.0.
/// See: https://docs.microsoft.com/windows/win32/api/dwmapi/ne-dwmapi-dwmwindowattribute
⋮----
/// Registry key for app theme preference.
⋮----
/// A value of 0 indicates apps should use dark mode. A non-zero or missing
/// value indicates apps should use light mode.
⋮----
// The number of Win32Window objects that currently exist.
⋮----
// Scale helper to convert logical scaler values to physical using passed in
// scale factor
int Scale(int source, double scale_factor) {
⋮----
// Dynamically loads the |EnableNonClientDpiScaling| from the User32 module.
// This API is only needed for PerMonitor V1 awareness mode.
void EnableFullDpiSupportIfAvailable(HWND hwnd) {
⋮----
}  // namespace
⋮----
// Manages the Win32Window's window class registration.
class WindowClassRegistrar {
⋮----
// Returns the singleton registrar instance.
static WindowClassRegistrar* GetInstance() {
⋮----
// Returns the name of the window class, registering the class if it hasn't
// previously been registered.
const wchar_t* GetWindowClass();
⋮----
// Unregisters the window class. Should only be called if there are no
// instances of the window.
void UnregisterWindowClass();
⋮----
WindowClassRegistrar() = default;
⋮----
const wchar_t* WindowClassRegistrar::GetWindowClass() {
⋮----
void WindowClassRegistrar::UnregisterWindowClass() {
⋮----
Win32Window::Win32Window() {
⋮----
bool Win32Window::Create(const std::wstring& title,
⋮----
bool Win32Window::Show() {
⋮----
// static
⋮----
Win32Window::MessageHandler(HWND hwnd,
⋮----
// Size and position the child window.
⋮----
void Win32Window::Destroy() {
⋮----
Win32Window* Win32Window::GetThisFromHandle(HWND const window) noexcept {
⋮----
void Win32Window::SetChildContent(HWND content) {
⋮----
RECT Win32Window::GetClientArea() {
⋮----
HWND Win32Window::GetHandle() {
⋮----
void Win32Window::SetQuitOnClose(bool quit_on_close) {
⋮----
bool Win32Window::OnCreate() {
// No-op; provided for subclasses.
⋮----
void Win32Window::OnDestroy() {
⋮----
void Win32Window::UpdateTheme(HWND const window) {
```

## File: windows/runner/win32_window.h
```c
// A class abstraction for a high DPI-aware Win32 Window. Intended to be
// inherited from by classes that wish to specialize with custom
// rendering and input handling
⋮----
struct Size {
⋮----
// Creates a win32 window with |title| that is positioned and sized using
// |origin| and |size|. New windows are created on the default monitor. Window
// sizes are specified to the OS in physical pixels, hence to ensure a
// consistent size this function will scale the inputted width and height as
// as appropriate for the default monitor. The window is invisible until
// |Show| is called. Returns true if the window was created successfully.
⋮----
// Show the current window. Returns true if the window was successfully shown.
⋮----
// Release OS resources associated with window.
⋮----
// Inserts |content| into the window tree.
⋮----
// Returns the backing Window handle to enable clients to set icon and other
// window properties. Returns nullptr if the window has been destroyed.
⋮----
// If true, closing this window will quit the application.
⋮----
// Return a RECT representing the bounds of the current client area.
⋮----
// Processes and route salient window messages for mouse handling,
// size change and DPI. Delegates handling of these to member overloads that
// inheriting classes can handle.
⋮----
// Called when CreateAndShow is called, allowing subclass window-related
// setup. Subclasses should return false if setup fails.
⋮----
// Called when Destroy is called.
⋮----
// OS callback called by message pump. Handles the WM_NCCREATE message which
// is passed when the non-client area is being created and enables automatic
// non-client DPI scaling so that the non-client area automatically
// responds to changes in DPI. All other messages are handled by
// MessageHandler.
⋮----
// Retrieves a class instance pointer for |window|
⋮----
// Update the window frame's theme to match the system theme.
⋮----
// window handle for top level window.
⋮----
// window handle for hosted content.
⋮----
#endif  // RUNNER_WIN32_WINDOW_H_
```

## File: windows/.gitignore
```
flutter/ephemeral/

# Visual Studio user-specific files.
*.suo
*.user
*.userosscache
*.sln.docstates

# Visual Studio build-related files.
x64/
x86/

# Visual Studio cache files
# files ending in .cache can be ignored
*.[Cc]ache
# but keep track of directories ending in .cache
!*.[Cc]ache/
```

## File: windows/CMakeLists.txt
```
# Project-level configuration.
cmake_minimum_required(VERSION 3.14)
project(launcher LANGUAGES CXX)

# The name of the executable created for the application. Change this to change
# the on-disk name of your application.
set(BINARY_NAME "launcher")

# Explicitly opt in to modern CMake behaviors to avoid warnings with recent
# versions of CMake.
cmake_policy(VERSION 3.14...3.25)

# Define build configuration option.
get_property(IS_MULTICONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if(IS_MULTICONFIG)
  set(CMAKE_CONFIGURATION_TYPES "Debug;Profile;Release"
    CACHE STRING "" FORCE)
else()
  if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE "Debug" CACHE
      STRING "Flutter build mode" FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
      "Debug" "Profile" "Release")
  endif()
endif()
# Define settings for the Profile build mode.
set(CMAKE_EXE_LINKER_FLAGS_PROFILE "${CMAKE_EXE_LINKER_FLAGS_RELEASE}")
set(CMAKE_SHARED_LINKER_FLAGS_PROFILE "${CMAKE_SHARED_LINKER_FLAGS_RELEASE}")
set(CMAKE_C_FLAGS_PROFILE "${CMAKE_C_FLAGS_RELEASE}")
set(CMAKE_CXX_FLAGS_PROFILE "${CMAKE_CXX_FLAGS_RELEASE}")

# Use Unicode for all projects.
add_definitions(-DUNICODE -D_UNICODE)

# Compilation settings that should be applied to most targets.
#
# Be cautious about adding new options here, as plugins use this function by
# default. In most cases, you should add new options to specific targets instead
# of modifying this function.
function(APPLY_STANDARD_SETTINGS TARGET)
  target_compile_features(${TARGET} PUBLIC cxx_std_17)
  target_compile_options(${TARGET} PRIVATE /W4 /WX /wd"4100")
  target_compile_options(${TARGET} PRIVATE /EHsc)
  target_compile_definitions(${TARGET} PRIVATE "_HAS_EXCEPTIONS=0")
  target_compile_definitions(${TARGET} PRIVATE "$<$<CONFIG:Debug>:_DEBUG>")
endfunction()

# Flutter library and tool build rules.
set(FLUTTER_MANAGED_DIR "${CMAKE_CURRENT_SOURCE_DIR}/flutter")
add_subdirectory(${FLUTTER_MANAGED_DIR})

# Application build; see runner/CMakeLists.txt.
add_subdirectory("runner")


# Generated plugin build rules, which manage building the plugins and adding
# them to the application.
include(flutter/generated_plugins.cmake)


# === Installation ===
# Support files are copied into place next to the executable, so that it can
# run in place. This is done instead of making a separate bundle (as on Linux)
# so that building and running from within Visual Studio will work.
set(BUILD_BUNDLE_DIR "$<TARGET_FILE_DIR:${BINARY_NAME}>")
# Make the "install" step default, as it's required to run.
set(CMAKE_VS_INCLUDE_INSTALL_TO_DEFAULT_BUILD 1)
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "${BUILD_BUNDLE_DIR}" CACHE PATH "..." FORCE)
endif()

set(INSTALL_BUNDLE_DATA_DIR "${CMAKE_INSTALL_PREFIX}/data")
set(INSTALL_BUNDLE_LIB_DIR "${CMAKE_INSTALL_PREFIX}")

install(TARGETS ${BINARY_NAME} RUNTIME DESTINATION "${CMAKE_INSTALL_PREFIX}"
  COMPONENT Runtime)

install(FILES "${FLUTTER_ICU_DATA_FILE}" DESTINATION "${INSTALL_BUNDLE_DATA_DIR}"
  COMPONENT Runtime)

install(FILES "${FLUTTER_LIBRARY}" DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
  COMPONENT Runtime)

if(PLUGIN_BUNDLED_LIBRARIES)
  install(FILES "${PLUGIN_BUNDLED_LIBRARIES}"
    DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
    COMPONENT Runtime)
endif()

# Copy the native assets provided by the build.dart from all packages.
set(NATIVE_ASSETS_DIR "${PROJECT_BUILD_DIR}native_assets/windows/")
install(DIRECTORY "${NATIVE_ASSETS_DIR}"
   DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
   COMPONENT Runtime)

# Fully re-copy the assets directory on each build to avoid having stale files
# from a previous install.
set(FLUTTER_ASSET_DIR_NAME "flutter_assets")
install(CODE "
  file(REMOVE_RECURSE \"${INSTALL_BUNDLE_DATA_DIR}/${FLUTTER_ASSET_DIR_NAME}\")
  " COMPONENT Runtime)
install(DIRECTORY "${PROJECT_BUILD_DIR}/${FLUTTER_ASSET_DIR_NAME}"
  DESTINATION "${INSTALL_BUNDLE_DATA_DIR}" COMPONENT Runtime)

# Install the AOT library on non-Debug builds only.
install(FILES "${AOT_LIBRARY}" DESTINATION "${INSTALL_BUNDLE_DATA_DIR}"
  CONFIGURATIONS Profile;Release
  COMPONENT Runtime)
```

## File: .gitignore
```
# Miscellaneous
*.class
*.log
*.pyc
*.swp
.DS_Store
.atom/
.build/
.buildlog/
.history
.svn/
.swiftpm/
migrate_working_dir/

# IntelliJ related
*.iml
*.ipr
*.iws
.idea/

# The .vscode folder contains launch configuration and tasks you configure in
# VS Code which you may wish to be included in version control, so this line
# is commented out by default.
#.vscode/

# Flutter/Dart/Pub related
**/doc/api/
**/ios/Flutter/.last_build_id
.dart_tool/
.flutter-plugins-dependencies
.pub-cache/
.pub/
/build/
/coverage/

# Symbolication related
app.*.symbols

# Obfuscation related
app.*.map.json

# Android Studio will place build artifacts here
/android/app/debug
/android/app/profile
/android/app/release

# Widget Preview related
.widget_preview/
```

## File: .metadata
```
# This file tracks properties of this Flutter project.
# Used by Flutter tool to assess capabilities and perform upgrades etc.
#
# This file should be version controlled and should not be manually edited.

version:
  revision: "6a19cca56475dbfba1478ee68d7bd0c2ef891da1"
  channel: "stable"

project_type: app

# Tracks metadata for the flutter migrate command
migration:
  platforms:
    - platform: root
      create_revision: 6a19cca56475dbfba1478ee68d7bd0c2ef891da1
      base_revision: 6a19cca56475dbfba1478ee68d7bd0c2ef891da1
    - platform: android
      create_revision: 6a19cca56475dbfba1478ee68d7bd0c2ef891da1
      base_revision: 6a19cca56475dbfba1478ee68d7bd0c2ef891da1
    - platform: ios
      create_revision: 6a19cca56475dbfba1478ee68d7bd0c2ef891da1
      base_revision: 6a19cca56475dbfba1478ee68d7bd0c2ef891da1
    - platform: linux
      create_revision: 6a19cca56475dbfba1478ee68d7bd0c2ef891da1
      base_revision: 6a19cca56475dbfba1478ee68d7bd0c2ef891da1
    - platform: macos
      create_revision: 6a19cca56475dbfba1478ee68d7bd0c2ef891da1
      base_revision: 6a19cca56475dbfba1478ee68d7bd0c2ef891da1
    - platform: web
      create_revision: 6a19cca56475dbfba1478ee68d7bd0c2ef891da1
      base_revision: 6a19cca56475dbfba1478ee68d7bd0c2ef891da1
    - platform: windows
      create_revision: 6a19cca56475dbfba1478ee68d7bd0c2ef891da1
      base_revision: 6a19cca56475dbfba1478ee68d7bd0c2ef891da1

  # User provided section

  # List of Local paths (relative to this file) that should be
  # ignored by the migrate tool.
  #
  # Files that are not part of the templates will be ignored by default.
  unmanaged_files:
    - 'lib/main.dart'
    - 'ios/Runner.xcodeproj/project.pbxproj'
```

## File: analysis_options.yaml
```yaml
# This file configures the analyzer, which statically analyzes Dart code to
# check for errors, warnings, and lints.
#
# The issues identified by the analyzer are surfaced in the UI of Dart-enabled
# IDEs (https://dart.dev/tools#ides-and-editors). The analyzer can also be
# invoked from the command line by running `flutter analyze`.
# The following line activates a set of recommended lints for Flutter apps,
# packages, and plugins designed to encourage good coding practices.
include: package:flutter_lints/flutter.yaml
analyzer:
  exclude:
    - build/**
    - android/**
    - ios/**
    - web/**
    - windows/**
    - macos/**
    - linux/**
linter:
  # The lint rules applied to this project can be customized in the
  # section below to disable rules from the `package:flutter_lints/flutter.yaml`
  # included above or to enable additional rules. A list of all available lints
  # and their documentation is published at https://dart.dev/lints.
  #
  # Instead of disabling a lint rule for the entire project in the
  # section below, it can also be suppressed for a single line of code
  # or a specific dart file by using the `// ignore: name_of_lint` and
  # `// ignore_for_file: name_of_lint` syntax on the line or in the file
  # producing the lint.
  rules:
    # avoid_print: false  # Uncomment to disable the `avoid_print` rule
    # prefer_single_quotes: true  # Uncomment to enable the `prefer_single_quotes` rule
# Additional information about this file can be found at
# https://dart.dev/guides/language/analysis-options
```

## File: prefs_new.xml
```xml

```

## File: prefs.xml
```xml

```

## File: pubspec.lock
```
# Generated by pub
# See https://dart.dev/tools/pub/glossary#lockfile
packages:
  args:
    dependency: transitive
    description:
      name: args
      sha256: d0481093c50b1da8910eb0bb301626d4d8eb7284aa739614d2b394ee09e3ea04
      url: "https://pub.dev"
    source: hosted
    version: "2.7.0"
  async:
    dependency: transitive
    description:
      name: async
      sha256: e2eb0491ba5ddb6177742d2da23904574082139b07c1e33b8503b9f46f3e1a37
      url: "https://pub.dev"
    source: hosted
    version: "2.13.1"
  boolean_selector:
    dependency: transitive
    description:
      name: boolean_selector
      sha256: "8aab1771e1243a5063b8b0ff68042d67334e3feab9e95b9490f9a6ebf73b42ea"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.2"
  characters:
    dependency: transitive
    description:
      name: characters
      sha256: faf38497bda5ead2a8c7615f4f7939df04333478bf32e4173fcb06d428b5716b
      url: "https://pub.dev"
    source: hosted
    version: "1.4.1"
  clock:
    dependency: transitive
    description:
      name: clock
      sha256: e51d50bca3217c9a9fa2b41a30e4a38971133f5f9ec7a3d57bae095007f1d28e
      url: "https://pub.dev"
    source: hosted
    version: "1.1.3"
  code_assets:
    dependency: transitive
    description:
      name: code_assets
      sha256: bf394f466ba9205f1812a0433b392d6af280f155f56651eda7c18cc32ed493b8
      url: "https://pub.dev"
    source: hosted
    version: "1.2.1"
  collection:
    dependency: transitive
    description:
      name: collection
      sha256: "2f5709ae4d3d59dd8f7cd309b4e023046b57d8a6c82130785d2b0e5868084e76"
      url: "https://pub.dev"
    source: hosted
    version: "1.19.1"
  crypto:
    dependency: transitive
    description:
      name: crypto
      sha256: c8ea0233063ba03258fbcf2ca4d6dadfefe14f02fab57702265467a19f27fadf
      url: "https://pub.dev"
    source: hosted
    version: "3.0.7"
  csslib:
    dependency: transitive
    description:
      name: csslib
      sha256: "09bad715f418841f976c77db72d5398dc1253c21fb9c0c7f0b0b985860b2d58e"
      url: "https://pub.dev"
    source: hosted
    version: "1.0.2"
  cupertino_icons:
    dependency: "direct main"
    description:
      name: cupertino_icons
      sha256: "41e005c33bd814be4d3096aff55b1908d419fde52ca656c8c47719ec745873cd"
      url: "https://pub.dev"
    source: hosted
    version: "1.0.9"
  fake_async:
    dependency: transitive
    description:
      name: fake_async
      sha256: "5368f224a74523e8d2e7399ea1638b37aecfca824a3cc4dfdf77bf1fa905ac44"
      url: "https://pub.dev"
    source: hosted
    version: "1.3.3"
  ffi:
    dependency: transitive
    description:
      name: ffi
      sha256: "6d7fd89431262d8f3125e81b50d3847a091d846eafcd4fdb88dd06f36d705a45"
      url: "https://pub.dev"
    source: hosted
    version: "2.2.0"
  file:
    dependency: transitive
    description:
      name: file
      sha256: a3b4f84adafef897088c160faf7dfffb7696046cb13ae90b508c2cbc95d3b8d4
      url: "https://pub.dev"
    source: hosted
    version: "7.0.1"
  fixnum:
    dependency: transitive
    description:
      name: fixnum
      sha256: b6dc7065e46c974bc7c5f143080a6764ec7a4be6da1285ececdc37be96de53be
      url: "https://pub.dev"
    source: hosted
    version: "1.1.1"
  flutter:
    dependency: "direct main"
    description: flutter
    source: sdk
    version: "0.0.0"
  flutter_lints:
    dependency: "direct dev"
    description:
      name: flutter_lints
      sha256: "3105dc8492f6183fb076ccf1f351ac3d60564bff92e20bfc4af9cc1651f4e7e1"
      url: "https://pub.dev"
    source: hosted
    version: "6.0.0"
  flutter_riverpod:
    dependency: "direct main"
    description:
      name: flutter_riverpod
      sha256: "2b7f9d2a3c730ac1a98221b420cef966b990fca7ab546ede324642ca57a533e3"
      url: "https://pub.dev"
    source: hosted
    version: "3.4.3"
  flutter_test:
    dependency: "direct dev"
    description: flutter
    source: sdk
    version: "0.0.0"
  flutter_web_plugins:
    dependency: transitive
    description: flutter
    source: sdk
    version: "0.0.0"
  google_fonts:
    dependency: "direct main"
    description:
      name: google_fonts
      sha256: e3cb3ee6b47fd2472c23de6da5744796a4da195137759ddb3fbcc9467b7b3c7d
      url: "https://pub.dev"
    source: hosted
    version: "8.2.1"
  hooks:
    dependency: transitive
    description:
      name: hooks
      sha256: "9a62a50b50b769a737bc0a8ff381f333529df3ab746b2f6b02e83760231455ba"
      url: "https://pub.dev"
    source: hosted
    version: "2.0.2"
  html:
    dependency: transitive
    description:
      name: html
      sha256: "43b67b8f43321ab066817dfac5619596c98bb1b61624e77203bb4351785f9699"
      url: "https://pub.dev"
    source: hosted
    version: "0.15.7"
  http:
    dependency: "direct main"
    description:
      name: http
      sha256: "87721a4a50b19c7f1d49001e51409bddc46303966ce89a65af4f4e6004896412"
      url: "https://pub.dev"
    source: hosted
    version: "1.6.0"
  http_parser:
    dependency: transitive
    description:
      name: http_parser
      sha256: "178d74305e7866013777bab2c3d8726205dc5a4dd935297175b19a23a2e66571"
      url: "https://pub.dev"
    source: hosted
    version: "4.1.2"
  intl:
    dependency: "direct main"
    description:
      name: intl
      sha256: "1ca20c894b1717686a2319b8548763d812bc0aabdac580420a44c5178c57a867"
      url: "https://pub.dev"
    source: hosted
    version: "0.20.3"
  jni:
    dependency: transitive
    description:
      name: jni
      sha256: f038e58b4dc2c9037f50e233175086337e0b305e356d28211bf55f21c504cbd3
      url: "https://pub.dev"
    source: hosted
    version: "1.0.3"
  jni_flutter:
    dependency: transitive
    description:
      name: jni_flutter
      sha256: b2310cdd4c18c65c081ab141a41efa94aa26c65431803703ece51996f174f351
      url: "https://pub.dev"
    source: hosted
    version: "1.0.3"
  jni_util:
    dependency: transitive
    description:
      name: jni_util
      sha256: "1ba86da04a5f2bf18fde2edb235587e70c5b0fc5bd4ba955f46b00942c3fc35f"
      url: "https://pub.dev"
    source: hosted
    version: "1.0.0"
  leak_tracker:
    dependency: transitive
    description:
      name: leak_tracker
      sha256: "33e2e26bdd85a0112ec15400c8cbffea70d0f9c3407491f672a2fad47915e2de"
      url: "https://pub.dev"
    source: hosted
    version: "11.0.2"
  leak_tracker_flutter_testing:
    dependency: transitive
    description:
      name: leak_tracker_flutter_testing
      sha256: "1dbc140bb5a23c75ea9c4811222756104fbcd1a27173f0c34ca01e16bea473c1"
      url: "https://pub.dev"
    source: hosted
    version: "3.0.10"
  leak_tracker_testing:
    dependency: transitive
    description:
      name: leak_tracker_testing
      sha256: "8d5a2d49f4a66b49744b23b018848400d23e54caf9463f4eb20df3eb8acb2eb1"
      url: "https://pub.dev"
    source: hosted
    version: "3.0.2"
  lints:
    dependency: transitive
    description:
      name: lints
      sha256: "12f842a479589fea194fe5c5a3095abc7be0c1f2ddfa9a0e76aed1dbd26a87df"
      url: "https://pub.dev"
    source: hosted
    version: "6.1.0"
  listen:
    dependency: transitive
    description:
      name: listen
      sha256: "47501a08016a43fcad79252439d723f50f14f88fa7bfd8a177e0a417e5c9e1f2"
      url: "https://pub.dev"
    source: hosted
    version: "1.0.1"
  logging:
    dependency: transitive
    description:
      name: logging
      sha256: c8245ada5f1717ed44271ed1c26b8ce85ca3228fd2ffdb75468ab01979309d61
      url: "https://pub.dev"
    source: hosted
    version: "1.3.0"
  matcher:
    dependency: transitive
    description:
      name: matcher
      sha256: "31bd099b47c10cd1aeb55146a2d46ce0277630ecef3f7dae54ad7873f36696cd"
      url: "https://pub.dev"
    source: hosted
    version: "0.12.20"
  material_color_utilities:
    dependency: transitive
    description:
      name: material_color_utilities
      sha256: "9c337007e82b1889149c82ed242ed1cb24a66044e30979c44912381e9be4c48b"
      url: "https://pub.dev"
    source: hosted
    version: "0.13.0"
  meta:
    dependency: transitive
    description:
      name: meta
      sha256: c82594181e3312f3d0695fc95aaaf7758d75b8d4ae2bbecf223b9fd5109a059d
      url: "https://pub.dev"
    source: hosted
    version: "1.18.3"
  objective_c:
    dependency: transitive
    description:
      name: objective_c
      sha256: b7fb95a6d9a4f009edd63dc5ac69f07420b23a16161c6dd8660290b59c602e8e
      url: "https://pub.dev"
    source: hosted
    version: "9.5.0"
  package_config:
    dependency: transitive
    description:
      name: package_config
      sha256: ffcf4cf3d6c0b74ac43708d9f56625506e8a68aa935abe9d267a7330f320eb5d
      url: "https://pub.dev"
    source: hosted
    version: "3.0.0"
  path:
    dependency: "direct main"
    description:
      name: path
      sha256: "75cca69d1490965be98c73ceaea117e8a04dd21217b37b292c9ddbec0d955bc5"
      url: "https://pub.dev"
    source: hosted
    version: "1.9.1"
  path_provider:
    dependency: "direct main"
    description:
      name: path_provider
      sha256: a7f4874f987173da295a61c181b8ee71dab59b332a486b391babf26a1b884825
      url: "https://pub.dev"
    source: hosted
    version: "2.1.6"
  path_provider_android:
    dependency: transitive
    description:
      name: path_provider_android
      sha256: "69cbd515a62b94d32a7944f086b2f82b4ac40a1d45bebfc00813a430ab2dabcd"
      url: "https://pub.dev"
    source: hosted
    version: "2.3.1"
  path_provider_foundation:
    dependency: transitive
    description:
      name: path_provider_foundation
      sha256: "2a376b7d6392d80cd3705782d2caa734ca4727776db0b6ec36ef3f1855197699"
      url: "https://pub.dev"
    source: hosted
    version: "2.6.0"
  path_provider_linux:
    dependency: transitive
    description:
      name: path_provider_linux
      sha256: "58c2005f147315b11e9b4a7bc889cd5203e250cba8e3f012dae259b4972b5c16"
      url: "https://pub.dev"
    source: hosted
    version: "2.2.2"
  path_provider_platform_interface:
    dependency: transitive
    description:
      name: path_provider_platform_interface
      sha256: "484838772624c3a4b94f1e44a3e19897fee738f2d5c4ce448443b0417f7c9dda"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.3"
  path_provider_windows:
    dependency: transitive
    description:
      name: path_provider_windows
      sha256: bd6f00dbd873bfb70d0761682da2b3a2c2fccc2b9e84c495821639601d81afe7
      url: "https://pub.dev"
    source: hosted
    version: "2.3.0"
  platform:
    dependency: transitive
    description:
      name: platform
      sha256: a36d119c13416516a7b5913fbe8af8531e11633d784c550b2125f76c758524ec
      url: "https://pub.dev"
    source: hosted
    version: "3.2.0"
  plugin_platform_interface:
    dependency: transitive
    description:
      name: plugin_platform_interface
      sha256: "4820fbfdb9478b1ebae27888254d445073732dae3d6ea81f0b7e06d5dedc3f02"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.8"
  pub_semver:
    dependency: transitive
    description:
      name: pub_semver
      sha256: "261236774e8b1d69cfc6b9eabbc96c40f25e7a2d6b171f3385d4f65d5734fb24"
      url: "https://pub.dev"
    source: hosted
    version: "2.2.1"
  record_use:
    dependency: transitive
    description:
      name: record_use
      sha256: "2551bd8eecfe95d14ae75f6021ad0248be5c27f138c2ec12fcb52b500b3ba1ed"
      url: "https://pub.dev"
    source: hosted
    version: "0.6.0"
  riverpod:
    dependency: transitive
    description:
      name: riverpod
      sha256: "484dfc873ea4c4f4240e5635444fa066f87b07862b7279ebd004a2b71fba4b7a"
      url: "https://pub.dev"
    source: hosted
    version: "3.4.3"
  shared_preferences:
    dependency: "direct main"
    description:
      name: shared_preferences
      sha256: c3025c5534b01739267eb7d76959bbc25a6d10f6988e1c2a3036940133dd10bf
      url: "https://pub.dev"
    source: hosted
    version: "2.5.5"
  shared_preferences_android:
    dependency: transitive
    description:
      name: shared_preferences_android
      sha256: "1e12aafe408aa50da80edfd679a2a6bf63ba7ab37c7fa98286da459a757b3399"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.28"
  shared_preferences_foundation:
    dependency: transitive
    description:
      name: shared_preferences_foundation
      sha256: "2ec3934efa51e46117f23031cc141b8fc878e8525b94ec1ea4f7f586cf1b47ea"
      url: "https://pub.dev"
    source: hosted
    version: "2.5.7"
  shared_preferences_linux:
    dependency: transitive
    description:
      name: shared_preferences_linux
      sha256: "580abfd40f415611503cae30adf626e6656dfb2f0cee8f465ece7b6defb40f2f"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.1"
  shared_preferences_platform_interface:
    dependency: transitive
    description:
      name: shared_preferences_platform_interface
      sha256: "649dc798a33931919ea356c4305c2d1f81619ea6e92244070b520187b5140ef9"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.2"
  shared_preferences_web:
    dependency: transitive
    description:
      name: shared_preferences_web
      sha256: c49bd060261c9a3f0ff445892695d6212ff603ef3115edbb448509d407600019
      url: "https://pub.dev"
    source: hosted
    version: "2.4.3"
  shared_preferences_windows:
    dependency: transitive
    description:
      name: shared_preferences_windows
      sha256: "94ef0f72b2d71bc3e700e025db3710911bd51a71cefb65cc609dd0d9a982e3c1"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.1"
  sky_engine:
    dependency: transitive
    description: flutter
    source: sdk
    version: "0.0.0"
  source_span:
    dependency: transitive
    description:
      name: source_span
      sha256: "56a02f1f4cd1a2d96303c0144c93bd6d909eea6bee6bf5a0e0b685edbd4c47ab"
      url: "https://pub.dev"
    source: hosted
    version: "1.10.2"
  sqflite:
    dependency: "direct main"
    description:
      name: sqflite
      sha256: "54ad23e2a79c846b596b6c56cdd9c867ea58c288258402316b602f78df0cbfe0"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.4"
  sqflite_android:
    dependency: transitive
    description:
      name: sqflite_android
      sha256: "805b27c6fa10d8883253795e644818fbd5c87ce665459db84fbe71326cbb5421"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.4"
  sqflite_common:
    dependency: transitive
    description:
      name: sqflite_common
      sha256: "077e38e82c099534146a2fb31b608c2a3a4489a0f21d9af6b2f5c87b566a1ea0"
      url: "https://pub.dev"
    source: hosted
    version: "2.5.13"
  sqflite_darwin:
    dependency: transitive
    description:
      name: sqflite_darwin
      sha256: dbdda396f975f74d611ffd3e6fb280ee3ee4cd2319b89278533f427e0140cf0b
      url: "https://pub.dev"
    source: hosted
    version: "2.4.4"
  sqflite_platform_interface:
    dependency: transitive
    description:
      name: sqflite_platform_interface
      sha256: c9177b2f3150ed0647b90a94307c28452fe0a5401863044216aed83addd6c7c5
      url: "https://pub.dev"
    source: hosted
    version: "2.4.2"
  stack_trace:
    dependency: transitive
    description:
      name: stack_trace
      sha256: "277654b3034d17ac6f9f1cb5595db011b1d5d41e8806866db28e0abaa101c490"
      url: "https://pub.dev"
    source: hosted
    version: "1.12.2"
  state_notifier:
    dependency: transitive
    description:
      name: state_notifier
      sha256: b8677376aa54f2d7c58280d5a007f9e8774f1968d1fb1c096adcb4792fba29bb
      url: "https://pub.dev"
    source: hosted
    version: "1.0.0"
  stream_channel:
    dependency: transitive
    description:
      name: stream_channel
      sha256: "969e04c80b8bcdf826f8f16579c7b14d780458bd97f56d107d3950fdbeef059d"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.4"
  string_scanner:
    dependency: transitive
    description:
      name: string_scanner
      sha256: "921cd31725b72fe181906c6a94d987c78e3b98c2e205b397ea399d4054872b43"
      url: "https://pub.dev"
    source: hosted
    version: "1.4.1"
  synchronized:
    dependency: transitive
    description:
      name: synchronized
      sha256: "397b146f97613b83d84bdccb439bc8d0f3aebb6c1d14a9641e6f24201c490b2d"
      url: "https://pub.dev"
    source: hosted
    version: "3.4.2"
  term_glyph:
    dependency: transitive
    description:
      name: term_glyph
      sha256: "7f554798625ea768a7518313e58f83891c7f5024f88e46e7182a4558850a4b8e"
      url: "https://pub.dev"
    source: hosted
    version: "1.2.2"
  test_api:
    dependency: transitive
    description:
      name: test_api
      sha256: "2a122cbe059f8b610d3a5415f42e255b6c17b1f21eee1d960f31080237fb4f11"
      url: "https://pub.dev"
    source: hosted
    version: "0.7.12"
  typed_data:
    dependency: transitive
    description:
      name: typed_data
      sha256: f9049c039ebfeb4cf7a7104a675823cd72dba8297f264b6637062516699fa006
      url: "https://pub.dev"
    source: hosted
    version: "1.4.0"
  uuid:
    dependency: transitive
    description:
      name: uuid
      sha256: "9b129329f58692f6e6578329498a8fe9fbe98f090beb764ffbb8ee2eadd01dcd"
      url: "https://pub.dev"
    source: hosted
    version: "4.6.0"
  vector_math:
    dependency: transitive
    description:
      name: vector_math
      sha256: "1d774bbdf6b72a0b12122fc1560c9c2d2a67db5a4a4cc2bd8a5c990ab20e3188"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.0"
  video_player:
    dependency: "direct main"
    description:
      name: video_player
      sha256: "07ae1e03f2d4c8e2e9a75ee678f90acbc4506d4458a9c628512d119a1eee5754"
      url: "https://pub.dev"
    source: hosted
    version: "2.14.1"
  video_player_android:
    dependency: transitive
    description:
      name: video_player_android
      sha256: d27054dea34d748a44f06d433a57005d2aac69944485b0abbaed3303dbcfa3f1
      url: "https://pub.dev"
    source: hosted
    version: "2.12.2"
  video_player_avfoundation:
    dependency: transitive
    description:
      name: video_player_avfoundation
      sha256: "7d620d8c69d00c158a5c57bf3d2a051833b547631203ff724664fbf301024bc1"
      url: "https://pub.dev"
    source: hosted
    version: "2.12.3"
  video_player_platform_interface:
    dependency: transitive
    description:
      name: video_player_platform_interface
      sha256: "92c0fbabe20c788e71fd10d26cea998d0d253282e65d145aed0818731cf593ce"
      url: "https://pub.dev"
    source: hosted
    version: "6.9.0"
  video_player_web:
    dependency: transitive
    description:
      name: video_player_web
      sha256: "9f3c00be2ef9b76a95d94ac5119fb843dca6f2c69e6c9968f6f2b6c9e7afbdeb"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.0"
  vm_service:
    dependency: transitive
    description:
      name: vm_service
      sha256: "5f37239c4851efcef929cea7824e76df7f2f0970aef85d66bbc430afa40e72f0"
      url: "https://pub.dev"
    source: hosted
    version: "15.3.0"
  web:
    dependency: transitive
    description:
      name: web
      sha256: "868d88a33d8a87b18ffc05f9f030ba328ffefba92d6c127917a2ba740f9cfe4a"
      url: "https://pub.dev"
    source: hosted
    version: "1.1.1"
  xdg_directories:
    dependency: transitive
    description:
      name: xdg_directories
      sha256: "7a3f37b05d989967cdddcbb571f1ea834867ae2faa29725fd085180e0883aa15"
      url: "https://pub.dev"
    source: hosted
    version: "1.1.0"
  yaml:
    dependency: transitive
    description:
      name: yaml
      sha256: f67cdd8e07d3c6329146aaef1ba043542b3134c12489f553ca9a7435d1068aea
      url: "https://pub.dev"
    source: hosted
    version: "3.1.4"
sdks:
  dart: ">=3.13.4 <4.0.0"
  flutter: ">=3.47.0"
```

## File: pubspec.yaml
```yaml
name: launcher
description: "A new Flutter project."
# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev
# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
# In Windows, build-name is used as the major, minor, and patch parts
# of the product and file versions while build-number is used as the build suffix.
version: 1.0.0+1
environment:
  sdk: ^3.13.4
# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter
  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8
  flutter_riverpod: ^3.4.3
  google_fonts: ^8.2.1
  intl: ^0.20.3
  sqflite: ^2.4.4
  path_provider: ^2.1.6
  http: ^1.6.0
  shared_preferences: ^2.5.5
  path: ^1.9.1
  video_player: ^2.14.1
dev_dependencies:
  flutter_test:
    sdk: flutter
  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^6.0.0
# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec
# The following section is specific to Flutter packages.
flutter:
  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true
  # To add assets to your application, add an assets section, like this:
  assets:
    - assets/images/wallpaper.png
    - assets/images/logo.png
  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/to/resolution-aware-images
  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/to/asset-from-package
  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/to/font-from-package
```

## File: README.md
```markdown
# launcher

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
```

## File: set_substream.py
```python
# Pull shared_prefs
⋮----
content = f.read()
⋮----
# Replace /live/ch00_0 with /live/ch00_1
new_content = content.replace('/live/ch00_0', '/live/ch00_1')
```
