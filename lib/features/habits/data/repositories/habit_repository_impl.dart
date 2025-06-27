import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/habit.dart';
import '../../domain/entities/relapse.dart';
import '../../domain/repositories/habit_repository.dart';
import '../datasources/datasources.dart';
import '../models/models.dart';

/// Implementation of HabitRepository using local data source
class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDataSource _habitLocalDataSource;
  final RelapseLocalDataSource _relapseLocalDataSource;

  HabitRepositoryImpl({
    required HabitLocalDataSource habitLocalDataSource,
    required RelapseLocalDataSource relapseLocalDataSource,
  }) : _habitLocalDataSource = habitLocalDataSource,
       _relapseLocalDataSource = relapseLocalDataSource;

  @override
  Future<Either<Failure, List<Habit>>> getHabits() async {
    try {
      AppLogger.debug('Repository: Getting all habits');

      final habitModels = await _habitLocalDataSource.getAllHabits();
      final habits = habitModels.map((model) => model.toEntity()).toList();

      AppLogger.debug(
        'Repository: Successfully retrieved ${habits.length} habits',
      );
      return Right(habits);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting all habits',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting all habits',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(message: 'Failed to get habits: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Habit>> getHabitById(String id) async {
    try {
      AppLogger.debug('Repository: Getting habit by ID: $id');

      if (id.trim().isEmpty) {
        AppLogger.warning('Repository: Empty habit ID provided');
        return Left(ValidationFailure(message: 'Habit ID cannot be empty'));
      }

      final habitModel = await _habitLocalDataSource.getHabitById(id);

      if (habitModel == null) {
        AppLogger.debug('Repository: Habit not found with ID: $id');
        return Left(ValidationFailure(message: 'Habit not found'));
      }

      final habit = habitModel.toEntity();
      AppLogger.debug('Repository: Found habit with ID: $id');
      return Right(habit);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting habit by ID: $id',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting habit by ID: $id',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(message: 'Failed to get habit: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Habit>> addHabit(Habit habit) async {
    try {
      AppLogger.debug('Repository: Adding new habit: ${habit.name}');

      // Validate habit data
      final validationResult = _validateHabit(habit);
      if (validationResult != null) {
        return Left(validationResult);
      }

      final habitModel = HabitModel.fromEntity(habit);
      final addedHabitModel = await _habitLocalDataSource.addHabit(habitModel);
      final addedHabit = addedHabitModel.toEntity();

      AppLogger.info(
        'Repository: Successfully added habit: ${addedHabit.name}',
      );
      return Right(addedHabit);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error adding habit: ${habit.name}',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error adding habit: ${habit.name}',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(message: 'Failed to add habit: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Habit>> updateHabit(Habit habit) async {
    try {
      AppLogger.debug('Repository: Updating habit: ${habit.name}');

      // Validate habit data
      final validationResult = _validateHabit(habit);
      if (validationResult != null) {
        return Left(validationResult);
      }

      final habitModel = HabitModel.fromEntity(habit);
      final updatedHabitModel = await _habitLocalDataSource.updateHabit(
        habitModel,
      );
      final updatedHabit = updatedHabitModel.toEntity();

      AppLogger.info(
        'Repository: Successfully updated habit: ${updatedHabit.name}',
      );
      return Right(updatedHabit);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error updating habit: ${habit.name}',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error updating habit: ${habit.name}',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(message: 'Failed to update habit: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteHabit(String id) async {
    try {
      AppLogger.debug('Repository: Deleting habit with ID: $id');

      if (id.trim().isEmpty) {
        AppLogger.warning('Repository: Empty habit ID provided for deletion');
        return Left(ValidationFailure(message: 'Habit ID cannot be empty'));
      }

      // Delete associated relapses first
      await _relapseLocalDataSource.deleteRelapsesByHabitId(id);

      // Delete the habit
      await _habitLocalDataSource.deleteHabit(id);

      AppLogger.info('Repository: Successfully deleted habit with ID: $id');
      return const Right(unit);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error deleting habit: $id',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error deleting habit: $id',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(message: 'Failed to delete habit: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<Habit>>> searchHabits(String query) async {
    try {
      AppLogger.debug('Repository: Searching habits with query: $query');

      if (query.trim().isEmpty) {
        AppLogger.debug('Repository: Empty search query, returning all habits');
        return getHabits();
      }

      final habitModels = await _habitLocalDataSource.searchHabits(
        query.trim(),
      );
      final habits = habitModels.map((model) => model.toEntity()).toList();

      AppLogger.debug(
        'Repository: Search found ${habits.length} habits for query: $query',
      );
      return Right(habits);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error searching habits: $query',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error searching habits: $query',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(message: 'Failed to search habits: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<Habit>>> getHabitsByCategory(
    HabitCategory category,
  ) async {
    try {
      AppLogger.debug(
        'Repository: Getting habits by category: ${category.name}',
      );

      final habitModels = await _habitLocalDataSource.getHabitsByCategory(
        category.name,
      );
      final habits = habitModels.map((model) => model.toEntity()).toList();

      AppLogger.debug(
        'Repository: Found ${habits.length} habits in category: ${category.name}',
      );
      return Right(habits);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting habits by category: ${category.name}',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting habits by category: ${category.name}',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get habits by category: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Habit>>> getHabitsByType(HabitType type) async {
    try {
      AppLogger.debug('Repository: Getting habits by type: ${type.name}');

      final habitModels = await _habitLocalDataSource.getHabitsByType(
        type.name,
      );
      final habits = habitModels.map((model) => model.toEntity()).toList();

      AppLogger.debug(
        'Repository: Found ${habits.length} habits of type: ${type.name}',
      );
      return Right(habits);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting habits by type: ${type.name}',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting habits by type: ${type.name}',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get habits by type: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Relapse>>> getHabitHistory(
    String habitId, {
    int? limit,
    int? offset,
  }) async {
    try {
      AppLogger.debug('Repository: Getting habit history for ID: $habitId');

      if (habitId.trim().isEmpty) {
        AppLogger.warning('Repository: Empty habit ID provided for history');
        return Left(ValidationFailure(message: 'Habit ID cannot be empty'));
      }

      final relapseModels = await _relapseLocalDataSource.getRelapsesByHabitId(
        habitId,
      );
      var relapses = relapseModels.map((model) => model.toEntity()).toList();

      // Apply pagination if provided
      if (offset != null) {
        relapses = relapses.skip(offset).toList();
      }
      if (limit != null) {
        relapses = relapses.take(limit).toList();
      }

      AppLogger.debug(
        'Repository: Found ${relapses.length} history entries for habit: $habitId',
      );
      return Right(relapses);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting habit history: $habitId',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting habit history: $habitId',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get habit history: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Habit>> addRelapse(Relapse relapse) async {
    try {
      AppLogger.debug(
        'Repository: Adding relapse for habit: ${relapse.habitId}',
      );

      // Validate relapse data
      final validationResult = _validateRelapse(relapse);
      if (validationResult != null) {
        return Left(validationResult);
      }

      // Check if habit exists
      final habitResult = await getHabitById(relapse.habitId);
      if (habitResult.isLeft()) {
        return Left(
          ValidationFailure(message: 'Cannot add relapse: habit not found'),
        );
      }

      final habit = habitResult.getOrElse(
        () => throw Exception('Habit should exist'),
      );

      final relapseModel = RelapseModel.fromEntity(relapse);
      await _relapseLocalDataSource.addRelapse(relapseModel);

      // Update habit statistics
      if (relapse.type == RelapseType.relapse) {
        final updatedHabitModel = await _habitLocalDataSource
            .updateHabitRelapseInfo(
              relapse.habitId,
              relapse.date,
              habit.totalRelapses + 1,
            );
        final updatedHabit = updatedHabitModel.toEntity();

        AppLogger.info(
          'Repository: Successfully added relapse for habit: ${relapse.habitId}',
        );
        return Right(updatedHabit);
      } else {
        // For success records, update streak
        final updatedHabitModel = await _habitLocalDataSource.updateHabitStreak(
          relapse.habitId,
          habit.currentStreak + 1,
          habit.bestStreak > habit.currentStreak + 1
              ? habit.bestStreak
              : habit.currentStreak + 1,
        );
        final updatedHabit = updatedHabitModel.toEntity();

        AppLogger.info(
          'Repository: Successfully added success record for habit: ${relapse.habitId}',
        );
        return Right(updatedHabit);
      }
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error adding relapse',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error adding relapse',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(message: 'Failed to add relapse: ${e.toString()}'),
      );
    }
  }

  // TODO: Implement remaining methods - these are basic stubs for now
  @override
  Future<Either<Failure, Habit>> addSuccess(
    String habitId, {
    DateTime? date,
    String? note,
  }) async {
    final successRelapse = Relapse(
      id: '',
      habitId: habitId,
      type: RelapseType.success,
      date: date ?? DateTime.now(),
      note: note,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return addRelapse(successRelapse);
  }

  @override
  Future<Either<Failure, List<Relapse>>> getAllRelapses({
    int? limit,
    int? offset,
  }) async {
    try {
      final relapseModels = await _relapseLocalDataSource.getAllRelapses();
      var relapses = relapseModels.map((model) => model.toEntity()).toList();

      if (offset != null) relapses = relapses.skip(offset).toList();
      if (limit != null) relapses = relapses.take(limit).toList();

      return Right(relapses);
    } catch (e) {
      return Left(
        UnexpectedFailure(
          message: 'Failed to get all relapses: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Relapse>>> getRelapsesInDateRange(
    DateTime startDate,
    DateTime endDate, {
    String? habitId,
  }) async {
    try {
      final relapseModels = await _relapseLocalDataSource
          .getRelapsesInDateRange(startDate, endDate);
      var relapses = relapseModels.map((model) => model.toEntity()).toList();

      if (habitId != null) {
        relapses = relapses
            .where((relapse) => relapse.habitId == habitId)
            .toList();
      }

      return Right(relapses);
    } catch (e) {
      return Left(
        UnexpectedFailure(
          message: 'Failed to get relapses in date range: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Relapse>> updateRelapse(Relapse relapse) async {
    try {
      final relapseModel = RelapseModel.fromEntity(relapse);
      final updatedModel = await _relapseLocalDataSource.updateRelapse(
        relapseModel,
      );
      return Right(updatedModel.toEntity());
    } catch (e) {
      return Left(
        UnexpectedFailure(message: 'Failed to update relapse: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Habit>> deleteRelapse(String relapseId) async {
    try {
      AppLogger.debug('Repository: Deleting relapse with ID: $relapseId');

      if (relapseId.trim().isEmpty) {
        return Left(ValidationFailure(message: 'Relapse ID cannot be empty'));
      }

      // Get the relapse first to find the habit ID
      final relapseModels = await _relapseLocalDataSource.getAllRelapses();
      RelapseModel? targetRelapse;

      try {
        targetRelapse = relapseModels.firstWhere(
          (model) => model.id == relapseId,
        );
      } catch (e) {
        return Left(ValidationFailure(message: 'Relapse not found'));
      }

      final relapse = targetRelapse.toEntity();

      // Delete the relapse
      await _relapseLocalDataSource.deleteRelapse(relapseId);

      // Get updated habit to recalculate streaks
      final habitResult = await getHabitById(relapse.habitId);
      if (habitResult.isLeft()) {
        return habitResult;
      }

      final habit = habitResult.getOrElse(
        () => throw Exception('Habit should exist'),
      );

      // Recalculate habit statistics (simplified approach)
      final allRelapses = await _relapseLocalDataSource.getRelapsesByHabitId(
        relapse.habitId,
      );
      final relapseEntities = allRelapses
          .map((model) => model.toEntity())
          .toList();

      // Recalculate streaks and statistics
      var totalRelapses = relapseEntities
          .where((r) => r.type == RelapseType.relapse)
          .length;
      var currentStreak = _calculateCurrentStreak(relapseEntities);
      var bestStreak = _calculateBestStreak(relapseEntities);

      // Update habit with recalculated values
      final updatedHabit = habit.copyWith(
        totalRelapses: totalRelapses,
        currentStreak: currentStreak,
        bestStreak: bestStreak,
        lastRelapseDate:
            relapseEntities
                .where((r) => r.type == RelapseType.relapse)
                .isNotEmpty
            ? relapseEntities
                  .where((r) => r.type == RelapseType.relapse)
                  .map((r) => r.date)
                  .reduce((a, b) => a.isAfter(b) ? a : b)
            : null,
      );

      final updatedHabitModel = HabitModel.fromEntity(updatedHabit);
      await _habitLocalDataSource.updateHabit(updatedHabitModel);

      AppLogger.info(
        'Repository: Successfully deleted relapse and updated habit',
      );
      return Right(updatedHabit);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error deleting relapse: $relapseId',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error deleting relapse: $relapseId',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(message: 'Failed to delete relapse: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, HabitStatistics>> getHabitStatistics(
    String habitId,
  ) async {
    try {
      AppLogger.debug('Repository: Getting statistics for habit: $habitId');

      if (habitId.trim().isEmpty) {
        return Left(ValidationFailure(message: 'Habit ID cannot be empty'));
      }

      final habitResult = await getHabitById(habitId);
      if (habitResult.isLeft()) {
        return Left(ValidationFailure(message: 'Habit not found'));
      }

      final habit = habitResult.getOrElse(
        () => throw Exception('Habit should exist'),
      );
      final relapseModels = await _relapseLocalDataSource.getRelapsesByHabitId(
        habitId,
      );
      final relapses = relapseModels.map((model) => model.toEntity()).toList();

      // Calculate statistics
      final totalDays = DateTime.now().difference(habit.startDate).inDays + 1;
      final totalRelapses = relapses
          .where((r) => r.type == RelapseType.relapse)
          .length;
      final successfulDays = relapses
          .where((r) => r.type == RelapseType.success)
          .length;
      final failureDays = totalRelapses;
      final successRate = totalDays > 0
          ? (successfulDays / totalDays) * 100
          : 0.0;

      // Calculate patterns
      final weeklyPattern = <int, int>{};
      final monthlyPattern = <int, int>{};
      final triggerFrequency = <String, int>{};
      final emotionFrequency = <String, int>{};

      for (final relapse in relapses.where(
        (r) => r.type == RelapseType.relapse,
      )) {
        // Weekly pattern (1 = Monday, 7 = Sunday)
        final weekday = relapse.date.weekday;
        weeklyPattern[weekday] = (weeklyPattern[weekday] ?? 0) + 1;

        // Monthly pattern
        final day = relapse.date.day;
        monthlyPattern[day] = (monthlyPattern[day] ?? 0) + 1;
        // Triggers and emotions
        if (relapse.trigger != null) {
          triggerFrequency[relapse.trigger!] =
              (triggerFrequency[relapse.trigger!] ?? 0) + 1;
        }

        if (relapse.emotion != null) {
          emotionFrequency[relapse.emotion!] =
              (emotionFrequency[relapse.emotion!] ?? 0) + 1;
        }
      }

      // Calculate average time between relapses
      double averageTimeBetweenRelapses = 0.0;
      if (totalRelapses > 1) {
        final relapseDates =
            relapses
                .where((r) => r.type == RelapseType.relapse)
                .map((r) => r.date)
                .toList()
              ..sort();

        double totalDaysBetween = 0;
        for (int i = 1; i < relapseDates.length; i++) {
          totalDaysBetween += relapseDates[i]
              .difference(relapseDates[i - 1])
              .inDays;
        }
        averageTimeBetweenRelapses =
            totalDaysBetween / (relapseDates.length - 1);
      }

      final statistics = HabitStatistics(
        habitId: habitId,
        totalDays: totalDays,
        successfulDays: successfulDays,
        failureDays: failureDays,
        successRate: successRate,
        currentStreak: habit.currentStreak,
        longestStreak: habit.bestStreak,
        totalRelapses: totalRelapses,
        averageTimeBetweenRelapses: averageTimeBetweenRelapses,
        triggerFrequency: triggerFrequency,
        emotionFrequency: emotionFrequency,
        weeklyPattern: weeklyPattern,
        monthlyPattern: monthlyPattern,
      );

      AppLogger.debug(
        'Repository: Successfully calculated statistics for habit: $habitId',
      );
      return Right(statistics);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting habit statistics: $habitId',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting habit statistics: $habitId',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get habit statistics: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, OverallStatistics>> getOverallStatistics() async {
    try {
      AppLogger.debug('Repository: Getting overall statistics');

      final habitModels = await _habitLocalDataSource.getAllHabits();
      final habits = habitModels.map((model) => model.toEntity()).toList();

      if (habits.isEmpty) {
        // Return empty statistics if no habits
        return Right(
          OverallStatistics(
            totalHabits: 0,
            activeHabits: 0,
            archivedHabits: 0,
            goodHabits: 0,
            badHabits: 0,
            overallSuccessRate: 0.0,
            totalSuccessfulDays: 0,
            totalRelapses: 0,
            longestOverallStreak: 0,
            mostSuccessfulHabitId: '',
            mostChallengingHabitId: '',
            categoryDistribution: {},
            commonTriggers: {},
            commonEmotions: {},
          ),
        );
      }

      // Basic counts
      final totalHabits = habits.length;
      final activeHabits = habits.where((h) => h.isActive).length;
      final archivedHabits = habits.where((h) => !h.isActive).length;
      final goodHabits = habits.where((h) => h.type == HabitType.good).length;
      final badHabits = habits.where((h) => h.type == HabitType.bad).length;

      // Get all relapses for calculations
      final allRelapseModels = await _relapseLocalDataSource.getAllRelapses();
      final allRelapses = allRelapseModels
          .map((model) => model.toEntity())
          .toList();

      final totalSuccessfulDays = allRelapses
          .where((r) => r.type == RelapseType.success)
          .length;
      final totalRelapses = allRelapses
          .where((r) => r.type == RelapseType.relapse)
          .length;

      // Calculate overall success rate
      final totalDays = habits.fold<int>(0, (sum, habit) {
        return sum + DateTime.now().difference(habit.startDate).inDays + 1;
      });
      final overallSuccessRate = totalDays > 0
          ? (totalSuccessfulDays / totalDays) * 100
          : 0.0;

      // Find longest streak
      final longestOverallStreak = habits.fold<int>(0, (max, habit) {
        return habit.bestStreak > max ? habit.bestStreak : max;
      });

      // Find most successful and challenging habits
      String mostSuccessfulHabitId = '';
      String mostChallengingHabitId = '';
      double bestSuccessRate = -1;
      double worstSuccessRate = 101;

      for (final habit in habits) {
        final habitDays = DateTime.now().difference(habit.startDate).inDays + 1;
        final habitRelapses = allRelapses.where((r) => r.habitId == habit.id);
        final habitSuccesses = habitRelapses
            .where((r) => r.type == RelapseType.success)
            .length;
        final successRate = habitDays > 0
            ? (habitSuccesses / habitDays) * 100
            : 0.0;

        if (successRate > bestSuccessRate) {
          bestSuccessRate = successRate;
          mostSuccessfulHabitId = habit.id;
        }

        if (successRate < worstSuccessRate) {
          worstSuccessRate = successRate;
          mostChallengingHabitId = habit.id;
        }
      }

      // Category distribution
      final categoryDistribution = <HabitCategory, int>{};
      for (final habit in habits) {
        categoryDistribution[habit.category] =
            (categoryDistribution[habit.category] ?? 0) + 1;
      }

      // Common triggers and emotions
      final commonTriggers = <String, int>{};
      final commonEmotions = <String, int>{};
      for (final relapse in allRelapses.where(
        (r) => r.type == RelapseType.relapse,
      )) {
        if (relapse.trigger != null) {
          commonTriggers[relapse.trigger!] =
              (commonTriggers[relapse.trigger!] ?? 0) + 1;
        }

        if (relapse.emotion != null) {
          commonEmotions[relapse.emotion!] =
              (commonEmotions[relapse.emotion!] ?? 0) + 1;
        }
      }

      final statistics = OverallStatistics(
        totalHabits: totalHabits,
        activeHabits: activeHabits,
        archivedHabits: archivedHabits,
        goodHabits: goodHabits,
        badHabits: badHabits,
        overallSuccessRate: overallSuccessRate,
        totalSuccessfulDays: totalSuccessfulDays,
        totalRelapses: totalRelapses,
        longestOverallStreak: longestOverallStreak,
        mostSuccessfulHabitId: mostSuccessfulHabitId,
        mostChallengingHabitId: mostChallengingHabitId,
        categoryDistribution: categoryDistribution,
        commonTriggers: commonTriggers,
        commonEmotions: commonEmotions,
      );

      AppLogger.debug('Repository: Successfully calculated overall statistics');
      return Right(statistics);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting overall statistics',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting overall statistics',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get overall statistics: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Habit>> archiveHabit(String habitId) async {
    try {
      final habitResult = await getHabitById(habitId);
      if (habitResult.isLeft()) return habitResult;

      final habit = habitResult.getOrElse(
        () => throw Exception('Should have habit'),
      );
      final updatedHabit = habit.copyWith(isActive: false);

      return updateHabit(updatedHabit);
    } catch (e) {
      return Left(
        UnexpectedFailure(message: 'Failed to archive habit: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Habit>> restoreHabit(String habitId) async {
    try {
      final habitResult = await getHabitById(habitId);
      if (habitResult.isLeft()) return habitResult;

      final habit = habitResult.getOrElse(
        () => throw Exception('Should have habit'),
      );
      final updatedHabit = habit.copyWith(isActive: true);

      return updateHabit(updatedHabit);
    } catch (e) {
      return Left(
        UnexpectedFailure(message: 'Failed to restore habit: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> exportHabitData() async {
    try {
      AppLogger.debug('Repository: Exporting habit data');

      final habitModels = await _habitLocalDataSource.getAllHabits();
      final relapseModels = await _relapseLocalDataSource.getAllRelapses();

      final exportData = {
        'habits': habitModels.map((model) => model.toJson()).toList(),
        'relapses': relapseModels.map((model) => model.toJson()).toList(),
        'exportDate': DateTime.now().toIso8601String(),
        'version': '1.0.0',
      };

      final jsonString = jsonEncode(exportData);

      AppLogger.info(
        'Repository: Successfully exported ${habitModels.length} habits and ${relapseModels.length} relapses',
      );
      return Right(jsonString);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error exporting habit data',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error exporting habit data',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to export habit data: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> importHabitData(
    String jsonData, {
    bool replaceExisting = false,
  }) async {
    try {
      AppLogger.debug(
        'Repository: Importing habit data (replaceExisting: $replaceExisting)',
      );

      if (jsonData.trim().isEmpty) {
        return Left(ValidationFailure(message: 'Import data cannot be empty'));
      }

      final Map<String, dynamic> importData;
      try {
        importData = jsonDecode(jsonData) as Map<String, dynamic>;
      } catch (e) {
        return Left(ValidationFailure(message: 'Invalid JSON format'));
      }

      if (!importData.containsKey('habits') ||
          !importData.containsKey('relapses')) {
        return Left(ValidationFailure(message: 'Invalid import data format'));
      }

      final habitsJson = importData['habits'] as List<dynamic>;
      final relapsesJson = importData['relapses'] as List<dynamic>;

      // If replaceExisting is true, clear existing data
      if (replaceExisting) {
        final existingHabits = await _habitLocalDataSource.getAllHabits();
        for (final habit in existingHabits) {
          await _relapseLocalDataSource.deleteRelapsesByHabitId(habit.id);
          await _habitLocalDataSource.deleteHabit(habit.id);
        }
      }

      int importedCount = 0;

      // Import habits
      for (final habitJson in habitsJson) {
        try {
          final habitModel = HabitModel.fromJson(
            habitJson as Map<String, dynamic>,
          );

          // Check if habit already exists (if not replacing)
          if (!replaceExisting) {
            final existing = await _habitLocalDataSource.getHabitById(
              habitModel.id,
            );
            if (existing != null) {
              continue; // Skip existing habits
            }
          }

          await _habitLocalDataSource.addHabit(habitModel);
          importedCount++;
        } catch (e) {
          AppLogger.warning(
            'Repository: Failed to import habit: ${e.toString()}',
          );
          continue; // Skip invalid habits
        }
      }

      // Import relapses
      for (final relapseJson in relapsesJson) {
        try {
          final relapseModel = RelapseModel.fromJson(
            relapseJson as Map<String, dynamic>,
          );

          // Check if relapse already exists and habit exists
          if (!replaceExisting) {
            final allRelapses = await _relapseLocalDataSource.getAllRelapses();
            if (allRelapses.any((r) => r.id == relapseModel.id)) {
              continue; // Skip existing relapses
            }
          }

          // Verify the habit exists
          final habitExists = await _habitLocalDataSource.getHabitById(
            relapseModel.habitId,
          );
          if (habitExists != null) {
            await _relapseLocalDataSource.addRelapse(relapseModel);
          }
        } catch (e) {
          AppLogger.warning(
            'Repository: Failed to import relapse: ${e.toString()}',
          );
          continue; // Skip invalid relapses
        }
      }

      AppLogger.info('Repository: Successfully imported $importedCount habits');
      return Right(importedCount);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error importing habit data',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error importing habit data',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to import habit data: ${e.toString()}',
        ),
      );
    }
  }

  /// Validates habit data before database operations
  ValidationFailure? _validateHabit(Habit habit) {
    if (habit.name.trim().isEmpty) {
      return ValidationFailure(message: 'Habit name cannot be empty');
    }

    if (habit.name.length > 100) {
      return ValidationFailure(
        message: 'Habit name cannot exceed 100 characters',
      );
    }

    if (habit.description.trim().isEmpty) {
      return ValidationFailure(message: 'Habit description cannot be empty');
    }

    if (habit.description.length > 500) {
      return ValidationFailure(
        message: 'Habit description cannot exceed 500 characters',
      );
    }

    if (habit.startDate.isAfter(DateTime.now())) {
      return ValidationFailure(
        message: 'Habit start date cannot be in the future',
      );
    }

    if (habit.targetDays != null && habit.targetDays! <= 0) {
      return ValidationFailure(
        message: 'Target days must be a positive number',
      );
    }

    if (habit.notes != null && habit.notes!.length > 1000) {
      return ValidationFailure(
        message: 'Habit notes cannot exceed 1000 characters',
      );
    }

    return null;
  }

  /// Validates relapse data before database operations
  ValidationFailure? _validateRelapse(Relapse relapse) {
    if (relapse.habitId.trim().isEmpty) {
      return ValidationFailure(message: 'Habit ID cannot be empty');
    }

    if (relapse.date.isAfter(DateTime.now())) {
      return ValidationFailure(message: 'Relapse date cannot be in the future');
    }

    if (relapse.note != null && relapse.note!.length > 1000) {
      return ValidationFailure(
        message: 'Relapse note cannot exceed 1000 characters',
      );
    }

    if (relapse.intensityLevel != null &&
        (relapse.intensityLevel! < 1 || relapse.intensityLevel! > 10)) {
      return ValidationFailure(
        message: 'Intensity level must be between 1 and 10',
      );
    }

    if (relapse.durationMinutes != null && relapse.durationMinutes! < 0) {
      return ValidationFailure(message: 'Duration cannot be negative');
    }
    return null;
  }

  /// Calculates the current streak for a habit based on relapse history
  int _calculateCurrentStreak(List<Relapse> relapses) {
    if (relapses.isEmpty) return 0;

    // Sort relapses by date (most recent first)
    final sortedRelapses = List<Relapse>.from(relapses)
      ..sort((a, b) => b.date.compareTo(a.date));

    int currentStreak = 0;
    DateTime currentDate = DateTime.now();

    // Start from today and work backwards
    for (int i = 0; i < sortedRelapses.length; i++) {
      final relapse = sortedRelapses[i];
      final daysDifference = currentDate.difference(relapse.date).inDays;

      if (daysDifference <= 1) {
        // Same day or yesterday
        if (relapse.type == RelapseType.success) {
          currentStreak++;
          currentDate = relapse.date;
        } else if (relapse.type == RelapseType.relapse) {
          break; // Streak is broken
        }
      } else if (daysDifference > 1) {
        break; // Gap in streak
      }
    }

    return currentStreak;
  }

  /// Calculates the best (longest) streak for a habit based on relapse history
  int _calculateBestStreak(List<Relapse> relapses) {
    if (relapses.isEmpty) return 0;

    // Sort relapses by date (oldest first)
    final sortedRelapses = List<Relapse>.from(relapses)
      ..sort((a, b) => a.date.compareTo(b.date));

    int bestStreak = 0;
    int currentStreak = 0;
    DateTime? lastSuccessDate;

    for (final relapse in sortedRelapses) {
      if (relapse.type == RelapseType.success) {
        if (lastSuccessDate == null ||
            relapse.date.difference(lastSuccessDate).inDays <= 1) {
          currentStreak++;
          bestStreak = currentStreak > bestStreak ? currentStreak : bestStreak;
        } else {
          currentStreak = 1; // Start new streak
        }
        lastSuccessDate = relapse.date;
      } else if (relapse.type == RelapseType.relapse) {
        currentStreak = 0; // Reset streak
        lastSuccessDate = null;
      }
    }

    return bestStreak;
  }
}
