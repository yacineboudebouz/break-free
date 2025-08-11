import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/features/home/data/repository/habits_repository.dart';
import 'package:bad_habit_killer/src/features/home/domain/add_relapse.dart';
import 'package:bad_habit_killer/src/features/home/providers/single_habit.dart';
part 'habit_controller.g.dart';

@riverpod
class HabitController extends _$HabitController {
  @override
  FutureOr build() {}

  Future<void> addRelapse(AddRelapse addRelapse) async {
    try {
      state = AsyncLoading();
      final habit = await ref
          .read(habitsRepositoryProvider)
          .addRelapse(addRelapse);
      ref
          .read(singleHabitProvider(addRelapse.habitId).notifier)
          .addRelapse(habit);
      state = AsyncData(habit);
    } catch (e, tr) {
      state = AsyncError(e, tr);
    }
  }
}
