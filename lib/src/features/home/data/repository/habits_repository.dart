// ignore_for_file: unused_catch_clause

import 'package:bad_habit_killer/src/core/config/error/app_exception.dart';
import 'package:bad_habit_killer/src/features/home/data/datasource/habits_datasource.dart';
import 'package:bad_habit_killer/src/features/home/domain/create_habit.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
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
    try {
      return await habitsDatasource.createHabit(habit);
    } catch (e) {
      if (e is DatabaseException) {
        throw AppException.cacheException(
          type: CacheExceptionType.createHabitFailed,
        );
      } else if (e is AppException) {
        rethrow;
      } else {
        throw AppException.cacheException(type: CacheExceptionType.unknown);
      }
    }
  }

  Future<List<HabitModel>> getAllHabits() async {
    try {
      return await habitsDatasource.getAllHabits();
    } on DatabaseException {
      throw AppException.cacheException(
        type: CacheExceptionType.getAllHabitsFailed,
      );
    } catch (e) {
      if (e is AppException) {
        rethrow;
      } else {
        throw AppException.cacheException(type: CacheExceptionType.unknown);
      }
    }
  }
}
