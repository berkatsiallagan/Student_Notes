# Instruksi Build APK - Student Notes

## Prerequisites

Pastikan Anda sudah menginstall:
- Flutter SDK (3.9.2 atau lebih baru)
- Android Studio dengan Android SDK
- Java Development Kit (JDK)

## Langkah-langkah Build APK

### 1. Persiapan Project

```bash
# Masuk ke direktori project
cd student_notes

# Install dependencies
flutter pub get

# Cek apakah ada error
flutter analyze

# Test build (opsional)
flutter build apk --debug
```

### 2. Konfigurasi Android

#### Update App Name & Package
Edit file `android/app/src/main/AndroidManifest.xml`:
```xml
<application
    android:label="Student Notes"
    android:name="${applicationName}"
    android:icon="@mipmap/ic_launcher">
```

#### Update Package Name (Opsional)
Edit `android/app/build.gradle.kts`:
```kotlin
namespace = "com.studentnotes.app"
applicationId = "com.studentnotes.app"
```

### 3. Generate Keystore (Untuk Release)

```bash
# Windows
keytool -genkey -v -keystore %USERPROFILE%\student-notes-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias student-notes

# Linux/Mac
keytool -genkey -v -keystore ~/student-notes-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias student-notes
```

Isi informasi yang diminta:
- Password keystore (simpan dengan aman!)
- Nama lengkap
- Organisasi
- Kota
- Provinsi
- Kode negara

### 4. Konfigurasi Signing (Untuk Release)

Buat file `android/key.properties`:
```properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=student-notes
storeFile=C:/Users/YourUsername/student-notes-key.jks
```

**PENTING**: Jangan commit file `key.properties` ke Git!

Edit `android/app/build.gradle.kts`, tambahkan sebelum `android {`:
```kotlin
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}
```

Tambahkan di dalam `android { ... }`:
```kotlin
signingConfigs {
    create("release") {
        keyAlias = keystoreProperties["keyAlias"] as String
        keyPassword = keystoreProperties["keyPassword"] as String
        storeFile = file(keystoreProperties["storeFile"] as String)
        storePassword = keystoreProperties["storePassword"] as String
    }
}

buildTypes {
    getByName("release") {
        signingConfig = signingConfigs.getByName("release")
    }
}
```

### 5. Build APK

#### Debug APK (Untuk Testing)
```bash
flutter build apk --debug
```
Output: `build/app/outputs/flutter-apk/app-debug.apk`

#### Release APK (Untuk Distribusi)
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

#### Split APK per ABI (Ukuran lebih kecil)
```bash
flutter build apk --split-per-abi --release
```
Output:
- `app-armeabi-v7a-release.apk` (ARM 32-bit)
- `app-arm64-v8a-release.apk` (ARM 64-bit)
- `app-x86_64-release.apk` (x86 64-bit)

### 6. Build App Bundle (Untuk Google Play Store)

```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

### 7. Install APK ke Device

#### Via ADB
```bash
# Install debug APK
adb install build/app/outputs/flutter-apk/app-debug.apk

# Install release APK
adb install build/app/outputs/flutter-apk/app-release.apk
```

#### Via File Manager
1. Copy APK ke device
2. Buka file manager
3. Tap APK file
4. Allow "Install from Unknown Sources" jika diminta
5. Tap "Install"

## Troubleshooting

### Error: "Execution failed for task ':app:lintVitalRelease'"
```bash
# Disable lint checks
flutter build apk --release --no-tree-shake-icons
```

### Error: "Gradle build failed"
```bash
# Clean build
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk --release
```

### Error: "SDK location not found"
Buat file `android/local.properties`:
```properties
sdk.dir=C:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk
```

### APK Size Terlalu Besar
```bash
# Build dengan obfuscation
flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols

# Build split per ABI
flutter build apk --split-per-abi --release
```

## Optimasi APK

### 1. Shrink Resources
Edit `android/app/build.gradle.kts`:
```kotlin
buildTypes {
    getByName("release") {
        isMinifyEnabled = true
        isShrinkResources = true
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }
}
```

### 2. Enable R8 (Default di Flutter)
R8 sudah enabled by default untuk mengurangi ukuran APK.

### 3. Compress Native Libraries
Sudah otomatis di Flutter.

## Verifikasi APK

### Cek Signature
```bash
# Windows
keytool -printcert -jarfile app-release.apk

# Linux/Mac
jarsigner -verify -verbose -certs app-release.apk
```

### Cek Size
```bash
# Windows
dir build\app\outputs\flutter-apk\app-release.apk

# Linux/Mac
ls -lh build/app/outputs/flutter-apk/app-release.apk
```

### Test APK
1. Install di device fisik
2. Test semua fitur:
   - Login/Logout
   - CRUD catatan
   - Search & Filter
   - Dark mode
   - Persistence data

## Distribusi

### Google Play Store
1. Build App Bundle: `flutter build appbundle --release`
2. Upload `app-release.aab` ke Google Play Console
3. Isi informasi app (deskripsi, screenshot, dll)
4. Submit untuk review

### Direct Distribution
1. Build APK: `flutter build apk --release`
2. Upload `app-release.apk` ke hosting (Google Drive, Dropbox, dll)
3. Share link download
4. User harus enable "Install from Unknown Sources"

## Checklist Sebelum Release

- [ ] Test di multiple devices (berbeda OS version)
- [ ] Test semua fitur utama
- [ ] Test offline functionality
- [ ] Test dark mode
- [ ] Cek tidak ada data hardcoded
- [ ] Update version di `pubspec.yaml`
- [ ] Update version code di `android/app/build.gradle.kts`
- [ ] Generate signed APK/AAB
- [ ] Test signed APK di device
- [ ] Backup keystore file dengan aman
- [ ] Siapkan screenshot untuk store listing
- [ ] Tulis release notes

## Version Management

Edit `pubspec.yaml`:
```yaml
version: 1.0.0+1
# Format: MAJOR.MINOR.PATCH+BUILD_NUMBER
```

Edit `android/app/build.gradle.kts`:
```kotlin
defaultConfig {
    versionCode = 1
    versionName = "1.0.0"
}
```

Increment untuk setiap release:
- **MAJOR**: Breaking changes
- **MINOR**: New features
- **PATCH**: Bug fixes
- **BUILD_NUMBER**: Setiap build baru

## Resources

- [Flutter Build & Release](https://docs.flutter.dev/deployment/android)
- [Android App Signing](https://developer.android.com/studio/publish/app-signing)
- [Google Play Console](https://play.google.com/console)

---

**Catatan**: Simpan keystore file dan password dengan aman! Jika hilang, Anda tidak bisa update app di Play Store.
