import 'package:bad_habit_killer/src/core/config/routing/app_router.dart';
import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/providers/current_app_theme_provider.dart';
import 'package:bad_habit_killer/src/core/presentation/constants/app_assets.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/drawer_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

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
              gapH64,
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
                onTap: () {
                  context.pushNamed(AppRouter.settings.name);
                },
              ),
              gapH12,
              DrawerItemWidget(
                title: "Support us !",
                icon: Icons.diamond_outlined,
                onTap: () async {
                  final url = Uri.parse(
                    'https://github.com/yacineboudebouz/break-free',
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
              ),
              gapH12,

              DrawerItemWidget(
                title: "Help".hardcoded,
                icon: Icons.help_outline,
                onTap: () {
                  context.pushNamed(AppRouter.help.name);
                },
              ),
              gapH12,

              DrawerItemWidget(
                title: "Feedback",
                icon: Icons.feedback_outlined,
                onTap: () async {
                  final url = Uri.parse(
                    'mailto:y_boudebouz@estin.dz?subject=Break Free - Help and Feedback',
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
              ),
              gapH12,
            ],
          ),
        ),
      ),
    );
  }
}
