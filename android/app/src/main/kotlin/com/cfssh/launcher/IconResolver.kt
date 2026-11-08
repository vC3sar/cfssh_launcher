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

