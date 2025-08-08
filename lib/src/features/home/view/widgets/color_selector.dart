import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/providers/current_app_theme_provider.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/database_colors.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ColorSelector extends HookConsumerWidget {
  const ColorSelector({super.key, this.onColorSelected});

  final ValueChanged<Color>? onColorSelected;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = useState<int>(0);
    final appColors = ref.watch(currentAppThemeModeProvider).appColors;
    const colors = DatabaseColors.colors;
    return SizedBox(
      height: Sizes.marginH40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              selectedColor.value = index;
              if (onColorSelected != null) {
                onColorSelected!(colors[index]);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: Sizes.marginH40,
              height: Sizes.marginH40,
              margin: const EdgeInsets.symmetric(horizontal: Sizes.marginH8),
              decoration: BoxDecoration(
                color: colors[index],
                borderRadius: BorderRadius.circular(Sizes.radius32),
                border: Border.all(
                  color: selectedColor.value == index
                      ? appColors.textPrimaryColor
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
