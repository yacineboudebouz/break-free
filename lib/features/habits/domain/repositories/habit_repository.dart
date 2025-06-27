import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../entities/habit.dart';
import '../entities/relapse.dart';

/// Repository interface for habit management
///
/// This abstract class defines the contract for habit data operations.
/// It follows the repository pattern and uses `Either<Failure, Success>`
/// for error handling in the domain layer.
abstract class HabitRepository {
  /// Retrieves all habits
  ///
  /// Returns [Right] with list of habits on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<Habit>>> getHabits();

  /// Retrieves habits filtered by type
  ///
  /// [type] - The type of habits to retrieve (good/bad)
  /// Returns [Right] with filtered list of habits on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<Habit>>> getHabitsByType(HabitType type);

  /// Retrieves habits filtered by category
  ///
  /// [category] - The category of habits to retrieve
  /// Returns [Right] with filtered list of habits on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<Habit>>> getHabitsByCategory(
    HabitCategory category,
  );

  /// Retrieves a specific habit by ID
  ///
  /// [id] - The unique identifier of the habit
  /// Returns [Right] with the habit on success
  /// Returns [Left] with [Failure] on error (including not found)
  Future<Either<Failure, Habit>> getHabitById(String id);

  /// Adds a new habit
  ///
  /// [habit] - The habit to add
  /// Returns [Right] with the created habit (with generated ID) on success
  /// Returns [Left] with [Failure] on error (including validation errors)
  Future<Either<Failure, Habit>> addHabit(Habit habit);

  /// Updates an existing habit
  ///
  /// [habit] - The habit with updated information
  /// Returns [Right] with the updated habit on success
  /// Returns [Left] with [Failure] on error (including not found, validation errors)
  Future<Either<Failure, Habit>> updateHabit(Habit habit);

  /// Deletes a habit and all its related relapses
  ///
  /// [id] - The unique identifier of the habit to delete
  /// Returns [Right] with unit (void) on success
  /// Returns [Left] with [Failure] on error (including not found)
  Future<Either<Failure, Unit>> deleteHabit(String id);

  /// Searches habits by name or description
  ///
  /// [query] - The search term
  /// Returns [Right] with list of matching habits on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<Habit>>> searchHabits(String query);

  /// Records a relapse for a habit
  ///
  /// [relapse] - The relapse event to record
  /// Returns [Right] with the updated habit (with new streak info) on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, Habit>> addRelapse(Relapse relapse);

  /// Records a success for a habit
  ///
  /// [habitId] - The ID of the habit
  /// [date] - The date of the success (defaults to today)
  /// [note] - Optional note about the success
  /// Returns [Right] with the updated habit (with new streak info) on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, Habit>> addSuccess(
    String habitId, {
    DateTime? date,
    String? note,
  });

  /// Gets the relapse/event history for a specific habit
  ///
  /// [habitId] - The ID of the habit
  /// [limit] - Maximum number of events to retrieve (optional)
  /// [offset] - Number of events to skip for pagination (optional)
  /// Returns [Right] with list of relapses/events on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<Relapse>>> getHabitHistory(
    String habitId, {
    int? limit,
    int? offset,
  });

  /// Gets all relapses/events across all habits
  ///
  /// [limit] - Maximum number of events to retrieve (optional)
  /// [offset] - Number of events to skip for pagination (optional)
  /// Returns [Right] with list of all relapses/events on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<Relapse>>> getAllRelapses({
    int? limit,
    int? offset,
  });

  /// Gets relapses/events within a date range
  ///
  /// [startDate] - Start of the date range
  /// [endDate] - End of the date range
  /// [habitId] - Optional habit ID to filter by specific habit
  /// Returns [Right] with list of relapses/events in range on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<Relapse>>> getRelapsesInDateRange(
    DateTime startDate,
    DateTime endDate, {
    String? habitId,
  });

  /// Updates a relapse/event record
  ///
  /// [relapse] - The relapse with updated information
  /// Returns [Right] with the updated relapse on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, Relapse>> updateRelapse(Relapse relapse);

  /// Deletes a relapse/event record
  ///
  /// [relapseId] - The ID of the relapse to delete
  /// Returns [Right] with the updated habit (recalculated streaks) on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, Habit>> deleteRelapse(String relapseId);

  /// Gets statistics for a specific habit
  ///
  /// [habitId] - The ID of the habit
  /// Returns [Right] with habit statistics on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, HabitStatistics>> getHabitStatistics(String habitId);

  /// Gets overall statistics across all habits
  ///
  /// Returns [Right] with overall statistics on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, OverallStatistics>> getOverallStatistics();

  /// Archives a habit (sets it as inactive but keeps data)
  ///
  /// [habitId] - The ID of the habit to archive
  /// Returns [Right] with the archived habit on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, Habit>> archiveHabit(String habitId);

  /// Restores an archived habit (sets it as active again)
  ///
  /// [habitId] - The ID of the habit to restore
  /// Returns [Right] with the restored habit on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, Habit>> restoreHabit(String habitId);

  /// Exports habit data (for backup or sharing)
  ///
  /// Returns [Right] with export data as JSON string on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, String>> exportHabitData();

  /// Imports habit data (from backup or sharing)
  ///
  /// [jsonData] - The JSON data to import
  /// [replaceExisting] - Whether to replace existing habits
  /// Returns [Right] with number of imported habits on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, int>> importHabitData(
    String jsonData, {
    bool replaceExisting = false,
  });
}

/// Statistics for a specific habit
class HabitStatistics extends Equatable {
  final String habitId;
  final int totalDays;
  final int successfulDays;
  final int failureDays;
  final double successRate;
  final int currentStreak;
  final int longestStreak;
  final int totalRelapses;
  final double averageTimeBetweenRelapses;
  final Map<String, int> triggerFrequency;
  final Map<String, int> emotionFrequency;
  final Map<int, int> weeklyPattern; // Day of week -> frequency
  final Map<int, int> monthlyPattern; // Day of month -> frequency

  const HabitStatistics({
    required this.habitId,
    required this.totalDays,
    required this.successfulDays,
    required this.failureDays,
    required this.successRate,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalRelapses,
    required this.averageTimeBetweenRelapses,
    required this.triggerFrequency,
    required this.emotionFrequency,
    required this.weeklyPattern,
    required this.monthlyPattern,
  });

  @override
  List<Object?> get props => [
    habitId,
    totalDays,
    successfulDays,
    failureDays,
    successRate,
    currentStreak,
    longestStreak,
    totalRelapses,
    averageTimeBetweenRelapses,
    triggerFrequency,
    emotionFrequency,
    weeklyPattern,
    monthlyPattern,
  ];
}

/// Overall statistics across all habits
class OverallStatistics extends Equatable {
  final int totalHabits;
  final int activeHabits;
  final int archivedHabits;
  final int goodHabits;
  final int badHabits;
  final double overallSuccessRate;
  final int totalSuccessfulDays;
  final int totalRelapses;
  final int longestOverallStreak;
  final String mostSuccessfulHabitId;
  final String mostChallengingHabitId;
  final Map<HabitCategory, int> categoryDistribution;
  final Map<String, int> commonTriggers;
  final Map<String, int> commonEmotions;

  const OverallStatistics({
    required this.totalHabits,
    required this.activeHabits,
    required this.archivedHabits,
    required this.goodHabits,
    required this.badHabits,
    required this.overallSuccessRate,
    required this.totalSuccessfulDays,
    required this.totalRelapses,
    required this.longestOverallStreak,
    required this.mostSuccessfulHabitId,
    required this.mostChallengingHabitId,
    required this.categoryDistribution,
    required this.commonTriggers,
    required this.commonEmotions,
  });

  @override
  List<Object?> get props => [
    totalHabits,
    activeHabits,
    archivedHabits,
    goodHabits,
    badHabits,
    overallSuccessRate,
    totalSuccessfulDays,
    totalRelapses,
    longestOverallStreak,
    mostSuccessfulHabitId,
    mostChallengingHabitId,
    categoryDistribution,
    commonTriggers,
    commonEmotions,
  ];
}
