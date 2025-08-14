part of 'habit_details_view.dart';

void _addRelapse(WidgetRef ref, HabitModel habit) {
  final relapse = AddRelapse(
    habitId: habit.id,
    relapseDate: DateTime.now(),
    note: null,
  );
  ref.read(habitControllerProvider.notifier).addRelapse(relapse);
}
