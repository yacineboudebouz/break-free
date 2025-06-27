import 'package:sqflite/sqflite.dart' hide DatabaseException;
import 'package:uuid/uuid.dart';

import '../../../../core/database/database_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../models/habit_model.dart';

/// Abstract interface for habit local data source
abstract class HabitLocalDataSource {
  /// Get all habits from local storage
  Future<List<HabitModel>> getAllHabits();

  /// Get a habit by ID from local storage
  Future<HabitModel?> getHabitById(String id);

  /// Add a new habit to local storage
  Future<HabitModel> addHabit(HabitModel habit);

  /// Update an existing habit in local storage
  Future<HabitModel> updateHabit(HabitModel habit);

  /// Delete a habit from local storage
  Future<void> deleteHabit(String id);

  /// Search habits by name or description
  Future<List<HabitModel>> searchHabits(String query);

  /// Get habits by category
  Future<List<HabitModel>> getHabitsByCategory(String category);

  /// Get habits by type
  Future<List<HabitModel>> getHabitsByType(String type);

  /// Get active habits only
  Future<List<HabitModel>> getActiveHabits();

  /// Get inactive habits only
  Future<List<HabitModel>> getInactiveHabits();

  /// Update habit streak information
  Future<HabitModel> updateHabitStreak(
    String id,
    int currentStreak,
    int bestStreak,
  );

  /// Update habit relapse information
  Future<HabitModel> updateHabitRelapseInfo(
    String id,
    DateTime lastRelapseDate,
    int totalRelapses,
  );

  /// Bulk update habits
  Future<void> updateHabits(List<HabitModel> habits);
}

/// Implementation of habit local data source using SQLite
class HabitLocalDataSourceImpl implements HabitLocalDataSource {
  final DatabaseService _databaseService;
  final Uuid _uuid = const Uuid();

  HabitLocalDataSourceImpl(this._databaseService);

  static const String _tableName = 'habits';

  @override
  Future<List<HabitModel>> getAllHabits() async {
    try {
      AppLogger.debug('Getting all habits from local storage');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(_tableName, orderBy: 'created_at DESC');

      final habits = maps.map((map) => HabitModel.fromMap(map)).toList();

      AppLogger.debug('Retrieved ${habits.length} habits from local storage');
      return habits;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get all habits', e, stackTrace);
      throw DatabaseException(message: 'Failed to retrieve habits: $e');
    }
  }

  @override
  Future<HabitModel?> getHabitById(String id) async {
    try {
      AppLogger.debug('Getting habit by ID: $id');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (maps.isEmpty) {
        AppLogger.debug('Habit not found with ID: $id');
        return null;
      }

      final habit = HabitModel.fromMap(maps.first);
      AppLogger.debug('Retrieved habit: ${habit.name}');
      return habit;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get habit by ID: $id', e, stackTrace);
      throw DatabaseException(message: 'Failed to retrieve habit: $e');
    }
  }

  @override
  Future<HabitModel> addHabit(HabitModel habit) async {
    try {
      AppLogger.debug('Adding new habit: ${habit.name}');

      final db = await _databaseService.getDatabase();

      // Generate new ID if not provided
      final habitWithId = habit.id.isEmpty
          ? habit.copyWith(id: _uuid.v4())
          : habit;

      final map = habitWithId.toMap();

      await db.insert(
        _tableName,
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      AppLogger.info('Successfully added habit: ${habitWithId.name}');
      return habitWithId;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to add habit: ${habit.name}', e, stackTrace);
      throw DatabaseException(message: 'Failed to add habit: $e');
    }
  }

  @override
  Future<HabitModel> updateHabit(HabitModel habit) async {
    try {
      AppLogger.debug('Updating habit: ${habit.name}');

      final db = await _databaseService.getDatabase();
      final map = habit.toMap();

      final rowsAffected = await db.update(
        _tableName,
        map,
        where: 'id = ?',
        whereArgs: [habit.id],
      );

      if (rowsAffected == 0) {
        throw DatabaseException(
          message: 'Habit not found for update: ${habit.id}',
        );
      }

      AppLogger.info('Successfully updated habit: ${habit.name}');
      return habit;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update habit: ${habit.name}', e, stackTrace);
      throw DatabaseException(message: 'Failed to update habit: $e');
    }
  }

  @override
  Future<void> deleteHabit(String id) async {
    try {
      AppLogger.debug('Deleting habit with ID: $id');

      final db = await _databaseService.getDatabase();

      final rowsAffected = await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (rowsAffected == 0) {
        throw DatabaseException(message: 'Habit not found for deletion: $id');
      }

      AppLogger.info('Successfully deleted habit with ID: $id');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete habit: $id', e, stackTrace);
      throw DatabaseException(message: 'Failed to delete habit: $e');
    }
  }

  @override
  Future<List<HabitModel>> searchHabits(String query) async {
    try {
      AppLogger.debug('Searching habits with query: $query');

      final db = await _databaseService.getDatabase();
      final searchQuery = '%$query%';

      final maps = await db.query(
        _tableName,
        where: 'name LIKE ? OR description LIKE ? OR notes LIKE ?',
        whereArgs: [searchQuery, searchQuery, searchQuery],
        orderBy: 'created_at DESC',
      );

      final habits = maps.map((map) => HabitModel.fromMap(map)).toList();

      AppLogger.debug('Found ${habits.length} habits matching query: $query');
      return habits;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to search habits with query: $query',
        e,
        stackTrace,
      );
      throw DatabaseException(message: 'Failed to search habits: $e');
    }
  }

  @override
  Future<List<HabitModel>> getHabitsByCategory(String category) async {
    try {
      AppLogger.debug('Getting habits by category: $category');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'category = ?',
        whereArgs: [category],
        orderBy: 'created_at DESC',
      );

      final habits = maps.map((map) => HabitModel.fromMap(map)).toList();

      AppLogger.debug('Found ${habits.length} habits in category: $category');
      return habits;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to get habits by category: $category',
        e,
        stackTrace,
      );
      throw DatabaseException(message: 'Failed to get habits by category: $e');
    }
  }

  @override
  Future<List<HabitModel>> getHabitsByType(String type) async {
    try {
      AppLogger.debug('Getting habits by type: $type');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'type = ?',
        whereArgs: [type],
        orderBy: 'created_at DESC',
      );

      final habits = maps.map((map) => HabitModel.fromMap(map)).toList();

      AppLogger.debug('Found ${habits.length} habits of type: $type');
      return habits;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get habits by type: $type', e, stackTrace);
      throw DatabaseException(message: 'Failed to get habits by type: $e');
    }
  }

  @override
  Future<List<HabitModel>> getActiveHabits() async {
    try {
      AppLogger.debug('Getting active habits');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'is_active = ?',
        whereArgs: [1],
        orderBy: 'created_at DESC',
      );

      final habits = maps.map((map) => HabitModel.fromMap(map)).toList();

      AppLogger.debug('Found ${habits.length} active habits');
      return habits;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get active habits', e, stackTrace);
      throw DatabaseException(message: 'Failed to get active habits: $e');
    }
  }

  @override
  Future<List<HabitModel>> getInactiveHabits() async {
    try {
      AppLogger.debug('Getting inactive habits');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'is_active = ?',
        whereArgs: [0],
        orderBy: 'created_at DESC',
      );

      final habits = maps.map((map) => HabitModel.fromMap(map)).toList();

      AppLogger.debug('Found ${habits.length} inactive habits');
      return habits;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get inactive habits', e, stackTrace);
      throw DatabaseException(message: 'Failed to get inactive habits: $e');
    }
  }

  @override
  Future<HabitModel> updateHabitStreak(
    String id,
    int currentStreak,
    int bestStreak,
  ) async {
    try {
      AppLogger.debug('Updating habit streak for ID: $id');

      final habit = await getHabitById(id);
      if (habit == null) {
        throw DatabaseException(
          message: 'Habit not found for streak update: $id',
        );
      }

      final updatedHabit = habit.copyWith(
        currentStreak: currentStreak,
        bestStreak: bestStreak,
        updatedAt: DateTime.now(),
      );

      return await updateHabit(updatedHabit);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update habit streak: $id', e, stackTrace);
      throw DatabaseException(message: 'Failed to update habit streak: $e');
    }
  }

  @override
  Future<HabitModel> updateHabitRelapseInfo(
    String id,
    DateTime lastRelapseDate,
    int totalRelapses,
  ) async {
    try {
      AppLogger.debug('Updating habit relapse info for ID: $id');

      final habit = await getHabitById(id);
      if (habit == null) {
        throw DatabaseException(
          message: 'Habit not found for relapse update: $id',
        );
      }

      final updatedHabit = habit.copyWith(
        lastRelapseDate: lastRelapseDate,
        totalRelapses: totalRelapses,
        currentStreak: 0, // Reset streak on relapse
        updatedAt: DateTime.now(),
      );

      return await updateHabit(updatedHabit);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to update habit relapse info: $id',
        e,
        stackTrace,
      );
      throw DatabaseException(
        message: 'Failed to update habit relapse info: $e',
      );
    }
  }

  @override
  Future<void> updateHabits(List<HabitModel> habits) async {
    try {
      AppLogger.debug('Bulk updating ${habits.length} habits');

      final db = await _databaseService.getDatabase();

      await db.transaction((txn) async {
        for (final habit in habits) {
          await txn.update(
            _tableName,
            habit.toMap(),
            where: 'id = ?',
            whereArgs: [habit.id],
          );
        }
      });

      AppLogger.info('Successfully bulk updated ${habits.length} habits');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to bulk update habits', e, stackTrace);
      throw DatabaseException(message: 'Failed to bulk update habits: $e');
    }
  }
}
