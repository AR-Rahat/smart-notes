plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

//def localProperties = new Properties()
//def localPropertiesFile = rootProject.file('local.properties')
//if (localPropertiesFile.exists()) {
//    localPropertiesFile.withReader('UTF-8') { reader ->
//        localProperties.load(reader)
//    }
//}
//
//def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
//if (flutterVersionCode == null) {
//    flutterVersionCode = '1'
//}
//
//def flutterVersionName = localProperties.getProperty('flutter.versionName')
//if (flutterVersionName == null) {
//    flutterVersionName = '1.0'
//}
//
//def keystoreProperties = new Properties()
//def keystorePropertiesFile = rootProject.file('key.properties')
//if (keystorePropertiesFile.exists()) {
//    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
//}

android {
    namespace = "com.arrahat.smart_notes"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.arrahat.smart_notes"
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
