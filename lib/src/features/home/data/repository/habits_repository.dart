// ignore_for_file: unused_catch_clause

import 'package:bad_habit_killer/src/core/config/error/app_exception.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/repository_error_handler.dart';
import 'package:bad_habit_killer/src/features/home/data/datasource/habits_datasource.dart';
import 'package:bad_habit_killer/src/features/home/domain/create_habit.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
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

  Future<int> createHabit(CreateHabitModel habit) async {
    return await habitsDatasource
        .createHabit(habit)
        .handleRepositoryErrors(
          throwForTest: true,
          specificErrorType: CacheExceptionType.createHabitFailed,
        );
  }

  Future<List<HabitModel>> getAllHabits() async {
    return await habitsDatasource.getAllHabits().handleRepositoryErrors(
      specificErrorType: CacheExceptionType.getAllHabitsFailed,
    );
  }
}
