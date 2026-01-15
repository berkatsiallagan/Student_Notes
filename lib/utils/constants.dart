import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'Student Notes';
  static const String appVersion = '1.0.0';

  // Colors - Modern Green Theme
  // Primary: Soft sage green yang smooth dan tidak norak
  static const Color primaryColor = Color(0xFF5F9E7F); // Sage green
  static const Color primaryLight = Color(0xFF7FB89D); // Light sage
  static const Color primaryDark = Color(0xFF4A8066); // Dark sage
  
  // Secondary: Mint green yang fresh
  static const Color secondaryColor = Color(0xFF8BC9A8); // Mint green
  static const Color secondaryLight = Color(0xFFA8D8BF); // Light mint
  
  // Accent: Warm terracotta untuk kontras
  static const Color accentColor = Color(0xFFE8A87C); // Soft terracotta
  
  // Background: Soft cream untuk kesan natural
  static const Color backgroundColor = Color(0xFFF8FAF7); // Soft cream
  static const Color cardColor = Colors.white;
  static const Color surfaceColor = Color(0xFFEEF5F0); // Light green tint
  
  // Text: High contrast untuk readability
  static const Color textPrimary = Color(0xFF2D3E3F); // Dark slate
  static const Color textSecondary = Color(0xFF6B7F7E); // Medium slate
  static const Color textTertiary = Color(0xFF9AADAC); // Light slate
  
  // Status colors
  static const Color errorColor = Color(0xFFE07A5F); // Soft coral red
  static const Color successColor = Color(0xFF5F9E7F); // Same as primary
  static const Color warningColor = Color(0xFFF2CC8F); // Soft amber
  static const Color infoColor = Color(0xFF81B4C4); // Soft blue

  // Course Colors - Harmonious green palette
  static const List<String> courseColors = [
    '#5F9E7F', // Sage green
    '#8BC9A8', // Mint green
    '#7FB89D', // Light sage
    '#A8D8BF', // Pale mint
    '#81B4C4', // Soft blue
    '#E8A87C', // Terracotta
    '#F2CC8F', // Soft amber
    '#9AADAC', // Slate gray
  ];

  // SharedPreferences Keys
  static const String keyUserId = 'user_id';
  static const String keyUserName = 'user_name';
  static const String keyUserEmail = 'user_email';
  static const String keyUserPhoto = 'user_photo';
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyThemeMode = 'theme_mode';

  // Validation
  static const int minTitleLength = 3;
  static const int minContentLength = 10;
  static const int maxTitleLength = 100;

  // UI
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;
  static const double padding = 16.0;
  static const double iconSize = 24.0;
}
