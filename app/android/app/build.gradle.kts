plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.base_project_bloc"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.base_project_bloc"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
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

              // FLAVOR-GEN-START
// DO NOT EDIT MANUALLY
flavorDimensions += "default"
productFlavors {
    create("staging") {
        dimension = "default"
        applicationId = "com.example.myapp.staging"
        resValue("string", "app_name", "AI Reminder Staging")
    }

    create("prod") {
        dimension = "default"
        applicationId = "com.example.myapp"
        resValue("string", "app_name", "AI Reminder")
    }

}

// FLAVOR-GEN-END
}

flutter {
    source = "../.."
}
