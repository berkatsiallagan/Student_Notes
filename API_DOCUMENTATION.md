# API Documentation - Student Notes

## Database Helper API

### DatabaseHelper Class

Singleton class untuk mengelola SQLite database operations.

#### Instance
```dart
DatabaseHelper.instance
```

---

### User Operations

#### createUser
Membuat user baru di database.

```dart
Future<User> createUser(User user)
```

**Parameters:**
- `user`: User object yang akan disimpan

**Returns:** User object yang telah disimpan

**Example:**
```dart
final user = User(
  id: 'user123',
  name: 'John Doe',
  email: 'john@example.com',
  photoUrl: 'https://example.com/photo.jpg',
);

final savedUser = await DatabaseHelper.instance.createUser(user);
```

---

#### getUser
Mengambil user berdasarkan ID.

```dart
Future<User?> getUser(String id)
```

**Parameters:**
- `id`: User ID

**Returns:** User object atau null jika tidak ditemukan

**Example:**
```dart
final user = await DatabaseHelper.instance.getUser('user123');
if (user != null) {
  print('User found: ${user.name}');
}
```

---

#### updateUser
Update data user.

```dart
Future<int> updateUser(User user)
```

**Parameters:**
- `user`: User object dengan data baru

**Returns:** Number of rows affected

**Example:**
```dart
final updatedUser = user.copyWith(name: 'Jane Doe');
await DatabaseHelper.instance.updateUser(updatedUser);
```

---

#### deleteUser
Hapus user dari database.

```dart
Future<int> deleteUser(String id)
```

**Parameters:**
- `id`: User ID

**Returns:** Number of rows deleted

**Example:**
```dart
await DatabaseHelper.instance.deleteUser('user123');
```

---

### Course Operations

#### createCourse
Membuat course baru.

```dart
Future<Course> createCourse(Course course)
```

**Parameters:**
- `course`: Course object

**Returns:** Course object yang telah disimpan

**Example:**
```dart
final course = Course(
  id: 'course123',
  userId: 'user123',
  courseName: 'Pemrograman Mobile',
  colorCode: '#FF6B6B',
);

await DatabaseHelper.instance.createCourse(course);
```

---

#### getCoursesByUser
Mengambil semua courses milik user.

```dart
Future<List<Course>> getCoursesByUser(String userId)
```

**Parameters:**
- `userId`: User ID

**Returns:** List of Course objects

**Example:**
```dart
final courses = await DatabaseHelper.instance.getCoursesByUser('user123');
print('Total courses: ${courses.length}');
```

---

#### deleteCourse
Hapus course.

```dart
Future<int> deleteCourse(String id)
```

**Parameters:**
- `id`: Course ID

**Returns:** Number of rows deleted

---

### Note Operations

#### createNote
Membuat note baru.

```dart
Future<Note> createNote(Note note)
```

**Parameters:**
- `note`: Note object

**Returns:** Note object yang telah disimpan

**Example:**
```dart
final note = Note(
  id: 'note123',
  userId: 'user123',
  title: 'Flutter Basics',
  course: 'Pemrograman Mobile',
  content: 'Flutter is a UI toolkit...',
  dateCreated: DateTime.now(),
  dateUpdated: DateTime.now(),
  isFavorite: false,
);

await DatabaseHelper.instance.createNote(note);
```

---

#### getNotesByUser
Mengambil semua notes milik user.

```dart
Future<List<Note>> getNotesByUser(String userId)
```

**Parameters:**
- `userId`: User ID

**Returns:** List of Note objects, sorted by dateUpdated DESC

**Example:**
```dart
final notes = await DatabaseHelper.instance.getNotesByUser('user123');
for (var note in notes) {
  print('${note.title} - ${note.course}');
}
```

---

#### getNote
Mengambil note berdasarkan ID.

```dart
Future<Note?> getNote(String id)
```

**Parameters:**
- `id`: Note ID

**Returns:** Note object atau null

---

#### updateNote
Update note.

```dart
Future<int> updateNote(Note note)
```

**Parameters:**
- `note`: Note object dengan data baru

**Returns:** Number of rows affected

**Example:**
```dart
final updatedNote = note.copyWith(
  title: 'Updated Title',
  dateUpdated: DateTime.now(),
);
await DatabaseHelper.instance.updateNote(updatedNote);
```

---

#### deleteNote
Hapus note.

```dart
Future<int> deleteNote(String id)
```

**Parameters:**
- `id`: Note ID

**Returns:** Number of rows deleted

---

#### searchNotes
Search notes berdasarkan query.

```dart
Future<List<Note>> searchNotes(String userId, String query)
```

**Parameters:**
- `userId`: User ID
- `query`: Search query (akan dicari di title dan content)

**Returns:** List of matching Note objects

**Example:**
```dart
final results = await DatabaseHelper.instance.searchNotes(
  'user123',
  'flutter',
);
print('Found ${results.length} notes');
```

---

#### filterNotesByCourse
Filter notes berdasarkan course.

```dart
Future<List<Note>> filterNotesByCourse(String userId, String course)
```

**Parameters:**
- `userId`: User ID
- `course`: Course name

**Returns:** List of Note objects

---

#### getFavoriteNotes
Mengambil semua favorite notes.

```dart
Future<List<Note>> getFavoriteNotes(String userId)
```

**Parameters:**
- `userId`: User ID

**Returns:** List of favorite Note objects

---

## Provider APIs

### UserProvider

State management untuk user authentication.

#### Properties
```dart
User? currentUser          // Current logged in user
bool isLoading            // Loading state
bool isLoggedIn           // Login status
```

#### Methods

##### checkLoginStatus
```dart
Future<void> checkLoginStatus()
```
Cek apakah user sudah login (dari SharedPreferences).

##### login
```dart
Future<bool> login(String email, String password)
```
Login dengan email & password.

##### loginWithGoogle
```dart
Future<void> loginWithGoogle(User user)
```
Login dengan Google (save user session).

##### logout
```dart
Future<void> logout()
```
Logout dan clear session.

##### updateUser
```dart
Future<void> updateUser(User user)
```
Update user data.

**Example Usage:**
```dart
final userProvider = Provider.of<UserProvider>(context, listen: false);

// Login
final success = await userProvider.login('email@example.com', 'password');

// Check current user
if (userProvider.isLoggedIn) {
  print('Logged in as: ${userProvider.currentUser!.name}');
}

// Logout
await userProvider.logout();
```

---

### NoteProvider

State management untuk notes CRUD dan filtering.

#### Properties
```dart
List<Note> notes              // Filtered notes list
bool isLoading               // Loading state
String searchQuery           // Current search query
String? selectedCourse       // Selected course filter
bool showFavoritesOnly       // Favorites filter status
int totalNotes              // Total notes count
int favoriteCount           // Favorite notes count
Set<String> allCourses      // All unique courses
```

#### Methods

##### loadNotes
```dart
Future<void> loadNotes(String userId)
```
Load semua notes untuk user.

##### createNote
```dart
Future<void> createNote({
  required String userId,
  required String title,
  required String course,
  required String content,
})
```
Buat note baru.

##### updateNote
```dart
Future<void> updateNote(Note note)
```
Update note.

##### deleteNote
```dart
Future<void> deleteNote(String noteId)
```
Hapus note.

##### toggleFavorite
```dart
Future<void> toggleFavorite(Note note)
```
Toggle favorite status.

##### searchNotes
```dart
void searchNotes(String query)
```
Search notes (real-time).

##### filterByCourse
```dart
void filterByCourse(String? course)
```
Filter by course.

##### toggleFavoritesFilter
```dart
void toggleFavoritesFilter()
```
Toggle favorites only filter.

##### clearFilters
```dart
void clearFilters()
```
Clear all filters.

##### getNoteById
```dart
Note? getNoteById(String id)
```
Get note by ID.

**Example Usage:**
```dart
final noteProvider = Provider.of<NoteProvider>(context, listen: false);

// Load notes
await noteProvider.loadNotes('user123');

// Create note
await noteProvider.createNote(
  userId: 'user123',
  title: 'My Note',
  course: 'Pemrograman Mobile',
  content: 'Note content...',
);

// Search
noteProvider.searchNotes('flutter');

// Filter
noteProvider.filterByCourse('Basis Data');
noteProvider.toggleFavoritesFilter();

// Clear
noteProvider.clearFilters();
```

---

### CourseProvider

State management untuk courses.

#### Properties
```dart
List<Course> courses         // List of courses
bool isLoading              // Loading state
```

#### Methods

##### loadCourses
```dart
Future<void> loadCourses(String userId)
```
Load courses untuk user (auto-create default courses jika kosong).

##### addCourse
```dart
Future<void> addCourse({
  required String userId,
  required String courseName,
  String? colorCode,
})
```
Tambah course baru.

##### deleteCourse
```dart
Future<void> deleteCourse(String courseId)
```
Hapus course.

##### getCourseNames
```dart
List<String> getCourseNames()
```
Get list of course names.

##### getCourseColor
```dart
String? getCourseColor(String courseName)
```
Get color code untuk course.

---

### ThemeProvider

State management untuk theme.

#### Properties
```dart
ThemeMode themeMode         // Current theme mode
bool isDarkMode            // Is dark mode active
```

#### Methods

##### toggleTheme
```dart
Future<void> toggleTheme()
```
Toggle between light and dark mode.

##### setThemeMode
```dart
Future<void> setThemeMode(ThemeMode mode)
```
Set specific theme mode.

**Example Usage:**
```dart
final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

// Toggle theme
await themeProvider.toggleTheme();

// Set specific theme
await themeProvider.setThemeMode(ThemeMode.dark);

// Check current theme
if (themeProvider.isDarkMode) {
  print('Dark mode is active');
}
```

---

## Models

### User Model

```dart
class User {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  Map<String, dynamic> toMap();
  factory User.fromMap(Map<String, dynamic> map);
  User copyWith({...});
}
```

---

### Note Model

```dart
class Note {
  final String id;
  final String userId;
  final String title;
  final String course;
  final String content;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final bool isFavorite;

  Note({
    required this.id,
    required this.userId,
    required this.title,
    required this.course,
    required this.content,
    required this.dateCreated,
    required this.dateUpdated,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap();
  factory Note.fromMap(Map<String, dynamic> map);
  Note copyWith({...});
}
```

---

### Course Model

```dart
class Course {
  final String id;
  final String userId;
  final String courseName;
  final String colorCode;

  Course({
    required this.id,
    required this.userId,
    required this.courseName,
    required this.colorCode,
  });

  Map<String, dynamic> toMap();
  factory Course.fromMap(Map<String, dynamic> map);
  Course copyWith({...});
}
```

---

## Validators

### Email Validation
```dart
String? Validators.validateEmail(String? value)
```
Returns error message atau null jika valid.

### Password Validation
```dart
String? Validators.validatePassword(String? value)
```
Minimal 6 karakter.

### Title Validation
```dart
String? Validators.validateTitle(String? value)
```
3-100 karakter.

### Content Validation
```dart
String? Validators.validateContent(String? value)
```
Minimal 10 karakter.

### Required Field
```dart
String? Validators.validateRequired(String? value, String fieldName)
```
Generic required validation.

---

## Constants

### App Constants
```dart
AppConstants.appName              // "Student Notes"
AppConstants.appVersion           // "1.0.0"
AppConstants.primaryColor         // Color(0xFF2D5B8F)
AppConstants.secondaryColor       // Color(0xFF4A90E2)
AppConstants.courseColors         // List<String> of color codes
AppConstants.keyUserId            // SharedPreferences key
AppConstants.keyIsLoggedIn        // SharedPreferences key
// ... more constants
```

---

## Error Handling

Semua database operations menggunakan try-catch dan return appropriate values:

```dart
try {
  await DatabaseHelper.instance.createNote(note);
  // Success
} catch (e) {
  debugPrint('Error: $e');
  // Handle error
  rethrow; // or return error
}
```

Provider methods juga handle errors dan update UI accordingly via SnackBar atau error states.

---

## Best Practices

1. **Always use Provider.of with listen: false** untuk operations:
```dart
final provider = Provider.of<NoteProvider>(context, listen: false);
```

2. **Use Consumer for UI updates**:
```dart
Consumer<NoteProvider>(
  builder: (context, provider, child) {
    return ListView.builder(...);
  },
)
```

3. **Dispose controllers**:
```dart
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

4. **Check mounted before setState**:
```dart
if (!mounted) return;
setState(() { ... });
```

5. **Use async/await properly**:
```dart
Future<void> loadData() async {
  try {
    await provider.loadNotes(userId);
  } catch (e) {
    // Handle error
  }
}
```

---

## Performance Tips

1. Use `ListView.builder` untuk large lists
2. Implement pagination jika data > 1000 items
3. Use `const` constructors where possible
4. Avoid unnecessary rebuilds dengan `Consumer` yang specific
5. Dispose resources properly

---

For more information, see the source code documentation in each file.
