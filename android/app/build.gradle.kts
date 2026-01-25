plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.doc_doc"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.example.doc_doc"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
        debug { }
    }

    flavorDimensions += "default"

    productFlavors {
        create("development") {
            dimension = "default"
            resValue("string", "app_name", "DocDoc Development")
            applicationIdSuffix = ".development"
        }
        create("production") {
            dimension = "default"
            resValue("string", "app_name", "DocDoc")
            applicationIdSuffix = ".production"
        }
    }
}

flutter {
    source = "../.."
}
