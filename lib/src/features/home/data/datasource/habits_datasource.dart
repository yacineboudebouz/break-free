import 'package:bad_habit_killer/src/core/core_features/database/app_database.dart';
import 'package:bad_habit_killer/src/features/home/domain/add_relapse.dart';
import 'package:bad_habit_killer/src/features/home/domain/create_habit.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
import 'package:bad_habit_killer/src/features/home/domain/relapse_model.dart';
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
    final List<Map<String, dynamic>> habits = await database.query(
      DatabaseTables.habits,
    );
    List<HabitModel> habitModels = [];
    for (var habit in habits) {
      final habitId = habit['id'];
      final List<Map<String, dynamic>> relapses = await database.query(
        DatabaseTables.relapses,
        where: 'habit_id = ?',
        whereArgs: [habitId],
        orderBy: 'relapse_date DESC',
      );
      List<RelapseModel> relapseModels = relapses.map((relapse) {
        return RelapseModel.fromMap(relapse);
      }).toList();

      HabitModel habitModel = HabitModel.fromMapWithRelapses(
        habit,
        relapses: relapseModels,
      );

      habitModels.add(habitModel);
    }

    return habitModels;
  }

  Future<int> addRelapse(AddRelapse addRelapse) async {
    return await database.insert(DatabaseTables.relapses, addRelapse.toMap());
  }
}
