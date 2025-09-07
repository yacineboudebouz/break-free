import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/interactive_layer/interactive_layer.dart';
import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget {
  const DrawerItemWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InteractiveLayer(
      onTap: onTap,
      config: InteractionConfig.scaleIn,
      child: Container(
        height: context.height * 0.07,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.paddingH12,
          vertical: Sizes.paddingV12,
        ),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(Sizes.radius32),
        ),
        child: Row(
          children: [
            Icon(icon, size: Sizes.icon28),
            gapW12,
            Text(title, style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
