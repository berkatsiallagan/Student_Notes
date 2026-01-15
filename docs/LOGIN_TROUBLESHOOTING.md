# Login Troubleshooting - Student Notes

## 🔧 Panduan Mengatasi Masalah Login

Jika Anda mengalami masalah "Email atau password salah" padahal sudah benar, ikuti panduan ini.

---

## ⚠️ PENTING: Uninstall App Lama!

### Masalah Utama
Jika Anda pernah install versi lama (v1.0.0), database schema-nya berbeda dan akan menyebabkan masalah login.

### Solusi: Fresh Install

```bash
1. Uninstall aplikasi lama
   Settings → Apps → Student Notes → Uninstall

2. Restart device (recommended)

3. Install APK baru (v1.0.1)

4. Buka app (demo account auto-created)

5. Register akun baru atau login dengan demo
```

---

## 🎯 Testing Login

### Test 1: Demo Account

```
Email:    demo@studentnotes.com
Password: demo123
```

**Steps:**
1. Buka app
2. Masukkan email: `demo@studentnotes.com`
3. Masukkan password: `demo123`
4. Tap "Masuk"

**Expected:** Login berhasil, masuk ke dashboard dengan 6 catatan

**If Failed:**
- Uninstall app
- Delete app data: `adb shell pm clear com.example.student_notes`
- Install ulang
- Try again

---

### Test 2: Register New Account

```
1. Tap "Daftar Sekarang"
2. Isi form:
   - Nama: Test User
   - Email: test@example.com
   - Password: test123
   - Konfirmasi: test123
3. Tap "Daftar"
4. Kembali ke login
5. Login dengan:
   - Email: test@example.com
   - Password: test123
```

**Expected:** Login berhasil

---

## 🐛 Common Issues & Solutions

### Issue 1: "Email atau password salah" (Demo Account)

**Penyebab:**
- Demo account belum dibuat
- Database corrupt
- App lama masih ada

**Solusi:**
```bash
# Option 1: Uninstall & Reinstall
adb uninstall com.example.student_notes
adb install app-release.apk

# Option 2: Clear app data
adb shell pm clear com.example.student_notes

# Option 3: Delete database
adb shell
run-as com.example.student_notes
cd databases
rm student_notes.db
exit
```

---

### Issue 2: "Email atau password salah" (After Register)

**Penyebab:**
- Password tidak tersimpan dengan benar
- Database error
- Hash mismatch

**Solusi:**
```
1. Check logs:
   flutter run
   # Look for:
   # "=== REGISTER ATTEMPT ==="
   # "User created successfully!"

2. Try register dengan email berbeda

3. If still fails, uninstall & reinstall
```

---

### Issue 3: Register Berhasil tapi Login Gagal

**Penyebab:**
- Password hash tidak match
- Database migration issue

**Debug Steps:**
```bash
# Run in debug mode
flutter run

# Watch logs saat register:
# "=== REGISTER ATTEMPT ==="
# "Hashed password: [hash]"
# "User created successfully!"

# Watch logs saat login:
# "=== LOGIN ATTEMPT ==="
# "User found: [name]"
# "Expected hash: [hash]"
# "Stored hash: [hash]"
# "Match: true/false"
```

**Solusi:**
```
If hashes don't match:
1. Uninstall app
2. Install fresh
3. Register again
4. Login immediately after register
```

---

## 🔍 Debug Mode

### Enable Debug Logging

App sudah include debug logging. Untuk melihat:

```bash
# Run in debug mode
flutter run

# Or check logcat
adb logcat | grep "StudentNotes\|===\|password\|hash"
```

### What to Look For

**Successful Register:**
```
=== REGISTER ATTEMPT ===
Name: Test User
Email: test@example.com
Hashed password: ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f
Creating user with ID: 1234567890
=== CREATE USER WITH PASSWORD ===
User inserted successfully
User created successfully!
```

**Successful Login:**
```
=== LOGIN ATTEMPT ===
Email: test@example.com
Hashed password: ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f
User found: Test User (1234567890)
=== VERIFY PASSWORD ===
Expected hash: ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f
Stored hash: ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f
Match: true
Password valid: true
Login successful!
```

**Failed Login:**
```
=== LOGIN ATTEMPT ===
Email: test@example.com
User not found with email: test@example.com
```
OR
```
=== VERIFY PASSWORD ===
Expected hash: [hash1]
Stored hash: [hash2]
Match: false
Password verification failed
```

---

## 🔐 Password Hashing

### How It Works

```dart
Input:    "demo123"
SHA-256:  ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f
```

Password di-hash dengan SHA-256 sebelum disimpan dan saat login.

### Verify Hash

Untuk verify password hash:

```bash
# Python
python3 -c "import hashlib; print(hashlib.sha256(b'demo123').hexdigest())"

# Output should be:
# ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f
```

---

## 📊 Database Check

### Verify Demo Account

```bash
adb shell
run-as com.example.student_notes
cd databases
sqlite3 student_notes.db

# Check if demo account exists
SELECT * FROM users WHERE email='demo@studentnotes.com';

# Should show:
# id|name|email|photo_url|password_hash
# [id]|Demo User|demo@studentnotes.com||ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f

# Exit
.exit
exit
```

### Verify Your Account

```sql
-- Check if your account exists
SELECT id, name, email FROM users WHERE email='your@email.com';

-- Check if password hash exists
SELECT id, email, password_hash FROM users WHERE email='your@email.com';
```

---

## ✅ Verification Checklist

Before reporting issue, verify:

- [ ] App is v1.0.1 (not v1.0.0)
- [ ] Fresh install (uninstalled old version)
- [ ] Device restarted after install
- [ ] Demo account login tested
- [ ] Register new account tested
- [ ] No typos in email/password
- [ ] Password is at least 6 characters
- [ ] Email format is valid

---

## 🚨 Emergency Reset

### Complete Reset

If nothing works:

```bash
# 1. Uninstall app
adb uninstall com.example.student_notes

# 2. Clear all app data
adb shell pm clear com.example.student_notes

# 3. Restart device
adb reboot

# 4. Install fresh APK
adb install app-release.apk

# 5. Open app
# Demo account will be auto-created

# 6. Test demo login
# Email: demo@studentnotes.com
# Password: demo123
```

---

## 📞 Still Not Working?

### Collect Debug Info

```bash
# Run app in debug mode
flutter run

# Reproduce the issue:
# 1. Try register
# 2. Try login

# Copy all logs that start with:
# "=== REGISTER ATTEMPT ==="
# "=== LOGIN ATTEMPT ==="
# "=== VERIFY PASSWORD ==="
# "=== CREATE USER WITH PASSWORD ==="

# Send logs with:
# - Device model
# - Android version
# - Steps to reproduce
```

### Report Issue

Include:
1. Device info (model, Android version)
2. App version (1.0.1)
3. Steps to reproduce
4. Debug logs (if available)
5. Screenshots

---

## 💡 Tips

### Do's ✅
- ✅ Always uninstall old version first
- ✅ Restart device after uninstall
- ✅ Test demo account first
- ✅ Use valid email format
- ✅ Password minimal 6 characters
- ✅ Check logs in debug mode

### Don'ts ❌
- ❌ Don't install over old version
- ❌ Don't use spaces in password
- ❌ Don't use special characters in email
- ❌ Don't skip uninstall step
- ❌ Don't clear app data while app is running

---

## 🎯 Quick Fix Summary

**Most Common Solution:**

```
1. Uninstall app completely
2. Restart device
3. Install v1.0.1 APK
4. Open app
5. Login with demo account:
   - Email: demo@studentnotes.com
   - Password: demo123
6. ✅ Should work!
```

**If demo account works but your account doesn't:**

```
1. Register new account with different email
2. Use simple password (e.g., "test123")
3. Login immediately after register
4. ✅ Should work!
```

---

**Last Updated:** January 15, 2026  
**Version:** 1.0.1+2  
**Status:** With Debug Logging
