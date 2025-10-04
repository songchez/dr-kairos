class AppConstants {
  static const String appName = 'KAIROS와 7명의 현자';
  static const String appVersion = '1.0.0';
  
  // API
  static const String baseUrl = 'https://api.kairos-sages.com';
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const int apiTimeout = 30000; // milliseconds
  
  // Local Storage
  static const String userBoxName = 'user_box';
  static const String conversationBoxName = 'conversation_box';
  static const String questBoxName = 'quest_box';
  
  // Animation
  static const Duration shortAnimation = Duration(milliseconds: 300);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 1000);
  
  // UI
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const double defaultSpacing = 8.0;
}