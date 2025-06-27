import 'package:flutter/material.dart';

/// Abstract base class for all app themes
///
/// This class defines the common structure that all themes must implement.
/// It provides a foundation for both AngelTheme (light/good habits) and
/// DevilTheme (dark/bad habits) implementations.
abstract class AppTheme {
  /// The primary color scheme for this theme
  ColorScheme get colorScheme;

  /// The dark color scheme for this theme
  ColorScheme get darkColorScheme;

  /// Typography theme for this theme
  TextTheme get textTheme;

  /// Typography theme for dark mode
  TextTheme get darkTextTheme;

  /// App bar theme configuration
  AppBarTheme get appBarTheme;

  /// App bar theme for dark mode
  AppBarTheme get darkAppBarTheme;

  /// Card theme configuration
  CardThemeData get cardTheme;

  /// Card theme for dark mode
  CardThemeData get darkCardTheme;

  /// Elevated button theme
  ElevatedButtonThemeData get elevatedButtonTheme;

  /// Text button theme
  TextButtonThemeData get textButtonTheme;

  /// Outlined button theme
  OutlinedButtonThemeData get outlinedButtonTheme;

  /// Input decoration theme
  InputDecorationTheme get inputDecorationTheme;

  /// Input decoration theme for dark mode
  InputDecorationTheme get darkInputDecorationTheme;

  /// Floating action button theme
  FloatingActionButtonThemeData get floatingActionButtonTheme;

  /// Bottom navigation bar theme
  BottomNavigationBarThemeData get bottomNavigationBarTheme;

  /// Chip theme
  ChipThemeData get chipTheme;

  /// Divider theme
  DividerThemeData get dividerTheme;

  /// Icon theme
  IconThemeData get iconTheme;

  /// Icon theme for dark mode
  IconThemeData get darkIconTheme;

  /// Creates the light theme data
  ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: textTheme,
    appBarTheme: appBarTheme,
    cardTheme: cardTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    textButtonTheme: textButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    inputDecorationTheme: inputDecorationTheme,
    floatingActionButtonTheme: floatingActionButtonTheme,
    bottomNavigationBarTheme: bottomNavigationBarTheme,
    chipTheme: chipTheme,
    dividerTheme: dividerTheme,
    iconTheme: iconTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // Custom spacing and sizing
    cardColor: colorScheme.surface,
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  /// Creates the dark theme data
  ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    textTheme: darkTextTheme,
    appBarTheme: darkAppBarTheme,
    cardTheme: darkCardTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    textButtonTheme: textButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    inputDecorationTheme: darkInputDecorationTheme,
    floatingActionButtonTheme: floatingActionButtonTheme,
    bottomNavigationBarTheme: bottomNavigationBarTheme,
    chipTheme: chipTheme,
    dividerTheme: dividerTheme,
    iconTheme: darkIconTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // Custom spacing and sizing
    cardColor: darkColorScheme.surface,
    scaffoldBackgroundColor: darkColorScheme.surface,
    canvasColor: darkColorScheme.surface,
  );

  /// Border radius for cards and containers
  BorderRadius get cardBorderRadius;

  /// Border radius for buttons
  BorderRadius get buttonBorderRadius;

  /// Standard padding for components
  EdgeInsets get standardPadding;

  /// Compact padding for tight spaces
  EdgeInsets get compactPadding;

  /// Large padding for spacious layouts
  EdgeInsets get largePadding;

  /// Standard spacing between elements
  double get standardSpacing;

  /// Compact spacing for tight layouts
  double get compactSpacing;

  /// Large spacing for spacious layouts
  double get largeSpacing;

  /// Standard elevation for cards
  double get cardElevation;

  /// Standard elevation for floating action buttons
  double get fabElevation;

  /// Standard elevation for app bars
  double get appBarElevation;
}

/// Spacing constants for consistent layout
class AppSpacing {
  AppSpacing._();

  /// Extra small spacing - 4.0
  static const double xs = 4.0;

  /// Small spacing - 8.0
  static const double sm = 8.0;

  /// Medium spacing - 16.0
  static const double md = 16.0;

  /// Large spacing - 24.0
  static const double lg = 24.0;

  /// Extra large spacing - 32.0
  static const double xl = 32.0;

  /// Extra extra large spacing - 48.0
  static const double xxl = 48.0;
}

/// Border radius constants for consistent design
class AppBorderRadius {
  AppBorderRadius._();

  /// Small border radius - 4.0
  static const double sm = 4.0;

  /// Medium border radius - 8.0
  static const double md = 8.0;

  /// Large border radius - 12.0
  static const double lg = 12.0;

  /// Extra large border radius - 16.0
  static const double xl = 16.0;

  /// Round border radius - 50.0
  static const double round = 50.0;
}

/// Elevation constants for consistent shadows
class AppElevation {
  AppElevation._();

  /// No elevation
  static const double none = 0.0;

  /// Low elevation - 2.0
  static const double low = 2.0;

  /// Medium elevation - 4.0
  static const double medium = 4.0;

  /// High elevation - 8.0
  static const double high = 8.0;

  /// Extra high elevation - 16.0
  static const double extraHigh = 16.0;
}

/// Duration constants for animations
class AppDuration {
  AppDuration._();

  /// Fast animation - 150ms
  static const Duration fast = Duration(milliseconds: 150);

  /// Medium animation - 300ms
  static const Duration medium = Duration(milliseconds: 300);

  /// Slow animation - 500ms
  static const Duration slow = Duration(milliseconds: 500);
}
