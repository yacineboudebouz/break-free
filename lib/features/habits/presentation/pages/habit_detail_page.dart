import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routing.dart';
import '../providers/habit_detail_notifier.dart';

/// Screen for viewing habit details
class HabitDetailPage extends ConsumerWidget {
  final String habitId;

  const HabitDetailPage({super.key, required this.habitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the habit detail state
    final detailState = ref.watch(habitDetailNotifierProvider(habitId));
    final stats = ref.watch(habitDetailStatsProvider(habitId));

    return Scaffold(
      appBar: AppBar(
        title: Text(detailState.habit?.name ?? 'Habit Details'),
        actions: [
          if (detailState.habit != null)
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
      body: detailState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : detailState.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        detailState.error!,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref
                            .read(habitDetailNotifierProvider(habitId).notifier)
                            .refresh(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : detailState.habit == null
                  ? const Center(child: Text('Habit not found'))
                  : RefreshIndicator(
                      onRefresh: () => ref
                          .read(habitDetailNotifierProvider(habitId).notifier)
                          .refresh(),
                      child: _buildHabitDetails(context, ref, detailState, stats),
                    ),
    );
  }

  Widget _buildHabitDetails(
    BuildContext context,
    WidgetRef ref,
    HabitDetailState state,
    HabitDetailStats stats,
  ) {
    final habit = state.habit!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Habit Info Card
          _buildHabitInfoCard(context, habit),
          const SizedBox(height: 16),

          // Statistics Card
          _buildStatsCard(context, stats),
          const SizedBox(height: 16),

          // Quick Actions Card
          _buildQuickActionsCard(context, ref, habit),
        ],
      ),
    );
  }

  Widget _buildHabitInfoCard(BuildContext context, habit) {
    final theme = Theme.of(context);
    final isGoodHabit = habit.type.name == 'good';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isGoodHabit
                        ? Colors.green.withOpacity(0.2)
                        : Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isGoodHabit ? 'GOOD HABIT' : 'BAD HABIT',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isGoodHabit ? Colors.green[700] : Colors.red[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Chip(
                  label: Text(habit.category.name.toUpperCase()),
                  backgroundColor: theme.colorScheme.surfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              habit.name,
              style: theme.textTheme.headlineSmall,
            ),
            if (habit.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                habit.description,
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context, HabitDetailStats stats) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistics',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Current Streak',
                    '${stats.currentStreak} days',
                    Icons.local_fire_department,
                    Colors.orange,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Best Streak',
                    '${stats.longestStreak} days',
                    Icons.emoji_events,
                    Colors.yellow[700]!,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsCard(BuildContext context, WidgetRef ref, habit) {
    final theme = Theme.of(context);
    final isGoodHabit = habit.type.name == 'good';
    final state = ref.watch(habitDetailNotifierProvider(habitId));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (isGoodHabit) ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: state.isAddingRelapse
                          ? null
                          : () => _addSuccess(ref),
                      icon: const Icon(Icons.check_circle),
                      label: const Text('Mark Success'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: state.isAddingRelapse
                          ? null
                          : () => _addMissed(ref),
                      icon: const Icon(Icons.cancel),
                      label: const Text('Mark Missed'),
                    ),
                  ),
                ],
              ),
            ] else ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: state.isAddingRelapse
                      ? null
                      : () => _addRelapse(ref),
                  icon: const Icon(Icons.warning),
                  label: const Text('Record Relapse'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  // Helper methods for actions
  Future<void> _addRelapse(WidgetRef ref) async {
    await ref
        .read(habitDetailNotifierProvider(habitId).notifier)
        .addRelapseEvent();
  }

  Future<void> _addSuccess(WidgetRef ref) async {
    await ref
        .read(habitDetailNotifierProvider(habitId).notifier)
        .addSuccess();
  }

  Future<void> _addMissed(WidgetRef ref) async {
    await ref
        .read(habitDetailNotifierProvider(habitId).notifier)
        .addMissed();
  }
}
