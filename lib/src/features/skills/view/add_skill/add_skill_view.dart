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
import 'package:bad_habit_killer/src/features/home/view/widgets/color_selector.dart';
import 'package:bad_habit_killer/src/features/home/view/widgets/text_field_with_animated_hint.dart';
import 'package:bad_habit_killer/src/features/skills/domain/create_skill.dart';
import 'package:bad_habit_killer/src/features/skills/providers/create_skill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
part 'add_skill_view_helper.dart';

class AddSkillView extends StatefulHookConsumerWidget {
  const AddSkillView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddSkillViewState();
}

class _AddSkillViewState extends ConsumerState<AddSkillView> {
  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController(text: "");
    final descriptionController = useTextEditingController(text: "");
    final targetHoursController = useTextEditingController(text: "10000");
    final currentColor = useState<Color>(Colors.red);
    final startDate = useState<DateTime>(DateTime.now());
    ref.listenAndHandleState(
      createSkillProvider,
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
                      "Add Skill".hardcoded,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  gapW48,
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.paddingH24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Begin your mastery journey with'.hardcoded,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      gapH8,
                      TextFieldWithAnimatedHint(
                        validator: Validator.isNotEmpty,
                        controller: nameController,
                        currentColor: currentColor.value,
                        hintText: "Skill name (e.g., Piano, Drawing)".hardcoded,
                      ),
                      Text(
                        "Why this skill matters to you".hardcoded,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      gapH8,
                      TextFieldWithAnimatedHint(
                        validator: Validator.isNotEmpty,
                        controller: descriptionController,
                        currentColor: currentColor.value,
                        hintText: "Your motivation for learning".hardcoded,
                      ),
                      Text(
                        'Target hours (default: 10,000)'.hardcoded,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      gapH8,
                      TextFormField(
                        controller: targetHoursController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter target hours'.hardcoded;
                          }
                          final hours = int.tryParse(value);
                          if (hours == null || hours < 1) {
                            return 'Please enter a valid number'.hardcoded;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "10000".hardcoded,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.radius12),
                            borderSide: BorderSide(color: currentColor.value),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.radius12),
                            borderSide: BorderSide(
                              color: currentColor.value,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      gapH8,
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
                              final selectedDate = await _selectDateTime(
                                context,
                              );
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
                        onColorSelected: (value) {
                          currentColor.value = value;
                        },
                      ),
                      gapH16,
                      AppButton(
                        isLoading: ref.isLoading(createSkillProvider),
                        text: "Begin Journey".hardcoded,
                        onPressed: () {
                          _submitForm(
                            formKey,
                            nameController,
                            descriptionController,
                            targetHoursController,
                            startDate.value,
                            currentColor,
                            ref,
                          );
                        },
                      ),
                      gapH24,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
