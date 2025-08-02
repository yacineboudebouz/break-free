import 'package:bad_habit_killer/src/core/config/routing/app_router.dart';
import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/providers/current_app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(currentAppThemeModeProvider);
    final router = ref.watch(goRouterProvider);
    final currentTheme = theme.getThemeData();
    return MaterialApp.router(
      title: 'Bad Habit Killer',
      theme: currentTheme,
      routerConfig: router,

      debugShowCheckedModeBanner: false,
    );
  }
}
