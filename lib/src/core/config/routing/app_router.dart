import 'package:bad_habit_killer/src/core/config/routing/animations/transition_framework.dart';
import 'package:bad_habit_killer/src/core/presentation/screens/error_builder_screen.dart';
import 'package:bad_habit_killer/src/features/home/view/add_habit/add_habit_view.dart';
import 'package:bad_habit_killer/src/features/home/view/habit_details/habit_details_view.dart';
import 'package:bad_habit_killer/src/features/home/view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_router.g.dart';

enum AppRouter { home, addHabit, habitDetails }

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
            pageBuilder: (_, __) {
              return slideRightTransition(child: AddHabitView(), duration: 800);
            },
          ),
          GoRoute(
            path: '/habit-details/:habitId',
            name: AppRouter.habitDetails.name,
            pageBuilder: (context, state) {
              final habitId = state.pathParameters['habitId'];

              return heroTransition(
                child: HabitDetailsView(id: int.parse(habitId!)),
              );
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
