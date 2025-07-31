import 'package:bad_habit_killer/src/core/presentation/extensions/app_error_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/database_colors.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:bad_habit_killer/src/features/home/domain/create_habit.dart';
import 'package:bad_habit_killer/src/features/home/providers/create_habit.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/color_selector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';

class AddHabitView extends StatefulHookConsumerWidget {
  const AddHabitView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddHabitViewState();
}

class _AddHabitViewState extends ConsumerState<AddHabitView> {
  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: "");
    final descriptionController = useTextEditingController(text: "");
    final currentColor = useState<Color>(Colors.red);
    final createHabitState = ref.watch(createHabitProvider);

    ref.listen<AsyncValue<void>>(createHabitProvider, (_, state) {
      if (state is AsyncData) {
        context.pop();
      }
      if (state is AsyncError) {
        final errorMessage = state.error.errorMessage();
        Logger().e("Error creating habit: $errorMessage");
      }
    });
    return AppScaffold(
      body: Column(
        spacing: Sizes.spacing8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: context.height * 0.12,
            padding: const EdgeInsets.all(Sizes.spacing16),
            child: Padding(
              padding: const EdgeInsets.only(top: Sizes.paddingV24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: Sizes.icon28),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  Center(
                    child: Text(
                      "Add Habit".hardcoded,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  gapW48,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingH24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start new life without'.hardcoded,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300),
                ),
                gapH8,
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    suffixIcon: Icon(Icons.edit_outlined),
                    hint: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      style:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            wordSpacing: 2,
                            color: currentColor.value,
                          ) ??
                          const TextStyle(),
                      child: Text("What you want to exclude".hardcoded),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                Text(
                  "Add the reason".hardcoded,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300),
                ),
                gapH8,
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    suffixIcon: Icon(Icons.edit_outlined),
                    hint: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      style:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            wordSpacing: 2,
                            color: currentColor.value,
                          ) ??
                          const TextStyle(),
                      child: Text("Why you want to exclude this.".hardcoded),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                gapH16,
                Text(
                  'Select color'.hardcoded,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300),
                ),
                gapH8,
                ColorSelector(
                  onColorSelected: (value) {
                    currentColor.value = value;
                  },
                ),

                gapH16,
                ElevatedButton(
                  onPressed: createHabitState.isLoading
                      ? null
                      : () {
                          final habit = CreateHabitModel(
                            name: nameController.text,
                            description: descriptionController.text,
                            color: DatabaseColors.colorToString(
                              currentColor.value,
                            ),
                            startDate: DateTime.now().toIso8601String(),
                          );
                          ref
                              .read(createHabitProvider.notifier)
                              .createHabit(habit);
                        },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, Sizes.marginH64),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Sizes.radius32),
                    ),
                  ),
                  child: Text(
                    "Add Habit".hardcoded,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
