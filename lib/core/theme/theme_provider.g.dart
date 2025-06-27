// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentThemeModeHash() => r'543f9e009ae9d263be63d359163bfba857d60ef1';

/// Convenience provider for quick access to theme mode
///
/// Copied from [currentThemeMode].
@ProviderFor(currentThemeMode)
final currentThemeModeProvider = AutoDisposeProvider<AppThemeMode>.internal(
  currentThemeMode,
  name: r'currentThemeModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentThemeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentThemeModeRef = AutoDisposeProviderRef<AppThemeMode>;
String _$isDarkModeHash() => r'44f761ca7a025b3022be3d7502cdaa968fd2b474';

/// Convenience provider for quick access to dark mode state
///
/// Copied from [isDarkMode].
@ProviderFor(isDarkMode)
final isDarkModeProvider = AutoDisposeProvider<bool>.internal(
  isDarkMode,
  name: r'isDarkModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isDarkModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsDarkModeRef = AutoDisposeProviderRef<bool>;
String _$currentThemeHash() => r'aeda7f6d2c2fd43495439dba884c43f3429db636';

/// Convenience provider for quick access to current theme
///
/// Copied from [currentTheme].
@ProviderFor(currentTheme)
final currentThemeProvider = AutoDisposeProvider<AppTheme>.internal(
  currentTheme,
  name: r'currentThemeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentThemeRef = AutoDisposeProviderRef<AppTheme>;
String _$materialThemeModeHash() => r'25f28dfef212834bba9c3e5caf836af594286d55';

/// Provider for Material App theme mode
///
/// Copied from [materialThemeMode].
@ProviderFor(materialThemeMode)
final materialThemeModeProvider = AutoDisposeProvider<ThemeMode>.internal(
  materialThemeMode,
  name: r'materialThemeModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$materialThemeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MaterialThemeModeRef = AutoDisposeProviderRef<ThemeMode>;
String _$lightThemeDataHash() => r'7ca6324e0ca09ccc05aa71428a6aa9a06c897415';

/// Provider for light theme data
///
/// Copied from [lightThemeData].
@ProviderFor(lightThemeData)
final lightThemeDataProvider = AutoDisposeProvider<ThemeData>.internal(
  lightThemeData,
  name: r'lightThemeDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lightThemeDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LightThemeDataRef = AutoDisposeProviderRef<ThemeData>;
String _$darkThemeDataHash() => r'9ab61be6cf8e9ac22f02ceda6b3ee410f2c09723';

/// Provider for dark theme data
///
/// Copied from [darkThemeData].
@ProviderFor(darkThemeData)
final darkThemeDataProvider = AutoDisposeProvider<ThemeData>.internal(
  darkThemeData,
  name: r'darkThemeDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$darkThemeDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DarkThemeDataRef = AutoDisposeProviderRef<ThemeData>;
String _$themeActionsHash() => r'ab7570b840297b0b13449bf387997d39ed60f88f';

/// Theme actions provider for easy access to theme switching
///
/// Copied from [themeActions].
@ProviderFor(themeActions)
final themeActionsProvider = AutoDisposeProvider<ThemeActions>.internal(
  themeActions,
  name: r'themeActionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeActionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ThemeActionsRef = AutoDisposeProviderRef<ThemeActions>;
String _$themeNotifierHash() => r'2bb7214152aee348d9c075a3f162ccc419de4020';

/// Theme notifier that manages app theme state and persistence
///
/// Copied from [ThemeNotifier].
@ProviderFor(ThemeNotifier)
final themeNotifierProvider =
    AutoDisposeNotifierProvider<ThemeNotifier, ThemeState>.internal(
      ThemeNotifier.new,
      name: r'themeNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$themeNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ThemeNotifier = AutoDisposeNotifier<ThemeState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
