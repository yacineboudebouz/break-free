import 'package:bad_habit_killer/src/core/core_features/theme/config/theme_repository.dart';
import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/utils/app_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_theme_provider.g.dart';

@Riverpod(keepAlive: true)
class AppThemeNotifier extends _$AppThemeNotifier {
  @override
  AppThemeMode build() {
    return _getUserThemeMode();
  }

  AppThemeMode _getUserThemeMode() {
    final theme = ref.watch(themeRepositoryProvider).getThemeMode();
    return AppThemeMode.values.byName(theme);
  }

  Future<void> changeTheme(AppThemeMode theme) async {
    state = theme;
    await ref.watch(themeRepositoryProvider).saveThemeMode(theme.name);
  }
}
