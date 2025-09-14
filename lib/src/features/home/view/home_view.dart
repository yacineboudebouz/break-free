import 'package:animate_do/animate_do.dart';
import 'package:bad_habit_killer/src/core/config/routing/app_router.dart';

import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/providers/current_app_theme_provider.dart';

import 'package:bad_habit_killer/src/core/presentation/constants/app_assets.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/go_router_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/animated_list/animated_list.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/async_value_widget.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/interactive_layer/interactive_layer.dart';
import 'package:bad_habit_killer/src/features/home/data/repository/habits_repository.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
import 'package:bad_habit_killer/src/features/home/providers/multi_habits.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/app_drawer.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/habit_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  static final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allHabits = ref.watch(multiHabitsProvider);
    final appColors = ref.watch(currentAppThemeModeProvider).appColors;
    return AppScaffold(
      scaffoldKey: drawerKey,
      drawer: AppDrawer(),
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
                    icon: Icon(Icons.settings, size: Sizes.icon28),
                    onPressed: () {
                      drawerKey.currentState?.openDrawer();
                    },
                  ),
                  Expanded(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        hintText: 'Search habits'.hardcoded,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizes.radius32),
                          borderSide: BorderSide(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // Add this
                          borderRadius: BorderRadius.circular(Sizes.radius32),
                          borderSide: BorderSide(
                            color: appColors.textPrimaryColor,
                            width: 2, // Your desired focus color
                          ),
                        ),
                        prefixIcon: Icon(Icons.search, size: Sizes.icon24),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: Sizes.paddingH12,
                        ), // Add this
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: AsyncValueWidget<List<HabitModel>>(
              value: allHabits,
              data: (habits) {
                if (habits.isEmpty) {
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
                          'Add a new habit to get started!'.hardcoded,
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
                    final habit = habits[index];
                    return Dismissible(
                      key: Key('habit_${habit.id}'),
                      onDismissed: (direction) {
                        ref
                            .read(multiHabitsProvider.notifier)
                            .deleteHabit(habit.id);
                      },
                      child: InteractiveLayer(
                        onTap: () {
                          context.goNamed(
                            AppRouter.habitDetails.name,
                            pathParameters: {'habitId': habit.id.toString()},
                          );
                        },
                        config: InteractionConfig.scaleIn,
                        child: HabitWidget(habit: habit),
                      ),
                    );
                  },
                  itemCount: habits.length,
                );
              },
              onRetry: () {
                ref.invalidate(allHabitsProvider);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppRouter.addHabit.name);
        },
        child: Icon(Icons.add, size: Sizes.icon24),
      ),
    );
  }
}
