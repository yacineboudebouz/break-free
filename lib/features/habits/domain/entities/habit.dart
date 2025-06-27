import 'package:equatable/equatable.dart';

/// Represents the type of habit
enum HabitType {
  /// Bad habits that user wants to quit
  bad,

  /// Good habits that user wants to develop
  good,
}

/// Represents the category of a habit
enum HabitCategory {
  health,
  productivity,
  social,
  personal,
  addiction,
  fitness,
  mindfulness,
  other,
}

/// Domain entity representing a habit
///
/// This is the core domain model for habits, containing all the business logic
/// and validation rules for habit management.
class Habit extends Equatable {
  /// Unique identifier for the habit
  final String id;

  /// Name of the habit
  final String name;

  /// Detailed description of the habit
  final String description;

  /// Type of habit (good or bad)
  final HabitType type;

  /// Category the habit belongs to
  final HabitCategory category;

  /// Date when the habit was created
  final DateTime createdAt;

  /// Date when the habit was last updated
  final DateTime updatedAt;

  /// Date when the user last had a relapse/failure (for bad habits)
  /// or last missed the habit (for good habits)
  final DateTime? lastRelapseDate;

  /// Date when the user started tracking this habit
  final DateTime startDate;

  /// Current streak count (days without relapse for bad habits,
  /// days with success for good habits)
  final int currentStreak;

  /// Best streak achieved for this habit
  final int bestStreak;

  /// Total number of relapses/failures
  final int totalRelapses;

  /// Total number of successful days
  final int totalSuccessDays;

  /// Whether the habit is currently active
  final bool isActive;

  /// Target number of days for the habit goal
  final int? targetDays;

  /// Custom notes about the habit
  final String? notes;

  const Habit({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    this.lastRelapseDate,
    required this.startDate,
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.totalRelapses = 0,
    this.totalSuccessDays = 0,
    this.isActive = true,
    this.targetDays,
    this.notes,
  });

  /// Creates a copy of this habit with the given fields replaced with new values
  Habit copyWith({
    String? id,
    String? name,
    String? description,
    HabitType? type,
    HabitCategory? category,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastRelapseDate,
    DateTime? startDate,
    int? currentStreak,
    int? bestStreak,
    int? totalRelapses,
    int? totalSuccessDays,
    bool? isActive,
    int? targetDays,
    String? notes,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastRelapseDate: lastRelapseDate ?? this.lastRelapseDate,
      startDate: startDate ?? this.startDate,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      totalRelapses: totalRelapses ?? this.totalRelapses,
      totalSuccessDays: totalSuccessDays ?? this.totalSuccessDays,
      isActive: isActive ?? this.isActive,
      targetDays: targetDays ?? this.targetDays,
      notes: notes ?? this.notes,
    );
  }

  /// Validates the habit data
  ///
  /// Returns a list of validation errors, empty if valid
  List<String> validate() {
    final errors = <String>[];

    if (name.trim().isEmpty) {
      errors.add('Habit name cannot be empty');
    }

    if (name.trim().length > 100) {
      errors.add('Habit name cannot exceed 100 characters');
    }

    if (description.trim().length > 500) {
      errors.add('Habit description cannot exceed 500 characters');
    }

    if (currentStreak < 0) {
      errors.add('Current streak cannot be negative');
    }

    if (bestStreak < 0) {
      errors.add('Best streak cannot be negative');
    }

    if (totalRelapses < 0) {
      errors.add('Total relapses cannot be negative');
    }

    if (totalSuccessDays < 0) {
      errors.add('Total success days cannot be negative');
    }

    if (targetDays != null && targetDays! <= 0) {
      errors.add('Target days must be greater than 0');
    }

    if (startDate.isAfter(DateTime.now())) {
      errors.add('Start date cannot be in the future');
    }

    if (createdAt.isAfter(DateTime.now())) {
      errors.add('Created date cannot be in the future');
    }

    if (updatedAt.isBefore(createdAt)) {
      errors.add('Updated date cannot be before created date');
    }

    if (lastRelapseDate != null && lastRelapseDate!.isBefore(startDate)) {
      errors.add('Last relapse date cannot be before start date');
    }

    return errors;
  }

  /// Checks if the habit is valid
  bool get isValid => validate().isEmpty;

  /// Gets the number of days since the habit was started
  int get daysSinceStart {
    final now = DateTime.now();
    return now.difference(startDate).inDays;
  }

  /// Gets the number of days since the last relapse
  /// Returns null if no relapse has occurred
  int? get daysSinceLastRelapse {
    if (lastRelapseDate == null) return null;
    final now = DateTime.now();
    return now.difference(lastRelapseDate!).inDays;
  }

  /// Calculates the success rate as a percentage
  double get successRate {
    final totalDays = daysSinceStart;
    if (totalDays == 0) return 0.0;
    return (totalSuccessDays / totalDays) * 100;
  }

  /// Checks if the habit has reached its target
  bool get hasReachedTarget {
    if (targetDays == null) return false;
    return currentStreak >= targetDays!;
  }

  /// Gets a motivational message based on the habit's progress
  String get motivationalMessage {
    if (hasReachedTarget) {
      return "🎉 Congratulations! You've reached your target!";
    }

    if (currentStreak == 0) {
      return type == HabitType.bad
          ? "💪 Every moment is a new chance to resist temptation!"
          : "🌱 Today is the perfect day to start building this habit!";
    }

    if (currentStreak == bestStreak && currentStreak > 0) {
      return "🔥 You're on your best streak ever! Keep it up!";
    }

    if (currentStreak >= 7) {
      return "⭐ Amazing! You've got a solid week going!";
    }

    if (currentStreak >= 3) {
      return "🚀 Great momentum! You're building something powerful!";
    }

    return "✨ Every day counts. You've got this!";
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    type,
    category,
    createdAt,
    updatedAt,
    lastRelapseDate,
    startDate,
    currentStreak,
    bestStreak,
    totalRelapses,
    totalSuccessDays,
    isActive,
    targetDays,
    notes,
  ];

  @override
  String toString() {
    return 'Habit(id: $id, name: $name, type: $type, category: $category, '
        'currentStreak: $currentStreak, isActive: $isActive)';
  }
}
