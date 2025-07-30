import 'package:bad_habit_killer/src/features/home/data/repository/habits_repository.dart';
import 'package:bad_habit_killer/src/features/home/domain/create_habit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'create_habit.g.dart';

@riverpod
class CreateHabit extends _$CreateHabit {
  @override
  FutureOr<void> build() {}

  // TODO: i am not sure if i will just consider ivalidating the provider
  // when the habit is created or if i will just return the created habit
  // and change the state manually
  Future<void> createHabit({
    required String name,
    required String description,
    required String type,
    required String color,
  }) async {
    try {
      state = const AsyncLoading();
      final habit = CreateHabitModel(
        name: name,
        description: description,
        type: type,
        color: color,
        startDate: DateTime.now().toIso8601String(),
      );
      await ref.read(habitsRepositoryProvider).createHabit(habit);
      ref.invalidate(allHabitsProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
