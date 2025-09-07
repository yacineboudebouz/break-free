import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/providers/current_app_theme_provider.dart';
import 'package:bad_habit_killer/src/core/presentation/constants/app_assets.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/drawer_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(currentAppThemeModeProvider).appColors;
    final theme = Theme.of(context);
    return Drawer(
      backgroundColor: appColors.scaffoldBGColor,
      width: double.maxFinite,
      child: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.paddingH16),
          child: Column(
            children: [
              gapH32,
              Image.asset(AppAssets.freedom),
              gapH24,
              Text(
                'Break Free'.hardcoded,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              gapH24,
              DrawerItemWidget(
                title: "Settings".hardcoded,
                icon: Icons.settings_outlined,
              ),
              gapH12,
              DrawerItemWidget(
                title: "Support us !",
                icon: Icons.diamond_outlined,
              ),
              gapH12,
              DrawerItemWidget(
                title: "Help and feedback",
                icon: Icons.feedback_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
