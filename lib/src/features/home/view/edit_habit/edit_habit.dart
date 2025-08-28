import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/datetime_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/go_router_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/widget_ref_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/database_colors.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/core/presentation/utils/validator.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_button.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:bad_habit_killer/src/features/home/domain/habit_model.dart';
import 'package:bad_habit_killer/src/features/home/providers/create_habit.dart';
import 'package:bad_habit_killer/src/features/home/providers/habit_controller.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/color_selector.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/text_field_with_animated_hint.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'edit_habit_helper.dart';

class EditHabitView extends StatefulHookConsumerWidget {
  const EditHabitView({super.key, required this.habit});
  final HabitModel habit;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditHabitViewState();
}

class _EditHabitViewState extends ConsumerState<EditHabitView> {
  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController(text: widget.habit.name);
    final descriptionController = useTextEditingController(
      text: widget.habit.description,
    );
    final currentColor = useState<Color>(widget.habit.colorValue);
    final startDate = useState<DateTime>(widget.habit.startDate);
    ref.listenAndHandleState(
      habitControllerProvider,
      handleData: true,
      whenData: (data) {
        context.popG();
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
                      "Edit Habit".hardcoded,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  gapW48,
                ],
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingH24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start new life without'.hardcoded,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  gapH8,
                  TextFieldWithAnimatedHint(
                    validator: Validator.isNotEmpty,
                    controller: nameController,
                    currentColor: currentColor.value,
                    hintText: "What you want to exclude".hardcoded,
                  ),
                  Text(
                    "Add the reason".hardcoded,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  gapH8,
                  TextFieldWithAnimatedHint(
                    validator: Validator.isNotEmpty,
                    controller: descriptionController,
                    currentColor: currentColor.value,
                    hintText: "Why you want to exclude it".hardcoded,
                  ),
                  Text(
                    'Select start date'.hardcoded,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  gapH8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        style:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              wordSpacing: 2,
                              color: currentColor.value,
                            ) ??
                            const TextStyle(),
                        child: Text(startDate.value.formatted),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today_outlined),
                        onPressed: () async {
                          final selectedDate = await _selectDateTime(context);
                          startDate.value = selectedDate;
                        },
                      ),
                    ],
                  ),
                  gapH16,
                  Text(
                    'Select color'.hardcoded,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  gapH8,
                  ColorSelector(
                    selectedColorIndex: DatabaseColors.indexFromColor(
                      currentColor.value,
                    ),
                    onColorSelected: (value) {
                      currentColor.value = value;
                    },
                  ),

                  gapH16,
                  AppButton(
                    isLoading: ref.isLoading(createHabitProvider),
                    text: "Confirm Changes".hardcoded,
                    onPressed: () {
                      final habit = HabitModel(
                        id: widget.habit.id,
                        name: nameController.text,
                        startDate: startDate.value,
                        description: descriptionController.text,
                        color: DatabaseColors.colorToString(currentColor.value),
                        relapses: widget.habit.relapses,
                      );

                      ref
                          .read(habitControllerProvider.notifier)
                          .updateHabit(habit);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
