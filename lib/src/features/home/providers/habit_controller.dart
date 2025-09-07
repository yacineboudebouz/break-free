import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/features/home/data/repository/habits_repository.dart';
import 'package:bad_habit_killer/src/features/home/domain/add_relapse.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
import 'package:bad_habit_killer/src/features/home/providers/single_habit.dart';
part 'habit_controller.g.dart';

@riverpod
class HabitController extends _$HabitController {
  @override
  FutureOr<void> build() {}

  Future<void> addRelapse(AddRelapse addRelapse) async {
    try {
      state = AsyncLoading();
      final habit = await ref
          .read(habitsRepositoryProvider)
          .addRelapse(addRelapse);
      ref
          .read(singleHabitProvider(addRelapse.habitId).notifier)
          .addRelapse(habit);
      state = AsyncData(null);
    } catch (e, tr) {
      state = AsyncError(e, tr);
    }
  }

  Future<void> updateHabit(HabitModel habit) async {
    try {
      state = AsyncLoading();
      await ref.read(habitsRepositoryProvider).updateHabit(habit);
      ref.read(singleHabitProvider(habit.id).notifier).updateHabit(habit);
      state = AsyncData(null);
    } catch (e, tr) {
      state = AsyncError(e, tr);
    }
  }

  Future<void> deleteRelapse(int relapseId, int habitId) async {
    try {
      state = AsyncLoading();
      await ref.read(habitsRepositoryProvider).deleteRelapse(relapseId);
      ref.read(singleHabitProvider(habitId).notifier).deleteRelapse(relapseId);
      state = AsyncData(null);
    } catch (e, tr) {
      state = AsyncError(e, tr);
    }
  }
}
