import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routing.dart';

/// Screen for viewing habit details
class HabitDetailPage extends ConsumerWidget {
  final String habitId;

  const HabitDetailPage({super.key, required this.habitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.pushNamed(
              AppRoutes.editHabitName,
              pathParameters: {AppRoutes.idParam: habitId},
            ),
            tooltip: 'Edit Habit',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Habit ID: $habitId',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'This is a placeholder for habit details.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Features to implement:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text('• Habit information display'),
                    const Text('• Progress tracking'),
                    const Text('• Relapse/success buttons'),
                    const Text('• History timeline'),
                    const Text('• Statistics'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement relapse tracking
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Relapse recorded (TODO)'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.warning),
                    label: const Text('Record Relapse'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement success tracking
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Success recorded (TODO)'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Mark Success'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
