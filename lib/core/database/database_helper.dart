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

      // Seed sample articles
      await _seedArticles(db);

      AppLogger.info('Initial data seeded successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to seed initial data', e, stackTrace);
      // Don't throw here as this is not critical for app functionality
    }
  }

  /// Seed sample articles
  Future<void> _seedArticles(Database db) async {
    final articles = [
      {
        DatabaseConstants.articlesTitle: 'The Power of Habit Formation',
        DatabaseConstants.articlesContent: '''
Habits are the compound interest of self-improvement. The same way that money multiplies through compound interest, the effects of your habits multiply as you repeat them.

Understanding the habit loop - cue, routine, reward - is crucial for building good habits and breaking bad ones. Every habit follows this simple neurological loop.

Key strategies for habit formation:
1. Start small - Focus on tiny habits that are easy to maintain
2. Stack habits - Link new habits to existing ones
3. Create environmental cues - Make good habits obvious
4. Track your progress - What gets measured gets managed
5. Celebrate small wins - Reward yourself for consistency

Remember: You don't rise to the level of your goals, you fall to the level of your systems.
        ''',
        DatabaseConstants.articlesAuthor: 'Habit Expert',
        DatabaseConstants.articlesCategory: 'Habit Formation',
        DatabaseConstants.articlesCreatedAt: DateTime.now().toIso8601String(),
        DatabaseConstants.articlesIsFavorite: 0,
      },
      {
        DatabaseConstants.articlesTitle:
            'Breaking Bad Habits: A Scientific Approach',
        DatabaseConstants.articlesContent: '''
Breaking bad habits is often harder than forming good ones because they're usually tied to immediate rewards. Here's a science-based approach to overcome them:

1. Identify Your Triggers
- Environmental cues (places, people, situations)
- Emotional states (stress, boredom, anxiety)
- Time of day patterns

2. Replace, Don't Just Remove
- Substitute the bad habit with a healthier alternative
- Keep the same cue and reward, change the routine
- Example: Instead of reaching for your phone when bored, do 10 push-ups

3. Change Your Environment
- Remove cues that trigger the bad habit
- Make the bad habit harder to do
- Make good alternatives more accessible

4. Use the 2-Minute Rule
- When you feel the urge, commit to doing something else for just 2 minutes
- Often, the urge will pass in this time

5. Track Your Relapses
- Don't judge yourself harshly for setbacks
- Learn from each relapse to identify patterns
- Focus on getting back on track quickly

Remember: Progress, not perfection, is the goal.
        ''',
        DatabaseConstants.articlesAuthor: 'Behavioral Scientist',
        DatabaseConstants.articlesCategory: 'Breaking Habits',
        DatabaseConstants.articlesCreatedAt: DateTime.now().toIso8601String(),
        DatabaseConstants.articlesIsFavorite: 0,
      },
      {
        DatabaseConstants.articlesTitle: 'The Psychology of Motivation',
        DatabaseConstants.articlesContent: '''
Understanding what truly motivates us is key to lasting behavior change. Research shows that intrinsic motivation (internal drive) is more powerful than extrinsic motivation (external rewards).

Types of Motivation:

Intrinsic Motivation:
- Autonomy: Feeling in control of your choices
- Mastery: Getting better at something that matters
- Purpose: Connecting to something larger than yourself

Extrinsic Motivation:
- Rewards: Money, praise, recognition
- Punishment: Fear of consequences
- Social pressure: Others' expectations

How to Boost Intrinsic Motivation:
1. Connect habits to your values and identity
2. Focus on the process, not just outcomes
3. Celebrate progress and learning
4. Give yourself choices and flexibility
5. Find meaning in your daily actions

Remember: The most sustainable changes come from internal desire, not external pressure.
        ''',
        DatabaseConstants.articlesAuthor: 'Psychology Researcher',
        DatabaseConstants.articlesCategory: 'Motivation',
        DatabaseConstants.articlesCreatedAt: DateTime.now().toIso8601String(),
        DatabaseConstants.articlesIsFavorite: 0,
      },
    ];

    for (final article in articles) {
      await db.insert(DatabaseConstants.articlesTable, article);
    }

    AppLogger.debug('Seeded ${articles.length} articles');
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
