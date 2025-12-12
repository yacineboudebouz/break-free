import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/progress_widget.dart';
import 'package:bad_habit_killer/src/features/skills/domain/skill_model.dart';
import 'package:flutter/material.dart';

class SkillWidget extends StatelessWidget {
  const SkillWidget({super.key, required this.skill});
  final SkillModel skill;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: context.height * 0.15,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.radius32),
        color: theme.cardColor,
      ),
      child: Row(
        children: [
          Hero(
            tag: 'progress_${skill.id}',
            child: ProgressWidget(
              value: skill.progressPercentage / 100,
              color: skill.colorValue,
            ),
          ),
          gapW4,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.paddingV8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    skill.name,
                    style: theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: skill.colorValue,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  gapH4,
                  Row(
                    spacing: Sizes.spacing8,
                    children: [
                      ColumnItem(
                        title: 'Hours'.hardcoded,
                        value:
                            '${skill.totalHoursPracticed.toStringAsFixed(1)}',
                        color: skill.colorValue,
                      ),
                      ColumnItem(
                        title: 'Target'.hardcoded,
                        value: '${skill.targetHours}',
                        color: skill.colorValue,
                      ),
                      ColumnItem(
                        title: 'Streak'.hardcoded,
                        value: '${skill.currentStreak}d',
                        color: skill.colorValue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColumnItem extends StatelessWidget {
  const ColumnItem({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });
  final String title;
  final String value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: theme.textTheme.bodyMedium),
        Text(value, style: theme.textTheme.bodyMedium!.copyWith(color: color)),
      ],
    );
  }
}
