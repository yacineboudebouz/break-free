import 'package:bad_habit_killer/src/core/core_features/database/app_database.dart';
import 'package:bad_habit_killer/src/features/home/domain/create_habit.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habits_datasource.g.dart';

@riverpod
HabitsDatasource habitsDatasource(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return HabitsDatasource(database);
}

class HabitsDatasource {
  final AppDatabase database;
  HabitsDatasource(this.database);

  Future<int> createHabit(CreateHabitModel habit) async {
    return await database.insert(DatabaseTables.habits, habit.toMap());
  }

  Future<List<HabitModel>> getAllHabits() async {
    final List<Map<String, dynamic>> maps = await database.query(
      DatabaseTables.habits,
    );
    return List.generate(maps.length, (i) {
      return HabitModel.fromMap(maps[i]);
    });
  }
}
