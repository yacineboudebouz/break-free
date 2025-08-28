import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/datetime_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/features/home/domain/event_model.dart';
import 'package:flutter/material.dart';

class RelapseHistoryWidget extends StatelessWidget {
  const RelapseHistoryWidget({super.key, required this.event});

  // TODO: i have to add encapsulation layer for relapse to handle
  // relpases, notes, first date
  final EventModel event;

  IconData get icon {
    switch (event.type) {
      case EventType.relapse:
        return Icons.close;
      case EventType.firstDate:
        return Icons.star;
      case EventType.note:
        return Icons.close;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.paddingH12,
        vertical: Sizes.paddingV8,
      ),
      child: Container(
        width: double.infinity,
        height: context.height * 0.1,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(Sizes.radius12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.paddingH12,
            vertical: Sizes.paddingV12,
          ),
          child: Row(
            spacing: Sizes.marginH8,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(event.icon, size: Sizes.icon28),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.date.formattedAmPm,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (event.note != null)
                      Flexible(
                        child: Text(
                          event.note!,
                          style: theme.textTheme.bodySmall,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  if (event.type == EventType.firstDate) {
                    return null;
                  } else {
                    // Handle other event types
                  }
                },
                icon: Icon(icon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
