# Release Notes - Student Notes v1.0.1

**Release Date:** January 15, 2026  
**Version:** 1.0.1 (Build 2)  
**Type:** Bug Fix & Feature Update

---

## 🎉 What's New

### Major Improvements

#### 1. ✅ Proper Authentication System
- **Register Screen** - Create account with email and password
- **Password Security** - SHA-256 password hashing
- **Email Validation** - Unique email constraint
- **Login Validation** - Credentials verified against database

#### 2. ✅ Data Persistence Fixed
- Logout now only clears session
- All notes and user data remain in database
- Login again to access your data

#### 3. ✅ Course Management
- **New Screen** - Manage your courses
- **Add Courses** - Create custom courses with colors
- **Delete Courses** - Remove unused courses
- **8 Color Options** - Personalize each course

#### 4. ✅ Google Sign-In Update
- Temporarily disabled (will be enabled in future release)
- Clear message directing users to email registration
- Proper Firebase integration coming soon

---

## 🔧 Bug Fixes

### Fixed Issues
1. ✅ Login now validates credentials against database
2. ✅ Data no longer deleted on logout
3. ✅ Course management now available
4. ✅ Password security implemented

### Security Improvements
- Password hashing with SHA-256
- Email unique constraint
- Proper authentication flow
- Session management improved

---

## ⚠️ Breaking Changes

### Database Schema Updated
- **Impact:** Requires fresh installation
- **Action Required:** Uninstall old version before installing v1.0.1
- **Reason:** Database structure changed to support authentication

### Authentication Required
- **Impact:** Must register before login
- **Action Required:** Create new account with email and password
- **Benefit:** Secure authentication and data protection

### Google Sign-In Disabled
- **Impact:** Cannot login with Google (temporarily)
- **Action Required:** Use email registration
- **Coming Soon:** Real Firebase Google Sign-In in v1.1.0

---

## 📦 Installation Instructions

### For New Users
1. Download `app-release.apk`
2. Enable "Install from Unknown Sources"
3. Install the APK
4. Open app and register
5. Start taking notes!

### For Existing Users (Upgrading from v1.0.0)
1. **IMPORTANT:** Uninstall old version first
2. Download `app-release.apk`
3. Install the new APK
4. Register with new account
5. Your old data cannot be migrated (sorry!)

### Why Uninstall Required?
- Database schema has changed
- Direct upgrade will cause crashes
- Fresh installation ensures stability

---

## 📱 System Requirements

### Minimum Requirements
- **Android:** 5.0 (API 21) or higher
- **Storage:** 50 MB free space
- **RAM:** 1 GB minimum

### Recommended
- **Android:** 8.0 or higher
- **Storage:** 100 MB free space
- **RAM:** 2 GB or more

### Tested On
- ✅ Android 8.0 (Oreo)
- ✅ Android 10.0
- ✅ Android 11.0
- ✅ Android 12.0
- ✅ Android 13.0
- ✅ Android 14.0

---

## 📊 APK Information

### Universal APK
- **File:** `app-release.apk`
- **Size:** ~15-20 MB
- **Architecture:** All (ARM, ARM64, x86_64)
- **Recommended for:** Most users

### Split APKs (Smaller Size)
- **ARM 32-bit:** `app-armeabi-v7a-release.apk` (~10-12 MB)
- **ARM 64-bit:** `app-arm64-v8a-release.apk` (~10-12 MB)
- **x86 64-bit:** `app-x86_64-release.apk` (~10-12 MB)
- **Recommended for:** Advanced users who know their device architecture

---

## 🎯 Features Overview

### Core Features
- ✅ Create, Read, Update, Delete notes
- ✅ Search notes by title and content
- ✅ Filter by course and favorites
- ✅ Offline-first (no internet required)
- ✅ Dark mode support
- ✅ Statistics dashboard

### New in v1.0.1
- ✅ User registration and authentication
- ✅ Password security with hashing
- ✅ Course management (add/delete)
- ✅ Improved data persistence
- ✅ Better error messages

---

## 🐛 Known Issues

### None Critical
All reported issues have been fixed in this release.

### Minor Issues
- Google Sign-In temporarily disabled (coming in v1.1.0)
- Cannot migrate data from v1.0.0 (database schema changed)

### Workarounds
- Use email registration instead of Google Sign-In
- Manual data entry for existing users

---

## 🔮 Coming Soon (v1.1.0)

### Planned Features
- [ ] Real Firebase Google Sign-In
- [ ] Forgot password feature
- [ ] Change password feature
- [ ] Cloud backup & sync
- [ ] Export notes to PDF
- [ ] Share notes functionality

### Timeline
- **v1.0.2:** Forgot/Change password (February 2026)
- **v1.1.0:** Cloud sync & Google Sign-In (March 2026)
- **v2.0.0:** Rich text editor & collaboration (Q2 2026)

---

## 📝 How to Use

### First Time Setup
1. **Register**
   - Open app
   - Tap "Daftar Sekarang"
   - Fill in name, email, password
   - Tap "Daftar"

2. **Login**
   - Enter your email
   - Enter your password
   - Tap "Masuk"

3. **Create Note**
   - Tap FAB (+) button
   - Fill in title, course, content
   - Tap "Simpan Catatan"

4. **Manage Courses**
   - Tap Profile icon
   - Tap "Kelola Mata Kuliah"
   - Add or delete courses

### Tips & Tricks
- Use search to find notes quickly
- Mark important notes as favorites
- Filter by course to focus on specific subjects
- Enable dark mode for night studying
- Pull down to refresh data

---

## 🔐 Security & Privacy

### Data Storage
- All data stored locally on your device
- SQLite database (encrypted by Android OS)
- No data sent to external servers

### Password Security
- Passwords hashed with SHA-256
- Never stored in plain text
- Cannot be recovered (must reset)

### Permissions Required
- **Storage:** To save notes locally
- **Internet:** Only for future cloud sync (optional)

---

## 📞 Support & Feedback

### Report Issues
If you encounter any problems:
1. Note your device model and Android version
2. Describe the steps to reproduce
3. Take screenshots if possible
4. Report via GitHub Issues (if available)

### Feature Requests
We welcome your suggestions!
- What features would you like to see?
- How can we improve the app?
- Share your ideas!

### Contact
- **Email:** [Your Email]
- **GitHub:** [Your GitHub]
- **Documentation:** See README.md

---

## 🙏 Acknowledgments

### Thanks To
- All users who provided feedback
- Flutter community for support
- Open source contributors

### Special Thanks
- Users who reported the 4 critical issues
- Beta testers (if any)

---

## 📄 License

This project is licensed under the MIT License.
See LICENSE file for details.

---

## ✅ Verification

### Checksums (SHA-256)
```
app-release.apk: [Will be generated after build]
```

### Signature
```
Signed with: student-notes-key.jks
Valid until: [10 years from signing]
```

---

## 🎉 Thank You!

Thank you for using Student Notes!

We hope this update improves your note-taking experience.

**Happy Note-Taking! 📝**

---

**Version:** 1.0.1 (Build 2)  
**Release Date:** January 15, 2026  
**Status:** Stable Release  
**Download:** [Link to APK]

---

*For detailed technical changes, see CHANGELOG.md*  
*For installation help, see BUILD_INSTRUCTIONS.md*  
*For bug fixes details, see FIXES_APPLIED.md*
