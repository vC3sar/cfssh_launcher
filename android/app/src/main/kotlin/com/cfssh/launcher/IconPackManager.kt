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

