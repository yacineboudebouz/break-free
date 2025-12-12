part of 'skill_details_view.dart';

void _addPracticeSession(
  WidgetRef ref,
  SkillModel skill,
  BuildContext context,
  ValueNotifier<DateTime> practiceDate,
  ValueNotifier<int> durationMinutes,
  TextEditingController noteController,
) {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Log Practice Session".hardcoded),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Duration (minutes)".hardcoded,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  gapH8,
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          setState(() {
                            if (durationMinutes.value > 5) {
                              durationMinutes.value -= 5;
                            }
                          });
                        },
                      ),
                      Expanded(
                        child: Slider(
                          value: durationMinutes.value.toDouble(),
                          min: 5,
                          max: 480,
                          divisions: 95,
                          label: '${durationMinutes.value}m',
                          onChanged: (value) {
                            setState(() {
                              durationMinutes.value = value.toInt();
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          setState(() {
                            if (durationMinutes.value < 480) {
                              durationMinutes.value += 5;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      _formatDuration(durationMinutes.value),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: skill.colorValue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  gapH16,
                  Text(
                    "Practice Date".hardcoded,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  gapH8,
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: practiceDate.value,
                        firstDate: skill.startDate,
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          practiceDate.value = date;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(Sizes.spacing16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(Sizes.radius8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(practiceDate.value.formatted),
                          Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  gapH16,
                  Text(
                    "Notes (optional)".hardcoded,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  gapH8,
                  TextField(
                    controller: noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "What did you practice?".hardcoded,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Sizes.radius8),
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
                  noteController.clear();
                },
                child: Text("Cancel".hardcoded),
              ),
              ElevatedButton(
                onPressed: () {
                  final session = AddPracticeSession(
                    skillId: skill.id,
                    practiceDate: practiceDate.value,
                    durationMinutes: durationMinutes.value,
                    note: noteController.text.isEmpty
                        ? null
                        : noteController.text,
                  );
                  ref
                      .read(skillControllerProvider.notifier)
                      .addPracticeSession(session);
                  context.pop();
                  noteController.clear();
                },
                child: Text("Log Session".hardcoded),
              ),
            ],
          );
        },
      );
    },
  );
}

String _formatDuration(int minutes) {
  final hours = minutes ~/ 60;
  final mins = minutes % 60;
  if (hours > 0) {
    return '${hours}h ${mins}m';
  }
  return '${mins}m';
}

void _deleteSession(
  WidgetRef ref,
  int sessionId,
  int skillId,
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Delete Session".hardcoded),
        content: Text(
          "Are you sure you want to delete this practice session?".hardcoded,
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text("Cancel".hardcoded),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              ref
                  .read(skillControllerProvider.notifier)
                  .deletePracticeSession(sessionId, skillId);
              context.pop();
            },
            child: Text("Delete".hardcoded),
          ),
        ],
      );
    },
  );
}
