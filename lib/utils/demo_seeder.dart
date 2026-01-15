import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../database/database_helper.dart';
import '../models/user.dart';
import '../models/course.dart';
import '../models/note.dart';
import 'constants.dart';

class DemoSeeder {
  static const String demoEmail = 'demo@studentnotes.com';
  static const String demoPassword = 'demo123';
  static const String demoName = 'Demo User';

  /// Check if demo account exists
  static Future<bool> demoAccountExists() async {
    try {
      final user = await DatabaseHelper.instance.getUserByEmail(demoEmail);
      return user != null;
    } catch (e) {
      debugPrint('Error checking demo account: $e');
      return false;
    }
  }

  /// Create demo account with sample data
  static Future<void> createDemoAccount() async {
    try {
      // Check if already exists
      if (await demoAccountExists()) {
        debugPrint('Demo account already exists');
        return;
      }

      debugPrint('Creating demo account...');

      // Create demo user
      final demoUser = User(
        id: const Uuid().v4(),
        name: demoName,
        email: demoEmail,
        photoUrl: null,
      );

      // Hash password (same as UserProvider)
      final hashedPassword = _hashPassword(demoPassword);

      // Save user with password
      await DatabaseHelper.instance.createUserWithPassword(
        demoUser,
        hashedPassword,
      );

      debugPrint('Demo user created: ${demoUser.email}');

      // Create demo courses
      await _createDemoCourses(demoUser.id);

      // Create demo notes
      await _createDemoNotes(demoUser.id);

      debugPrint('Demo account setup complete!');
    } catch (e) {
      debugPrint('Error creating demo account: $e');
    }
  }

  /// Hash password (same as UserProvider)
  static String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Create demo courses
  static Future<void> _createDemoCourses(String userId) async {
    final courses = [
      {'name': 'Pemrograman Mobile', 'color': AppConstants.courseColors[0]},
      {'name': 'Basis Data', 'color': AppConstants.courseColors[1]},
      {'name': 'Algoritma & Struktur Data', 'color': AppConstants.courseColors[2]},
      {'name': 'Jaringan Komputer', 'color': AppConstants.courseColors[3]},
      {'name': 'Sistem Operasi', 'color': AppConstants.courseColors[4]},
    ];

    for (var courseData in courses) {
      final course = Course(
        id: const Uuid().v4(),
        userId: userId,
        courseName: courseData['name'] as String,
        colorCode: courseData['color'] as String,
      );

      await DatabaseHelper.instance.createCourse(course);
      debugPrint('Created course: ${course.courseName}');
    }
  }

  /// Create demo notes
  static Future<void> _createDemoNotes(String userId) async {
    final notes = [
      {
        'title': 'Pengenalan Flutter',
        'course': 'Pemrograman Mobile',
        'content': '''Flutter adalah UI toolkit dari Google untuk membuat aplikasi native yang indah untuk mobile, web, dan desktop dari satu codebase.

Keunggulan Flutter:
• Hot Reload untuk development cepat
• Widget-based architecture
• High performance (compiled to native)
• Beautiful Material Design & Cupertino widgets
• Cross-platform (iOS, Android, Web, Desktop)

Flutter menggunakan bahasa Dart yang mudah dipelajari dan powerful.'''
      },
      {
        'title': 'Normalisasi Database',
        'course': 'Basis Data',
        'content': '''Normalisasi adalah proses mengorganisir data dalam database untuk mengurangi redundansi dan meningkatkan integritas data.

Bentuk Normal:
1. 1NF (First Normal Form)
   - Setiap kolom harus atomic (tidak bisa dipecah lagi)
   - Tidak ada repeating groups

2. 2NF (Second Normal Form)
   - Sudah dalam 1NF
   - Tidak ada partial dependency

3. 3NF (Third Normal Form)
   - Sudah dalam 2NF
   - Tidak ada transitive dependency

Normalisasi membantu menghindari anomali insert, update, dan delete.'''
      },
      {
        'title': 'Binary Search Tree',
        'course': 'Algoritma & Struktur Data',
        'content': '''Binary Search Tree (BST) adalah struktur data tree dimana setiap node memiliki maksimal 2 child.

Properti BST:
• Left subtree < parent node
• Right subtree > parent node
• Tidak ada duplicate values

Operasi BST:
• Insert: O(log n) average, O(n) worst
• Search: O(log n) average, O(n) worst
• Delete: O(log n) average, O(n) worst

BST sangat efisien untuk operasi search, insert, dan delete data yang terurut.'''
      },
      {
        'title': 'TCP vs UDP',
        'course': 'Jaringan Komputer',
        'content': '''TCP (Transmission Control Protocol) dan UDP (User Datagram Protocol) adalah dua protokol transport layer yang berbeda.

TCP:
✓ Connection-oriented
✓ Reliable (guaranteed delivery)
✓ Ordered data transfer
✓ Error checking & correction
✓ Flow control
✗ Slower
Contoh: HTTP, FTP, Email

UDP:
✓ Connectionless
✓ Fast & lightweight
✗ Unreliable (no guarantee)
✗ No ordering
✗ Minimal error checking
Contoh: Video streaming, Gaming, DNS'''
      },
      {
        'title': 'Process Scheduling',
        'course': 'Sistem Operasi',
        'content': '''Process Scheduling adalah metode yang digunakan OS untuk menentukan proses mana yang akan dieksekusi oleh CPU.

Algoritma Scheduling:

1. FCFS (First Come First Serve)
   - Sederhana, non-preemptive
   - Convoy effect

2. SJF (Shortest Job First)
   - Optimal average waiting time
   - Starvation possible

3. Round Robin
   - Preemptive, time quantum
   - Fair untuk semua proses

4. Priority Scheduling
   - Berdasarkan prioritas
   - Aging untuk prevent starvation

Pemilihan algoritma tergantung pada kebutuhan sistem.'''
      },
      {
        'title': 'Tips Belajar Efektif',
        'course': 'Pemrograman Mobile',
        'content': '''Tips untuk belajar programming secara efektif:

1. Practice, Practice, Practice
   - Coding setiap hari minimal 1 jam
   - Buat project kecil-kecil

2. Baca Dokumentasi
   - Official docs adalah sumber terbaik
   - Pahami konsep, bukan hafal syntax

3. Debug dengan Sabar
   - Error adalah guru terbaik
   - Gunakan debugger, bukan print()

4. Join Community
   - Stack Overflow
   - GitHub
   - Discord/Telegram groups

5. Build Real Projects
   - Portfolio untuk CV
   - Solve real problems

Keep learning and never give up! 🚀'''
      },
    ];

    for (var noteData in notes) {
      final note = Note(
        id: const Uuid().v4(),
        userId: userId,
        title: noteData['title'] as String,
        course: noteData['course'] as String,
        content: noteData['content'] as String,
        dateCreated: DateTime.now().subtract(
          Duration(days: notes.indexOf(noteData)),
        ),
        dateUpdated: DateTime.now().subtract(
          Duration(days: notes.indexOf(noteData)),
        ),
        isFavorite: notes.indexOf(noteData) < 2, // First 2 are favorites
      );

      await DatabaseHelper.instance.createNote(note);
      debugPrint('Created note: ${note.title}');
    }
  }

  /// Get demo credentials info
  static Map<String, String> getDemoCredentials() {
    return {
      'email': demoEmail,
      'password': demoPassword,
      'name': demoName,
    };
  }
}
