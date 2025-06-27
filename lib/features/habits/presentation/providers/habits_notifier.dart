import 'package:bad_habit_killer/features/habits/domain/providers/usecase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/domain.dart' hide getHabitsUseCaseProvider;
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';

part 'habits_notifier.g.dart';

/// State for the habits list
class HabitsState {
  final List<Habit> habits;
  final List<Habit> filteredHabits;
  final bool isLoading;
  final String? error;
  final String searchQuery;
  final HabitFilter filter;

  const HabitsState({
    this.habits = const [],
    this.filteredHabits = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
    this.filter = HabitFilter.all,
  });

  HabitsState copyWith({
    List<Habit>? habits,
    List<Habit>? filteredHabits,
    bool? isLoading,
    String? error,
    String? searchQuery,
    HabitFilter? filter,
  }) {
    return HabitsState(
      habits: habits ?? this.habits,
      filteredHabits: filteredHabits ?? this.filteredHabits,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      searchQuery: searchQuery ?? this.searchQuery,
      filter: filter ?? this.filter,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitsState &&
          runtimeType == other.runtimeType &&
          habits == other.habits &&
          filteredHabits == other.filteredHabits &&
          isLoading == other.isLoading &&
          error == other.error &&
          searchQuery == other.searchQuery &&
          filter == other.filter;

  @override
  int get hashCode =>
      habits.hashCode ^
      filteredHabits.hashCode ^
      isLoading.hashCode ^
      error.hashCode ^
      searchQuery.hashCode ^
      filter.hashCode;
}

/// Filter options for habits
enum HabitFilter { all, good, bad }

/// Notifier for managing habits list state
@riverpod
class HabitsNotifier extends _$HabitsNotifier {
  @override
  HabitsState build() {
    // Initialize and load habits
    _loadHabits();
    return const HabitsState(isLoading: true);
  }

  /// Load all habits from repository
  Future<void> _loadHabits() async {
    try {
      AppLogger.debug('HabitsNotifier: Loading habits');

      state = state.copyWith(isLoading: true, error: null);

      final getHabitsUseCase = ref.read(getHabitsUseCaseProvider);
      final result = await getHabitsUseCase(const GetHabitsParams());

      result.fold(
        (failure) {
          AppLogger.error('HabitsNotifier: Failed to load habits', failure);
          state = state.copyWith(
            isLoading: false,
            error: _mapFailureToMessage(failure),
          );
        },
        (habits) {
          AppLogger.info('HabitsNotifier: Loaded ${habits.length} habits');
          final filteredHabits = _applyFilters(habits);
          state = state.copyWith(
            habits: habits,
            filteredHabits: filteredHabits,
            isLoading: false,
            error: null,
          );
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'HabitsNotifier: Unexpected error loading habits',
        e,
        stackTrace,
      );
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
    }
  }

  /// Refresh habits (pull-to-refresh)
  Future<void> refreshHabits() async {
    AppLogger.debug('HabitsNotifier: Refreshing habits');
    await _loadHabits();
  }

  /// Add a new habit
  Future<bool> addHabit(Habit habit) async {
    try {
      AppLogger.debug('HabitsNotifier: Adding habit: ${habit.name}');

      state = state.copyWith(isLoading: true, error: null);

      final addHabitUseCase = ref.read(addHabitUseCaseProvider);
      final result = await addHabitUseCase(AddHabitParams(habit: habit));

      return result.fold(
        (failure) {
          AppLogger.error('HabitsNotifier: Failed to add habit', failure);
          state = state.copyWith(
            isLoading: false,
            error: _mapFailureToMessage(failure),
          );
          return false;
        },
        (_) {
          AppLogger.info(
            'HabitsNotifier: Successfully added habit: ${habit.name}',
          );
          // Reload habits to get updated list
          _loadHabits();
          return true;
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'HabitsNotifier: Unexpected error adding habit',
        e,
        stackTrace,
      );
      state = state.copyWith(isLoading: false, error: 'Failed to add habit');
      return false;
    }
  }

  /// Update an existing habit
  Future<bool> updateHabit(Habit habit) async {
    try {
      AppLogger.debug('HabitsNotifier: Updating habit: ${habit.id}');

      state = state.copyWith(isLoading: true, error: null);

      final updateHabitUseCase = ref.read(updateHabitUseCaseProvider);
      final result = await updateHabitUseCase(UpdateHabitParams(habit: habit));

      return result.fold(
        (failure) {
          AppLogger.error('HabitsNotifier: Failed to update habit', failure);
          state = state.copyWith(
            isLoading: false,
            error: _mapFailureToMessage(failure),
          );
          return false;
        },
        (_) {
          AppLogger.info(
            'HabitsNotifier: Successfully updated habit: ${habit.id}',
          );
          // Reload habits to get updated list
          _loadHabits();
          return true;
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'HabitsNotifier: Unexpected error updating habit',
        e,
        stackTrace,
      );
      state = state.copyWith(isLoading: false, error: 'Failed to update habit');
      return false;
    }
  }

  /// Delete a habit
  Future<bool> deleteHabit(String habitId) async {
    try {
      AppLogger.debug('HabitsNotifier: Deleting habit: $habitId');

      state = state.copyWith(isLoading: true, error: null);

      final deleteHabitUseCase = ref.read(deleteHabitUseCaseProvider);
      final result = await deleteHabitUseCase(
        DeleteHabitParams(habitId: habitId),
      );

      return result.fold(
        (failure) {
          AppLogger.error('HabitsNotifier: Failed to delete habit', failure);
          state = state.copyWith(
            isLoading: false,
            error: _mapFailureToMessage(failure),
          );
          return false;
        },
        (_) {
          AppLogger.info(
            'HabitsNotifier: Successfully deleted habit: $habitId',
          );
          // Reload habits to get updated list
          _loadHabits();
          return true;
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'HabitsNotifier: Unexpected error deleting habit',
        e,
        stackTrace,
      );
      state = state.copyWith(isLoading: false, error: 'Failed to delete habit');
      return false;
    }
  }

  /// Search habits
  Future<void> searchHabits(String query) async {
    try {
      AppLogger.debug('HabitsNotifier: Searching habits with query: "$query"');

      state = state.copyWith(searchQuery: query, isLoading: true, error: null);

      if (query.isEmpty) {
        // If query is empty, show all habits with current filter
        final filteredHabits = _applyFilters(state.habits);
        state = state.copyWith(
          filteredHabits: filteredHabits,
          isLoading: false,
        );
        return;
      }

      final searchHabitsUseCase = ref.read(searchHabitsUseCaseProvider);
      final result = await searchHabitsUseCase(
        SearchHabitsParams(query: query),
      );

      result.fold(
        (failure) {
          AppLogger.error('HabitsNotifier: Failed to search habits', failure);
          state = state.copyWith(
            isLoading: false,
            error: _mapFailureToMessage(failure),
          );
        },
        (searchResults) {
          AppLogger.info(
            'HabitsNotifier: Found ${searchResults.length} habits for query: "$query"',
          );
          final filteredResults = _applyFilters(searchResults);
          state = state.copyWith(
            filteredHabits: filteredResults,
            isLoading: false,
            error: null,
          );
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'HabitsNotifier: Unexpected error searching habits',
        e,
        stackTrace,
      );
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to search habits',
      );
    }
  }

  /// Apply filter to habits
  void setFilter(HabitFilter filter) {
    AppLogger.debug('HabitsNotifier: Setting filter to: ${filter.name}');

    final baseHabits = state.searchQuery.isEmpty
        ? state.habits
        : state.filteredHabits;
    final filteredHabits = _applyFilters(baseHabits, filter);

    state = state.copyWith(filter: filter, filteredHabits: filteredHabits);
  }

  /// Clear search and filters
  void clearSearch() {
    AppLogger.debug('HabitsNotifier: Clearing search');

    final filteredHabits = _applyFilters(state.habits, state.filter);
    state = state.copyWith(searchQuery: '', filteredHabits: filteredHabits);
  }

  /// Clear any error state
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Apply filters to habits list
  List<Habit> _applyFilters(List<Habit> habits, [HabitFilter? filter]) {
    final currentFilter = filter ?? state.filter;

    switch (currentFilter) {
      case HabitFilter.all:
        return habits;
      case HabitFilter.good:
        return habits.where((habit) => habit.type == HabitType.good).toList();
      case HabitFilter.bad:
        return habits.where((habit) => habit.type == HabitType.bad).toList();
    }
  }

  /// Map failure to user-friendly message
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case DatabaseFailure:
        return 'Database error occurred';
      case ValidationFailure:
        return 'Invalid habit data';
      default:
        return failure.message ?? 'An error occurred';
    }
  }
}

/// Convenience providers for accessing specific parts of habits state

@riverpod
List<Habit> filteredHabits(FilteredHabitsRef ref) {
  return ref.watch(habitsNotifierProvider).filteredHabits;
}

@riverpod
List<Habit> goodHabits(GoodHabitsRef ref) {
  final habits = ref.watch(filteredHabitsProvider);
  return habits.where((habit) => habit.type == HabitType.good).toList();
}

@riverpod
List<Habit> badHabits(BadHabitsRef ref) {
  final habits = ref.watch(filteredHabitsProvider);
  return habits.where((habit) => habit.type == HabitType.bad).toList();
}

@riverpod
bool isHabitsLoading(IsHabitsLoadingRef ref) {
  return ref.watch(habitsNotifierProvider).isLoading;
}

@riverpod
String? habitsError(HabitsErrorRef ref) {
  return ref.watch(habitsNotifierProvider).error;
}

@riverpod
String habitsSearchQuery(HabitsSearchQueryRef ref) {
  return ref.watch(habitsNotifierProvider).searchQuery;
}

@riverpod
HabitFilter habitsFilter(HabitsFilterRef ref) {
  return ref.watch(habitsNotifierProvider).filter;
}
