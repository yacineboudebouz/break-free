import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/database_colors.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/progress_widget.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            value: 0.7,
            color: DatabaseColors.fromString(habit.color),
          ),
        ],
      ),
    );
  }
}
