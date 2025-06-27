import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_routes.dart';
import '../../features/habits/presentation/pages/home_page.dart';
import '../../features/habits/presentation/pages/habit_detail_page.dart';
import '../../features/habits/presentation/pages/add_habit_page.dart';
import '../../features/habits/presentation/pages/edit_habit_page.dart';

part 'app_router.g.dart';

/// Router configuration for the Bad Habit Killer app
@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    routes: [
      // Main routes
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeName,
        builder: (context, state) => const HomePage(),
      ),
      // Habit detail route
      GoRoute(
        path: AppRoutes.habitDetail,
        name: AppRoutes.habitDetailName,
        builder: (context, state) {
          final id = state.pathParameters[AppRoutes.idParam]!;
          return HabitDetailPage(habitId: id);
        },
      ),

      // Add habit route
      GoRoute(
        path: AppRoutes.addHabit,
        name: AppRoutes.addHabitName,
        builder: (context, state) => const AddHabitPage(),
      ),

      // Edit habit route
      GoRoute(
        path: AppRoutes.editHabit,
        name: AppRoutes.editHabitName,
        builder: (context, state) {
          final id = state.pathParameters[AppRoutes.idParam]!;
          return EditHabitPage(habitId: id);
        },
      ),

      // Articles route
      GoRoute(
        path: AppRoutes.articles,
        name: AppRoutes.articlesName,
        builder: (context, state) => const ArticlesPlaceholder(),
        routes: [
          // Article detail as nested route
          GoRoute(
            path: ':${AppRoutes.idParam}',
            name: AppRoutes.articleDetailName,
            builder: (context, state) {
              final id = state.pathParameters[AppRoutes.idParam]!;
              return ArticleDetailPlaceholder(articleId: id);
            },
          ),
        ],
      ),

      // Settings route
      GoRoute(
        path: AppRoutes.settings,
        name: AppRoutes.settingsName,
        builder: (context, state) => const SettingsPlaceholder(),
      ),

      // Credits route
      GoRoute(
        path: AppRoutes.credits,
        name: AppRoutes.creditsName,
        builder: (context, state) => const CreditsPlaceholder(),
      ),
    ],
    // Error handling
    errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),
  );
}

// Placeholder widgets for articles, settings, and credits - these will be replaced in Phase 9
class ArticlesPlaceholder extends StatelessWidget {
  const ArticlesPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Articles')),
      body: const Center(child: Text('Articles Page')),
    );
  }
}

class ArticleDetailPlaceholder extends StatelessWidget {
  final String articleId;

  const ArticleDetailPlaceholder({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Article: $articleId')),
      body: Center(child: Text('Article Detail Page - ID: $articleId')),
    );
  }
}

class SettingsPlaceholder extends StatelessWidget {
  const SettingsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Page')),
    );
  }
}

class CreditsPlaceholder extends StatelessWidget {
  const CreditsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Credits')),
      body: const Center(child: Text('Credits Page')),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final String error;

  const ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Navigation Error: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
