import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RelapseButton extends HookConsumerWidget {
  const RelapseButton({super.key, required this.color, this.onPressed});
  final Color color;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = context.height * 0.06;
    final width = context.width * 0.35;

    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizes.radius12),
          border: Border.all(color: color, width: Sizes.borderWidth1),
        ),

        child: Center(
          child: Text(
            'Relapse'.hardcoded,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: color),
          ),
        ),
      ),
    );
  }
}
