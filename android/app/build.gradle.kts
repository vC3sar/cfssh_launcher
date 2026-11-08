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
