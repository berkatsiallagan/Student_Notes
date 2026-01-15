import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/note.dart';
import '../models/course.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('student_notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2, // Increment version untuk migration
      onCreate: _createDB,
      onUpgrade: _onUpgrade, // Handle migration
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Migration dari v1 ke v2
      try {
        // Tambah kolom password_hash dengan default value
        await db.execute('ALTER TABLE users ADD COLUMN password_hash TEXT NOT NULL DEFAULT "temp_hash"');
        
        // Tidak bisa tambah UNIQUE constraint ke kolom existing
        // Jadi kita recreate table
        await db.execute('ALTER TABLE users RENAME TO users_old');
        
        // Create new users table dengan UNIQUE constraint
        await db.execute('''
          CREATE TABLE users (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            photo_url TEXT,
            password_hash TEXT NOT NULL
          )
        ''');
        
        // Copy data dari old table (skip duplicate emails)
        await db.execute('''
          INSERT OR IGNORE INTO users (id, name, email, photo_url, password_hash)
          SELECT id, name, email, photo_url, password_hash FROM users_old
        ''');
        
        // Drop old table
        await db.execute('DROP TABLE users_old');
        
        debugPrint('Database migrated from v$oldVersion to v$newVersion');
      } catch (e) {
        debugPrint('Migration error: $e');
        // Jika migration gagal, user harus uninstall
      }
    }
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    // Users table dengan password
    await db.execute('''
      CREATE TABLE users (
        id $idType,
        name $textType,
        email $textType UNIQUE,
        photo_url TEXT,
        password_hash $textType
      )
    ''');

    // Courses table
    await db.execute('''
      CREATE TABLE courses (
        id $idType,
        user_id $textType,
        course_name $textType,
        color_code $textType,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // Notes table
    await db.execute('''
      CREATE TABLE notes (
        id $idType,
        user_id $textType,
        title $textType,
        course $textType,
        content $textType,
        date_created $textType,
        date_updated $textType,
        is_favorite $intType DEFAULT 0,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');
  }

  // User operations
  Future<User> createUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap());
    return user;
  }

  Future<User> createUserWithPassword(User user, String passwordHash) async {
    final db = await database;
    debugPrint('=== CREATE USER WITH PASSWORD ===');
    debugPrint('User ID: ${user.id}');
    debugPrint('Email: ${user.email}');
    debugPrint('Password hash: $passwordHash');
    
    final userMap = user.toMap();
    userMap['password_hash'] = passwordHash;
    
    debugPrint('User map: $userMap');
    
    await db.insert('users', userMap);
    debugPrint('User inserted successfully');
    
    return user;
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<bool> verifyPassword(String userId, String passwordHash) async {
    final db = await database;
    debugPrint('=== VERIFY PASSWORD ===');
    debugPrint('User ID: $userId');
    debugPrint('Expected hash: $passwordHash');
    
    final maps = await db.query(
      'users',
      columns: ['password_hash'],
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      final storedHash = maps.first['password_hash'];
      debugPrint('Stored hash: $storedHash');
      debugPrint('Match: ${storedHash == passwordHash}');
      return storedHash == passwordHash;
    }
    
    debugPrint('No password found for user');
    return false;
  }

  Future<User?> getUser(String id) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(String id) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Course operations
  Future<Course> createCourse(Course course) async {
    final db = await database;
    await db.insert('courses', course.toMap());
    return course;
  }

  Future<List<Course>> getCoursesByUser(String userId) async {
    final db = await database;
    final result = await db.query(
      'courses',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'course_name ASC',
    );

    return result.map((map) => Course.fromMap(map)).toList();
  }

  Future<int> deleteCourse(String id) async {
    final db = await database;
    return await db.delete(
      'courses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Note operations
  Future<Note> createNote(Note note) async {
    final db = await database;
    await db.insert('notes', note.toMap());
    return note;
  }

  Future<List<Note>> getNotesByUser(String userId) async {
    final db = await database;
    final result = await db.query(
      'notes',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'date_updated DESC',
    );

    return result.map((map) => Note.fromMap(map)).toList();
  }

  Future<Note?> getNote(String id) async {
    final db = await database;
    final maps = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateNote(Note note) async {
    final db = await database;
    return db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(String id) async {
    final db = await database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Note>> searchNotes(String userId, String query) async {
    final db = await database;
    final result = await db.query(
      'notes',
      where: 'user_id = ? AND (title LIKE ? OR content LIKE ?)',
      whereArgs: [userId, '%$query%', '%$query%'],
      orderBy: 'date_updated DESC',
    );

    return result.map((map) => Note.fromMap(map)).toList();
  }

  Future<List<Note>> filterNotesByCourse(String userId, String course) async {
    final db = await database;
    final result = await db.query(
      'notes',
      where: 'user_id = ? AND course = ?',
      whereArgs: [userId, course],
      orderBy: 'date_updated DESC',
    );

    return result.map((map) => Note.fromMap(map)).toList();
  }

  Future<List<Note>> getFavoriteNotes(String userId) async {
    final db = await database;
    final result = await db.query(
      'notes',
      where: 'user_id = ? AND is_favorite = 1',
      whereArgs: [userId],
      orderBy: 'date_updated DESC',
    );

    return result.map((map) => Note.fromMap(map)).toList();
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
