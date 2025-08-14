import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/features/home/data/repository/habits_repository.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
import 'package:bad_habit_killer/src/features/home/domain/relapse_model.dart';
part 'multi_habits.g.dart';

@Riverpod(keepAlive: true)
class MultiHabits extends _$MultiHabits {
  @override
  FutureOr<List<HabitModel>> build() async {
    return await ref.watch(allHabitsProvider.future);
  }

  void addHabit(HabitModel habit) {
    state = state.whenData((habits) => [...habits, habit]);
  }

  void addRelapseToHabit(RelapseModel relapse, int id) {
    if (state.hasValue) {
      final currentHabits = state.value!;
      final updatedHabits = currentHabits.map((habit) {
        if (habit.id == id) {
          return habit.copyWith(relapses: [...habit.relapses, relapse]);
        }
        return habit;
      }).toList();
      state = AsyncValue.data(updatedHabits);
    }
  }
}
