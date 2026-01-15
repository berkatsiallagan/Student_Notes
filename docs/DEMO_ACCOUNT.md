# Demo Account - Student Notes

## 🎯 Akun Demo untuk Testing

Aplikasi Student Notes menyediakan akun demo yang sudah berisi data contoh untuk memudahkan testing.

---

## 📧 Kredensial Demo

```
Email:    demo@studentnotes.com
Password: demo123
```

**PENTING:** Akun ini dibuat otomatis saat pertama kali app dibuka!

---

## 📝 Data yang Sudah Ada

### User Profile
- **Nama:** Demo User
- **Email:** demo@studentnotes.com
- **Password:** demo123 (hashed dengan SHA-256)

### Mata Kuliah (5 courses)
1. ✅ Pemrograman Mobile
2. ✅ Basis Data
3. ✅ Algoritma & Struktur Data
4. ✅ Jaringan Komputer
5. ✅ Sistem Operasi

### Catatan (6 notes)
1. **Pengenalan Flutter** (Pemrograman Mobile) ⭐ Favorit
   - Penjelasan tentang Flutter framework
   - Keunggulan dan fitur-fitur Flutter

2. **Normalisasi Database** (Basis Data) ⭐ Favorit
   - Bentuk-bentuk normal (1NF, 2NF, 3NF)
   - Tujuan normalisasi

3. **Binary Search Tree** (Algoritma & Struktur Data)
   - Properti BST
   - Operasi dan kompleksitas

4. **TCP vs UDP** (Jaringan Komputer)
   - Perbedaan TCP dan UDP
   - Use cases masing-masing

5. **Process Scheduling** (Sistem Operasi)
   - Algoritma scheduling
   - FCFS, SJF, Round Robin, Priority

6. **Tips Belajar Efektif** (Pemrograman Mobile)
   - Tips praktis untuk belajar programming
   - Best practices

---

## 🚀 Cara Menggunakan

### Metode 1: Login Langsung (Recommended)

1. Buka aplikasi
2. Di login screen, lihat box hijau "Akun Demo Tersedia"
3. Gunakan kredensial:
   - Email: `demo@studentnotes.com`
   - Password: `demo123`
4. Tap "Masuk"
5. ✅ Langsung masuk dengan data contoh!

### Metode 2: Auto-Created

Akun demo dibuat otomatis saat:
- Pertama kali app dibuka
- Splash screen loading
- Sebelum redirect ke login screen

**Tidak perlu setup manual!**

---

## ✨ Fitur yang Bisa Dicoba

### 1. View Notes
- ✅ Lihat 6 catatan contoh
- ✅ 2 catatan sudah di-favorite
- ✅ Berbagai mata kuliah

### 2. CRUD Operations
- ✅ Buat catatan baru
- ✅ Edit catatan yang ada
- ✅ Hapus catatan
- ✅ Toggle favorite

### 3. Search & Filter
- ✅ Search "Flutter" → 2 hasil
- ✅ Filter by "Pemrograman Mobile" → 2 catatan
- ✅ Filter favorites only → 2 catatan
- ✅ Combine filters

### 4. Course Management
- ✅ Lihat 5 mata kuliah
- ✅ Tambah mata kuliah baru
- ✅ Hapus mata kuliah
- ✅ Pilih warna custom

### 5. Profile & Settings
- ✅ Lihat profile demo user
- ✅ Toggle dark mode
- ✅ Lihat statistik
- ✅ Logout (data tetap ada!)

---

## 🔐 Keamanan

### Password Hashing
```dart
Input:    "demo123"
Hashed:   "ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f"
```

Password di-hash dengan SHA-256, sama seperti user registration biasa.

### Data Isolation
- Akun demo terpisah dari user lain
- Data demo tidak bisa diakses user lain
- Setiap user punya data sendiri

---

## 🧪 Testing Scenarios

### Scenario 1: First Time User
```
1. Install app
2. Open app (splash screen)
3. Demo account auto-created
4. Login with demo credentials
5. Explore features
```

### Scenario 2: Data Persistence
```
1. Login with demo account
2. Add new note
3. Logout
4. Login again
5. ✅ All data still there (including new note)
```

### Scenario 3: CRUD Testing
```
1. Login with demo account
2. Create note → Success
3. Edit note → Success
4. Delete note → Success
5. Toggle favorite → Success
```

### Scenario 4: Search & Filter
```
1. Login with demo account
2. Search "Flutter" → 2 results
3. Filter "Basis Data" → 1 result
4. Filter favorites → 2 results
5. Clear filters → 6 results
```

---

## 📊 Demo Data Statistics

```
Total Users:     1 (Demo User)
Total Courses:   5 courses
Total Notes:     6 notes
Favorites:       2 notes
Oldest Note:     5 days ago
Newest Note:     Today
```

---

## 🔄 Reset Demo Account

### Cara 1: Hapus Semua Data
```
1. Login with demo account
2. Profile → Hapus Semua Data
3. Confirm
4. ✅ All notes deleted (courses remain)
```

### Cara 2: Uninstall & Reinstall
```
1. Uninstall app
2. Install app again
3. ✅ Fresh demo account created
```

### Cara 3: Manual Database Reset
```bash
# Via ADB
adb shell
run-as com.example.student_notes
cd databases
rm student_notes.db
exit
```

---

## 💡 Tips untuk Tester

### Do's ✅
- ✅ Test all CRUD operations
- ✅ Try search with different keywords
- ✅ Test multiple filters
- ✅ Add custom courses
- ✅ Toggle dark mode
- ✅ Test logout/login cycle

### Don'ts ❌
- ❌ Jangan hapus akun demo (untuk testing lain)
- ❌ Jangan ubah password demo (orang lain perlu akses)
- ❌ Jangan hapus semua courses (notes jadi orphan)

### Best Practices
1. **Test di device fisik** untuk experience yang real
2. **Test di berbagai Android version** (8.0 - 14.0)
3. **Test di berbagai screen size** (small, medium, large)
4. **Test offline mode** (matikan internet)
5. **Test dark mode** (toggle beberapa kali)

---

## 🐛 Known Issues

### None!
Demo account berfungsi dengan sempurna.

### Limitations
- Hanya 1 demo account (by design)
- Data demo bisa diedit/dihapus oleh siapa saja
- Tidak ada reset otomatis (harus manual)

---

## 📝 For Developers

### Auto-Creation Logic

```dart
// In splash_screen.dart
Future<void> _checkLoginStatus() async {
  // Create demo account if not exists
  await DemoSeeder.createDemoAccount();
  
  // Continue with normal flow
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  await userProvider.checkLoginStatus();
  // ...
}
```

### Demo Seeder Class

```dart
// lib/utils/demo_seeder.dart
class DemoSeeder {
  static const String demoEmail = 'demo@studentnotes.com';
  static const String demoPassword = 'demo123';
  
  static Future<void> createDemoAccount() async {
    // Check if exists
    if (await demoAccountExists()) return;
    
    // Create user
    // Create courses
    // Create notes
  }
}
```

### Customization

Untuk mengubah data demo, edit file:
```
lib/utils/demo_seeder.dart
```

Ubah:
- Email/password demo
- Jumlah courses
- Jumlah notes
- Konten notes

---

## 🎯 Use Cases

### For Testers
- Quick testing tanpa setup
- Consistent test data
- Reproducible scenarios

### For Demos
- Show features to stakeholders
- Present to clients
- App store screenshots

### For Development
- Test UI dengan real data
- Debug dengan consistent data
- Performance testing

---

## 📞 Support

Jika demo account tidak berfungsi:

1. **Check logs:**
   ```bash
   flutter run
   # Look for: "Demo account setup complete!"
   ```

2. **Verify database:**
   ```bash
   adb shell
   run-as com.example.student_notes
   cd databases
   sqlite3 student_notes.db
   SELECT * FROM users WHERE email='demo@studentnotes.com';
   ```

3. **Reset app:**
   ```bash
   adb uninstall com.example.student_notes
   flutter run
   ```

---

## ✅ Verification Checklist

Setelah install, verify:

- [ ] Demo account auto-created
- [ ] Can login with demo credentials
- [ ] 5 courses visible
- [ ] 6 notes visible
- [ ] 2 notes marked as favorite
- [ ] Search works
- [ ] Filter works
- [ ] CRUD operations work
- [ ] Logout preserves data
- [ ] Login again shows same data

---

## 🎉 Summary

**Demo Account Ready!**

```
✅ Email: demo@studentnotes.com
✅ Password: demo123
✅ Auto-created on first launch
✅ 6 sample notes included
✅ 5 courses pre-configured
✅ Ready for testing!
```

**Happy Testing! 🚀**

---

**Last Updated:** January 15, 2026  
**Version:** 1.0.1+2  
**Status:** Active & Working
