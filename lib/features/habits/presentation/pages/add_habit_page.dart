import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen for adding a new habit
class AddHabitPage extends ConsumerStatefulWidget {
  const AddHabitPage({super.key});

  @override
  ConsumerState<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends ConsumerState<AddHabitPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _habitType = 'bad';

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Habit'),
        actions: [TextButton(onPressed: _saveHabit, child: const Text('Save'))],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Habit Name',
                  hintText: 'Enter habit name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a habit name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter habit description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              Text(
                'Habit Type',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Bad Habit'),
                      subtitle: const Text('Habit to quit'),
                      value: 'bad',
                      groupValue: _habitType,
                      onChanged: (value) {
                        setState(() {
                          _habitType = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Good Habit'),
                      subtitle: const Text('Habit to build'),
                      value: 'good',
                      groupValue: _habitType,
                      onChanged: (value) {
                        setState(() {
                          _habitType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveHabit,
                  child: const Text('Create Habit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveHabit() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement habit saving logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Habit "${_nameController.text}" created! (TODO: Implement saving)',
          ),
        ),
      );

      // Navigate back
      context.pop();
    }
  }
}
