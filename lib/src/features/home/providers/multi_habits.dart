import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/features/home/data/repository/habits_repository.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
import 'package:bad_habit_killer/src/features/home/domain/relapse_model.dart';
part 'multi_habits.g.dart';

@riverpod
class MultiHabits extends _$MultiHabits {
  @override
  FutureOr<List<HabitModel>> build() async {
    return await ref.watch(allHabitsProvider.future);
  }

  void addHabit(HabitModel habit) {
    state = state.whenData((habits) => [...habits, habit]);
  }

  void addRelapseToHabit(RelapseModel relapse, int id) {
    state = state.whenData((habits) {
      final habitIndex = habits.indexWhere((habit) => habit.id == id);
      if (habitIndex != -1) {
        final updatedRelapses = [...habits[habitIndex].relapses, relapse];
        final updatedHabit = habits[habitIndex].copyWith(
          relapses: updatedRelapses,
        );
        final updatedHabits = List<HabitModel>.from(habits);
        updatedHabits[habitIndex] = updatedHabit;
        return updatedHabits;
      }
      return habits;
    });
  }
}
