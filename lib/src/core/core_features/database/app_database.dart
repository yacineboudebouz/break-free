import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'app_database.g.dart';

@riverpod
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}

@riverpod
Future<Database> database(Ref ref) {
  return ref.watch(appDatabaseProvider).database;
}

class DatabaseTables {
  const DatabaseTables._();

  static const String habits = "habits";
  static const String relapses = "relapses";
  static const String notes = "notes";
  static const String skills = "skills";
  static const String practiceSessions = "practice_sessions";
}

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  static Database? _database;

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  AppDatabase._internal();

  factory AppDatabase() => _instance;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    _logger.i('🔧 Initializing database...');
    final stopwatch = Stopwatch()..start();

    try {
      String path = join(await getDatabasesPath(), 'meal_planner.db');
      _logger.d('📁 Database path: $path');

      final db = await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );

      stopwatch.stop();
      _logger.i(
        '✅ Database initialized successfully in ${stopwatch.elapsedMilliseconds}ms',
      );
      return db;
    } catch (e, stackTrace) {
      stopwatch.stop();
      _logger.e(
        '❌ Failed to initialize database',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DatabaseTables.habits} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        start_date TEXT NOT NULL,
        description TEXT,
        color TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE ${DatabaseTables.relapses} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        habit_id INTEGER NOT NULL,
        relapse_date TEXT NOT NULL,
        note TEXT,
        FOREIGN KEY (habit_id) REFERENCES habits (id) ON DELETE CASCADE
      )
    ''');
    await db.execute('''
      CREATE TABLE ${DatabaseTables.notes} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        habit_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        note TEXT NOT NULL,
        FOREIGN KEY (habit_id) REFERENCES habits (id) ON DELETE CASCADE
      )
    ''');
    await db.execute('''
      CREATE TABLE ${DatabaseTables.skills} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        start_date TEXT NOT NULL,
        description TEXT,
        color TEXT NOT NULL,
        target_hours INTEGER NOT NULL DEFAULT 10000
      )
    ''');
    await db.execute('''
      CREATE TABLE ${DatabaseTables.practiceSessions} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        skill_id INTEGER NOT NULL,
        practice_date TEXT NOT NULL,
        duration_minutes INTEGER NOT NULL,
        note TEXT,
        FOREIGN KEY (skill_id) REFERENCES skills (id) ON DELETE CASCADE
      )
    ''');

    /// since i am going to refetch the data everytime
    /// and the join is is expensive operation
    ///  i will create `indexes` on the foreign keys
    await db.execute(
      'CREATE INDEX idx_relapses_habit_id ON relapses(habit_id)',
    );
    await db.execute('CREATE INDEX idx_notes_habit_id ON notes(habit_id)');
    await db.execute(
      'CREATE INDEX idx_practice_sessions_skill_id ON practice_sessions(skill_id)',
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    _logger.i('⬆️ Upgrading database from version $oldVersion to $newVersion');
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    _logger.d('➕ INSERT into $table: ${data.toString()}');
    final stopwatch = Stopwatch()..start();

    try {
      final db = await database;
      final result = await db.insert(table, data);
      stopwatch.stop();
      _logger.d(
        '✅ INSERT completed in ${stopwatch.elapsedMilliseconds}ms, ID: $result',
      );
      return result;
    } catch (e, stackTrace) {
      stopwatch.stop();
      _logger.e(
        '❌ INSERT failed for table $table',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    _logger.d('🔍 QUERY $table WHERE $where ARGS $whereArgs');
    final stopwatch = Stopwatch()..start();

    try {
      final db = await database;
      final result = await db.query(
        table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
      _logger.d(result);
      stopwatch.stop();
      _logger.d(
        '✅ QUERY completed in ${stopwatch.elapsedMilliseconds}ms, found ${result.length} records',
      );
      return result;
    } catch (e, stackTrace) {
      stopwatch.stop();
      _logger.e(
        '❌ QUERY failed for table $table',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    _logger.d(
      '🔄 UPDATE $table SET ${data.toString()} WHERE $where ARGS $whereArgs',
    );
    final stopwatch = Stopwatch()..start();

    try {
      final db = await database;
      final result = await db.update(
        table,
        data,
        where: where,
        whereArgs: whereArgs,
      );
      stopwatch.stop();
      _logger.d(
        '✅ UPDATE completed in ${stopwatch.elapsedMilliseconds}ms, affected $result rows',
      );
      return result;
    } catch (e, stackTrace) {
      stopwatch.stop();
      _logger.e(
        '❌ UPDATE failed for table $table',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    _logger.d('🗑️ DELETE from $table WHERE $where ARGS $whereArgs');
    final stopwatch = Stopwatch()..start();

    try {
      final db = await database;
      final result = await db.delete(table, where: where, whereArgs: whereArgs);
      stopwatch.stop();
      _logger.d(
        '✅ DELETE completed in ${stopwatch.elapsedMilliseconds}ms, deleted $result rows',
      );
      return result;
    } catch (e, stackTrace) {
      stopwatch.stop();
      _logger.e(
        '❌ DELETE failed for table $table',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<dynamic>? arguments,
  ]) async {
    _logger.d('⚡ RAW QUERY: $sql ARGS: $arguments');
    final stopwatch = Stopwatch()..start();

    try {
      final db = await database;
      final result = await db.rawQuery(sql, arguments);
      stopwatch.stop();
      _logger.d(
        '✅ RAW QUERY completed in ${stopwatch.elapsedMilliseconds}ms, found ${result.length} records',
      );
      return result;
    } catch (e, stackTrace) {
      stopwatch.stop();
      _logger.e('❌ RAW QUERY failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<T> transaction<T>(Future<T> Function(Transaction txn) action) async {
    _logger.d('🔄 Starting transaction...');
    final stopwatch = Stopwatch()..start();

    try {
      final db = await database;
      final result = await db.transaction(action);
      stopwatch.stop();
      _logger.d(
        '✅ Transaction completed successfully in ${stopwatch.elapsedMilliseconds}ms',
      );
      return result;
    } catch (e, stackTrace) {
      stopwatch.stop();
      _logger.e(
        '❌ Transaction failed in ${stopwatch.elapsedMilliseconds}ms',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<void> close() async {
    _logger.i('🔒 Closing database...');
    try {
      final db = await database;
      await db.close();
      _database = null;
      _logger.i('✅ Database closed successfully');
    } catch (e, stackTrace) {
      _logger.e('❌ Failed to close database', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  // Future<void> clearAllData() async {
  //   _logger.w('🧹 Clearing all data...');
  //   final stopwatch = Stopwatch()..start();

  //   try {
  //     final db = await database;
  //     await db.transaction((txn) async {
  //       await txn.delete(DatabaseTables.plannedMealFoods);
  //       await txn.delete(DatabaseTables.plannedMeals);
  //       await txn.delete(DatabaseTables.recipeIngredients);
  //       await txn.delete(DatabaseTables.foods);
  //       await txn.delete(DatabaseTables.ingredients);
  //       await txn.delete(DatabaseTables.foodTypes);
  //     });
  //     await _insertDefaultData(db);
  //     stopwatch.stop();
  //     _logger.i(
  //       '✅ All data cleared and reset in ${stopwatch.elapsedMilliseconds}ms',
  //     );
  //   } catch (e, stackTrace) {
  //     stopwatch.stop();
  //     _logger.e('❌ Failed to clear data', error: e, stackTrace: stackTrace);
  //     rethrow;
  //   }
  // }

  /// this is a generated funciton to debug print all tables and their data
  /// it will print the structure of each table and all data in it
  Future<void> debugPrintAllTables() async {
    // First get the list of all tables
    final tablesQuery = await rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'android_%'",
    );
    final tables = tablesQuery.map((row) => row['name'] as String).toList();

    print('===== DATABASE DEBUG: ALL TABLES =====');

    // For each table, print structure and data
    for (final tableName in tables) {
      print('\n📋 TABLE: $tableName');
      // Get table data
      final dataQuery = await query(tableName);
      print('\n  Data (${dataQuery.length} rows):');
      if (dataQuery.isEmpty) {
        print('    [EMPTY TABLE]');
      } else {
        for (final row in dataQuery) {
          print('    - $row');
        }
      }

      print('----------------------------------------');
    }

    print('===== END DATABASE DEBUG =====');
  }

  Future<void> dropTheDatabase() async {
    _logger.w('🗑️ Dropping the database...');
    final stopwatch = Stopwatch()..start();

    try {
      final path = join(await getDatabasesPath(), 'meal_planner.db');
      await deleteDatabase(path);
      _database = null;
      stopwatch.stop();
      _logger.i(
        '✅ Database dropped successfully in ${stopwatch.elapsedMilliseconds}ms',
      );
    } catch (e, stackTrace) {
      stopwatch.stop();
      _logger.e('❌ Failed to drop database', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
