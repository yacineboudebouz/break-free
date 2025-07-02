import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/providers/app_theme_provider.dart';
import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/utils/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_app_theme_provider.g.dart';

@Riverpod(keepAlive: true)
AppThemeMode currentAppThemeMode(Ref ref) {
  return ref.watch(appThemeNotifierProvider);
}
