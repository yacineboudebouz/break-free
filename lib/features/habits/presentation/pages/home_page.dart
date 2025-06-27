import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routing.dart';
import '../../../../core/theme/theme.dart';

/// Home page displaying habits and main navigation
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(currentThemeProvider);
    final themeActions = ref.watch(themeActionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bad Habit Killer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.pushNamed(AppRoutes.addHabitName),
            tooltip: 'Add Habit',
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Theme switcher section
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme Controls',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => themeActions.switchToAngelTheme(),
                        child: const Text('Angel Theme'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => themeActions.switchToDevilTheme(),
                        child: const Text('Devil Theme'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => themeActions.toggleDarkMode(),
                        child: const Text('Toggle Dark'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Navigation testing section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Navigation Testing',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.pushNamed(
                      AppRoutes.habitDetailName,
                      pathParameters: {AppRoutes.idParam: 'test-habit-1'},
                    ),
                    child: const Text('View Test Habit'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context.pushNamed(AppRoutes.addHabitName),
                    child: const Text('Add New Habit'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context.pushNamed(
                      AppRoutes.editHabitName,
                      pathParameters: {AppRoutes.idParam: 'test-habit-1'},
                    ),
                    child: const Text('Edit Test Habit'),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Current Theme: ${currentTheme.runtimeType}',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(AppRoutes.addHabitName),
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// App drawer for navigation
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Text(
              'Bad Habit Killer',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              context.goNamed(AppRoutes.homeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.article),
            title: const Text('Articles'),
            onTap: () {
              Navigator.pop(context);
              context.pushNamed(AppRoutes.articlesName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              context.pushNamed(AppRoutes.settingsName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Credits'),
            onTap: () {
              Navigator.pop(context);
              context.pushNamed(AppRoutes.creditsName);
            },
          ),
        ],
      ),
    );
  }
}
