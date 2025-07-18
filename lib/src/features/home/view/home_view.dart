import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/providers/app_theme_provider.dart';
import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/providers/current_app_theme_provider.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(currentAppThemeModeProvider);
    return AppScaffold(
      paddingH: Sizes.paddingH16,
      paddingV: Sizes.paddingV12,
      body: Column(
        spacing: Sizes.marginH8,
        children: [
          Center(
            child: Text(
              'Home View'.hardcoded,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final changedTheme = theme.opposite;
              ref
                  .read(appThemeNotifierProvider.notifier)
                  .changeTheme(changedTheme);
            },
            child: theme.isLightTheme
                ? Text('Switch to Dark Theme'.hardcoded)
                : Text('Switch to Light Theme'.hardcoded),
          ),
        ],
      ),
    );
  }
}
