import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/database_colors.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/progress_widget.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
import 'package:flutter/material.dart';

class HabitWidget extends StatelessWidget {
  const HabitWidget({super.key, required this.habit});
  final HabitModel habit;
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
          ProgressWidget(
            value: habit.progress,
            color: DatabaseColors.fromString(habit.color),
          ),
          gapW4,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.paddingV8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.name,
                    style: theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: habit.colorValue,
                    ),
                  ),
                  gapH4,
                  Row(
                    spacing: Sizes.spacing8,
                    children: [
                      ColumnItem(
                        title: 'Goal'.hardcoded,
                        value: habit.goal.toString(),
                        color: habit.colorValue,
                      ),
                      ColumnItem(
                        title: 'Attempt'.hardcoded,
                        value: habit.attempt.toString(),
                        color: habit.colorValue,
                      ),
                      ColumnItem(
                        title: 'Record'.hardcoded,
                        value: habit.record.toString(),
                        color: habit.colorValue,
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
      children: [
        Text(title, style: theme.textTheme.bodyMedium),
        Text(value, style: theme.textTheme.bodyMedium!.copyWith(color: color)),
      ],
    );
  }
}
