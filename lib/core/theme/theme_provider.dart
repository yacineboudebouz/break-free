import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/logger.dart';
import 'theme.dart';

part 'theme_provider.g.dart';

/// Enum representing available theme modes
enum AppThemeMode {
  /// Angel theme (light colors, good habits)
  angel,

  /// Devil theme (dark colors, bad habits)
  devil,

  /// System theme (follows device settings)
  system,
}

/// Theme state class containing current theme configuration
class ThemeState {
  final AppThemeMode themeMode;
  final Brightness systemBrightness;
  final AppTheme currentTheme;
  final bool isDarkMode;

  const ThemeState({
    required this.themeMode,
    required this.systemBrightness,
    required this.currentTheme,
    required this.isDarkMode,
  });

  ThemeState copyWith({
    AppThemeMode? themeMode,
    Brightness? systemBrightness,
    AppTheme? currentTheme,
    bool? isDarkMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      systemBrightness: systemBrightness ?? this.systemBrightness,
      currentTheme: currentTheme ?? this.currentTheme,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeState &&
          runtimeType == other.runtimeType &&
          themeMode == other.themeMode &&
          systemBrightness == other.systemBrightness &&
          isDarkMode == other.isDarkMode;

  @override
  int get hashCode =>
      themeMode.hashCode ^ systemBrightness.hashCode ^ isDarkMode.hashCode;
}

/// Theme notifier that manages app theme state and persistence
@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  static const String _themePreferenceKey = 'app_theme_mode';
  static const String _darkModePreferenceKey = 'app_dark_mode';
  @override
  ThemeState build() {
    return ThemeState(
      themeMode: AppThemeMode.angel,
      systemBrightness: Brightness.light,
      currentTheme: AngelTheme.instance,
      isDarkMode: false,
    );
  }

  /// Initialize theme from saved preferences
  Future<void> initialize() async {
    try {
      AppLogger.debug('ThemeProvider: Initializing theme preferences');

      final prefs = await SharedPreferences.getInstance();

      // Load saved theme mode
      final savedThemeModeIndex = prefs.getInt(_themePreferenceKey) ?? 0;
      final themeMode = AppThemeMode
          .values[savedThemeModeIndex.clamp(0, AppThemeMode.values.length - 1)];

      // Load saved dark mode preference
      final isDarkMode = prefs.getBool(_darkModePreferenceKey) ?? false;

      // Get system brightness
      final systemBrightness = _getSystemBrightness();

      // Determine current theme
      final currentTheme = _determineTheme(themeMode);

      state = ThemeState(
        themeMode: themeMode,
        systemBrightness: systemBrightness,
        currentTheme: currentTheme,
        isDarkMode: isDarkMode,
      );

      AppLogger.info(
        'ThemeProvider: Initialized with theme: ${themeMode.name}, dark mode: $isDarkMode',
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'ThemeProvider: Failed to initialize theme preferences',
        e,
        stackTrace,
      ); // Fall back to default values
      state = ThemeState(
        themeMode: AppThemeMode.angel,
        systemBrightness: Brightness.light,
        currentTheme: AngelTheme.instance,
        isDarkMode: false,
      );
    }
  }

  /// Switch to Angel theme
  Future<void> setAngelTheme() async {
    await _setThemeMode(AppThemeMode.angel);
  }

  /// Switch to Devil theme
  Future<void> setDevilTheme() async {
    await _setThemeMode(AppThemeMode.devil);
  }

  /// Switch to system theme
  Future<void> setSystemTheme() async {
    await _setThemeMode(AppThemeMode.system);
  }

  /// Toggle dark mode on/off
  Future<void> toggleDarkMode() async {
    final newDarkMode = !state.isDarkMode;
    await _setDarkMode(newDarkMode);
  }

  /// Set dark mode state
  Future<void> setDarkMode(bool isDarkMode) async {
    await _setDarkMode(isDarkMode);
  }

  /// Update system brightness (called from app lifecycle)
  void updateSystemBrightness(Brightness brightness) {
    if (state.systemBrightness != brightness) {
      AppLogger.debug(
        'ThemeProvider: System brightness changed to ${brightness.name}',
      );

      state = state.copyWith(
        systemBrightness: brightness,
        currentTheme: _determineTheme(state.themeMode),
      );
    }
  }

  /// Private method to set theme mode
  Future<void> _setThemeMode(AppThemeMode themeMode) async {
    try {
      AppLogger.debug('ThemeProvider: Setting theme mode to ${themeMode.name}');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themePreferenceKey, themeMode.index);

      final currentTheme = _determineTheme(themeMode);

      state = state.copyWith(themeMode: themeMode, currentTheme: currentTheme);

      AppLogger.info('ThemeProvider: Theme mode changed to ${themeMode.name}');
    } catch (e, stackTrace) {
      AppLogger.error('ThemeProvider: Failed to set theme mode', e, stackTrace);
    }
  }

  /// Private method to set dark mode
  Future<void> _setDarkMode(bool isDarkMode) async {
    try {
      AppLogger.debug('ThemeProvider: Setting dark mode to $isDarkMode');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_darkModePreferenceKey, isDarkMode);

      state = state.copyWith(isDarkMode: isDarkMode);

      AppLogger.info('ThemeProvider: Dark mode changed to $isDarkMode');
    } catch (e, stackTrace) {
      AppLogger.error('ThemeProvider: Failed to set dark mode', e, stackTrace);
    }
  }

  /// Determine which theme to use based on mode and system settings
  AppTheme _determineTheme(AppThemeMode themeMode) {
    switch (themeMode) {
      case AppThemeMode.angel:
        return AngelTheme.instance;
      case AppThemeMode.devil:
        return DevilTheme.instance;
      case AppThemeMode.system:
        // For system mode, use Angel theme as default
        // In a real app, you might want to detect if user has more good or bad habits
        return AngelTheme.instance;
    }
  }

  /// Get system brightness (placeholder - in real app this would use platform channels)
  Brightness _getSystemBrightness() {
    // In a real implementation, you would get this from the platform
    // For now, return light as default
    return Brightness.light;
  }
}

/// Convenience provider for quick access to theme mode
@riverpod
AppThemeMode currentThemeMode(CurrentThemeModeRef ref) {
  return ref.watch(themeNotifierProvider).themeMode;
}

/// Convenience provider for quick access to dark mode state
@riverpod
bool isDarkMode(IsDarkModeRef ref) {
  return ref.watch(themeNotifierProvider).isDarkMode;
}

/// Convenience provider for quick access to current theme
@riverpod
AppTheme currentTheme(CurrentThemeRef ref) {
  return ref.watch(themeNotifierProvider).currentTheme;
}

/// Provider for Material App theme mode
@riverpod
ThemeMode materialThemeMode(MaterialThemeModeRef ref) {
  final themeState = ref.watch(themeNotifierProvider);

  if (themeState.isDarkMode) return ThemeMode.dark;

  switch (themeState.themeMode) {
    case AppThemeMode.angel:
    case AppThemeMode.devil:
      return ThemeMode.light;
    case AppThemeMode.system:
      return ThemeMode.system;
  }
}

/// Provider for light theme data
@riverpod
ThemeData lightThemeData(LightThemeDataRef ref) {
  final currentTheme = ref.watch(currentThemeProvider);
  return currentTheme.lightTheme;
}

/// Provider for dark theme data
@riverpod
ThemeData darkThemeData(DarkThemeDataRef ref) {
  final currentTheme = ref.watch(currentThemeProvider);
  return currentTheme.darkTheme;
}

/// Helper class for theme actions
class ThemeActions {
  final ThemeNotifier _themeNotifier;

  ThemeActions(this._themeNotifier);

  /// Quick action to switch to Angel theme
  Future<void> switchToAngelTheme() async {
    await _themeNotifier.setAngelTheme();
  }

  /// Quick action to switch to Devil theme
  Future<void> switchToDevilTheme() async {
    await _themeNotifier.setDevilTheme();
  }

  /// Quick action to toggle dark mode
  Future<void> toggleDarkMode() async {
    await _themeNotifier.toggleDarkMode();
  }

  /// Quick action to switch based on habit type
  Future<void> switchThemeForHabitType(String habitType) async {
    if (habitType.toLowerCase() == 'good') {
      await switchToAngelTheme();
    } else if (habitType.toLowerCase() == 'bad') {
      await switchToDevilTheme();
    }
  }
}

/// Theme actions provider for easy access to theme switching
@riverpod
ThemeActions themeActions(ThemeActionsRef ref) {
  return ThemeActions(ref.read(themeNotifierProvider.notifier));
}
