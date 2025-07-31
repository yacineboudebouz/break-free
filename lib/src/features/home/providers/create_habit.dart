import 'package:bad_habit_killer/src/features/home/data/repository/habits_repository.dart';
import 'package:bad_habit_killer/src/features/home/domain/create_habit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'create_habit.g.dart';

@riverpod
class CreateHabit extends _$CreateHabit {
  @override
  FutureOr<void> build() {}

  // Original notifier with manual state management
  Future<void> createHabit(CreateHabitModel createHabit) async {
    state = const AsyncLoading();
    final habitsRepository = ref.watch(habitsRepositoryProvider);
    try {
      final createdHabitId = await habitsRepository.createHabit(createHabit);
      ref.invalidate(allHabitsProvider);
      state = AsyncData(null); // This might still cause issues
    } catch (e, tr) {
      state = AsyncError(e, tr);
    }
  }
}
