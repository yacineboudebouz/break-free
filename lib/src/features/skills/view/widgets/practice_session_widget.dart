import 'package:bad_habit_killer/src/core/presentation/extensions/datetime_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/features/skills/domain/practice_session_model.dart';
import 'package:flutter/material.dart';

class PracticeSessionWidget extends StatelessWidget {
  const PracticeSessionWidget({
    super.key,
    required this.session,
    required this.color,
  });

  final PracticeSessionModel session;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Sizes.paddingH16,
        vertical: Sizes.paddingV8,
      ),
      padding: EdgeInsets.all(Sizes.spacing16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(Sizes.radius12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Sizes.spacing16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Sizes.radius12),
            ),
            child: Icon(Icons.timer, color: color, size: 28),
          ),
          gapW12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      session.formattedDuration,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      session.practiceDate.formatted,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                if (session.note != null && session.note!.isNotEmpty) ...[
                  gapH4,
                  Text(
                    session.note!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(
                        0.7,
                      ),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
