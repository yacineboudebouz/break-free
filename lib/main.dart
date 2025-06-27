import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/database/database_service.dart';
import 'core/theme/theme.dart';
import 'core/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logger
  AppLogger.info('Starting Bad Habit Killer app');

  runApp(const ProviderScope(child: BadHabitKillerApp()));
}

class BadHabitKillerApp extends ConsumerStatefulWidget {
  const BadHabitKillerApp({super.key});

  @override
  ConsumerState<BadHabitKillerApp> createState() => _BadHabitKillerAppState();
}

class _BadHabitKillerAppState extends ConsumerState<BadHabitKillerApp> {
  @override
  void initState() {
    super.initState();
    // Initialize theme provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(themeNotifierProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lightTheme = ref.watch(lightThemeDataProvider);
    final darkTheme = ref.watch(darkThemeDataProvider);
    final themeMode = ref.watch(materialThemeModeProvider);

    return MaterialApp(
      title: 'Bad Habit Killer',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(currentThemeModeProvider);
    final isDarkMode = ref.watch(isDarkModeProvider);
    final themeActions = ref.watch(themeActionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bad Habit Killer'),
        actions: [
          // Theme switch button
          PopupMenuButton<String>(
            icon: const Icon(Icons.palette),
            onSelected: (value) {
              switch (value) {
                case 'angel':
                  themeActions.switchToAngelTheme();
                  break;
                case 'devil':
                  themeActions.switchToDevilTheme();
                  break;
                case 'dark':
                  themeActions.toggleDarkMode();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'angel',
                child: Row(
                  children: [
                    Icon(
                      Icons.light_mode,
                      color: currentThemeMode == AppThemeMode.angel
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                    const SizedBox(width: 8),
                    const Text('Angel Theme'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'devil',
                child: Row(
                  children: [
                    Icon(
                      Icons.dark_mode,
                      color: currentThemeMode == AppThemeMode.devil
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                    const SizedBox(width: 8),
                    const Text('Devil Theme'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'dark',
                child: Row(
                  children: [
                    Icon(isDarkMode ? Icons.brightness_7 : Icons.brightness_4),
                    const SizedBox(width: 8),
                    Text(isDarkMode ? 'Light Mode' : 'Dark Mode'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Bad Habit Killer!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Current Theme: ${currentThemeMode.name.toUpperCase()}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Mode: ${isDarkMode ? 'Dark' : 'Light'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => themeActions.switchToAngelTheme(),
                  icon: const Icon(Icons.lightbulb),
                  label: const Text('Angel Theme'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentThemeMode == AppThemeMode.angel
                        ? Theme.of(context).primaryColor
                        : null,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => themeActions.switchToDevilTheme(),
                  icon: const Icon(Icons.warning),
                  label: const Text('Devil Theme'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentThemeMode == AppThemeMode.devil
                        ? Theme.of(context).primaryColor
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () => themeActions.toggleDarkMode(),
              icon: Icon(isDarkMode ? Icons.brightness_7 : Icons.brightness_4),
              label: Text(isDarkMode ? 'Switch to Light' : 'Switch to Dark'),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _testDatabase(ref),
              child: const Text('Test Database'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _testLogger(),
              child: const Text('Test Logger'),
            ),
          ],
        ),
      ),
    );
  }

  void _testDatabase(WidgetRef ref) async {
    final context = ref.context; // Store context before async operations
    try {
      AppLogger.info('Testing database connection...');
      final dbService = ref.read(databaseServiceProvider);
      await dbService.getDatabase();
      AppLogger.info('Database connection successful!');

      // Test if database exists
      final exists = await dbService.databaseExists();
      AppLogger.info('Database exists: $exists');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Database test successful!')),
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error('Database test failed', e, stackTrace);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Database test failed: $e')));
      }
    }
  }

  void _testLogger() {
    AppLogger.debug('This is a debug message');
    AppLogger.info('This is an info message');
    AppLogger.warning('This is a warning message');
    AppLogger.error('This is an error message');

    // Test class-specific logger
    final classLogger = AppLogger.getLogger('HomePage');
    classLogger.i('This is a tagged log message');
  }
}
