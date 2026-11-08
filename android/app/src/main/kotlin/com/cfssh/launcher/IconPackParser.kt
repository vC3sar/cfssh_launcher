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

