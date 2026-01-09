import 'package:animate_do/animate_do.dart';
import 'package:bad_habit_killer/src/core/config/routing/app_router.dart';
import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/providers/current_app_theme_provider.dart';
import 'package:bad_habit_killer/src/core/presentation/constants/app_assets.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/animated_list/animated_list.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/async_value_widget.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/interactive_layer/interactive_layer.dart';
import 'package:bad_habit_killer/src/features/skills/data/repository/skills_repository.dart';
import 'package:bad_habit_killer/src/features/skills/domain/skill_model.dart';
import 'package:bad_habit_killer/src/features/skills/providers/multi_skills.dart';
import 'package:bad_habit_killer/src/features/skills/view/widgets/skill_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SkillsView extends HookConsumerWidget {
  const SkillsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allSkills = ref.watch(multiSkillsProvider);
    final appColors = ref.watch(currentAppThemeModeProvider).appColors;
    return AppScaffold(
      body: Column(
        children: [
          Container(
            height: context.height * 0.12,
            padding: const EdgeInsets.all(Sizes.spacing16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
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
                  Expanded(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        hintText: 'Search skills'.hardcoded,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizes.radius32),
                          borderSide: BorderSide(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizes.radius32),
                          borderSide: BorderSide(
                            color: appColors.textPrimaryColor,
                            width: 2,
                          ),
                        ),
                        prefixIcon: Icon(Icons.search, size: Sizes.icon24),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: Sizes.paddingH12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: AsyncValueWidget<List<SkillModel>>(
              value: allSkills,
              data: (skills) {
                if (skills.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          AppAssets.notFound,
                          repeat: true,
                          height: context.height * 0.4,
                        ),
                        Text(
                          'Start your 10,000 hour journey!\nAdd a skill to master.'
                              .hardcoded,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ).bounceInRight(),
                        gapH64,
                      ],
                    ),
                  );
                }
                return AppAnimatedList(
                  separatorBuilder: (context, index) => gapH16,
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.paddingH16,
                    vertical: Sizes.paddingV16,
                  ),
                  itemBuilder: (context, index) {
                    final skill = skills[index];
                    return Dismissible(
                      key: Key('skill_${skill.id}'),
                      onDismissed: (direction) {
                        ref
                            .read(multiSkillsProvider.notifier)
                            .deleteSkill(skill.id);
                      },
                      child: InteractiveLayer(
                        onTap: () {
                          context.goNamed(
                            AppRouter.skillDetails.name,
                            pathParameters: {'skillId': skill.id.toString()},
                          );
                        },
                        config: InteractionConfig.scaleIn,
                        child: SkillWidget(skill: skill),
                      ),
                    );
                  },
                  itemCount: skills.length,
                );
              },
              onRetry: () {
                ref.invalidate(allSkillsProvider);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppRouter.addSkill.name);
        },
        child: Icon(Icons.add, size: Sizes.icon24),
      ),
    );
  }
}
