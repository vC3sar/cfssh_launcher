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

