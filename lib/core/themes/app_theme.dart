import 'package:flutter/material.dart';

class AppTheme {
  // 우주 테마 색상 팔레트
  static const Color primaryColor = Color(0xFF2D1B69);      // 딥 바이올렛
  static const Color secondaryColor = Color(0xFF6C5CE7);    // 라벤더
  static const Color accentColor = Color(0xFFFFD700);       // 골드
  static const Color backgroundColor = Color(0xFF0F0B1A);   // 다크 네이비
  static const Color surfaceColor = Color(0xFF1A1625);      // 다크 퍼플
  static const Color errorColor = Color(0xFFFF6B6B);        // 소프트 레드
  
  // 그라데이션 색상
  static const List<Color> cosmicGradient = [
    Color(0xFF0F0B1A),
    Color(0xFF2D1B69),
    Color(0xFF6C5CE7),
  ];
  
  static const List<Color> starGradient = [
    Color(0xFFFFD700),
    Color(0xFFFFA726),
    Color(0xFFFF7043),
  ];

  // 현자별 테마 색상
  static const Map<String, Color> sageColors = {
    'stella': Color(0xFFFFD700),      // 골드 (별)
    'solon': Color(0xFF8B4513),       // 브라운 (대지)
    'orion': Color(0xFF9370DB),       // 퍼플 (신비)
    'drKairos': Color(0xFF4169E1),    // 로얄 블루 (논리)
    'gaia': Color(0xFF228B22),        // 포레스트 그린 (자연)
    'logos': Color(0xFF20B2AA),       // 라이트 시그린 (데이터)
    'morpheus': Color(0xFF4B0082),    // 인디고 (꿈)
  };

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 8,
        shadowColor: secondaryColor.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.white70,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Colors.white60,
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: Colors.grey.shade50,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black87,
        onError: Colors.white,
      ),
    );
  }
}