import 'package:bad_habit_killer/src/core/config/providers/shared_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'local_storage_keys.dart';
part 'local_storage_service.g.dart';

@Riverpod(keepAlive: true)
LocalStorageService localStorageService(Ref ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return LocalStorageService(sharedPreferences.requireValue);
}

class LocalStorageService {
  final SharedPreferences _sharedPreferences;

  const LocalStorageService(this._sharedPreferences);

  Future<void> saveThemeMode(String themeMode) async {
    await _sharedPreferences.setString(LocalStorageKeys.themeMode, themeMode);
  }

  String? getThemeMode() {
    return _sharedPreferences.getString(LocalStorageKeys.themeMode);
  }

  Future<void> saveOnboardingCompleted(bool completed) async {
    await _sharedPreferences.setBool(
      LocalStorageKeys.onboardingCompleted,
      completed,
    );
  }

  bool? getOnboardingCompleted() {
    return _sharedPreferences.getBool(LocalStorageKeys.onboardingCompleted);
  }
}
