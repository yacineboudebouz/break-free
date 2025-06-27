/// Database-related constants
class DatabaseConstants {
  // Database Information
  static const String databaseName = 'bad_habit_killer.db';
  static const int databaseVersion = 1;

  // Table Names
  static const String habitsTable = 'habits';
  static const String relapsesTable = 'relapses';
  static const String articlesTable = 'articles';

  // Habits Table Columns
  static const String habitsId = 'id';
  static const String habitsName = 'name';
  static const String habitsDescription = 'description';
  static const String habitsType = 'type';
  static const String habitsCategory = 'category';
  static const String habitsCreatedAt = 'created_at';
  static const String habitsUpdatedAt = 'updated_at';
  static const String habitsStreakCount = 'streak_count';
  static const String habitsLastSuccessDate = 'last_success_date';
  static const String habitsIsActive = 'is_active';

  // Relapses Table Columns
  static const String relapsesId = 'id';
  static const String relapsesHabitId = 'habit_id';
  static const String relapsesDate = 'date';
  static const String relapsesNote = 'note';
  static const String relapsesCreatedAt = 'created_at';
  static const String relapsesType = 'type'; // 'relapse' or 'success'

  // Articles Table Columns
  static const String articlesId = 'id';
  static const String articlesTitle = 'title';
  static const String articlesContent = 'content';
  static const String articlesAuthor = 'author';
  static const String articlesCategory = 'category';
  static const String articlesCreatedAt = 'created_at';
  static const String articlesIsFavorite = 'is_favorite';

  // SQL Create Table Statements
  static const String createHabitsTable =
      '''
    CREATE TABLE $habitsTable (
      $habitsId INTEGER PRIMARY KEY AUTOINCREMENT,
      $habitsName TEXT NOT NULL,
      $habitsDescription TEXT,
      $habitsType TEXT NOT NULL,
      $habitsCategory TEXT,
      $habitsCreatedAt TEXT NOT NULL,
      $habitsUpdatedAt TEXT NOT NULL,
      $habitsStreakCount INTEGER DEFAULT 0,
      $habitsLastSuccessDate TEXT,
      $habitsIsActive INTEGER DEFAULT 1
    )
  ''';

  static const String createRelapsesTable =
      '''
    CREATE TABLE $relapsesTable (
      $relapsesId INTEGER PRIMARY KEY AUTOINCREMENT,
      $relapsesHabitId INTEGER NOT NULL,
      $relapsesDate TEXT NOT NULL,
      $relapsesNote TEXT,
      $relapsesType TEXT NOT NULL,
      $relapsesCreatedAt TEXT NOT NULL,
      FOREIGN KEY ($relapsesHabitId) REFERENCES $habitsTable($habitsId) ON DELETE CASCADE
    )
  ''';

  static const String createArticlesTable =
      '''
    CREATE TABLE $articlesTable (
      $articlesId INTEGER PRIMARY KEY AUTOINCREMENT,
      $articlesTitle TEXT NOT NULL,
      $articlesContent TEXT NOT NULL,
      $articlesAuthor TEXT,
      $articlesCategory TEXT,
      $articlesCreatedAt TEXT NOT NULL,
      $articlesIsFavorite INTEGER DEFAULT 0
    )
  ''';
}
