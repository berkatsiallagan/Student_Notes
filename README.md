# Student Notes - Aplikasi Pencatatan Kuliah Digital

Aplikasi mobile untuk mahasiswa yang memungkinkan pencatatan kuliah digital dengan fitur lengkap, offline-first, dan user-friendly.

## 🎯 Fitur Utama

### 1. **Autentikasi & Session Management**
- Login dengan email & password
- Login dengan Google (simulasi)
- Session persistence - auto-login setelah login pertama
- Logout dengan konfirmasi

### 2. **CRUD Catatan Kuliah**
- Buat catatan baru dengan judul, mata kuliah, dan konten
- Edit catatan yang sudah ada
- Hapus catatan dengan konfirmasi
- Toggle favorit untuk catatan penting
- Auto-save draft detection

### 3. **Search & Filter System**
- Pencarian real-time berdasarkan judul dan konten
- Filter berdasarkan mata kuliah
- Filter hanya catatan favorit
- Kombinasi multiple filters

### 4. **Offline-First Architecture**
- Semua data tersimpan di SQLite local database
- Tidak memerlukan koneksi internet
- Data persisten dan aman

### 5. **UI/UX Modern**
- Material Design 3
- Dark mode support
- Loading shimmer effects
- Empty states dengan ilustrasi
- Smooth animations
- Responsive design

### 6. **Dashboard & Statistik**
- Total catatan
- Jumlah mata kuliah
- Jumlah catatan favorit
- Daftar catatan terbaru

## 📱 Struktur Halaman

1. **Splash Screen** - Logo animasi dan auto-redirect
2. **Login Screen** - Email/password dan Google Sign-In
3. **Home Screen** - Dashboard dengan daftar catatan
4. **Note Detail Screen** - CRUD catatan
5. **Profile Screen** - Profil user dan pengaturan

## 🗂️ Struktur Project

```
lib/
├── main.dart                    # Entry point aplikasi
├── models/                      # Data models
│   ├── user.dart
│   ├── note.dart
│   └── course.dart
├── database/                    # SQLite database
│   └── database_helper.dart
├── providers/                   # State management (Provider)
│   ├── user_provider.dart
│   ├── note_provider.dart
│   ├── course_provider.dart
│   └── theme_provider.dart
├── screens/                     # UI Screens
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── note_detail_screen.dart
│   └── profile_screen.dart
├── widgets/                     # Reusable widgets
│   ├── note_card.dart
│   ├── custom_appbar.dart
│   ├── empty_state.dart
│   └── loading_shimmer.dart
└── utils/                       # Utilities
    ├── constants.dart
    ├── validators.dart
    └── theme.dart
```

## 🗄️ Database Schema

### Users Table
```sql
CREATE TABLE users (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  photo_url TEXT
)
```

### Courses Table
```sql
CREATE TABLE courses (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  course_name TEXT NOT NULL,
  color_code TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users (id)
)
```

### Notes Table
```sql
CREATE TABLE notes (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  title TEXT NOT NULL,
  course TEXT NOT NULL,
  content TEXT NOT NULL,
  date_created TEXT NOT NULL,
  date_updated TEXT NOT NULL,
  is_favorite INTEGER NOT NULL DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES users (id)
)
```

## 🚀 Cara Menjalankan

### Prerequisites
- Flutter SDK (3.9.2 atau lebih baru)
- Dart SDK
- Android Studio / VS Code
- Android Emulator / iOS Simulator / Physical Device

### Instalasi

1. **Clone atau buka project**
```bash
cd student_notes
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Jalankan aplikasi**
```bash
flutter run
```

### Mode Demo
Aplikasi ini berjalan dalam mode demo. Anda bisa login dengan:
- **Email**: apa saja (contoh: demo@test.com)
- **Password**: apa saja (minimal 6 karakter)
- **Google Sign-In**: Klik tombol "Masuk dengan Google"

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  google_fonts: ^6.1.0
  provider: ^6.1.1
  sqflite: ^2.3.0
  path_provider: ^2.1.1
  path: ^1.8.3
  shared_preferences: ^2.2.2
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  google_sign_in: ^6.2.1
  intl: ^0.19.0
  uuid: ^4.3.3
```

## 🎨 Design System

### Colors
- **Primary**: #2D5B8F (Biru Akademik)
- **Secondary**: #4A90E2 (Biru Terang)
- **Accent**: #FFB74D (Orange)
- **Background**: #F5F7FA (Abu-abu Terang)

### Typography
- **Font Family**: Poppins (via Google Fonts)
- **Heading**: Bold, 24-32px
- **Body**: Regular, 14-16px
- **Caption**: Regular, 12px

## 🔧 Fitur Teknis

### State Management
- **Provider** untuk global state management
- Reactive UI updates
- Efficient rebuilds

### Data Persistence
- **SQLite** untuk local database
- **SharedPreferences** untuk session storage
- Automatic data migration

### Validation
- Email format validation
- Password strength validation
- Form field validation
- Input sanitization

### Error Handling
- Database error handling
- Network error handling (untuk future Firebase integration)
- User-friendly error messages
- Graceful degradation

## 📱 Build APK Release

### Android

1. **Generate keystore** (jika belum ada)
```bash
keytool -genkey -v -keystore student-notes-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias student-notes
```

2. **Build APK**
```bash
flutter build apk --release
```

3. **Build App Bundle** (untuk Google Play)
```bash
flutter build appbundle --release
```

APK akan tersimpan di: `build/app/outputs/flutter-apk/app-release.apk`

### iOS

```bash
flutter build ios --release
```

## 🧪 Testing Scenario

### 1. Authentication Flow
- [ ] Login dengan email/password
- [ ] Login dengan Google
- [ ] Auto-login setelah restart app
- [ ] Logout

### 2. CRUD Operations
- [ ] Buat catatan baru
- [ ] Edit catatan
- [ ] Hapus catatan
- [ ] Toggle favorit

### 3. Search & Filter
- [ ] Search by title
- [ ] Search by content
- [ ] Filter by course
- [ ] Filter favorites only
- [ ] Clear filters

### 4. UI/UX
- [ ] Dark mode toggle
- [ ] Loading states
- [ ] Empty states
- [ ] Error handling
- [ ] Animations

## 📝 Sample Data

Aplikasi akan otomatis membuat 5 mata kuliah default:
1. Pemrograman Mobile
2. Basis Data
3. Algoritma & Struktur Data
4. Jaringan Komputer
5. Sistem Operasi

## 🎯 Future Enhancements

- [ ] Firebase Firestore sync
- [ ] Real Google Sign-In integration
- [ ] Rich text editor
- [ ] Image attachments
- [ ] Export to PDF
- [ ] Reminder notifications
- [ ] Cloud backup
- [ ] Sharing notes

## 👨‍💻 Developer Notes

### Key Implementation Details

1. **Session Persistence**: Menggunakan SharedPreferences untuk menyimpan user session. Setelah login, user ID disimpan dan dicek saat app startup.

2. **Offline-First**: Semua operasi CRUD dilakukan di SQLite local database. Tidak ada dependency ke network.

3. **State Management**: Provider pattern untuk reactive state updates. Setiap perubahan data otomatis update UI.

4. **Validation**: Input validation di form level dan business logic level untuk data integrity.

5. **Error Handling**: Try-catch blocks dengan user-friendly error messages via SnackBar.

## 📄 License

This project is created for educational purposes.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

---

**Dibuat dengan ❤️ menggunakan Flutter**
