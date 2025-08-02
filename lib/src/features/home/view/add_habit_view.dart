import 'package:bad_habit_killer/src/core/presentation/extensions/app_error_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/widget_ref_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/database_colors.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_button.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:bad_habit_killer/src/features/home/domain/create_habit.dart';
import 'package:bad_habit_killer/src/features/home/providers/create_habit.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/color_selector.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/text_field_with_animated_hint.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

    ref.listenAndHandleState(
      createHabitProvider,
      handleData: true,
      whenData: (data) {
        context.pop();
      },
    );
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
                TextFieldWithAnimatedHint(
                  descriptionController: nameController,
                  currentColor: currentColor.value,
                  hintText: "What you want to exclude".hardcoded,
                ),

                Text(
                  "Add the reason".hardcoded,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300),
                ),
                gapH8,
                TextFieldWithAnimatedHint(
                  descriptionController: descriptionController,
                  currentColor: currentColor.value,
                  hintText: "Why you want to exclude it".hardcoded,
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
                AppButton(
                  isLoading: ref.isLoading(createHabitProvider),
                  text: "Add Habit".hardcoded,
                  onPressed: () {
                    final habit = CreateHabitModel(
                      name: nameController.text,
                      description: descriptionController.text,
                      color: DatabaseColors.colorToString(currentColor.value),
                      startDate: DateTime.now().toIso8601String(),
                    );
                    ref.read(createHabitProvider.notifier).createHabit(habit);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
