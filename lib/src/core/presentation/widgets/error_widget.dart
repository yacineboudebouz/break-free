import 'package:bad_habit_killer/src/core/presentation/extensions/app_error_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, required this.error, required this.onRetry});
  final Object error;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    final message = error.errorMessage();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: Sizes.spacing16),
        AppButton(text: 'Retry'.hardcoded, onPressed: onRetry),
      ],
    );
  }
}
