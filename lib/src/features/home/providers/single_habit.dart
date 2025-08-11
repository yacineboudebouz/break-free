import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
import 'package:bad_habit_killer/src/features/home/domain/relapse_model.dart';
import 'package:bad_habit_killer/src/features/home/providers/multi_habits.dart';
part 'single_habit.g.dart';

@riverpod
class SingleHabit extends _$SingleHabit {
  @override
  FutureOr<HabitModel> build(int id) async {
    final habits = await ref.watch(multiHabitsProvider.future);
    return habits.firstWhere((habit) => habit.id == id);
  }

  void addRelapse(RelapseModel relapse) {
    state = state.whenData((habit) {
      final updatedRelapses = [...habit.relapses, relapse];
      final updatedHabit = habit.copyWith(relapses: updatedRelapses);
      return updatedHabit;
    });
    ref
        .read(multiHabitsProvider.notifier)
        .addRelapseToHabit(relapse, state.value!.id);
  }
}
