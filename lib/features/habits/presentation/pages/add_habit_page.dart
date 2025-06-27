import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/habit.dart';
import '../providers/add_habit_notifier.dart';

/// Screen for adding a new habit
class AddHabitPage extends ConsumerWidget {
  const AddHabitPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addHabitNotifierProvider);
    final notifier = ref.read(addHabitNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Habit'),
        actions: [
          TextButton(
            onPressed: state.isLoading ? null : () => _saveHabit(context, ref),
            child: state.isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Error display
            if (state.error != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.error!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: notifier.clearError,
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ],
                ),
              ),

            // Habit name field
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Habit Name *',
                hintText: 'Enter habit name',
                border: const OutlineInputBorder(),
                errorText: notifier.getFieldError('name'),
              ),
              onChanged: notifier.updateName,
              enabled: !state.isLoading,
            ),
            const SizedBox(height: 16),

            // Description field
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter habit description',
                border: const OutlineInputBorder(),
                errorText: notifier.getFieldError('description'),
              ),
              maxLines: 3,
              onChanged: notifier.updateDescription,
              enabled: !state.isLoading,
            ),
            const SizedBox(height: 24),

            // Habit type selection
            Text('Habit Type', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<HabitType>(
                    title: const Text('Bad Habit'),
                    subtitle: const Text('Habit to quit'),
                    value: HabitType.bad,
                    groupValue: state.type,
                    onChanged: state.isLoading
                        ? null
                        : (value) => notifier.updateType(value!),
                  ),
                ),
                Expanded(
                  child: RadioListTile<HabitType>(
                    title: const Text('Good Habit'),
                    subtitle: const Text('Habit to build'),
                    value: HabitType.good,
                    groupValue: state.type,
                    onChanged: state.isLoading
                        ? null
                        : (value) => notifier.updateType(value!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Category selection
            Text('Category', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            DropdownButtonFormField<HabitCategory>(
              value: state.category,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select category',
              ),
              items: HabitCategory.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(_getCategoryDisplayName(category)),
                );
              }).toList(),
              onChanged: state.isLoading
                  ? null
                  : (value) => notifier.updateCategory(value!),
            ),
            const SizedBox(height: 24),

            // Start date selection
            Text('Start Date', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            InkWell(
              onTap: state.isLoading
                  ? null
                  : () => _selectStartDate(context, ref),
              child: InputDecorator(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: notifier.getFieldError('startDate'),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.startDate != null
                          ? _formatDate(state.startDate!)
                          : 'Select start date',
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Target days (optional)
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Target Days (Optional)',
                hintText: 'e.g., 30, 90, 365',
                border: const OutlineInputBorder(),
                errorText: notifier.getFieldError('targetDays'),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final parsed = int.tryParse(value);
                notifier.updateTargetDays(parsed);
              },
              enabled: !state.isLoading,
            ),
            const SizedBox(height: 24),

            // Notes field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Notes (Optional)',
                hintText: 'Additional notes about this habit',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: notifier.updateNotes,
              enabled: !state.isLoading,
            ),
            const SizedBox(height: 32),

            // Create button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (state.isFormValid && !state.isLoading)
                    ? () => _saveHabit(context, ref)
                    : null,
                child: state.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Create Habit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveHabit(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(addHabitNotifierProvider.notifier);

    final success = await notifier.createHabit();
    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Habit created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      context.pop();
    }
  }

  Future<void> _selectStartDate(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(addHabitNotifierProvider.notifier);
    final currentDate =
        ref.read(addHabitNotifierProvider).startDate ?? DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );

    if (selectedDate != null) {
      notifier.updateStartDate(selectedDate);
    }
  }

  String _getCategoryDisplayName(HabitCategory category) {
    switch (category) {
      case HabitCategory.health:
        return 'Health';
      case HabitCategory.productivity:
        return 'Productivity';
      case HabitCategory.social:
        return 'Social';
      case HabitCategory.personal:
        return 'Personal';
      case HabitCategory.addiction:
        return 'Addiction';
      case HabitCategory.fitness:
        return 'Fitness';
      case HabitCategory.mindfulness:
        return 'Mindfulness';
      case HabitCategory.other:
        return 'Other';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
