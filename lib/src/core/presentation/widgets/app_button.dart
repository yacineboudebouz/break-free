import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.isLoading = false,
    required this.text,
    required this.onPressed,
  });

  final bool isLoading;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, Sizes.marginH64),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.radius12),
        ),
        overlayColor: Colors.transparent,
      ),
      child: Text(
        isLoading ? "Loading...".hardcoded : text,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
