import 'package:sqflite/sqflite.dart' hide DatabaseException;
import 'package:path/path.dart';
import '../constants/database_constants.dart';
import '../utils/logger.dart';
import '../error/exceptions.dart' as app_exceptions;

/// Database helper class that manages SQLite database operations
/// Implements singleton pattern for consistent database access
class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  // Private constructor for singleton pattern
  DatabaseHelper._();

  /// Get the singleton instance of DatabaseHelper
  static DatabaseHelper get instance {
    _instance ??= DatabaseHelper._();
    return _instance!;
  }

  /// Get the database instance, creating it if necessary
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  /// Initialize the database
  Future<Database> _initDatabase() async {
    try {
      AppLogger.info('Initializing database...');

      // Get the database path
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, DatabaseConstants.databaseName);

      AppLogger.debug('Database path: $path');

      // Open the database
      final database = await openDatabase(
        path,
        version: DatabaseConstants.databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onOpen: _onOpen,
      );

      AppLogger.info('Database initialized successfully');
      return database;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize database', e, stackTrace);
      throw app_exceptions.DatabaseException(
        message: 'Failed to initialize database: ${e.toString()}',
        cause: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Called when the database is created for the first time
  Future<void> _onCreate(Database db, int version) async {
    try {
      AppLogger.info('Creating database tables...');

      // Create habits table
      await db.execute(DatabaseConstants.createHabitsTable);
      AppLogger.debug('Created habits table');

      // Create relapses table
      await db.execute(DatabaseConstants.createRelapsesTable);
      AppLogger.debug('Created relapses table');

      // Create articles table
      await db.execute(DatabaseConstants.createArticlesTable);
      AppLogger.debug('Created articles table');

      // Seed initial data
      await _seedInitialData(db);

      AppLogger.info('Database tables created successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to create database tables', e, stackTrace);
      throw app_exceptions.DatabaseException(
        message: 'Failed to create database tables: ${e.toString()}',
        cause: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Called when the database needs to be upgraded
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      AppLogger.info(
        'Upgrading database from version $oldVersion to $newVersion',
      );

      // Handle database migrations here based on version numbers
      if (oldVersion < 2) {
        // Example migration for version 2
        // await db.execute('ALTER TABLE habits ADD COLUMN new_column TEXT');
      }

      AppLogger.info('Database upgraded successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to upgrade database', e, stackTrace);
      throw app_exceptions.DatabaseException(
        message: 'Failed to upgrade database: ${e.toString()}',
        cause: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Called when the database is opened
  Future<void> _onOpen(Database db) async {
    AppLogger.debug('Database opened');
    // Enable foreign key constraints
    await db.execute('PRAGMA foreign_keys = ON');
    AppLogger.debug('Foreign key constraints enabled');
  }

  /// Seed initial data into the database
  Future<void> _seedInitialData(Database db) async {
    try {
      AppLogger.info('Seeding initial data...');

      // Note: Articles will be seeded by the ArticleLocalDataSource
      // when the app starts for the first time

      AppLogger.info('Initial data setup completed');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to seed initial data', e, stackTrace);
      // Don't throw here as this is not critical for app functionality
    }
  }

  /// Close the database connection
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
      AppLogger.info('Database connection closed');
    }
  }

  /// Delete the database (useful for testing or reset functionality)
  Future<void> deleteDatabase() async {
    try {
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, DatabaseConstants.databaseName);

      await databaseFactory.deleteDatabase(path);
      _database = null;

      AppLogger.info('Database deleted successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete database', e, stackTrace);
      throw app_exceptions.DatabaseException(
        message: 'Failed to delete database: ${e.toString()}',
        cause: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Check if database exists
  Future<bool> databaseExists() async {
    try {
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, DatabaseConstants.databaseName);
      return await databaseFactory.databaseExists(path);
    } catch (e) {
      AppLogger.error('Failed to check database existence', e);
      return false;
    }
  }
}
