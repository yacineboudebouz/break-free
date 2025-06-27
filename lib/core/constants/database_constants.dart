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
  static const String habitsLastRelapseDate = 'last_relapse_date';
  static const String habitsStartDate = 'start_date';
  static const String habitsCurrentStreak = 'current_streak';
  static const String habitsBestStreak = 'best_streak';
  static const String habitsTotalRelapses = 'total_relapses';
  static const String habitsTotalSuccessDays = 'total_success_days';
  static const String habitsIsActive = 'is_active';
  static const String habitsTargetDays = 'target_days';
  static const String habitsNotes = 'notes';

  // Relapses Table Columns
  static const String relapsesId = 'id';
  static const String relapsesHabitId = 'habit_id';
  static const String relapsesType = 'type';
  static const String relapsesDate = 'date';
  static const String relapsesNote = 'note';
  static const String relapsesTrigger = 'trigger';
  static const String relapsesEmotion = 'emotion';
  static const String relapsesLocation = 'location';
  static const String relapsesIntensityLevel = 'intensity_level';
  static const String relapsesDurationMinutes = 'duration_minutes';
  static const String relapsesFeltGuilty = 'felt_guilty';
  static const String relapsesLessonsLearned = 'lessons_learned';
  static const String relapsesRecoveryPlan = 'recovery_plan';
  static const String relapsesCreatedAt = 'created_at';
  static const String relapsesUpdatedAt = 'updated_at';

  // Articles Table Columns
  static const String articlesId = 'id';
  static const String articlesTitle = 'title';
  static const String articlesSummary = 'summary';
  static const String articlesContent = 'content';
  static const String articlesAuthor = 'author';
  static const String articlesCategory = 'category';
  static const String articlesMood = 'mood';
  static const String articlesDifficulty = 'difficulty';
  static const String articlesTags = 'tags';
  static const String articlesReadTimeMinutes = 'read_time_minutes';
  static const String articlesPublishedDate = 'published_date';
  static const String articlesIsFeatured = 'is_featured';
  static const String articlesThumbnailUrl = 'thumbnail_url';
  static const String articlesKeyQuote = 'key_quote';
  static const String articlesTargetAudience = 'target_audience';
  static const String articlesSource = 'source';

  // SQL Create Table Statements
  static const String createHabitsTable =
      '''
    CREATE TABLE $habitsTable (
      $habitsId TEXT PRIMARY KEY,
      $habitsName TEXT NOT NULL,
      $habitsDescription TEXT NOT NULL,
      $habitsType TEXT NOT NULL,
      $habitsCategory TEXT NOT NULL,
      $habitsCreatedAt INTEGER NOT NULL,
      $habitsUpdatedAt INTEGER NOT NULL,
      $habitsLastRelapseDate INTEGER,
      $habitsStartDate INTEGER NOT NULL,
      $habitsCurrentStreak INTEGER DEFAULT 0,
      $habitsBestStreak INTEGER DEFAULT 0,
      $habitsTotalRelapses INTEGER DEFAULT 0,
      $habitsTotalSuccessDays INTEGER DEFAULT 0,
      $habitsIsActive INTEGER DEFAULT 1,
      $habitsTargetDays INTEGER,
      $habitsNotes TEXT
    )
  ''';

  static const String createRelapsesTable =
      '''
    CREATE TABLE $relapsesTable (
      $relapsesId TEXT PRIMARY KEY,
      $relapsesHabitId TEXT NOT NULL,
      $relapsesType TEXT NOT NULL,
      $relapsesDate INTEGER NOT NULL,
      $relapsesNote TEXT,
      $relapsesTrigger TEXT,
      $relapsesEmotion TEXT,
      $relapsesLocation TEXT,
      $relapsesIntensityLevel INTEGER,
      $relapsesDurationMinutes INTEGER,
      $relapsesFeltGuilty INTEGER DEFAULT 0,
      $relapsesLessonsLearned TEXT,
      $relapsesRecoveryPlan TEXT,
      $relapsesCreatedAt INTEGER NOT NULL,
      $relapsesUpdatedAt INTEGER NOT NULL,
      FOREIGN KEY ($relapsesHabitId) REFERENCES $habitsTable($habitsId) ON DELETE CASCADE
    )
  ''';

  static const String createArticlesTable =
      '''
    CREATE TABLE $articlesTable (
      $articlesId TEXT PRIMARY KEY,
      $articlesTitle TEXT NOT NULL,
      $articlesSummary TEXT NOT NULL,
      $articlesContent TEXT NOT NULL,
      $articlesAuthor TEXT NOT NULL,
      $articlesCategory TEXT NOT NULL,
      $articlesMood TEXT NOT NULL,
      $articlesDifficulty TEXT NOT NULL,
      $articlesTags TEXT NOT NULL,
      $articlesReadTimeMinutes INTEGER NOT NULL,
      $articlesPublishedDate INTEGER NOT NULL,
      $articlesIsFeatured INTEGER DEFAULT 0,
      $articlesThumbnailUrl TEXT,
      $articlesKeyQuote TEXT,
      $articlesTargetAudience TEXT,
      $articlesSource TEXT
    )
  ''';
}
