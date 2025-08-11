// ignore_for_file: unused_catch_clause

import 'package:bad_habit_killer/src/core/config/error/app_exception.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/repository_error_handler.dart';
import 'package:bad_habit_killer/src/features/home/data/datasource/habits_datasource.dart';
import 'package:bad_habit_killer/src/features/home/domain/add_relapse.dart';
import 'package:bad_habit_killer/src/features/home/domain/create_habit.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
import 'package:bad_habit_killer/src/features/home/domain/relapse_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habits_repository.g.dart';

@riverpod
Future<List<HabitModel>> allHabits(Ref ref) async {
  final habitsRepository = ref.watch(habitsRepositoryProvider);
  return await habitsRepository.getAllHabits();
}

@riverpod
HabitsRepository habitsRepository(Ref ref) {
  final habitsDatasource = ref.watch(habitsDatasourceProvider);
  return HabitsRepository(habitsDatasource);
}

class HabitsRepository {
  final HabitsDatasource habitsDatasource;
  HabitsRepository(this.habitsDatasource);

  Future<HabitModel> createHabit(CreateHabitModel habit) async {
    final habitId = await executeWithErrorHandling(
      () => habitsDatasource.createHabit(habit),
      specificErrorType: CacheExceptionType.createHabitFailed,
    );
    return HabitModel(
      id: habitId,
      name: habit.name,
      startDate: DateTime.parse(habit.startDate),
      description: habit.description,
      color: habit.color,
      relapses: [],
    );
  }

  Future<List<HabitModel>> getAllHabits() async {
    return await executeWithErrorHandling(
      () => habitsDatasource.getAllHabits(),
      specificErrorType: CacheExceptionType.getAllHabitsFailed,
    );
  }

  Future<RelapseModel> addRelapse(AddRelapse addRelapse) async {
    final id = await executeWithErrorHandling(
      () => habitsDatasource.addRelapse(addRelapse),
      specificErrorType: CacheExceptionType.addRelapseFailed,
    );

    return RelapseModel(
      id: id,
      date: addRelapse.relapseDate,
      note: addRelapse.note,
    );
  }
}
