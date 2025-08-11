import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/widget_ref_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/async_value_widget.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/interactive_layer/interactive_layer.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/progress_widget.dart';
import 'package:bad_habit_killer/src/features/home/domain/add_relapse.dart';
import 'package:bad_habit_killer/src/features/home/providers/habit_controller.dart';
import 'package:bad_habit_killer/src/features/home/providers/single_habit.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/habit_widget.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/relapse_button.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/time_ticker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HabitDetailsView extends HookConsumerWidget {
  const HabitDetailsView({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitAsync = ref.watch(singleHabitProvider(id));
    final controller = ref.watch(habitControllerProvider);
    ref.listenAndHandleState(habitControllerProvider);
    return AppScaffold(
      body: AsyncValueWidget(
        value: habitAsync,
        data: (habit) => Column(
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
                        habit.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    gapW48,
                  ],
                ),
              ),
            ),
            SizedBox(
              height: context.height * 0.3,
              child: Hero(
                tag: 'progress_$id',
                child: ProgressWidget(
                  ringColor: Theme.of(context).cardColor,
                  strokeWidth: Sizes.borderWidth16,
                  value: habit.progress,
                  color: habit.colorValue,
                ),
              ),
            ),
            TimeTicker(
              color: habit.colorValue,
              dateTime: habit.lastRelapseDate,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.paddingH32,
                vertical: Sizes.paddingV8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ColumnItem(
                    title: 'Attempt'.hardcoded,
                    value: habit.attempt.toString(),
                    color: habit.colorValue,
                  ),
                  InteractiveLayer(
                    config: InteractionConfig.scaleIn,
                    child: RelapseButton(
                      color: habit.colorValue,
                      onPressed: controller.isLoading
                          ? null
                          : () {
                              final relapse = AddRelapse(
                                habitId: habit.id,
                                relapseDate: DateTime.now(),
                                note: null,
                              );
                              ref
                                  .read(habitControllerProvider.notifier)
                                  .addRelapse(relapse);
                            },
                    ),
                  ),
                  ColumnItem(
                    title: 'Record'.hardcoded,
                    value: habit.record.toString(),
                    color: habit.colorValue,
                  ),
                ],
              ),
            ),
          ],
        ),
        onRetry: () {},
      ),
    );
  }
}
