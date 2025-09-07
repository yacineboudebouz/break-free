import 'package:animate_do/animate_do.dart';
import 'package:bad_habit_killer/src/core/config/routing/app_router.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/datetime_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/widget_ref_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/animated_list/animated_list.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/async_value_widget.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/interactive_layer/interactive_layer.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/progress_widget.dart';
import 'package:bad_habit_killer/src/features/home/domain/add_relapse.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
import 'package:bad_habit_killer/src/features/home/providers/habit_controller.dart';
import 'package:bad_habit_killer/src/features/home/providers/single_habit.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/habit_widget.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/relapse_button.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/relapse_history_widget.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/time_ticker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
part 'habit_details_view_helper.dart';

class HabitDetailsView extends StatefulHookConsumerWidget {
  const HabitDetailsView({super.key, required this.id});

  final int id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HabitDetailsViewState();
}

class _HabitDetailsViewState extends ConsumerState<HabitDetailsView> {
  @override
  Widget build(BuildContext context) {
    final habitAsync = ref.watch(singleHabitProvider(widget.id));
    final controller = ref.watch(habitControllerProvider);
    final noteController = useTextEditingController();
    final relapseDate = useState<DateTime>(DateTime.now());
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
                    IconButton(
                      icon: Icon(Icons.edit, size: Sizes.icon28),
                      onPressed: () {
                        context.pushNamed(
                          AppRouter.editHabit.name,
                          extra: habit,
                          pathParameters: {"habitId": habit.id.toString()},
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: context.height * 0.3,
                    child: Hero(
                      tag: 'progress_${widget.id}',
                      child: ProgressWidget(
                        ringColor: Theme.of(context).cardColor,
                        strokeWidth: Sizes.borderWidth16,
                        value: habit.progress,
                        color: habit.colorValue,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  child: Column(
                    children: [
                      Text(
                        "Current Goal",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        habit.goal.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: habit.colorValue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                      isLoading: controller.isLoading,
                      onPressed: () {
                        _addRelapse(
                          ref,
                          habit,
                          context,
                          relapseDate,
                          noteController,
                        );
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
            gapH12,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingH32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "History".hardcoded,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingH8),
              child: Divider(),
            ),
            Expanded(
              child: AppAnimatedList(
                itemBuilder: (_, index) {
                  final relapse = habit.events[index];
                  return RelapseHistoryWidget(
                    event: relapse,
                    onTap: () async {
                      _deleteRelapse(ref, relapse.id, habit.id, context);
                    },
                  );
                },
                itemCount: habit.events.length,
              ),
            ),
          ],
        ),
        onRetry: () {},
      ),
    );
  }
}
