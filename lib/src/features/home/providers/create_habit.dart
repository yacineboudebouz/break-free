import 'package:bad_habit_killer/src/features/home/data/repository/habits_repository.dart';
import 'package:bad_habit_killer/src/features/home/domain/create_habit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'create_habit.g.dart';

@riverpod
class CreateHabit extends _$CreateHabit {
  @override
  FutureOr<void> build() {}

  Future createHabit({
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
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
