import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' hide DatabaseException;
import '../database/database_helper.dart';
import '../providers/providers.dart';
import '../utils/logger.dart';
import '../error/exceptions.dart' as app_exceptions;

/// Abstract database service interface for testing
abstract class DatabaseService {
  Future<Database> getDatabase();
  Future<void> closeDatabase();
  Future<void> deleteDatabase();
  Future<bool> databaseExists();
}

/// Production database service implementation
class DatabaseServiceImpl implements DatabaseService {
  final DatabaseHelper _databaseHelper;

  DatabaseServiceImpl(this._databaseHelper);

  @override
  Future<Database> getDatabase() async {
    try {
      return await _databaseHelper.database;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get database from service', e, stackTrace);
      throw app_exceptions.DatabaseException(
        message: 'Database service error: ${e.toString()}',
        cause: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<void> closeDatabase() async {
    try {
      await _databaseHelper.close();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to close database from service', e, stackTrace);
      throw app_exceptions.DatabaseException(
        message: 'Failed to close database: ${e.toString()}',
        cause: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<void> deleteDatabase() async {
    try {
      await _databaseHelper.deleteDatabase();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete database from service', e, stackTrace);
      throw app_exceptions.DatabaseException(
        message: 'Failed to delete database: ${e.toString()}',
        cause: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<bool> databaseExists() async {
    try {
      return await _databaseHelper.databaseExists();
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to check database existence from service',
        e,
        stackTrace,
      );
      return false;
    }
  }
}

/// Database service provider for dependency injection
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  final databaseHelper = ref.read(databaseHelperProvider);
  return DatabaseServiceImpl(databaseHelper);
});

/// Convenience provider for getting database instance through service
final databaseInstanceProvider = FutureProvider<Database>((ref) async {
  final databaseService = ref.read(databaseServiceProvider);
  return await databaseService.getDatabase();
});
