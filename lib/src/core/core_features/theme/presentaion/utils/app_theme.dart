import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/utils/app_colors.dart';
import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/utils/custom_colors.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:flutter/material.dart';

/// here we define the app theme modes so we can have theming in one place
/// and easily manage the theme of the app
enum AppThemeMode {
  light,
  dark;

  ThemeData get themeData => AppTheme(themeMode: this).themeData;

  AppColors get appColors {
    return AppTheme(themeMode: this)._appColors;
  }

  AppColors get oppositeAppColors {
    return AppTheme(themeMode: opposite)._appColors;
  }

  /// these getters are used to check the current theme mode
  bool get isLightTheme => this == AppThemeMode.light;
  bool get isDarkTheme => this == AppThemeMode.dark;

  /// this getter is used to get the opposite theme mode
  /// to void using if-else statements and make code more readable
  AppThemeMode get opposite {
    return switch (this) {
      AppThemeMode.light => AppThemeMode.dark,
      AppThemeMode.dark => AppThemeMode.light,
    };
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

  BorderSide get dividerBorder {
    return switch (this) {
      AppThemeMode.light => const BorderSide(color: Colors.grey),
      AppThemeMode.dark => const BorderSide(color: Colors.white30),
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
  AppColors get appColors => _appColors;

  late final CustomColors _customColors = _appColors.customColors;
  late final IconThemeData _iconTheme = IconThemeData(
    color: _appColors.iconColor,
    size: 24.0, // You can adjust the size as needed
  );

  late final TextTheme _textTheme = _baseTheme.textTheme.copyWith(
    bodySmall: _baseTheme.textTheme.bodySmall?.copyWith(
      color: _appColors.textPrimaryColor,
      fontSize: Sizes.font16,
    ),
    bodyMedium: _baseTheme.textTheme.bodyMedium?.copyWith(
      color: _appColors.textPrimaryColor,
      fontSize: Sizes.font18,
    ),
    bodyLarge: _baseTheme.textTheme.bodyLarge?.copyWith(
      color: _appColors.textPrimaryColor,
      fontSize: Sizes.font20,
    ),
    titleSmall: _baseTheme.textTheme.titleSmall?.copyWith(
      color: _appColors.textPrimaryColor,
      fontSize: Sizes.font16,
    ),
    titleMedium: _baseTheme.textTheme.titleMedium?.copyWith(
      color: _appColors.textPrimaryColor,
      fontSize: Sizes.font18,
    ),
    titleLarge: _baseTheme.textTheme.titleLarge?.copyWith(
      color: _appColors.textPrimaryColor,
      fontSize: Sizes.font24,
    ),
  );

  late final FloatingActionButtonThemeData _actionButtonThemeData =
      FloatingActionButtonThemeData(
        backgroundColor: _appColors.textPrimaryColor,
        foregroundColor: _appColors.scaffoldBGColor,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.radius32),
          side: BorderSide(color: _appColors.dividerColor, width: 1.0),
        ),
      );

  // here for input decoration theme
  late final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.radius32),
      borderSide: BorderSide(color: _appColors.primaryColor, width: 2.0),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.radius32),
      borderSide: BorderSide(color: _appColors.dividerColor, width: 1.0),
    ),
  );

  late final TextSelectionThemeData _textSelectionThemeData =
      TextSelectionThemeData(
        cursorColor: _appColors.textPrimaryColor,
        selectionColor: _appColors.textPrimaryColor.withOpacity(0.5),
        selectionHandleColor: _appColors.textPrimaryColor,
      );

  late final DatePickerThemeData _datePickerThemeData = DatePickerThemeData(
    backgroundColor: _appColors.scaffoldBGColor,
    dayStyle: TextStyle(color: _appColors.textPrimaryColor),
    headerBackgroundColor: _appColors.appBarColor,
    headerForegroundColor: _appColors.textPrimaryColor,
    surfaceTintColor: Colors.transparent,
    confirmButtonStyle: TextButton.styleFrom(
      foregroundColor: _appColors.textPrimaryColor,
    ),
    cancelButtonStyle: TextButton.styleFrom(
      foregroundColor: _appColors.textPrimaryColor,
    ),
  );

  late final TimePickerThemeData _timePickerThemeData = TimePickerThemeData(
    backgroundColor: _appColors.scaffoldBGColor,
    hourMinuteTextColor: _appColors.textPrimaryColor,
    dialBackgroundColor: _appColors.appBarColor,
    entryModeIconColor: _appColors.textPrimaryColor,
    hourMinuteColor: _appColors.primaryColor,
    hourMinuteTextStyle: _baseTheme.timePickerTheme.hourMinuteTextStyle
        ?.copyWith(color: _appColors.scaffoldBGColor),

    cancelButtonStyle: TextButton.styleFrom(
      foregroundColor: _appColors.textPrimaryColor,
    ),
    confirmButtonStyle: TextButton.styleFrom(
      foregroundColor: _appColors.textPrimaryColor,
    ),

    dialHandColor: _appColors.primaryColor,
    hourMinuteShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Sizes.radius32),
      side: BorderSide(color: _appColors.dividerColor, width: 1.0),
    ),
    dialTextColor: _appColors.textPrimaryColor,
  );

  //TODO: in future if i want to add responsive texts and so on
  // i just have to add flutter screenutil package and create other custom classes
  // to handle screen sizes and responsive texts and just add them here with base theme
  ThemeData get themeData {
    return _baseTheme.copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: _scaffoldBackgroundColor,
      colorScheme: _colorScheme,
      dividerColor: _themeMode.dividerBorder.color,
      datePickerTheme: _datePickerThemeData,
      timePickerTheme: _timePickerThemeData,
      cardColor: _appColors.cardBGColor,
      iconTheme: _iconTheme,
      textTheme: _textTheme,
      focusColor: _appColors.appBarColor,
      floatingActionButtonTheme: _actionButtonThemeData,
      inputDecorationTheme: _inputDecorationTheme,
      textSelectionTheme: _textSelectionThemeData,
      extensions: [_customColors],
    );
  }
}
