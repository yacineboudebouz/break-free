import 'package:sqflite/sqflite.dart' hide DatabaseException;
import 'package:uuid/uuid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../models/relapse_model.dart';

part 'relapse_local_data_source.g.dart';

/// Abstract interface for relapse local data source
abstract class RelapseLocalDataSource {
  /// Get all relapses from local storage
  Future<List<RelapseModel>> getAllRelapses();

  /// Get relapses for a specific habit
  Future<List<RelapseModel>> getRelapsesByHabitId(String habitId);

  /// Get a relapse by ID from local storage
  Future<RelapseModel?> getRelapseById(String id);

  /// Add a new relapse to local storage
  Future<RelapseModel> addRelapse(RelapseModel relapse);

  /// Update an existing relapse in local storage
  Future<RelapseModel> updateRelapse(RelapseModel relapse);

  /// Delete a relapse from local storage
  Future<void> deleteRelapse(String id);

  /// Delete all relapses for a specific habit
  Future<void> deleteRelapsesByHabitId(String habitId);

  /// Get relapses by type (relapse/success)
  Future<List<RelapseModel>> getRelapsesByType(String type);

  /// Get relapses within a date range
  Future<List<RelapseModel>> getRelapsesInDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Get relapses by trigger
  Future<List<RelapseModel>> getRelapsesByTrigger(String trigger);

  /// Get recent relapses (last N days)
  Future<List<RelapseModel>> getRecentRelapses(int days);

  /// Get relapse statistics for a habit
  Future<Map<String, dynamic>> getRelapseStats(String habitId);
}

/// Implementation of relapse local data source using SQLite
class RelapseLocalDataSourceImpl implements RelapseLocalDataSource {
  final DatabaseService _databaseService;
  final Uuid _uuid = const Uuid();

  RelapseLocalDataSourceImpl(this._databaseService);

  static const String _tableName = 'relapses';

  @override
  Future<List<RelapseModel>> getAllRelapses() async {
    try {
      AppLogger.debug('Getting all relapses from local storage');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(_tableName, orderBy: 'date DESC');

      final relapses = maps.map((map) => RelapseModel.fromMap(map)).toList();

      AppLogger.debug(
        'Retrieved ${relapses.length} relapses from local storage',
      );
      return relapses;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get all relapses', e, stackTrace);
      throw DatabaseException(message: 'Failed to retrieve relapses: $e');
    }
  }

  @override
  Future<List<RelapseModel>> getRelapsesByHabitId(String habitId) async {
    try {
      AppLogger.debug('Getting relapses for habit ID: $habitId');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'habit_id = ?',
        whereArgs: [habitId],
        orderBy: 'date DESC',
      );

      final relapses = maps.map((map) => RelapseModel.fromMap(map)).toList();

      AppLogger.debug(
        'Retrieved ${relapses.length} relapses for habit: $habitId',
      );
      return relapses;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to get relapses for habit: $habitId',
        e,
        stackTrace,
      );
      throw DatabaseException(
        message: 'Failed to retrieve relapses for habit: $e',
      );
    }
  }

  @override
  Future<RelapseModel?> getRelapseById(String id) async {
    try {
      AppLogger.debug('Getting relapse by ID: $id');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (maps.isEmpty) {
        AppLogger.debug('Relapse not found with ID: $id');
        return null;
      }

      final relapse = RelapseModel.fromMap(maps.first);
      AppLogger.debug('Retrieved relapse: ${relapse.id}');
      return relapse;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get relapse by ID: $id', e, stackTrace);
      throw DatabaseException(message: 'Failed to retrieve relapse: $e');
    }
  }

  @override
  Future<RelapseModel> addRelapse(RelapseModel relapse) async {
    try {
      AppLogger.debug('Adding new relapse for habit: ${relapse.habitId}');

      final db = await _databaseService.getDatabase();

      // Generate new ID if not provided
      final relapseWithId = relapse.id.isEmpty
          ? relapse.copyWith(id: _uuid.v4())
          : relapse;

      final map = relapseWithId.toMap();

      await db.insert(
        _tableName,
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      AppLogger.info('Successfully added relapse: ${relapseWithId.id}');
      return relapseWithId;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to add relapse: ${relapse.habitId}',
        e,
        stackTrace,
      );
      throw DatabaseException(message: 'Failed to add relapse: $e');
    }
  }

  @override
  Future<RelapseModel> updateRelapse(RelapseModel relapse) async {
    try {
      AppLogger.debug('Updating relapse: ${relapse.id}');

      final db = await _databaseService.getDatabase();
      final map = relapse.toMap();

      final rowsAffected = await db.update(
        _tableName,
        map,
        where: 'id = ?',
        whereArgs: [relapse.id],
      );

      if (rowsAffected == 0) {
        throw DatabaseException(
          message: 'Relapse not found for update: ${relapse.id}',
        );
      }

      AppLogger.info('Successfully updated relapse: ${relapse.id}');
      return relapse;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update relapse: ${relapse.id}', e, stackTrace);
      throw DatabaseException(message: 'Failed to update relapse: $e');
    }
  }

  @override
  Future<void> deleteRelapse(String id) async {
    try {
      AppLogger.debug('Deleting relapse with ID: $id');

      final db = await _databaseService.getDatabase();

      final rowsAffected = await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (rowsAffected == 0) {
        throw DatabaseException(message: 'Relapse not found for deletion: $id');
      }

      AppLogger.info('Successfully deleted relapse with ID: $id');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete relapse: $id', e, stackTrace);
      throw DatabaseException(message: 'Failed to delete relapse: $e');
    }
  }

  @override
  Future<void> deleteRelapsesByHabitId(String habitId) async {
    try {
      AppLogger.debug('Deleting all relapses for habit ID: $habitId');

      final db = await _databaseService.getDatabase();

      final rowsAffected = await db.delete(
        _tableName,
        where: 'habit_id = ?',
        whereArgs: [habitId],
      );

      AppLogger.info(
        'Successfully deleted $rowsAffected relapses for habit: $habitId',
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to delete relapses for habit: $habitId',
        e,
        stackTrace,
      );
      throw DatabaseException(
        message: 'Failed to delete relapses for habit: $e',
      );
    }
  }

  @override
  Future<List<RelapseModel>> getRelapsesByType(String type) async {
    try {
      AppLogger.debug('Getting relapses by type: $type');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'type = ?',
        whereArgs: [type],
        orderBy: 'date DESC',
      );

      final relapses = maps.map((map) => RelapseModel.fromMap(map)).toList();

      AppLogger.debug('Found ${relapses.length} relapses of type: $type');
      return relapses;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get relapses by type: $type', e, stackTrace);
      throw DatabaseException(message: 'Failed to get relapses by type: $e');
    }
  }

  @override
  Future<List<RelapseModel>> getRelapsesInDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      AppLogger.debug('Getting relapses in date range: $startDate to $endDate');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'date >= ? AND date <= ?',
        whereArgs: [
          startDate.millisecondsSinceEpoch,
          endDate.millisecondsSinceEpoch,
        ],
        orderBy: 'date DESC',
      );

      final relapses = maps.map((map) => RelapseModel.fromMap(map)).toList();

      AppLogger.debug('Found ${relapses.length} relapses in date range');
      return relapses;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get relapses in date range', e, stackTrace);
      throw DatabaseException(
        message: 'Failed to get relapses in date range: $e',
      );
    }
  }

  @override
  Future<List<RelapseModel>> getRelapsesByTrigger(String trigger) async {
    try {
      AppLogger.debug('Getting relapses by trigger: $trigger');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'trigger LIKE ?',
        whereArgs: ['%$trigger%'],
        orderBy: 'date DESC',
      );

      final relapses = maps.map((map) => RelapseModel.fromMap(map)).toList();

      AppLogger.debug(
        'Found ${relapses.length} relapses with trigger: $trigger',
      );
      return relapses;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to get relapses by trigger: $trigger',
        e,
        stackTrace,
      );
      throw DatabaseException(message: 'Failed to get relapses by trigger: $e');
    }
  }

  @override
  Future<List<RelapseModel>> getRecentRelapses(int days) async {
    try {
      AppLogger.debug('Getting recent relapses (last $days days)');

      final db = await _databaseService.getDatabase();
      final startDate = DateTime.now().subtract(Duration(days: days));

      final maps = await db.query(
        _tableName,
        where: 'date >= ?',
        whereArgs: [startDate.millisecondsSinceEpoch],
        orderBy: 'date DESC',
      );

      final relapses = maps.map((map) => RelapseModel.fromMap(map)).toList();

      AppLogger.debug('Found ${relapses.length} recent relapses');
      return relapses;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get recent relapses', e, stackTrace);
      throw DatabaseException(message: 'Failed to get recent relapses: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getRelapseStats(String habitId) async {
    try {
      AppLogger.debug('Getting relapse statistics for habit: $habitId');

      final db = await _databaseService.getDatabase();

      // Get total count of relapses
      final totalResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM $_tableName WHERE habit_id = ? AND type = ?',
        [habitId, 'relapse'],
      );
      final totalRelapses = totalResult.first['count'] as int;

      // Get most recent relapse
      final recentResult = await db.query(
        _tableName,
        where: 'habit_id = ? AND type = ?',
        whereArgs: [habitId, 'relapse'],
        orderBy: 'date DESC',
        limit: 1,
      );

      DateTime? lastRelapseDate;
      if (recentResult.isNotEmpty) {
        lastRelapseDate = DateTime.fromMillisecondsSinceEpoch(
          recentResult.first['date'] as int,
        );
      }

      // Get most common trigger
      final triggerResult = await db.rawQuery(
        '''
        SELECT trigger, COUNT(*) as count 
        FROM $_tableName 
        WHERE habit_id = ? AND type = ? AND trigger IS NOT NULL
        GROUP BY trigger 
        ORDER BY count DESC 
        LIMIT 1
      ''',
        [habitId, 'relapse'],
      );

      String? mostCommonTrigger;
      if (triggerResult.isNotEmpty) {
        mostCommonTrigger = triggerResult.first['trigger'] as String?;
      }

      // Get average intensity level
      final intensityResult = await db.rawQuery(
        '''
        SELECT AVG(intensity_level) as avg_intensity 
        FROM $_tableName 
        WHERE habit_id = ? AND type = ? AND intensity_level IS NOT NULL
      ''',
        [habitId, 'relapse'],
      );

      double? avgIntensity;
      if (intensityResult.isNotEmpty &&
          intensityResult.first['avg_intensity'] != null) {
        avgIntensity = intensityResult.first['avg_intensity'] as double;
      }

      final stats = {
        'totalRelapses': totalRelapses,
        'lastRelapseDate': lastRelapseDate?.toIso8601String(),
        'mostCommonTrigger': mostCommonTrigger,
        'averageIntensity': avgIntensity,
      };

      AppLogger.debug('Retrieved relapse stats for habit: $habitId');
      return stats;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to get relapse stats for habit: $habitId',
        e,
        stackTrace,
      );      throw DatabaseException(message: 'Failed to get relapse statistics: $e');
    }
  }
}

// Data Source Provider
@riverpod
RelapseLocalDataSource relapseLocalDataSource(RelapseLocalDataSourceRef ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return RelapseLocalDataSourceImpl(databaseService);
}
