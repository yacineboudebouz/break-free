import 'package:bad_habit_killer/features/habits/domain/providers/usecase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../domain/domain.dart';
import '../../../../core/utils/logger.dart';

part 'add_habit_notifier.g.dart';

/// State for the add habit form
class AddHabitState {
  final String name;
  final String description;
  final HabitType type;
  final HabitCategory category;
  final DateTime? startDate;
  final int? targetDays;
  final String? notes;
  final bool isLoading;
  final String? error;
  final Map<String, String> fieldErrors;
  final bool isFormValid;

  const AddHabitState({
    this.name = '',
    this.description = '',
    this.type = HabitType.bad,
    this.category = HabitCategory.other,
    this.startDate,
    this.targetDays,
    this.notes,
    this.isLoading = false,
    this.error,
    this.fieldErrors = const {},
    this.isFormValid = false,
  });

  AddHabitState copyWith({
    String? name,
    String? description,
    HabitType? type,
    HabitCategory? category,
    DateTime? startDate,
    int? targetDays,
    String? notes,
    bool? isLoading,
    String? error,
    Map<String, String>? fieldErrors,
    bool? isFormValid,
  }) {
    return AddHabitState(
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      category: category ?? this.category,
      startDate: startDate ?? this.startDate,
      targetDays: targetDays ?? this.targetDays,
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      fieldErrors: fieldErrors ?? this.fieldErrors,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddHabitState &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          type == other.type &&
          category == other.category &&
          startDate == other.startDate &&
          targetDays == other.targetDays &&
          notes == other.notes &&
          isLoading == other.isLoading &&
          error == other.error &&
          fieldErrors == other.fieldErrors &&
          isFormValid == other.isFormValid;

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      type.hashCode ^
      category.hashCode ^
      startDate.hashCode ^
      targetDays.hashCode ^
      notes.hashCode ^
      isLoading.hashCode ^
      error.hashCode ^
      fieldErrors.hashCode ^
      isFormValid.hashCode;
}

/// Notifier for managing add habit form state and operations
@riverpod
class AddHabitNotifier extends _$AddHabitNotifier {
  late final AddHabit _addHabitUseCase;

  @override
  AddHabitState build() {
    _addHabitUseCase = ref.watch(addHabitUseCaseProvider);
    return AddHabitState(
      startDate: DateTime.now(), // Default to today
    );
  }

  /// Updates the habit name and validates it
  void updateName(String name) {
    final trimmedName = name.trim();
    final fieldErrors = Map<String, String>.from(state.fieldErrors);

    // Validate name
    if (trimmedName.isEmpty) {
      fieldErrors['name'] = 'Habit name is required';
    } else if (trimmedName.length > 100) {
      fieldErrors['name'] = 'Habit name cannot exceed 100 characters';
    } else {
      fieldErrors.remove('name');
    }

    state = state.copyWith(
      name: name,
      fieldErrors: fieldErrors,
      isFormValid: _isFormValid(fieldErrors),
    );
  }

  /// Updates the habit description and validates it
  void updateDescription(String description) {
    final fieldErrors = Map<String, String>.from(state.fieldErrors);

    // Validate description
    if (description.trim().length > 500) {
      fieldErrors['description'] = 'Description cannot exceed 500 characters';
    } else {
      fieldErrors.remove('description');
    }

    state = state.copyWith(
      description: description,
      fieldErrors: fieldErrors,
      isFormValid: _isFormValid(fieldErrors),
    );
  }

  /// Updates the habit type
  void updateType(HabitType type) {
    state = state.copyWith(type: type);
  }

  /// Updates the habit category
  void updateCategory(HabitCategory category) {
    state = state.copyWith(category: category);
  }

  /// Updates the start date and validates it
  void updateStartDate(DateTime startDate) {
    final fieldErrors = Map<String, String>.from(state.fieldErrors);

    // Validate start date
    if (startDate.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      fieldErrors['startDate'] = 'Start date cannot be in the future';
    } else {
      fieldErrors.remove('startDate');
    }

    state = state.copyWith(
      startDate: startDate,
      fieldErrors: fieldErrors,
      isFormValid: _isFormValid(fieldErrors),
    );
  }

  /// Updates the target days and validates it
  void updateTargetDays(int? targetDays) {
    final fieldErrors = Map<String, String>.from(state.fieldErrors);

    // Validate target days
    if (targetDays != null && targetDays <= 0) {
      fieldErrors['targetDays'] = 'Target days must be greater than 0';
    } else if (targetDays != null && targetDays > 3650) {
      // 10 years max
      fieldErrors['targetDays'] =
          'Target days cannot exceed 10 years (3650 days)';
    } else {
      fieldErrors.remove('targetDays');
    }

    state = state.copyWith(
      targetDays: targetDays,
      fieldErrors: fieldErrors,
      isFormValid: _isFormValid(fieldErrors),
    );
  }

  /// Updates the notes
  void updateNotes(String? notes) {
    state = state.copyWith(notes: notes);
  }

  /// Validates all fields and returns validation errors
  Map<String, String> _validateAllFields() {
    final errors = <String, String>{};

    // Validate name
    final trimmedName = state.name.trim();
    if (trimmedName.isEmpty) {
      errors['name'] = 'Habit name is required';
    } else if (trimmedName.length > 100) {
      errors['name'] = 'Habit name cannot exceed 100 characters';
    }

    // Validate description
    if (state.description.trim().length > 500) {
      errors['description'] = 'Description cannot exceed 500 characters';
    }

    // Validate start date
    if (state.startDate != null &&
        state.startDate!.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      errors['startDate'] = 'Start date cannot be in the future';
    }

    // Validate target days
    if (state.targetDays != null && state.targetDays! <= 0) {
      errors['targetDays'] = 'Target days must be greater than 0';
    } else if (state.targetDays != null && state.targetDays! > 3650) {
      errors['targetDays'] = 'Target days cannot exceed 10 years (3650 days)';
    }

    return errors;
  }

  /// Checks if the form is valid based on field errors
  bool _isFormValid(Map<String, String> fieldErrors) {
    return fieldErrors.isEmpty && state.name.trim().isNotEmpty;
  }

  /// Validates the entire form
  bool validateForm() {
    final errors = _validateAllFields();
    state = state.copyWith(
      fieldErrors: errors,
      isFormValid: _isFormValid(errors),
    );
    return state.isFormValid;
  }

  /// Creates a new habit
  Future<bool> createHabit() async {
    try {
      // Validate form first
      if (!validateForm()) {
        AppLogger.warning('Form validation failed, cannot create habit');
        return false;
      }

      // Set loading state
      state = state.copyWith(isLoading: true, error: null);

      // Create habit entity
      final habit = Habit(
        id: const Uuid().v4(),
        name: state.name.trim(),
        description: state.description.trim(),
        type: state.type,
        category: state.category,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        startDate: state.startDate ?? DateTime.now(),
        targetDays: state.targetDays,
        notes: state.notes?.trim().isEmpty == true ? null : state.notes?.trim(),
      );

      // Call use case
      final result = await _addHabitUseCase(AddHabitParams(habit: habit));

      return result.fold(
        (failure) {
          AppLogger.error('Failed to create habit: ${failure.message}');
          state = state.copyWith(isLoading: false, error: failure.message);
          return false;
        },
        (createdHabit) {
          AppLogger.info('Successfully created habit: ${createdHabit.name}');
          state = state.copyWith(isLoading: false, error: null);
          return true;
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error creating habit', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred while creating the habit',
      );
      return false;
    }
  }

  /// Resets the form to initial state
  void resetForm() {
    state = AddHabitState(startDate: DateTime.now());
  }

  /// Clears any error state
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Gets the error message for a specific field
  String? getFieldError(String fieldName) {
    return state.fieldErrors[fieldName];
  }

  /// Checks if a specific field has an error
  bool hasFieldError(String fieldName) {
    return state.fieldErrors.containsKey(fieldName);
  }
}
