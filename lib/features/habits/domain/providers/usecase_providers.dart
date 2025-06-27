import 'package:bad_habit_killer/features/habits/data/repositories/habit_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../usecases/add_habit.dart';
import '../usecases/delete_habit.dart';
import '../usecases/get_habits.dart';
import '../usecases/search_habits.dart';
import '../usecases/update_habit.dart';
import '../usecases/add_relapse.dart';
import '../usecases/get_habit_history.dart';

part 'usecase_providers.g.dart';

// Habit Use Case Providers

@riverpod
GetHabits getHabitsUseCase(GetHabitsUseCaseRef ref) {
  final repository = ref.watch(habitRepositoryProvider);
  return GetHabits(repository);
}

@riverpod
AddHabit addHabitUseCase(AddHabitUseCaseRef ref) {
  final repository = ref.watch(habitRepositoryProvider);
  return AddHabit(repository);
}

@riverpod
UpdateHabit updateHabitUseCase(UpdateHabitUseCaseRef ref) {
  final repository = ref.watch(habitRepositoryProvider);
  return UpdateHabit(repository);
}

@riverpod
DeleteHabit deleteHabitUseCase(DeleteHabitUseCaseRef ref) {
  final repository = ref.watch(habitRepositoryProvider);
  return DeleteHabit(repository);
}

@riverpod
SearchHabits searchHabitsUseCase(SearchHabitsUseCaseRef ref) {
  final repository = ref.watch(habitRepositoryProvider);
  return SearchHabits(repository);
}

@riverpod
AddRelapse addRelapseUseCase(AddRelapseUseCaseRef ref) {
  final repository = ref.watch(habitRepositoryProvider);
  return AddRelapse(repository);
}

@riverpod
GetHabitHistory getHabitHistoryUseCase(GetHabitHistoryUseCaseRef ref) {
  final repository = ref.watch(habitRepositoryProvider);
  return GetHabitHistory(repository);
}
