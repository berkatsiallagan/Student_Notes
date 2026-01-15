# Quick Start Guide - Student Notes

## 🚀 Mulai Cepat dalam 5 Menit

### 1. Install Dependencies (1 menit)

```bash
cd student_notes
flutter pub get
```

### 2. Jalankan Aplikasi (30 detik)

```bash
flutter run
```

Atau pilih device:
```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web
flutter run -d chrome

# Windows
flutter run -d windows
```

### 3. Login (30 detik)

**Mode Demo - Gunakan kredensial apapun:**
- Email: `demo@test.com` (atau email apapun)
- Password: `123456` (atau password apapun minimal 6 karakter)

Atau klik **"Masuk dengan Google"** untuk login instant.

### 4. Buat Catatan Pertama (1 menit)

1. Tap tombol **"Buat Catatan"** (FAB di kanan bawah)
2. Isi form:
   - **Judul**: "Catatan Flutter Pertama"
   - **Mata Kuliah**: Pilih "Pemrograman Mobile"
   - **Konten**: "Belajar Flutter itu menyenangkan!"
3. Tap **"Simpan Catatan"**

### 5. Explore Fitur (2 menit)

- **Search**: Tap icon 🔍 di AppBar
- **Filter**: Tap icon ⚙️ untuk filter by course atau favorites
- **Edit**: Tap note card untuk edit
- **Favorite**: Tap ⭐ pada note card
- **Dark Mode**: Profile → Toggle "Mode Gelap"

---

## 📱 Fitur Utama

### ✅ Yang Bisa Dilakukan

1. **Buat Catatan**
   - Judul, mata kuliah, konten
   - Auto-save timestamp
   - Validasi input

2. **Edit & Hapus**
   - Edit catatan kapan saja
   - Hapus dengan konfirmasi
   - Undo changes detection

3. **Search & Filter**
   - Search real-time
   - Filter by course
   - Show favorites only
   - Combine filters

4. **Offline Mode**
   - Semua data lokal (SQLite)
   - Tidak perlu internet
   - Data aman dan cepat

5. **Dark Mode**
   - Toggle light/dark theme
   - Auto-save preference
   - Smooth transition

---

## 🎯 Use Cases

### Mahasiswa
- Catat materi kuliah per mata kuliah
- Tandai catatan penting sebagai favorit
- Cari catatan dengan cepat
- Akses offline di kelas

### Pelajar
- Organize notes by subject
- Quick search untuk review
- Dark mode untuk belajar malam
- Backup otomatis (lokal)

### Professional
- Meeting notes
- Project documentation
- Quick reference
- Organized by category

---

## 🔧 Troubleshooting

### App tidak bisa run?

```bash
# Clean dan rebuild
flutter clean
flutter pub get
flutter run
```

### Error di Android?

```bash
# Update gradle
cd android
./gradlew clean
cd ..
flutter run
```

### Error di iOS?

```bash
# Update pods
cd ios
pod install
cd ..
flutter run
```

### Database error?

```bash
# Clear app data
flutter run --clear-cache
```

Atau uninstall app dan install ulang.

---

## 📚 Dokumentasi Lengkap

- **README.md** - Overview & setup
- **FEATURES.md** - Daftar lengkap fitur
- **BUILD_INSTRUCTIONS.md** - Cara build APK
- **TESTING_GUIDE.md** - Testing scenarios
- **API_DOCUMENTATION.md** - API reference
- **CHANGELOG.md** - Version history

---

## 💡 Tips & Tricks

### Productivity Tips

1. **Gunakan Search** untuk find notes cepat
2. **Favorite** catatan penting untuk quick access
3. **Filter by Course** untuk focus per mata kuliah
4. **Dark Mode** untuk reduce eye strain
5. **Pull to Refresh** untuk update data

### Keyboard Shortcuts (Desktop)

- `Ctrl/Cmd + N` - New note (future)
- `Ctrl/Cmd + S` - Save note (future)
- `Ctrl/Cmd + F` - Search (future)
- `Ctrl/Cmd + D` - Toggle dark mode (future)

### Best Practices

1. **Judul yang Jelas** - Mudah dicari
2. **Gunakan Mata Kuliah** - Organize better
3. **Favorite Penting** - Quick access
4. **Regular Backup** - Export data (future)

---

## 🎨 Customization

### Tambah Mata Kuliah Baru

Saat ini ada 5 default courses. Untuk tambah:

1. Edit `lib/providers/course_provider.dart`
2. Tambah di `_addDefaultCourses()`:
```dart
final defaultCourses = [
  'Pemrograman Mobile',
  'Basis Data',
  'Your New Course', // Add here
];
```

### Ubah Warna Theme

Edit `lib/utils/constants.dart`:
```dart
static const Color primaryColor = Color(0xFF2D5B8F); // Change this
```

### Ubah Font

Edit `lib/utils/theme.dart`:
```dart
textTheme: GoogleFonts.robotoTextTheme(), // Change font
```

---

## 🐛 Known Issues

1. **Google Sign-In** - Mode simulasi (not real Firebase)
2. **No Cloud Sync** - Data hanya lokal (planned v2.0)
3. **No Rich Text** - Plain text only (planned v2.0)

---

## 🚀 Next Steps

### Untuk User
1. Buat beberapa catatan
2. Explore search & filter
3. Try dark mode
4. Favorite important notes

### Untuk Developer
1. Baca API_DOCUMENTATION.md
2. Explore source code
3. Run tests (future)
4. Contribute features

---

## 📞 Support

### Issues?
- Check TROUBLESHOOTING section
- Read documentation
- Check GitHub issues (if public)

### Feature Requests?
- See CHANGELOG.md untuk roadmap
- Submit feature request (if public)

---

## ⭐ Quick Commands Cheat Sheet

```bash
# Development
flutter run                    # Run app
flutter run --release         # Run release mode
flutter hot-reload            # Hot reload (r in terminal)
flutter hot-restart           # Hot restart (R in terminal)

# Build
flutter build apk             # Build debug APK
flutter build apk --release   # Build release APK
flutter build appbundle       # Build app bundle

# Maintenance
flutter clean                 # Clean build
flutter pub get              # Get dependencies
flutter pub upgrade          # Upgrade dependencies
flutter analyze              # Analyze code
flutter doctor               # Check setup

# Testing
flutter test                 # Run tests (future)
flutter drive                # Integration tests (future)
```

---

## 🎉 Selamat!

Anda sudah siap menggunakan Student Notes!

**Happy Note-Taking! 📝**

---

**Version:** 1.0.0  
**Last Updated:** January 15, 2026  
**Platform:** Flutter 3.9.2+
