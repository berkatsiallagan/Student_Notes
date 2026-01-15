import 'constants.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }
    
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    
    return null;
  }

  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Judul tidak boleh kosong';
    }
    
    if (value.length < AppConstants.minTitleLength) {
      return 'Judul minimal ${AppConstants.minTitleLength} karakter';
    }
    
    if (value.length > AppConstants.maxTitleLength) {
      return 'Judul maksimal ${AppConstants.maxTitleLength} karakter';
    }
    
    return null;
  }

  static String? validateContent(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konten tidak boleh kosong';
    }
    
    if (value.length < AppConstants.minContentLength) {
      return 'Konten minimal ${AppConstants.minContentLength} karakter';
    }
    
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }

  static String? validateCourseName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama mata kuliah tidak boleh kosong';
    }
    
    if (value.length < 3) {
      return 'Nama mata kuliah minimal 3 karakter';
    }
    
    return null;
  }
}
