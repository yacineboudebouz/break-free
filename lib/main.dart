import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/database_service.dart';
import 'core/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logger
  AppLogger.info('Starting Bad Habit Killer app');

  runApp(const ProviderScope(child: BadHabitKillerApp()));
}

class BadHabitKillerApp extends ConsumerWidget {
  const BadHabitKillerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Bad Habit Killer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Bad Habit Killer'),
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
