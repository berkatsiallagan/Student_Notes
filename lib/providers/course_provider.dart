import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/course.dart';
import '../database/database_helper.dart';
import '../utils/constants.dart';

class CourseProvider with ChangeNotifier {
  List<Course> _courses = [];
  bool _isLoading = false;

  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;

  Future<void> loadCourses(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _courses = await DatabaseHelper.instance.getCoursesByUser(userId);
      
      // Add default courses if empty
      if (_courses.isEmpty) {
        await _addDefaultCourses(userId);
      }
    } catch (e) {
      debugPrint('Error loading courses: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _addDefaultCourses(String userId) async {
    final defaultCourses = [
      'Pemrograman Mobile',
      'Basis Data',
      'Algoritma & Struktur Data',
      'Jaringan Komputer',
      'Sistem Operasi',
    ];

    for (int i = 0; i < defaultCourses.length; i++) {
      final course = Course(
        id: const Uuid().v4(),
        userId: userId,
        courseName: defaultCourses[i],
        colorCode: AppConstants.courseColors[i % AppConstants.courseColors.length],
      );
      
      await DatabaseHelper.instance.createCourse(course);
      _courses.add(course);
    }
    
    notifyListeners();
  }

  Future<void> addCourse({
    required String userId,
    required String courseName,
    String? colorCode,
  }) async {
    try {
      final course = Course(
        id: const Uuid().v4(),
        userId: userId,
        courseName: courseName,
        colorCode: colorCode ?? AppConstants.courseColors[_courses.length % AppConstants.courseColors.length],
      );

      await DatabaseHelper.instance.createCourse(course);
      _courses.add(course);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding course: $e');
      rethrow;
    }
  }

  Future<void> deleteCourse(String courseId) async {
    try {
      await DatabaseHelper.instance.deleteCourse(courseId);
      _courses.removeWhere((course) => course.id == courseId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting course: $e');
      rethrow;
    }
  }

  List<String> getCourseNames() {
    return _courses.map((course) => course.courseName).toList();
  }

  String? getCourseColor(String courseName) {
    try {
      final course = _courses.firstWhere((c) => c.courseName == courseName);
      return course.colorCode;
    } catch (e) {
      return null;
    }
  }
}
