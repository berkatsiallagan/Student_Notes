# Testing Guide - Student Notes

## Testing Scenarios

### 1. Authentication Flow

#### Test Case 1.1: Login dengan Email & Password
**Steps:**
1. Buka aplikasi
2. Tunggu splash screen selesai
3. Masukkan email: `test@example.com`
4. Masukkan password: `password123`
5. Tap tombol "Masuk"

**Expected Result:**
- Loading indicator muncul
- Redirect ke Home Screen
- User session tersimpan

**Test Data:**
- Email: Any valid email format
- Password: Minimal 6 karakter

#### Test Case 1.2: Login dengan Google
**Steps:**
1. Buka aplikasi
2. Tap tombol "Masuk dengan Google"
3. Tunggu simulasi login

**Expected Result:**
- Loading indicator muncul
- Redirect ke Home Screen dengan user "Demo User"
- Session tersimpan

#### Test Case 1.3: Auto-Login (Session Persistence)
**Steps:**
1. Login dengan metode apapun
2. Close aplikasi (force stop)
3. Buka aplikasi lagi

**Expected Result:**
- Splash screen muncul
- Langsung redirect ke Home Screen tanpa login lagi
- Data user masih ada

#### Test Case 1.4: Logout
**Steps:**
1. Login ke aplikasi
2. Tap icon profile di AppBar
3. Scroll ke bawah
4. Tap "Keluar"
5. Konfirmasi logout

**Expected Result:**
- Dialog konfirmasi muncul
- Setelah konfirmasi, redirect ke Login Screen
- Session dihapus
- Saat buka app lagi, harus login ulang

### 2. CRUD Operations

#### Test Case 2.1: Create Note
**Steps:**
1. Login ke aplikasi
2. Tap FAB "Buat Catatan"
3. Isi form:
   - Judul: "Catatan Pemrograman Mobile"
   - Mata Kuliah: Pilih "Pemrograman Mobile"
   - Konten: "Ini adalah catatan tentang Flutter..."
4. Tap tombol "Simpan Catatan"

**Expected Result:**
- Catatan tersimpan ke database
- Redirect ke Home Screen
- Catatan baru muncul di list
- SnackBar sukses muncul

**Validation Tests:**
- Judul kosong → Error message
- Mata kuliah tidak dipilih → Error message
- Konten kurang dari 10 karakter → Error message

#### Test Case 2.2: Read/View Note
**Steps:**
1. Di Home Screen, tap salah satu note card
2. Lihat detail catatan

**Expected Result:**
- Redirect ke Note Detail Screen
- Semua data ditampilkan dengan benar
- Judul, mata kuliah, konten sesuai

#### Test Case 2.3: Update Note
**Steps:**
1. Tap note card untuk edit
2. Ubah judul menjadi "Catatan Updated"
3. Ubah konten
4. Tap tombol "Perbarui Catatan"

**Expected Result:**
- Catatan terupdate di database
- Redirect ke Home Screen
- Perubahan terlihat di list
- SnackBar sukses muncul

#### Test Case 2.4: Delete Note
**Steps:**
1. Tap note card untuk edit
2. Tap tombol "Hapus Catatan"
3. Konfirmasi delete

**Expected Result:**
- Dialog konfirmasi muncul
- Setelah konfirmasi, catatan terhapus
- Redirect ke Home Screen
- Catatan tidak ada di list
- SnackBar sukses muncul

#### Test Case 2.5: Toggle Favorite
**Steps:**
1. Di Home Screen, tap icon star pada note card
2. Tap lagi untuk un-favorite

**Expected Result:**
- Icon berubah dari star_border ke star (filled)
- Warna berubah ke amber
- Counter favorit di statistik bertambah
- Tap lagi, icon kembali ke star_border

### 3. Search & Filter

#### Test Case 3.1: Search by Title
**Steps:**
1. Di Home Screen, tap icon search
2. Ketik "Pemrograman"
3. Lihat hasil

**Expected Result:**
- Search bar muncul
- List filter real-time
- Hanya catatan dengan judul mengandung "Pemrograman" yang muncul
- Tap back arrow untuk clear search

#### Test Case 3.2: Search by Content
**Steps:**
1. Tap icon search
2. Ketik kata yang ada di konten catatan
3. Lihat hasil

**Expected Result:**
- List filter berdasarkan konten
- Catatan yang mengandung kata tersebut muncul

#### Test Case 3.3: Filter by Course
**Steps:**
1. Tap icon filter
2. Pilih mata kuliah "Basis Data"
3. Lihat hasil

**Expected Result:**
- Bottom sheet filter muncul
- Setelah pilih, hanya catatan Basis Data yang muncul
- Chip "Basis Data" terselect

#### Test Case 3.4: Filter Favorites Only
**Steps:**
1. Tap icon filter
2. Toggle "Hanya Favorit"
3. Lihat hasil

**Expected Result:**
- Hanya catatan favorit yang muncul
- Switch aktif

#### Test Case 3.5: Multiple Filters
**Steps:**
1. Tap icon filter
2. Toggle "Hanya Favorit"
3. Pilih mata kuliah "Pemrograman Mobile"
4. Lihat hasil

**Expected Result:**
- Hanya catatan favorit dari Pemrograman Mobile yang muncul

#### Test Case 3.6: Clear Filters
**Steps:**
1. Apply beberapa filter
2. Tap "Reset Filter"

**Expected Result:**
- Semua filter clear
- Semua catatan muncul kembali

### 4. UI/UX Features

#### Test Case 4.1: Dark Mode Toggle
**Steps:**
1. Tap icon profile
2. Toggle "Mode Gelap"
3. Lihat perubahan

**Expected Result:**
- Theme berubah ke dark mode
- Semua screen menggunakan dark theme
- Preference tersimpan
- Saat restart app, dark mode masih aktif

#### Test Case 4.2: Empty State
**Steps:**
1. Login dengan user baru (atau hapus semua catatan)
2. Lihat Home Screen

**Expected Result:**
- Empty state illustration muncul
- Text "Belum Ada Catatan"
- Message yang friendly

#### Test Case 4.3: Loading State
**Steps:**
1. Login ke aplikasi
2. Perhatikan saat load data

**Expected Result:**
- Loading shimmer muncul
- Skeleton cards terlihat
- Smooth transition ke actual data

#### Test Case 4.4: Statistics Display
**Steps:**
1. Di Home Screen, lihat card statistik
2. Buat catatan baru
3. Refresh (pull down)

**Expected Result:**
- Statistik menampilkan:
  - Total catatan
  - Jumlah mata kuliah
  - Jumlah favorit
- Angka update setelah CRUD operation

### 5. Data Persistence

#### Test Case 5.1: Offline Functionality
**Steps:**
1. Login dan buat beberapa catatan
2. Matikan internet/WiFi
3. Buat, edit, delete catatan
4. Lihat semua fitur

**Expected Result:**
- Semua fitur tetap berfungsi
- Tidak ada error network
- Data tersimpan di SQLite local

#### Test Case 5.2: Data Retention
**Steps:**
1. Buat 10 catatan
2. Close app (force stop)
3. Buka app lagi
4. Cek semua catatan

**Expected Result:**
- Semua catatan masih ada
- Urutan sesuai (terbaru di atas)
- Tidak ada data loss

#### Test Case 5.3: Delete All Data
**Steps:**
1. Buat beberapa catatan
2. Tap icon profile
3. Tap "Hapus Semua Data"
4. Konfirmasi

**Expected Result:**
- Dialog konfirmasi muncul
- Setelah konfirmasi, semua catatan terhapus
- Statistik reset ke 0
- Empty state muncul

### 6. Profile & Settings

#### Test Case 6.1: View Profile
**Steps:**
1. Tap icon profile di AppBar
2. Lihat informasi profile

**Expected Result:**
- Foto profile muncul (atau icon default)
- Nama user ditampilkan
- Email ditampilkan
- Statistik ditampilkan

#### Test Case 6.2: Theme Toggle
**Steps:**
1. Di Profile Screen, toggle "Mode Gelap"
2. Navigate ke screen lain
3. Kembali ke Profile

**Expected Result:**
- Theme berubah di semua screen
- Setting tersimpan
- Konsisten di semua screen

### 7. Edge Cases & Error Handling

#### Test Case 7.1: Form Validation
**Steps:**
1. Tap "Buat Catatan"
2. Submit form kosong
3. Isi judul 2 karakter
4. Isi konten 5 karakter

**Expected Result:**
- Error message muncul untuk setiap field
- Form tidak submit
- Error message jelas dan helpful

#### Test Case 7.2: Concurrent Operations
**Steps:**
1. Buat catatan
2. Langsung tap back sebelum save selesai
3. Coba edit catatan saat loading

**Expected Result:**
- Loading indicator muncul
- Button disabled saat loading
- Tidak ada crash
- Operation selesai dengan benar

#### Test Case 7.3: Long Text Handling
**Steps:**
1. Buat catatan dengan judul sangat panjang (>100 karakter)
2. Buat catatan dengan konten sangat panjang (>10000 karakter)

**Expected Result:**
- Judul di-truncate dengan ellipsis di card
- Konten di-truncate di preview
- Full text terlihat di detail screen
- Scroll berfungsi dengan baik

#### Test Case 7.4: Special Characters
**Steps:**
1. Buat catatan dengan special characters: @#$%^&*()
2. Buat catatan dengan emoji: 😀📱💻
3. Buat catatan dengan unicode: 中文, العربية

**Expected Result:**
- Semua karakter tersimpan dengan benar
- Ditampilkan dengan benar
- Tidak ada encoding issue

### 8. Performance Testing

#### Test Case 8.1: Large Dataset
**Steps:**
1. Buat 100+ catatan
2. Scroll list
3. Search catatan
4. Filter catatan

**Expected Result:**
- Scroll smooth tanpa lag
- Search responsive
- Filter cepat
- Tidak ada memory leak

#### Test Case 8.2: App Startup Time
**Steps:**
1. Force stop app
2. Buka app
3. Ukur waktu dari splash ke home

**Expected Result:**
- Splash screen < 2 detik
- Total startup < 3 detik
- Smooth animation

### 9. Cross-Device Testing

#### Test Case 9.1: Different Screen Sizes
**Test Devices:**
- Small phone (< 5 inch)
- Medium phone (5-6 inch)
- Large phone (> 6 inch)
- Tablet (7-10 inch)

**Expected Result:**
- Layout responsive
- Text readable
- Button accessible
- No overflow

#### Test Case 9.2: Different Android Versions
**Test Versions:**
- Android 8.0 (API 26)
- Android 10.0 (API 29)
- Android 12.0 (API 31)
- Android 13.0 (API 33)

**Expected Result:**
- App berfungsi di semua versi
- Tidak ada compatibility issue
- UI konsisten

### 10. Regression Testing

Setelah setiap update, test ulang:
- [ ] Login/Logout flow
- [ ] Create note
- [ ] Edit note
- [ ] Delete note
- [ ] Search functionality
- [ ] Filter functionality
- [ ] Dark mode
- [ ] Data persistence
- [ ] Session persistence

## Bug Report Template

```
**Bug Title:** [Short description]

**Severity:** Critical / High / Medium / Low

**Steps to Reproduce:**
1. Step 1
2. Step 2
3. Step 3

**Expected Result:**
[What should happen]

**Actual Result:**
[What actually happens]

**Screenshots:**
[Attach screenshots if applicable]

**Device Info:**
- Device: [e.g., Samsung Galaxy S21]
- Android Version: [e.g., Android 12]
- App Version: [e.g., 1.0.0]

**Additional Notes:**
[Any other relevant information]
```

## Test Coverage Checklist

### Functional Testing
- [ ] Authentication (Login/Logout)
- [ ] CRUD Operations
- [ ] Search & Filter
- [ ] Data Persistence
- [ ] Session Management

### UI/UX Testing
- [ ] Dark Mode
- [ ] Loading States
- [ ] Empty States
- [ ] Error Messages
- [ ] Animations

### Performance Testing
- [ ] App Startup Time
- [ ] Scroll Performance
- [ ] Search Performance
- [ ] Memory Usage

### Compatibility Testing
- [ ] Different Screen Sizes
- [ ] Different Android Versions
- [ ] Orientation Changes

### Security Testing
- [ ] Data Encryption (SQLite)
- [ ] Session Security
- [ ] Input Validation

## Automated Testing (Future)

### Unit Tests
```dart
// Example: test/models/note_test.dart
test('Note model should convert to/from map correctly', () {
  final note = Note(...);
  final map = note.toMap();
  final noteFromMap = Note.fromMap(map);
  expect(noteFromMap.id, note.id);
});
```

### Widget Tests
```dart
// Example: test/widgets/note_card_test.dart
testWidgets('NoteCard should display note information', (tester) async {
  await tester.pumpWidget(NoteCard(...));
  expect(find.text('Test Title'), findsOneWidget);
});
```

### Integration Tests
```dart
// Example: integration_test/app_test.dart
testWidgets('Complete user flow', (tester) async {
  // Login
  // Create note
  // Edit note
  // Delete note
  // Logout
});
```

---

**Note:** Lakukan testing secara menyeluruh sebelum release ke production!
