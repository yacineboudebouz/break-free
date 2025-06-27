import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Devil-themed UI for bad habits and warning states
///
/// This theme uses dark, intense colors with sharp design elements
/// to create a sense of urgency and warning for users working on
/// breaking bad habits.
class DevilTheme extends AppTheme {
  DevilTheme._();

  static final DevilTheme _instance = DevilTheme._();
  static DevilTheme get instance => _instance;

  // Devil Color Palette
  static const Color _devilPrimary = Color(0xFFDC2626); // Deep red
  static const Color _devilSecondary = Color(0xFFEA580C); // Burning orange
  static const Color _devilAccent = Color(0xFFFBBF24); // Fiery yellow
  static const Color _devilError = Color(0xFFB91C1C); // Dark red
  // Light theme colors (for contrast)
  static const Color _lightSurface = Color(0xFFFFFFFF); // Pure white
  static const Color _lightOnPrimary = Color(0xFFFFFFFF); // White on primary
  static const Color _lightOnSecondary = Color(
    0xFFFFFFFF,
  ); // White on secondary
  static const Color _lightOnSurface = Color(0xFF991B1B); // Medium red

  // Dark theme colors
  static const Color _darkSurface = Color(0xFF1C1917); // Dark brown
  static const Color _darkOnPrimary = Color(0xFFFFFFFF); // White on primary
  static const Color _darkOnSecondary = Color(0xFF000000); // Black on secondary
  static const Color _darkOnSurface = Color(0xFFEF4444); // Light red

  @override
  ColorScheme get colorScheme => const ColorScheme.light(
    brightness: Brightness.light,
    primary: _devilPrimary,
    onPrimary: _lightOnPrimary,
    secondary: _devilSecondary,
    onSecondary: _lightOnSecondary,
    tertiary: _devilAccent,
    error: _devilError,
    onError: Colors.white,
    surface: _lightSurface,
    onSurface: _lightOnSurface,
    surfaceContainerHighest: Color(0xFFFEF7F7),
    onSurfaceVariant: Color(0xFFA21CAF),
    outline: Color(0xFFE11D48),
    outlineVariant: Color(0xFFFECDD3),
    shadow: Color(0x40000000),
    scrim: Color(0x80000000),
  );

  @override
  ColorScheme get darkColorScheme => const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: _devilPrimary,
    onPrimary: _darkOnPrimary,
    secondary: _devilSecondary,
    onSecondary: _darkOnSecondary,
    tertiary: _devilAccent,
    error: _devilError,
    onError: Colors.white,
    surface: _darkSurface,
    onSurface: _darkOnSurface,
    surfaceContainerHighest: Color(0xFF292524),
    onSurfaceVariant: Color(0xFFF87171),
    outline: Color(0xFF7C2D12),
    outlineVariant: Color(0xFF451A03),
    shadow: Color(0x80000000),
    scrim: Color(0x90000000),
  );

  @override
  TextTheme get textTheme => const TextTheme(
    // Display styles - More aggressive/bold than angel theme
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w700, // Heavier weight
      letterSpacing: -0.25,
      height: 1.12,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      height: 1.16,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      height: 1.22,
    ),

    // Headline styles
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w800, // Extra bold
      letterSpacing: -0.5,
      height: 1.25,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
      height: 1.29,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.25,
      height: 1.33,
    ),

    // Title styles
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      height: 1.27,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      height: 1.50,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.10,
      height: 1.43,
    ),

    // Body styles
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500, // Slightly heavier
      letterSpacing: 0.15,
      height: 1.50,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      height: 1.43,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.40,
      height: 1.33,
    ),

    // Label styles
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700, // Bold labels
      letterSpacing: 0.10,
      height: 1.43,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.50,
      height: 1.33,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.50,
      height: 1.45,
    ),
  );

  @override
  TextTheme get darkTextTheme =>
      textTheme.apply(bodyColor: _darkOnSurface, displayColor: _darkOnSurface);

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    elevation: AppElevation.medium, // More elevation for devil theme
    backgroundColor: colorScheme.surface,
    foregroundColor: colorScheme.onSurface,
    surfaceTintColor: colorScheme.primary.withValues(alpha: 0.1),
    iconTheme: IconThemeData(color: colorScheme.onSurface),
    actionsIconTheme: IconThemeData(color: colorScheme.onSurface),
    titleTextStyle: textTheme.titleLarge?.copyWith(
      color: colorScheme.onSurface,
      fontWeight: FontWeight.w800, // Extra bold
    ),
    toolbarTextStyle: textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurface,
    ),
    shape: Border(
      bottom: BorderSide(
        color: colorScheme.primary.withValues(alpha: 0.3),
        width: 2, // Thicker border
      ),
    ),
  );

  @override
  AppBarTheme get darkAppBarTheme => AppBarTheme(
    elevation: AppElevation.medium,
    backgroundColor: darkColorScheme.surface,
    foregroundColor: darkColorScheme.onSurface,
    surfaceTintColor: darkColorScheme.primary.withValues(alpha: 0.1),
    iconTheme: IconThemeData(color: darkColorScheme.onSurface),
    actionsIconTheme: IconThemeData(color: darkColorScheme.onSurface),
    titleTextStyle: darkTextTheme.titleLarge?.copyWith(
      color: darkColorScheme.onSurface,
      fontWeight: FontWeight.w800,
    ),
    toolbarTextStyle: darkTextTheme.bodyMedium?.copyWith(
      color: darkColorScheme.onSurface,
    ),
    shape: Border(
      bottom: BorderSide(
        color: darkColorScheme.primary.withValues(alpha: 0.3),
        width: 2,
      ),
    ),
  );

  @override
  CardThemeData get cardTheme => CardThemeData(
    elevation: AppElevation.medium, // Higher elevation
    shape: RoundedRectangleBorder(
      borderRadius: cardBorderRadius,
      side: BorderSide(
        color: colorScheme.outline.withValues(alpha: 0.2),
        width: 1,
      ),
    ),
    color: colorScheme.surface,
    surfaceTintColor: colorScheme.primary.withValues(alpha: 0.05),
    shadowColor: colorScheme.primary.withValues(alpha: 0.3),
    margin: EdgeInsets.all(AppSpacing.sm),
  );

  @override
  CardThemeData get darkCardTheme => CardThemeData(
    elevation: AppElevation.medium,
    shape: RoundedRectangleBorder(
      borderRadius: cardBorderRadius,
      side: BorderSide(
        color: darkColorScheme.outline.withValues(alpha: 0.3),
        width: 1,
      ),
    ),
    color: darkColorScheme.surface,
    surfaceTintColor: darkColorScheme.primary.withValues(alpha: 0.05),
    shadowColor: darkColorScheme.primary.withValues(alpha: 0.4),
    margin: EdgeInsets.all(AppSpacing.sm),
  );

  @override
  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: AppElevation.medium, // More elevation
      padding: standardPadding,
      shape: RoundedRectangleBorder(borderRadius: buttonBorderRadius),
      textStyle: textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w700, // Bold text
      ),
      shadowColor: colorScheme.primary.withValues(alpha: 0.4),
    ),
  );

  @override
  TextButtonThemeData get textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: standardPadding,
      shape: RoundedRectangleBorder(borderRadius: buttonBorderRadius),
      textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
    ),
  );

  @override
  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: standardPadding,
      shape: RoundedRectangleBorder(borderRadius: buttonBorderRadius),
      side: BorderSide(
        color: colorScheme.primary,
        width: 2, // Thicker border
      ),
      textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
    ),
  );

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppBorderRadius.sm,
      ), // Sharper corners
      borderSide: BorderSide(color: colorScheme.outline, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      borderSide: BorderSide(color: colorScheme.outline, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      borderSide: BorderSide(color: colorScheme.primary, width: 3),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      borderSide: BorderSide(color: colorScheme.error, width: 2),
    ),
    contentPadding: standardPadding,
    labelStyle: textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w600,
    ),
    hintStyle: textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
    ),
  );

  @override
  InputDecorationTheme get darkInputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: darkColorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      borderSide: BorderSide(color: darkColorScheme.outline, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      borderSide: BorderSide(color: darkColorScheme.outline, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      borderSide: BorderSide(color: darkColorScheme.primary, width: 3),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      borderSide: BorderSide(color: darkColorScheme.error, width: 2),
    ),
    contentPadding: standardPadding,
    labelStyle: darkTextTheme.bodyMedium?.copyWith(
      color: darkColorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w600,
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
          borderRadius: BorderRadius.circular(
            AppBorderRadius.md,
          ), // Less rounded
        ),
        splashColor: colorScheme.secondary.withValues(alpha: 0.3),
      );

  @override
  BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        selectedLabelStyle: textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700, // Bold selection
        ),
        unselectedLabelStyle: textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: AppElevation.high, // Higher elevation
      );

  @override
  ChipThemeData get chipTheme => ChipThemeData(
    backgroundColor: colorScheme.surfaceContainerHighest,
    deleteIconColor: colorScheme.error,
    disabledColor: colorScheme.onSurface.withValues(alpha: 0.12),
    selectedColor: colorScheme.primary,
    secondarySelectedColor: colorScheme.secondary,
    padding: EdgeInsets.all(AppSpacing.sm),
    labelStyle: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
    secondaryLabelStyle: textTheme.labelMedium?.copyWith(
      fontWeight: FontWeight.w600,
    ),
    brightness: Brightness.light,
    elevation: AppElevation.low,
    pressElevation: AppElevation.medium,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.sm), // Sharper
      side: BorderSide(
        color: colorScheme.outline.withValues(alpha: 0.5),
        width: 1,
      ),
    ),
  );

  @override
  DividerThemeData get dividerTheme => DividerThemeData(
    color: colorScheme.primary.withValues(alpha: 0.3), // Red-tinted dividers
    thickness: 2, // Thicker dividers
    space: 2,
  );

  @override
  IconThemeData get iconTheme =>
      IconThemeData(color: colorScheme.onSurface, size: 24);

  @override
  IconThemeData get darkIconTheme =>
      IconThemeData(color: darkColorScheme.onSurface, size: 24);

  // Spacing and sizing overrides - Sharper, more angular
  @override
  BorderRadius get cardBorderRadius =>
      BorderRadius.circular(AppBorderRadius.md); // Less rounded

  @override
  BorderRadius get buttonBorderRadius =>
      BorderRadius.circular(AppBorderRadius.sm); // Sharp

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
  double get cardElevation => AppElevation.medium; // Higher elevation

  @override
  double get fabElevation => AppElevation.high; // Higher elevation

  @override
  double get appBarElevation => AppElevation.medium; // More prominent
}
