# Instruksi Testing - Student Notes v1.0.1

## 🎯 Langkah Testing yang Harus Dilakukan

### PENTING: Fresh Install Wajib!

Karena ada perubahan database schema, Anda **HARUS** uninstall aplikasi lama terlebih dahulu.

---

## 📋 Langkah-Langkah Testing

### Step 1: Uninstall Aplikasi Lama

```
1. Buka Settings di HP
2. Pilih Apps / Aplikasi
3. Cari "Student Notes"
4. Tap "Uninstall"
5. Konfirmasi uninstall
6. Restart HP (recommended)
```

**Atau via ADB:**
```bash
adb uninstall com.example.student_notes
adb reboot
```

---

### Step 2: Install APK Baru

```
1. Copy file: build/app/outputs/flutter-apk/app-release.apk ke HP
2. Buka file APK di HP
3. Izinkan install dari sumber tidak dikenal (jika diminta)
4. Tap "Install"
5. Tunggu sampai selesai
6. Tap "Open" atau buka dari app drawer
```

**Atau via ADB:**
```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

---

### Step 3: Test Demo Account (PRIORITAS PERTAMA)

```
1. Buka aplikasi Student Notes
2. Tunggu splash screen selesai
3. Di halaman login, scroll ke bawah
4. Lihat kotak hijau "Akun Demo Tersedia"
5. Masukkan credentials:
   Email:    demo@studentnotes.com
   Password: demo123
6. Tap "Masuk"
```

**Expected Result:**
- ✅ Login berhasil
- ✅ Masuk ke Dashboard
- ✅ Melihat 6 catatan contoh
- ✅ Melihat 5 mata kuliah

**If Failed:**
- ❌ Tampil "Email atau password salah"
- 🔧 Lakukan Emergency Reset (lihat di bawah)

---

### Step 4: Test Logout & Login Ulang

```
1. Dari Dashboard, tap icon profile (kanan atas)
2. Scroll ke bawah
3. Tap "Keluar"
4. Konfirmasi logout
5. Kembali ke halaman login
6. Login lagi dengan demo account:
   Email:    demo@studentnotes.com
   Password: demo123
7. Tap "Masuk"
```

**Expected Result:**
- ✅ Login berhasil
- ✅ Semua 6 catatan masih ada (tidak hilang)
- ✅ Semua mata kuliah masih ada

---

### Step 5: Test Register Akun Baru

```
1. Dari halaman login, tap "Daftar Sekarang"
2. Isi form registrasi:
   Nama:              Test User
   Email:             test@example.com
   Password:          test123
   Konfirmasi:        test123
3. Tap "Daftar"
4. Tunggu proses registrasi
```

**Expected Result:**
- ✅ Muncul snackbar "Registrasi berhasil"
- ✅ Kembali ke halaman login

**If Failed:**
- ❌ Muncul error "Email sudah terdaftar"
  → Gunakan email lain (test2@example.com)
- ❌ Muncul error lain
  → Screenshot dan laporkan

---

### Step 6: Test Login dengan Akun Baru

```
1. Di halaman login, masukkan:
   Email:    test@example.com
   Password: test123
2. Tap "Masuk"
```

**Expected Result:**
- ✅ Login berhasil
- ✅ Masuk ke Dashboard
- ✅ Dashboard kosong (belum ada catatan)
- ✅ Nama "Test User" muncul di profile

**If Failed:**
- ❌ Tampil "Email atau password salah"
- 🚨 INI MASALAH UTAMA - laporkan segera!

---

### Step 7: Test CRUD Catatan

```
1. Tap tombol "+" (Floating Action Button)
2. Isi form:
   Judul:        Test Note
   Mata Kuliah:  Pilih salah satu
   Konten:       Ini adalah catatan test
3. Tap "Simpan"
4. Kembali ke Dashboard
5. Lihat catatan baru muncul
6. Tap catatan untuk edit
7. Ubah judul menjadi "Test Note Updated"
8. Tap "Simpan"
9. Kembali ke Dashboard
10. Lihat perubahan tersimpan
```

**Expected Result:**
- ✅ Catatan berhasil dibuat
- ✅ Catatan berhasil diupdate
- ✅ Perubahan tersimpan

---

### Step 8: Test CRUD Mata Kuliah

```
1. Dari Dashboard, tap icon menu (kiri atas)
2. Pilih "Kelola Mata Kuliah"
3. Tap tombol "+" (kanan bawah)
4. Isi nama: "Test Course"
5. Pilih warna
6. Tap "Simpan"
7. Lihat mata kuliah baru muncul
8. Tap mata kuliah untuk edit
9. Ubah nama menjadi "Updated Course"
10. Tap "Simpan"
11. Lihat perubahan tersimpan
```

**Expected Result:**
- ✅ Mata kuliah berhasil dibuat
- ✅ Mata kuliah berhasil diupdate
- ✅ Bisa digunakan saat buat catatan baru

---

## 🐛 Jika Ada Masalah

### Emergency Reset

Jika login tetap gagal setelah fresh install:

```bash
# Via ADB
adb uninstall com.example.student_notes
adb shell pm clear com.example.student_notes
adb reboot

# Tunggu HP restart
# Install ulang APK
adb install build/app/outputs/flutter-apk/app-release.apk

# Test demo account lagi
```

---

### Debug Mode (Untuk Developer)

Jika ingin lihat debug logs:

```bash
# Connect HP via USB
# Enable USB Debugging

# Run in debug mode
flutter run

# Atau lihat logcat
adb logcat | findstr "=== password hash"
```

**Look for:**
```
=== REGISTER ATTEMPT ===
Name: Test User
Email: test@example.com
Hashed password: [hash]
User created successfully!

=== LOGIN ATTEMPT ===
Email: test@example.com
User found: Test User
Password valid: true
Login successful!
```

---

## ✅ Checklist Testing

Centang setiap test yang berhasil:

- [ ] Fresh install (uninstall old app)
- [ ] Demo account login berhasil
- [ ] Logout & login ulang berhasil
- [ ] Data tidak hilang setelah logout
- [ ] Register akun baru berhasil
- [ ] Login dengan akun baru berhasil
- [ ] CRUD catatan berfungsi
- [ ] CRUD mata kuliah berfungsi
- [ ] Search & filter berfungsi
- [ ] Dark mode berfungsi

---

## 📊 Hasil Testing

### Jika Semua Test Passed ✅

**Berarti:**
- ✅ Bug login sudah fixed
- ✅ Database migration berhasil
- ✅ Password hashing berfungsi
- ✅ Demo account auto-creation berfungsi
- ✅ Data persistence berfungsi

**Next Steps:**
- Aplikasi siap digunakan
- Bisa mulai buat catatan kuliah
- Bisa share APK ke teman

---

### Jika Ada Test Failed ❌

**Laporkan dengan info:**

1. **Test mana yang gagal?**
   - Demo account login?
   - Register?
   - Login setelah register?

2. **Error message apa yang muncul?**
   - Screenshot error

3. **Device info:**
   - Model HP: _______
   - Android version: _______
   - RAM: _______

4. **Steps yang dilakukan:**
   - Apakah sudah uninstall app lama?
   - Apakah sudah restart HP?
   - Apakah fresh install?

5. **Debug logs (jika ada):**
   ```
   Paste logs dari flutter run atau adb logcat
   ```

---

## 🎯 Priority Testing

**Test ini PALING PENTING:**

### Test #1: Demo Account Login
```
Email:    demo@studentnotes.com
Password: demo123
```

**Jika ini berhasil** → Bug sudah fixed! ✅

**Jika ini gagal** → Masih ada masalah, perlu investigasi lebih lanjut ❌

---

### Test #2: Register & Login
```
1. Register dengan email baru
2. Login dengan email tersebut
```

**Jika ini berhasil** → Authentication system berfungsi sempurna! ✅

**Jika ini gagal** → Ada masalah di password hashing atau database ❌

---

## 📞 Contact

Jika ada masalah atau pertanyaan:

1. Screenshot error message
2. Copy debug logs (jika ada)
3. Isi checklist testing di atas
4. Laporkan dengan detail

---

## 💡 Tips

### Do's ✅
- ✅ Uninstall app lama sebelum install baru
- ✅ Restart HP setelah uninstall
- ✅ Test demo account dulu
- ✅ Gunakan email valid saat register
- ✅ Password minimal 6 karakter
- ✅ Screenshot jika ada error

### Don'ts ❌
- ❌ Jangan install over app lama
- ❌ Jangan skip uninstall step
- ❌ Jangan gunakan spasi di password
- ❌ Jangan gunakan email yang sudah terdaftar
- ❌ Jangan clear app data saat app running

---

**Version:** 1.0.1+2  
**Last Updated:** January 15, 2026  
**Status:** Ready for Testing

---

## 🚀 Quick Start

**Cara tercepat untuk test:**

```
1. Uninstall app lama
2. Restart HP
3. Install APK baru
4. Buka app
5. Login dengan:
   Email:    demo@studentnotes.com
   Password: demo123
6. ✅ Done!
```

Jika step ini berhasil, berarti semua fix sudah berfungsi dengan baik! 🎉
