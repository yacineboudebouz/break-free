import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:flutter/material.dart';

class TextFieldWithAnimatedHint extends StatelessWidget {
  const TextFieldWithAnimatedHint({
    super.key,
    required this.descriptionController,
    required this.currentColor,
    required this.hintText,
  });

  final TextEditingController descriptionController;
  final Color currentColor;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
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
                color: currentColor,
              ) ??
              const TextStyle(),
          child: Text(hintText),
        ),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
