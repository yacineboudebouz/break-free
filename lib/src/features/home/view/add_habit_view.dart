import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddHabitView extends StatefulHookConsumerWidget {
  const AddHabitView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddHabitViewState();
}

class _AddHabitViewState extends ConsumerState<AddHabitView> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        spacing: Sizes.spacing8,
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
                  SizedBox.square(dimension: Sizes.icon28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
