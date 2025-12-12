part of 'add_skill_view.dart';

void _submitForm(
  GlobalKey<FormState> formKey,
  TextEditingController nameController,
  TextEditingController descriptionController,
  TextEditingController targetHoursController,
  DateTime startDate,
  ValueNotifier<Color> currentColor,
  WidgetRef ref,
) {
  if (formKey.currentState!.validate()) {
    final skill = CreateSkillModel(
      name: nameController.text,
      description: descriptionController.text,
      color: DatabaseColors.colorToString(currentColor.value),
      startDate: startDate,
      targetHours: int.parse(targetHoursController.text),
    );
    ref.read(createSkillProvider.notifier).createSkill(skill);
  }
}

Future<DateTime> _selectDateTime(BuildContext context) async {
  DateTime? selectedDate;

  final date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
  );
  if (date != null) {
    final time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dialOnly,
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
