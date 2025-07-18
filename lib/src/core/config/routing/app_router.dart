import 'package:bad_habit_killer/src/core/presentation/screens/error_builder_screen.dart';
import 'package:bad_habit_killer/src/features/home/view/home_view.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_router.g.dart';

enum AppRouter { home }

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRouter.home.name,
        builder: (context, state) {
          return HomeView();
        },
      ),
    ],
    errorBuilder: (context, state) {
      return ErrorBuilderScreen();
    },
  );
}
