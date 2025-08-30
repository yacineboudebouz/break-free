part of 'habit_details_view.dart';

// ignore: no_leading_underscores_for_local_identifiers
void _addRelapse(
  WidgetRef ref,
  HabitModel habit,
  BuildContext context,
  ValueNotifier<DateTime> relapseDate,
  TextEditingController noteController,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text('Add Relapse'.hardcoded),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: relapseDate,
                    builder: (context, value, child) {
                      return AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        style:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              wordSpacing: 2,
                              color: habit.colorValue,
                            ) ??
                            const TextStyle(),
                        child: Text(relapseDate.value.formatted),
                      );
                    },
                  ),

                  IconButton(
                    icon: const Icon(Icons.calendar_today_outlined),
                    onPressed: () async {
                      final selectedDate = await _selectDateTime(
                        context,
                        habit.startDate,
                      );
                      relapseDate.value = selectedDate;
                    },
                  ),
                ],
              ),
              gapH12,
              TextField(
                controller: noteController,
                maxLines: 3,
                textAlignVertical: TextAlignVertical.center,

                decoration: InputDecoration(
                  labelText: "NOTE (optional)".hardcoded,
                  labelStyle: TextStyle(color: Theme.of(context).hintColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.radius12),
                    borderSide: BorderSide(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.radius12),
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Cancel'.hardcoded,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final relapse = AddRelapse(
                habitId: habit.id,
                relapseDate: relapseDate.value,
                note: noteController.text.isEmpty ? null : noteController.text,
              );
              ref.read(habitControllerProvider.notifier).addRelapse(relapse);
              context.pop();
            },
            child: Text(
              'Add'.hardcoded,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: habit.colorValue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<DateTime> _selectDateTime(
  BuildContext context,
  DateTime firstDate,
) async {
  DateTime? selectedDate;

  final date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: firstDate,
    lastDate: DateTime.now(),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
  );
  if (date != null) {
    final time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dialOnly,
      // ignore: use_build_context_synchronously
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      selectedDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    } else {
      selectedDate = date;
    }
  }
  return selectedDate ?? DateTime.now();
}
