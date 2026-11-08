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

