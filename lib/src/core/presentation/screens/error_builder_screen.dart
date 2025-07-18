import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class ErrorBuilderScreen extends StatelessWidget {
  const ErrorBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      paddingH: Sizes.paddingH16,
      paddingV: Sizes.paddingV12,
      body: Center(
        child: Text(
          'This page is not found.'.hardcoded,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
