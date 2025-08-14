part of 'habit_details_view.dart';

void _addRelapse(WidgetRef ref, HabitModel habit) {
  final relapse = AddRelapse(
    habitId: habit.id,
    relapseDate: DateTime.now(),
    note: "AAAAAAAAAAXXXXXXXXXXXXXXXXx",
  );
  ref.read(habitControllerProvider.notifier).addRelapse(relapse);
}
