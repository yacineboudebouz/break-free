import 'package:bad_habit_killer/src/core/config/routing/animations/transition_framework.dart';
import 'package:bad_habit_killer/src/core/presentation/screens/error_builder_screen.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
import 'package:bad_habit_killer/src/features/home/view/add_habit/add_habit_view.dart';
import 'package:bad_habit_killer/src/features/home/view/edit_habit/edit_habit.dart';
import 'package:bad_habit_killer/src/features/home/view/habit_details/habit_details_view.dart';
import 'package:bad_habit_killer/src/features/home/view/home_view.dart';
import 'package:bad_habit_killer/src/features/settings/view/settings_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_router.g.dart';

enum AppRouter { home, addHabit, habitDetails, editHabit, settings }

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRouter.home.name,
        pageBuilder: (_, _) {
          return fadeTransition(child: HomeView());
        },
        routes: [
          GoRoute(
            path: 'add-habit',
            name: AppRouter.addHabit.name,
            pageBuilder: (_, _) {
              return slideRightTransition(child: AddHabitView());
            },
          ),
          GoRoute(
            path: '/habit-details/:habitId',
            name: AppRouter.habitDetails.name,
            pageBuilder: (_, state) {
              final habitId = state.pathParameters['habitId'];
              return heroTransition(
                duration: 500,
                child: HabitDetailsView(id: int.parse(habitId!)),
              );
            },
            routes: [
              GoRoute(
                path: "/edit-habit",
                name: AppRouter.editHabit.name,
                pageBuilder: (_, state) {
                  final habit = state.extra as HabitModel;
                  return slideRightTransition(
                    child: EditHabitView(habit: habit),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/settings',
            name: AppRouter.settings.name,
            pageBuilder: (_, __) {
              return slideRightTransition(child: const SettingsView());
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return ErrorBuilderScreen();
    },
  );
}
