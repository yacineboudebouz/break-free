import 'package:bad_habit_killer/src/features/home/data/repository/habits_repository.dart';
import 'package:bad_habit_killer/src/features/home/domain/create_habit.dart';
import 'package:bad_habit_killer/src/features/home/providers/multi_habits.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'create_habit.g.dart';

@riverpod
class CreateHabit extends _$CreateHabit {
  @override
  FutureOr<void> build() {}

  // TODO: i am not sure if i will just consider ivalidating the provider
  // when the habit is created or if i will just return the created habit
  // and change the state manually
  // read this: https://riverpod.dev/docs/essentials/side_effects
  Future<void> createHabit(CreateHabitModel createHabit) async {
    try {
      state = const AsyncLoading();

      final habit = await ref
          .read(habitsRepositoryProvider)
          .createHabit(createHabit);
      ref.read(multiHabitsProvider.notifier).addHabit(habit);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
