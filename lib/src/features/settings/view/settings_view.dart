import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/providers/app_theme_provider.dart';
import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/providers/current_app_theme_provider.dart';
import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/utils/app_theme.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:bad_habit_killer/src/features/settings/view/widgets/setting_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
part 'settings_view_helper.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(currentAppThemeModeProvider);
    return AppScaffold(
      body: Column(
        children: [
          Container(
            height: context.height * 0.12,
            padding: const EdgeInsets.all(Sizes.spacing16),
            child: Padding(
              padding: const EdgeInsets.only(top: Sizes.paddingV24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: Sizes.icon28),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  Center(
                    child: Text(
                      "Settings".hardcoded,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  gapW48,
                ],
              ),
            ),
          ),
          Column(
            children: [
              SettingCard(
                title: "App".hardcoded,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Appearance".hardcoded),
                    leading: Icon(Icons.color_lens, size: Sizes.icon28),
                    subtitle: Text(
                      currentTheme.isDarkTheme
                          ? "Dark".hardcoded
                          : "Light".hardcoded,
                    ),
                    onTap: () => _changeTheme(ref, context),
                  ),
                ],
              ),
              gapH16,
              SettingCard(
                title: "About".hardcoded,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("App version".hardcoded),
                    leading: Icon(Icons.info, size: Sizes.icon28),
                    subtitle: Text("1.1.0"),
                  ),
                ],
              ),
              gapH16,
              SettingCard(
                title: "Developer",
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Website".hardcoded),
                    leading: Icon(Icons.public, size: Sizes.icon28),
                    onTap: () async {
                      final url = Uri.parse("https://yacineboudebouz.tech");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
