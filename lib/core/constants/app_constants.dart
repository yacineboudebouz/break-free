/// Application-wide constants
class AppConstants {
  // App Information
  static const String appName = 'Bad Habit Killer';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Track and manage your habits with devil/angel themes';

  // Developer Information
  static const String developerName = 'Your Name';
  static const String developerEmail = 'your.email@example.com';

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 4.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // Habit Types
  static const String goodHabitType = 'good';
  static const String badHabitType = 'bad';

  // Theme Keys
  static const String themeKey = 'app_theme';
  static const String lightTheme = 'light';
  static const String darkTheme = 'dark';
  static const String systemTheme = 'system';
}
