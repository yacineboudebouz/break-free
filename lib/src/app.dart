import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/providers/current_app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(currentAppThemeModeProvider);
    return MaterialApp(
      title: 'Bad Habit Killer',
      theme: theme.getThemeData(),
      home: Scaffold(
        appBar: AppBar(title: const Text('Bad Habit Killer')),
        body: Center(
          child: Text(
            'Current Theme: ${theme.name}',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
