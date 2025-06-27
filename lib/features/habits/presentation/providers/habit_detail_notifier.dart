import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/habit.dart';
import '../../domain/entities/relapse.dart';
import '../../domain/usecases/get_habits.dart';
import '../../domain/usecases/add_relapse.dart';
import '../../domain/usecases/get_habit_history.dart';
import '../../domain/providers/usecase_providers.dart' as providers;
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';

part 'habit_detail_notifier.g.dart';

/// State for individual habit detail view
class HabitDetailState {
  final Habit? habit;
  final List<Relapse> history;
  final bool isLoading;
  final bool isLoadingHistory;
  final bool isAddingRelapse;
  final String? error;
  final String? actionError;
  final int historyOffset;
  final bool hasMoreHistory;

  const HabitDetailState({
    this.habit,
    this.history = const [],
    this.isLoading = false,
    this.isLoadingHistory = false,
    this.isAddingRelapse = false,
    this.error,
    this.actionError,
    this.historyOffset = 0,
    this.hasMoreHistory = true,
  });

  HabitDetailState copyWith({
    Habit? habit,
    List<Relapse>? history,
    bool? isLoading,
    bool? isLoadingHistory,
    bool? isAddingRelapse,
    String? error,
    String? actionError,
    int? historyOffset,
    bool? hasMoreHistory,
  }) {
    return HabitDetailState(
      habit: habit ?? this.habit,
      history: history ?? this.history,
      isLoading: isLoading ?? this.isLoading,
      isLoadingHistory: isLoadingHistory ?? this.isLoadingHistory,
      isAddingRelapse: isAddingRelapse ?? this.isAddingRelapse,
      error: error ?? this.error,
      actionError: actionError ?? this.actionError,
      historyOffset: historyOffset ?? this.historyOffset,
      hasMoreHistory: hasMoreHistory ?? this.hasMoreHistory,
    );
  }

  /// Clear only action errors (not main loading error)
  HabitDetailState clearActionError() {
    return copyWith(actionError: null);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitDetailState &&
          runtimeType == other.runtimeType &&
          habit == other.habit &&
          history == other.history &&
          isLoading == other.isLoading &&
          isLoadingHistory == other.isLoadingHistory &&
          isAddingRelapse == other.isAddingRelapse &&
          error == other.error &&
          actionError == other.actionError &&
          historyOffset == other.historyOffset &&
          hasMoreHistory == other.hasMoreHistory;

  @override
  int get hashCode =>
      habit.hashCode ^
      history.hashCode ^
      isLoading.hashCode ^
      isLoadingHistory.hashCode ^
      isAddingRelapse.hashCode ^
      error.hashCode ^
      actionError.hashCode ^
      historyOffset.hashCode ^
      hasMoreHistory.hashCode;
}

/// Statistics derived from habit detail state
class HabitDetailStats {
  final int currentStreak;
  final int longestStreak;
  final int totalRelapses;
  final int totalSuccesses;
  final double successRate;
  final Duration cleanTime;
  final Relapse? lastEvent;
  final DateTime? lastRelapseDate;
  final DateTime? lastSuccessDate;

  const HabitDetailStats({
    required this.currentStreak,
    required this.longestStreak,
    required this.totalRelapses,
    required this.totalSuccesses,
    required this.successRate,
    required this.cleanTime,
    this.lastEvent,
    this.lastRelapseDate,
    this.lastSuccessDate,
  });
}

/// Notifier for managing individual habit detail state
@riverpod
class HabitDetailNotifier extends _$HabitDetailNotifier {
  static const int _historyPageSize = 20;

  @override
  HabitDetailState build(String habitId) {
    // Initialize and load habit details
    _loadHabitDetail(habitId);
    return const HabitDetailState(isLoading: true);
  }

  /// Load habit details and initial history
  Future<void> _loadHabitDetail(String habitId) async {
    try {
      AppLogger.debug('HabitDetailNotifier: Loading habit detail for ID: $habitId');
      
      state = state.copyWith(isLoading: true, error: null);
        // Load habit and history in parallel
      final getHabitsUseCase = ref.read(providers.getHabitsUseCaseProvider);
      final getHistoryUseCase = ref.read(providers.getHabitHistoryUseCaseProvider);
      
      final habitsResult = await getHabitsUseCase(const GetHabitsParams());
      
      final habit = habitsResult.fold(
        (failure) => null,
        (habits) => habits.firstWhere(
          (h) => h.id == habitId,
          orElse: () => throw Exception('Habit not found'),
        ),
      );

      if (habit == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'Habit not found',
        );
        return;
      }

      // Load initial history
      final historyResult = await getHistoryUseCase(
        GetHabitHistoryParams(
          habitId: habitId,
          limit: _historyPageSize,
          offset: 0,
        ),
      );

      historyResult.fold(
        (failure) {
          AppLogger.error('HabitDetailNotifier: Failed to load history', failure);
          state = state.copyWith(
            habit: habit,
            isLoading: false,
            error: _mapFailureToMessage(failure),
          );
        },
        (history) {
          AppLogger.info('HabitDetailNotifier: Loaded habit and ${history.length} history items');
          state = state.copyWith(
            habit: habit,
            history: history,
            isLoading: false,
            error: null,
            historyOffset: history.length,
            hasMoreHistory: history.length >= _historyPageSize,
          );
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('HabitDetailNotifier: Unexpected error loading habit detail', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
    }
  }

  /// Refresh habit data
  Future<void> refresh() async {
    if (state.habit != null) {
      AppLogger.debug('HabitDetailNotifier: Refreshing habit detail');
      await _loadHabitDetail(state.habit!.id);
    }
  }

  /// Load more history items (pagination)
  Future<void> loadMoreHistory() async {
    if (state.habit == null || state.isLoadingHistory || !state.hasMoreHistory) {
      return;
    }

    try {
      AppLogger.debug('HabitDetailNotifier: Loading more history');
        state = state.copyWith(isLoadingHistory: true);
      
      final getHistoryUseCase = ref.read(providers.getHabitHistoryUseCaseProvider);
      final result = await getHistoryUseCase(
        GetHabitHistoryParams(
          habitId: state.habit!.id,
          limit: _historyPageSize,
          offset: state.historyOffset,
        ),
      );

      result.fold(
        (failure) {
          AppLogger.error('HabitDetailNotifier: Failed to load more history', failure);
          state = state.copyWith(
            isLoadingHistory: false,
            actionError: _mapFailureToMessage(failure),
          );
        },
        (newHistory) {
          AppLogger.info('HabitDetailNotifier: Loaded ${newHistory.length} more history items');
          final allHistory = [...state.history, ...newHistory];
          state = state.copyWith(
            history: allHistory,
            isLoadingHistory: false,
            historyOffset: allHistory.length,
            hasMoreHistory: newHistory.length >= _historyPageSize,
            actionError: null,
          );
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('HabitDetailNotifier: Unexpected error loading more history', e, stackTrace);
      state = state.copyWith(
        isLoadingHistory: false,
        actionError: 'Failed to load more history',
      );
    }
  }

  /// Add a relapse/event to the habit
  Future<bool> addRelapse({
    required RelapseType type,
    String? note,
    String? trigger,
    String? emotion,
    String? location,
    int? intensityLevel,
    DateTime? customDate,
  }) async {
    if (state.habit == null || state.isAddingRelapse) {
      return false;
    }

    try {
      AppLogger.debug('HabitDetailNotifier: Adding ${type.name} for habit: ${state.habit!.name}');
      
      state = state.copyWith(isAddingRelapse: true, actionError: null);
      
      final relapse = Relapse(
        id: '', // Will be generated by repository
        habitId: state.habit!.id,
        type: type,
        date: customDate ?? DateTime.now(),
        note: note,
        trigger: trigger,
        emotion: emotion,
        location: location,
        intensityLevel: intensityLevel,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final addRelapseUseCase = ref.read(providers.addRelapseUseCaseProvider);
      final result = await addRelapseUseCase(AddRelapseParams(relapse: relapse));
      
      return result.fold(
        (failure) {
          AppLogger.error('HabitDetailNotifier: Failed to add ${type.name}', failure);
          state = state.copyWith(
            isAddingRelapse: false,
            actionError: _mapFailureToMessage(failure),
          );
          return false;
        },
        (updatedHabit) {
          AppLogger.info('HabitDetailNotifier: Successfully added ${type.name}');
          
          // Update habit and refresh history
          state = state.copyWith(
            habit: updatedHabit,
            isAddingRelapse: false,
            actionError: null,
          );
          
          // Refresh history to show the new event
          _refreshHistory();
          
          return true;
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('HabitDetailNotifier: Unexpected error adding ${type.name}', e, stackTrace);
      state = state.copyWith(
        isAddingRelapse: false,
        actionError: 'Failed to add ${type.name}',
      );
      return false;
    }
  }

  /// Add a relapse (convenience method for bad habits)
  Future<bool> addRelapseEvent({
    String? note,
    String? trigger,
    String? emotion,
    String? location,
    int? intensityLevel,
    DateTime? customDate,
  }) async {
    return addRelapse(
      type: RelapseType.relapse,
      note: note,
      trigger: trigger,
      emotion: emotion,
      location: location,
      intensityLevel: intensityLevel,
      customDate: customDate,
    );
  }

  /// Add a success (convenience method for good habits)
  Future<bool> addSuccess({
    String? note,
    DateTime? customDate,
  }) async {
    return addRelapse(
      type: RelapseType.success,
      note: note,
      customDate: customDate,
    );
  }

  /// Add a missed event (convenience method for good habits)
  Future<bool> addMissed({
    String? note,
    DateTime? customDate,
  }) async {
    return addRelapse(
      type: RelapseType.missed,
      note: note,
      customDate: customDate,
    );
  }

  /// Reset habit streak
  Future<bool> resetStreak({String? note}) async {
    return addRelapse(
      type: RelapseType.reset,
      note: note,
    );
  }

  /// Refresh history after adding new events
  Future<void> _refreshHistory() async {
    if (state.habit == null) return;    try {
      final getHistoryUseCase = ref.read(providers.getHabitHistoryUseCaseProvider);
      final result = await getHistoryUseCase(
        GetHabitHistoryParams(
          habitId: state.habit!.id,
          limit: _historyPageSize,
          offset: 0,
        ),
      );

      result.fold(
        (failure) {
          AppLogger.error('HabitDetailNotifier: Failed to refresh history', failure);
        },
        (history) {
          state = state.copyWith(
            history: history,
            historyOffset: history.length,
            hasMoreHistory: history.length >= _historyPageSize,
          );
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('HabitDetailNotifier: Error refreshing history', e, stackTrace);
    }  }

  /// Clear action errors
  void clearActionError() {
    state = state.clearActionError();
  }

  /// Map failure to user-friendly message
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error. Please try again later.';
      case CacheFailure:
        return 'Data loading error. Please check your connection.';
      case ValidationFailure:
        return failure.message;
      case DatabaseFailure:
        return 'Database error. Please try again.';
      default:
        return failure.message;
    }
  }
}

/// Provider for habit detail statistics
@riverpod
HabitDetailStats habitDetailStats(HabitDetailStatsRef ref, String habitId) {
  final detailState = ref.watch(habitDetailNotifierProvider(habitId));
  final habit = detailState.habit;
  final history = detailState.history;

  if (habit == null) {
    return const HabitDetailStats(
      currentStreak: 0,
      longestStreak: 0,
      totalRelapses: 0,
      totalSuccesses: 0,
      successRate: 0.0,
      cleanTime: Duration.zero,
    );
  }

  // Calculate statistics based on habit type and history
  return _calculateStats(habit, history);
}

/// Calculate habit statistics
HabitDetailStats _calculateStats(Habit habit, List<Relapse> history) {
  if (history.isEmpty) {
    final cleanTime = habit.lastRelapseDate != null 
        ? DateTime.now().difference(habit.lastRelapseDate!)
        : DateTime.now().difference(habit.createdAt);
    
    return HabitDetailStats(
      currentStreak: habit.currentStreak,
      longestStreak: habit.bestStreak,
      totalRelapses: 0,
      totalSuccesses: 0,
      successRate: 0.0,
      cleanTime: cleanTime,
    );
  }

  // Sort history by date (most recent first)
  final sortedHistory = [...history]
    ..sort((a, b) => b.date.compareTo(a.date));

  final relapses = sortedHistory.where((h) => h.type == RelapseType.relapse).toList();
  final successes = sortedHistory.where((h) => h.type == RelapseType.success).toList();
  final totalEvents = relapses.length + successes.length;

  final successRate = totalEvents > 0 ? (successes.length / totalEvents) * 100 : 0.0;

  final lastEvent = sortedHistory.isNotEmpty ? sortedHistory.first : null;
  final lastRelapseDate = relapses.isNotEmpty ? relapses.first.date : habit.lastRelapseDate;
  final lastSuccessDate = successes.isNotEmpty ? successes.first.date : null;

  // Calculate clean time (time since last relapse)
  final cleanTime = lastRelapseDate != null 
      ? DateTime.now().difference(lastRelapseDate)
      : DateTime.now().difference(habit.createdAt);

  return HabitDetailStats(
    currentStreak: habit.currentStreak,
    longestStreak: habit.bestStreak,
    totalRelapses: relapses.length,
    totalSuccesses: successes.length,
    successRate: successRate,
    cleanTime: cleanTime,
    lastEvent: lastEvent,
    lastRelapseDate: lastRelapseDate,
    lastSuccessDate: lastSuccessDate,
  );
}

/// Convenience providers for accessing specific aspects of habit detail

@riverpod
bool habitDetailIsLoading(HabitDetailIsLoadingRef ref, String habitId) {
  return ref.watch(habitDetailNotifierProvider(habitId).select((state) => state.isLoading));
}

@riverpod
String? habitDetailError(HabitDetailErrorRef ref, String habitId) {
  return ref.watch(habitDetailNotifierProvider(habitId).select((state) => state.error));
}

@riverpod
String? habitDetailActionError(HabitDetailActionErrorRef ref, String habitId) {
  return ref.watch(habitDetailNotifierProvider(habitId).select((state) => state.actionError));
}

@riverpod
Habit? habitDetail(HabitDetailRef ref, String habitId) {
  return ref.watch(habitDetailNotifierProvider(habitId).select((state) => state.habit));
}

@riverpod
List<Relapse> habitDetailHistory(HabitDetailHistoryRef ref, String habitId) {
  return ref.watch(habitDetailNotifierProvider(habitId).select((state) => state.history));
}

@riverpod
bool habitDetailCanLoadMore(HabitDetailCanLoadMoreRef ref, String habitId) {
  final state = ref.watch(habitDetailNotifierProvider(habitId));
  return state.hasMoreHistory && !state.isLoadingHistory;
}
