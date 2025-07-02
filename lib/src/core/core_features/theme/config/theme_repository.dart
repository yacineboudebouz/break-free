import 'package:bad_habit_killer/src/core/config/services/local_storage/local_storage_service.dart';
import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/utils/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme_repository.g.dart';

@riverpod
ThemeRepository themeRepository(Ref ref) {
  return ThemeRepository(ref.watch(localStorageServiceProvider));
}

class ThemeRepository {
  final LocalStorageService _localStorageService;
  const ThemeRepository(this._localStorageService);

  Future<void> saveThemeMode(String themeMode) async {
    await _localStorageService.saveThemeMode(themeMode);
  }

  String getThemeMode() {
    return _localStorageService.getThemeMode() ?? AppThemeMode.dark.name;
  }
}
