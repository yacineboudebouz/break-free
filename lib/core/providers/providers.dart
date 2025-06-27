import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../database/database_service.dart';

part 'providers.g.dart';

/// Core providers that are used throughout the application
/// These providers handle fundamental app services and dependencies

/// Logger provider for application-wide logging
@riverpod
Logger logger(Ref ref) {
  return Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    level: Level.debug, // Change to Level.warning for release builds
  );
}

/// Database helper provider
@riverpod
DatabaseHelper databaseHelper(Ref ref) {
  return DatabaseHelper.instance;
}

/// Database provider - provides the actual database instance
@riverpod
Future<Database> database(Ref ref) async {
  final databaseHelper = ref.read(databaseHelperProvider);
  return await databaseHelper.database;
}

/// Database service provider - handles database operations
@riverpod
DatabaseService databaseService(DatabaseServiceRef ref) {
  final databaseHelper = ref.watch(databaseHelperProvider);
  return DatabaseServiceImpl(databaseHelper);
}

// Theme provider will be added in Phase 4
// @riverpod
// class ThemeNotifier extends _$ThemeNotifier {
//   @override
//   ThemeState build() {
//     // Theme management will be implemented in Phase 4
//   }
// }

// Router provider will be added in Phase 5
// @riverpod
// GoRouter router(RouterRef ref) {
//   // Router configuration will be implemented in Phase 5
// }
