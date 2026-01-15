# Installation Guide - Student Notes v1.0.1

## 📱 Panduan Instalasi APK

---

## 📦 Download APK

### File yang Tersedia

**Universal APK (Recommended)**
- **File:** `app-release.apk`
- **Size:** 48.6 MB
- **Compatible:** Semua device Android
- **Download:** [Link to APK]

---

## 🚀 Cara Instalasi

### Step 1: Enable Unknown Sources

1. Buka **Settings** di Android
2. Pilih **Security** atau **Privacy**
3. Aktifkan **Install from Unknown Sources** atau **Allow from this source**
4. Pilih browser/file manager yang akan digunakan

**Catatan:** Lokasi setting bisa berbeda tergantung Android version.

---

### Step 2: Download APK

1. Download `app-release.apk` dari link yang disediakan
2. Tunggu sampai download selesai
3. Buka **Downloads** folder atau notification

---

### Step 3: Install APK

1. Tap file `app-release.apk`
2. Tap **Install**
3. Tunggu proses instalasi (5-10 detik)
4. Tap **Open** atau **Done**

---

### Step 4: First Launch

1. Buka aplikasi **Student Notes**
2. Tunggu splash screen (2-3 detik)
3. **Demo account otomatis dibuat!**
4. Anda akan diarahkan ke login screen

---

## 🎯 Login Pertama Kali

### Option 1: Gunakan Akun Demo (Recommended untuk Testing)

```
Email:    demo@studentnotes.com
Password: demo123
```

**Keuntungan:**
- ✅ Langsung bisa testing
- ✅ Sudah ada 6 catatan contoh
- ✅ Sudah ada 5 mata kuliah
- ✅ 2 catatan favorit

**Cara:**
1. Di login screen, lihat box hijau "Akun Demo Tersedia"
2. Masukkan email: `demo@studentnotes.com`
3. Masukkan password: `demo123`
4. Tap "Masuk"
5. ✅ Selesai!

---

### Option 2: Buat Akun Baru

**Cara:**
1. Di login screen, tap "Daftar Sekarang"
2. Isi form registrasi:
   - Nama lengkap
   - Email (gunakan email valid)
   - Password (minimal 6 karakter)
   - Konfirmasi password
3. Tap "Daftar"
4. Kembali ke login screen
5. Login dengan email dan password yang baru dibuat

---

## ⚠️ Upgrade dari Versi Lama

### PENTING: Uninstall Dulu!

Jika Anda sudah install versi 1.0.0, **HARUS uninstall dulu**:

```
1. Settings → Apps → Student Notes
2. Tap "Uninstall"
3. Confirm
4. Install versi baru (app-release.apk)
```

**Alasan:**
- Database schema berubah
- Direct upgrade akan crash
- Data lama tidak bisa di-migrate

---

## 🔧 Troubleshooting

### Issue 1: "App not installed"

**Penyebab:**
- Signature mismatch (ada versi lama)
- Storage penuh
- APK corrupt

**Solusi:**
```
1. Uninstall versi lama
2. Clear cache: Settings → Storage → Clear Cache
3. Restart device
4. Install lagi
```

---

### Issue 2: "Parse error"

**Penyebab:**
- APK corrupt
- Download tidak lengkap
- Android version terlalu lama

**Solusi:**
```
1. Download ulang APK
2. Verify file size (harus 48.6 MB)
3. Check Android version (minimal 5.0)
```

---

### Issue 3: "Installation blocked"

**Penyebab:**
- Unknown sources belum diaktifkan
- Play Protect blocking

**Solusi:**
```
1. Enable "Install from Unknown Sources"
2. Disable Play Protect sementara:
   - Play Store → Menu → Play Protect
   - Settings → Disable "Scan apps with Play Protect"
3. Install APK
4. Enable Play Protect lagi
```

---

### Issue 4: App crash saat dibuka

**Penyebab:**
- Versi lama masih ada
- Database conflict

**Solusi:**
```
1. Uninstall app
2. Clear app data:
   adb shell pm clear com.example.student_notes
3. Restart device
4. Install ulang
```

---

## 📋 System Requirements

### Minimum
- **Android:** 5.0 (Lollipop) or higher
- **RAM:** 1 GB
- **Storage:** 100 MB free space
- **Screen:** 4.5 inch or larger

### Recommended
- **Android:** 8.0 (Oreo) or higher
- **RAM:** 2 GB or more
- **Storage:** 200 MB free space
- **Screen:** 5.5 inch or larger

### Tested On
- ✅ Android 8.0 (Oreo)
- ✅ Android 9.0 (Pie)
- ✅ Android 10.0
- ✅ Android 11.0
- ✅ Android 12.0
- ✅ Android 13.0
- ✅ Android 14.0

---

## 🔐 Permissions

### Required Permissions
- **Storage:** Untuk menyimpan database lokal
- **Internet:** Untuk future features (cloud sync)

### Optional Permissions
- None

**Catatan:** App berfungsi 100% offline, tidak perlu internet.

---

## ✅ Verification

Setelah install, verify:

### 1. App Installed
```
Settings → Apps → Student Notes
- Version: 1.0.1
- Size: ~50 MB
```

### 2. Demo Account Created
```
Login dengan:
- Email: demo@studentnotes.com
- Password: demo123
- Harus berhasil login
```

### 3. Sample Data Available
```
Setelah login:
- 6 catatan terlihat
- 5 mata kuliah tersedia
- 2 catatan favorit
```

---

## 🎯 Quick Start

### 5 Menit Pertama

**Menit 1-2: Install & Login**
```
1. Install APK
2. Buka app
3. Login dengan demo account
```

**Menit 3: Explore Features**
```
1. Lihat dashboard
2. Tap salah satu catatan
3. Lihat detail
```

**Menit 4: Try CRUD**
```
1. Tap FAB (+)
2. Buat catatan baru
3. Save
```

**Menit 5: Try Search**
```
1. Tap search icon
2. Ketik "Flutter"
3. Lihat hasil
```

---

## 📞 Support

### Jika Ada Masalah

1. **Check dokumentasi:**
   - README.md
   - DEMO_ACCOUNT.md
   - TROUBLESHOOTING.md

2. **Check logs:**
   ```bash
   adb logcat | grep StudentNotes
   ```

3. **Report issue:**
   - Device model
   - Android version
   - Steps to reproduce
   - Screenshots

---

## 🔄 Update ke Versi Baru

### Cara Update (Future)

```
1. Download APK versi baru
2. Tap APK file
3. Tap "Update"
4. ✅ Data tetap ada (jika tidak ada breaking changes)
```

**Catatan:** Untuk v1.0.1, harus uninstall dulu karena breaking changes.

---

## 🎉 Selesai!

Anda sudah berhasil install Student Notes!

### Next Steps:

1. ✅ Login dengan demo account
2. ✅ Explore semua fitur
3. ✅ Buat catatan sendiri
4. ✅ Customize mata kuliah
5. ✅ Enjoy! 📝

---

**Version:** 1.0.1 (Build 2)  
**Release Date:** January 15, 2026  
**APK Size:** 48.6 MB  
**Status:** Stable Release

---

**Happy Note-Taking! 🚀**
