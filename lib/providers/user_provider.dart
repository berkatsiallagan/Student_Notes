import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/user.dart';
import '../database/database_helper.dart';
import '../utils/constants.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser != null;

  // Hash password untuk keamanan
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> checkLoginStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool(AppConstants.keyIsLoggedIn) ?? false;

      if (isLoggedIn) {
        final userId = prefs.getString(AppConstants.keyUserId);
        if (userId != null) {
          final user = await DatabaseHelper.instance.getUser(userId);
          if (user != null) {
            _currentUser = user;
          } else {
            // User tidak ditemukan di database, clear session
            await prefs.clear();
          }
        }
      }
    } catch (e) {
      debugPrint('Error checking login status: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('=== REGISTER ATTEMPT ===');
      debugPrint('Name: $name');
      debugPrint('Email: $email');
      
      // Cek apakah email sudah terdaftar
      final existingUser = await DatabaseHelper.instance.getUserByEmail(email);
      if (existingUser != null) {
        debugPrint('Email already registered');
        return {
          'success': false,
          'message': 'Email sudah terdaftar',
        };
      }

      // Hash password
      final hashedPassword = _hashPassword(password);
      debugPrint('Hashed password: $hashedPassword');

      // Buat user baru
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        photoUrl: null,
      );

      debugPrint('Creating user with ID: ${user.id}');

      // Simpan user dan password ke database
      await DatabaseHelper.instance.createUserWithPassword(user, hashedPassword);

      debugPrint('User created successfully!');

      return {
        'success': true,
        'message': 'Registrasi berhasil',
      };
    } catch (e) {
      debugPrint('Register error: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      debugPrint('=== LOGIN ATTEMPT ===');
      debugPrint('Email: $email');
      
      // Hash password untuk pencocokan
      final hashedPassword = _hashPassword(password);
      debugPrint('Hashed password: $hashedPassword');

      // Cek user di database
      final user = await DatabaseHelper.instance.getUserByEmail(email);
      
      if (user == null) {
        debugPrint('User not found with email: $email');
        _isLoading = false;
        notifyListeners();
        return false;
      }

      debugPrint('User found: ${user.name} (${user.id})');

      // Verifikasi password
      final isPasswordValid = await DatabaseHelper.instance.verifyPassword(user.id, hashedPassword);
      debugPrint('Password valid: $isPasswordValid');
      
      if (!isPasswordValid) {
        debugPrint('Password verification failed');
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Login berhasil
      debugPrint('Login successful!');
      await _saveUserSession(user);
      _currentUser = user;
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Login error: $e');
      return false;
    }
  }

  Future<void> _saveUserSession(User user) async {
    // Save to SharedPreferences only (user already in database)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyIsLoggedIn, true);
    await prefs.setString(AppConstants.keyUserId, user.id);
    await prefs.setString(AppConstants.keyUserName, user.name);
    await prefs.setString(AppConstants.keyUserEmail, user.email);
    if (user.photoUrl != null) {
      await prefs.setString(AppConstants.keyUserPhoto, user.photoUrl!);
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      // Hanya clear session, JANGAN hapus data user dari database
      await prefs.remove(AppConstants.keyIsLoggedIn);
      await prefs.remove(AppConstants.keyUserId);
      await prefs.remove(AppConstants.keyUserName);
      await prefs.remove(AppConstants.keyUserEmail);
      await prefs.remove(AppConstants.keyUserPhoto);
      
      _currentUser = null;
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await DatabaseHelper.instance.updateUser(user);
      _currentUser = user;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.keyUserName, user.name);
      await prefs.setString(AppConstants.keyUserEmail, user.email);
      if (user.photoUrl != null) {
        await prefs.setString(AppConstants.keyUserPhoto, user.photoUrl!);
      }
      
      notifyListeners();
    } catch (e) {
      debugPrint('Update user error: $e');
    }
  }
}
