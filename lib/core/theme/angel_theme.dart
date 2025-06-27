import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Angel-themed UI for good habits and positive reinforcement
///
/// This theme uses light, positive colors with soft design elements
/// to create an uplifting and motivational experience for users
/// working on building good habits.
class AngelTheme extends AppTheme {
  AngelTheme._();

  static final AngelTheme _instance = AngelTheme._();
  static AngelTheme get instance => _instance;
  // Angel Color Palette
  static const Color _angelPrimary = Color(0xFF6366F1); // Soft indigo
  static const Color _angelSecondary = Color(0xFF10B981); // Emerald green
  static const Color _angelAccent = Color(0xFFF59E0B); // Warm amber
  static const Color _angelError = Color(0xFFEF4444); // Soft red
  // Light theme colors
  static const Color _lightSurface = Color(0xFFFFFFFF); // Pure white
  static const Color _lightOnPrimary = Color(0xFFFFFFFF); // White on primary
  static const Color _lightOnSecondary = Color(
    0xFFFFFFFF,
  ); // White on secondary
  static const Color _lightOnSurface = Color(0xFF374151); // Medium dark gray

  // Dark theme colors
  static const Color _darkSurface = Color(0xFF1E293B); // Dark blue-gray
  static const Color _darkOnPrimary = Color(0xFFFFFFFF); // White on primary
  static const Color _darkOnSecondary = Color(0xFF000000); // Black on secondary
  static const Color _darkOnSurface = Color(0xFFE2E8F0); // Light blue-gray

  @override
  ColorScheme get colorScheme => const ColorScheme.light(
    brightness: Brightness.light,
    primary: _angelPrimary,
    onPrimary: _lightOnPrimary,
    secondary: _angelSecondary,
    onSecondary: _lightOnSecondary,
    tertiary: _angelAccent,
    error: _angelError,
    onError: Colors.white,
    surface: _lightSurface,
    onSurface: _lightOnSurface,
    surfaceContainerHighest: Color(0xFFF8FAFC),
    onSurfaceVariant: Color(0xFF64748B),
    outline: Color(0xFFCBD5E1),
    outlineVariant: Color(0xFFE2E8F0),
    shadow: Color(0x1A000000),
    scrim: Color(0x80000000),
  );

  @override
  ColorScheme get darkColorScheme => const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: _angelPrimary,
    onPrimary: _darkOnPrimary,
    secondary: _angelSecondary,
    onSecondary: _darkOnSecondary,
    tertiary: _angelAccent,
    error: _angelError,
    onError: Colors.white,
    surface: _darkSurface,
    onSurface: _darkOnSurface,
    surfaceContainerHighest: Color(0xFF334155),
    onSurfaceVariant: Color(0xFF94A3B8),
    outline: Color(0xFF475569),
    outlineVariant: Color(0xFF334155),
    shadow: Color(0x40000000),
    scrim: Color(0x80000000),
  );

  @override
  TextTheme get textTheme => const TextTheme(
    // Display styles
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      height: 1.12,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.16,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.22,
    ),

    // Headline styles
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.25,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.29,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.33,
    ),

    // Title styles
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      height: 1.27,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 1.50,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.10,
      height: 1.43,
    ),

    // Body styles
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      height: 1.50,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.43,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.40,
      height: 1.33,
    ),

    // Label styles
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.10,
      height: 1.43,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.50,
      height: 1.33,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.50,
      height: 1.45,
    ),
  );

  @override
  TextTheme get darkTextTheme =>
      textTheme.apply(bodyColor: _darkOnSurface, displayColor: _darkOnSurface);

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    elevation: AppElevation.none,
    backgroundColor: colorScheme.surface,
    foregroundColor: colorScheme.onSurface,
    surfaceTintColor: colorScheme.surfaceTint,
    iconTheme: IconThemeData(color: colorScheme.onSurface),
    actionsIconTheme: IconThemeData(color: colorScheme.onSurface),
    titleTextStyle: textTheme.titleLarge?.copyWith(
      color: colorScheme.onSurface,
      fontWeight: FontWeight.w600,
    ),
    toolbarTextStyle: textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurface,
    ),
    shape: Border(
      bottom: BorderSide(
        color: colorScheme.outline.withValues(alpha: 0.2),
        width: 1,
      ),
    ),
  );

  @override
  AppBarTheme get darkAppBarTheme => AppBarTheme(
    elevation: AppElevation.none,
    backgroundColor: darkColorScheme.surface,
    foregroundColor: darkColorScheme.onSurface,
    surfaceTintColor: darkColorScheme.surfaceTint,
    iconTheme: IconThemeData(color: darkColorScheme.onSurface),
    actionsIconTheme: IconThemeData(color: darkColorScheme.onSurface),
    titleTextStyle: darkTextTheme.titleLarge?.copyWith(
      color: darkColorScheme.onSurface,
      fontWeight: FontWeight.w600,
    ),
    toolbarTextStyle: darkTextTheme.bodyMedium?.copyWith(
      color: darkColorScheme.onSurface,
    ),
    shape: Border(
      bottom: BorderSide(
        color: darkColorScheme.outline.withValues(alpha: 0.2),
        width: 1,
      ),
    ),
  );

  @override
  CardThemeData get cardTheme => CardThemeData(
    elevation: AppElevation.low,
    shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
    color: colorScheme.surface,
    surfaceTintColor: colorScheme.surfaceTint,
    shadowColor: colorScheme.shadow,
    margin: EdgeInsets.all(AppSpacing.sm),
  );

  @override
  CardThemeData get darkCardTheme => CardThemeData(
    elevation: AppElevation.low,
    shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
    color: darkColorScheme.surface,
    surfaceTintColor: darkColorScheme.surfaceTint,
    shadowColor: darkColorScheme.shadow,
    margin: EdgeInsets.all(AppSpacing.sm),
  );

  @override
  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: AppElevation.low,
      padding: standardPadding,
      shape: RoundedRectangleBorder(borderRadius: buttonBorderRadius),
      textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
    ),
  );

  @override
  TextButtonThemeData get textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: standardPadding,
      shape: RoundedRectangleBorder(borderRadius: buttonBorderRadius),
      textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
    ),
  );

  @override
  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: standardPadding,
      shape: RoundedRectangleBorder(borderRadius: buttonBorderRadius),
      side: BorderSide(color: colorScheme.outline, width: 1),
      textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
    ),
  );

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.md),
      borderSide: BorderSide(color: colorScheme.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.md),
      borderSide: BorderSide(color: colorScheme.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.md),
      borderSide: BorderSide(color: colorScheme.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.md),
      borderSide: BorderSide(color: colorScheme.error),
    ),
    contentPadding: standardPadding,
    labelStyle: textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurfaceVariant,
    ),
    hintStyle: textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
    ),
  );

  @override
  InputDecorationTheme get darkInputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: darkColorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.md),
      borderSide: BorderSide(color: darkColorScheme.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.md),
      borderSide: BorderSide(color: darkColorScheme.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.md),
      borderSide: BorderSide(color: darkColorScheme.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.md),
      borderSide: BorderSide(color: darkColorScheme.error),
    ),
    contentPadding: standardPadding,
    labelStyle: darkTextTheme.bodyMedium?.copyWith(
      color: darkColorScheme.onSurfaceVariant,
    ),
    hintStyle: darkTextTheme.bodyMedium?.copyWith(
      color: darkColorScheme.onSurfaceVariant.withValues(alpha: 0.6),
    ),
  );

  @override
  FloatingActionButtonThemeData get floatingActionButtonTheme =>
      FloatingActionButtonThemeData(
        elevation: fabElevation,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.xl),
        ),
      );

  @override
  BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        selectedLabelStyle: textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: textTheme.labelSmall,
        type: BottomNavigationBarType.fixed,
        elevation: AppElevation.medium,
      );

  @override
  ChipThemeData get chipTheme => ChipThemeData(
    backgroundColor: colorScheme.surfaceContainerHighest,
    deleteIconColor: colorScheme.onSurfaceVariant,
    disabledColor: colorScheme.onSurface.withValues(alpha: 0.12),
    selectedColor: colorScheme.secondaryContainer,
    secondarySelectedColor: colorScheme.secondary,
    padding: EdgeInsets.all(AppSpacing.sm),
    labelStyle: textTheme.labelMedium,
    secondaryLabelStyle: textTheme.labelMedium,
    brightness: Brightness.light,
    elevation: AppElevation.none,
    pressElevation: AppElevation.low,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.md),
    ),
  );

  @override
  DividerThemeData get dividerTheme => DividerThemeData(
    color: colorScheme.outline.withValues(alpha: 0.2),
    thickness: 1,
    space: 1,
  );

  @override
  IconThemeData get iconTheme =>
      IconThemeData(color: colorScheme.onSurface, size: 24);

  @override
  IconThemeData get darkIconTheme =>
      IconThemeData(color: darkColorScheme.onSurface, size: 24);

  // Spacing and sizing overrides
  @override
  BorderRadius get cardBorderRadius =>
      BorderRadius.circular(AppBorderRadius.lg);

  @override
  BorderRadius get buttonBorderRadius =>
      BorderRadius.circular(AppBorderRadius.md);

  @override
  EdgeInsets get standardPadding => const EdgeInsets.all(AppSpacing.md);

  @override
  EdgeInsets get compactPadding => const EdgeInsets.all(AppSpacing.sm);

  @override
  EdgeInsets get largePadding => const EdgeInsets.all(AppSpacing.lg);

  @override
  double get standardSpacing => AppSpacing.md;

  @override
  double get compactSpacing => AppSpacing.sm;

  @override
  double get largeSpacing => AppSpacing.lg;

  @override
  double get cardElevation => AppElevation.low;

  @override
  double get fabElevation => AppElevation.medium;

  @override
  double get appBarElevation => AppElevation.none;
}
