import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen for editing an existing habit
class EditHabitPage extends ConsumerStatefulWidget {
  final String habitId;

  const EditHabitPage({super.key, required this.habitId});

  @override
  ConsumerState<EditHabitPage> createState() => _EditHabitPageState();
}

class _EditHabitPageState extends ConsumerState<EditHabitPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _habitType = 'bad';

  @override
  void initState() {
    super.initState();
    _loadHabitData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _loadHabitData() {
    // TODO: Load habit data from repository
    // For now, populate with dummy data
    _nameController.text = 'Sample Habit ${widget.habitId}';
    _descriptionController.text = 'This is a sample habit description';
    _habitType = 'bad';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Habit'),
        actions: [
          TextButton(onPressed: _saveChanges, child: const Text('Save')),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteConfirmation();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete Habit'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
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
                        'Editing Habit ID: ${widget.habitId}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 16),
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement habit update logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Habit "${_nameController.text}" updated! (TODO: Implement saving)',
          ),
        ),
      );

      // Navigate back
      context.pop();
    }
  }

  void _showDeleteConfirmation() {
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Habit'),
        content: const Text(
          'Are you sure you want to delete this habit? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true) {
        _deleteHabit();
      }
    });
  }

  void _deleteHabit() {
    // TODO: Implement habit deletion logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Habit "${_nameController.text}" deleted! (TODO: Implement deletion)',
        ),
      ),
    );

    // Navigate back to home
    context.go('/');
  }
}
