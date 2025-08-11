import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/features/home/data/repository/habits_repository.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
part 'single_habit.g.dart';

@riverpod
class SingleHabit extends _$SingleHabit {
  @override
  Future<HabitModel> build(int id) async {
    final habits = await ref.watch(allHabitsProvider.future);
    return habits.firstWhere((habit) => habit.id == id);
  }
}
