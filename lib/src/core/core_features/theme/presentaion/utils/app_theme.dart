import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/utils/app_colors.dart';
import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/utils/custom_colors.dart';
import 'package:flutter/material.dart';

/// here we define the app theme modes so we can have theming in one place
/// and easily manage the theme of the app
enum AppThemeMode {
  light,
  dark;

  ThemeData getThemeData(
    // we can add more parameters in the future if needed
  ) {
    return AppTheme(themeMode: this).getThemeData();
  }

  const AppThemeMode();
  ThemeData get _baseTheme {
    return switch (this) {
      AppThemeMode.light => ThemeData.light(),
      AppThemeMode.dark => ThemeData.dark(),
    };
  }

  AppColors get _colorsPalette {
    return switch (this) {
      AppThemeMode.light => AppColorsLight(),
      AppThemeMode.dark => AppColorsDark(),
    };
  }

  ColorScheme get _baseColorScheme {
    return switch (this) {
      AppThemeMode.light => const ColorScheme.light(),
      AppThemeMode.dark => const ColorScheme.dark(),
    };
  }

  IconData get settingsIcon {
    return switch (this) {
      AppThemeMode.light => Icons.wb_sunny,
      AppThemeMode.dark => Icons.nights_stay,
    };
  }
}

class AppTheme {
  AppTheme({required AppThemeMode themeMode}) : _themeMode = themeMode;

  final AppThemeMode _themeMode;

  late final ThemeData _baseTheme = _themeMode._baseTheme;
  late final AppColors _appColors = _themeMode._colorsPalette;
  late final ColorScheme _colorScheme = _themeMode._baseColorScheme;
  late final Color primaryColor = _appColors.primaryColor;
  late final Color _scaffoldBackgroundColor = _appColors.scaffoldBGColor;

  late final CustomColors _customColors = _appColors.customColors;

  ThemeData getThemeData() {
    return _baseTheme.copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: _scaffoldBackgroundColor,
      colorScheme: _colorScheme,
      extensions: [_customColors],
    );
  }
}
