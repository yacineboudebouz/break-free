import 'package:equatable/equatable.dart';

/// Represents the type of relapse/event
enum RelapseType {
  /// User had a relapse/failure (for bad habits)
  relapse,

  /// User successfully completed the habit (for good habits)
  success,

  /// User missed/skipped the habit (for good habits)
  missed,

  /// User reset their streak manually
  reset,
}

/// Domain entity representing a relapse or habit event
///
/// This entity tracks all events related to a habit, including relapses,
/// successes, misses, and manual resets. It provides a complete history
/// of the user's interaction with their habits.
class Relapse extends Equatable {
  /// Unique identifier for the relapse/event
  final String id;

  /// ID of the habit this relapse/event belongs to
  final String habitId;

  /// Type of event (relapse, success, missed, reset)
  final RelapseType type;

  /// Date and time when the event occurred
  final DateTime date;

  /// Optional note about the event
  final String? note;

  /// Trigger that led to the relapse (for bad habits)
  final String? trigger;

  /// Emotion the user was feeling during the event
  final String? emotion;

  /// Location where the event occurred
  final String? location;

  /// Intensity level of the urge/temptation (1-10 scale)
  final int? intensityLevel;

  /// Duration of the relapse/activity in minutes
  final int? durationMinutes;

  /// Whether the user felt guilty about this event
  final bool feltGuilty;

  /// Lessons learned from this event
  final String? lessonsLearned;

  /// Recovery plan or next steps
  final String? recoveryPlan;

  /// Date when this record was created
  final DateTime createdAt;

  /// Date when this record was last updated
  final DateTime updatedAt;

  const Relapse({
    required this.id,
    required this.habitId,
    required this.type,
    required this.date,
    this.note,
    this.trigger,
    this.emotion,
    this.location,
    this.intensityLevel,
    this.durationMinutes,
    this.feltGuilty = false,
    this.lessonsLearned,
    this.recoveryPlan,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a copy of this relapse with the given fields replaced with new values
  Relapse copyWith({
    String? id,
    String? habitId,
    RelapseType? type,
    DateTime? date,
    String? note,
    String? trigger,
    String? emotion,
    String? location,
    int? intensityLevel,
    int? durationMinutes,
    bool? feltGuilty,
    String? lessonsLearned,
    String? recoveryPlan,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Relapse(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      type: type ?? this.type,
      date: date ?? this.date,
      note: note ?? this.note,
      trigger: trigger ?? this.trigger,
      emotion: emotion ?? this.emotion,
      location: location ?? this.location,
      intensityLevel: intensityLevel ?? this.intensityLevel,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      feltGuilty: feltGuilty ?? this.feltGuilty,
      lessonsLearned: lessonsLearned ?? this.lessonsLearned,
      recoveryPlan: recoveryPlan ?? this.recoveryPlan,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Validates the relapse data
  ///
  /// Returns a list of validation errors, empty if valid
  List<String> validate() {
    final errors = <String>[];

    if (habitId.trim().isEmpty) {
      errors.add('Habit ID cannot be empty');
    }

    if (note != null && note!.length > 1000) {
      errors.add('Note cannot exceed 1000 characters');
    }

    if (trigger != null && trigger!.length > 200) {
      errors.add('Trigger cannot exceed 200 characters');
    }

    if (emotion != null && emotion!.length > 100) {
      errors.add('Emotion cannot exceed 100 characters');
    }

    if (location != null && location!.length > 200) {
      errors.add('Location cannot exceed 200 characters');
    }

    if (intensityLevel != null &&
        (intensityLevel! < 1 || intensityLevel! > 10)) {
      errors.add('Intensity level must be between 1 and 10');
    }

    if (durationMinutes != null && durationMinutes! < 0) {
      errors.add('Duration cannot be negative');
    }

    if (lessonsLearned != null && lessonsLearned!.length > 500) {
      errors.add('Lessons learned cannot exceed 500 characters');
    }

    if (recoveryPlan != null && recoveryPlan!.length > 500) {
      errors.add('Recovery plan cannot exceed 500 characters');
    }

    if (date.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      errors.add('Date cannot be more than 1 day in the future');
    }

    if (createdAt.isAfter(DateTime.now())) {
      errors.add('Created date cannot be in the future');
    }

    if (updatedAt.isBefore(createdAt)) {
      errors.add('Updated date cannot be before created date');
    }

    return errors;
  }

  /// Checks if the relapse data is valid
  bool get isValid => validate().isEmpty;

  /// Checks if this is a negative event (relapse or miss)
  bool get isNegativeEvent =>
      type == RelapseType.relapse || type == RelapseType.missed;

  /// Checks if this is a positive event (success)
  bool get isPositiveEvent => type == RelapseType.success;

  /// Checks if this event happened today
  bool get happenedToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDate = DateTime(date.year, date.month, date.day);
    return today.isAtSameMomentAs(eventDate);
  }

  /// Gets the number of days ago this event occurred
  int get daysAgo {
    final now = DateTime.now();
    return now.difference(date).inDays;
  }

  /// Gets a human-readable time description
  String get timeAgo {
    final days = daysAgo;

    if (days == 0) return 'Today';
    if (days == 1) return 'Yesterday';
    if (days < 7) return '$days days ago';
    if (days < 30) {
      final weeks = (days / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    }
    if (days < 365) {
      final months = (days / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    }

    final years = (days / 365).floor();
    return years == 1 ? '1 year ago' : '$years years ago';
  }

  /// Gets an appropriate emoji for the event type
  String get emoji {
    switch (type) {
      case RelapseType.relapse:
        return '😞';
      case RelapseType.success:
        return '🎉';
      case RelapseType.missed:
        return '😐';
      case RelapseType.reset:
        return '🔄';
    }
  }

  /// Gets a formatted intensity description
  String? get intensityDescription {
    if (intensityLevel == null) return null;

    if (intensityLevel! <= 2) return 'Very Low';
    if (intensityLevel! <= 4) return 'Low';
    if (intensityLevel! <= 6) return 'Medium';
    if (intensityLevel! <= 8) return 'High';
    return 'Very High';
  }

  /// Gets a formatted duration description
  String? get durationDescription {
    if (durationMinutes == null) return null;

    if (durationMinutes! < 60) {
      return '$durationMinutes minutes';
    }

    final hours = durationMinutes! ~/ 60;
    final minutes = durationMinutes! % 60;

    if (minutes == 0) {
      return hours == 1 ? '1 hour' : '$hours hours';
    }

    return '$hours hours $minutes minutes';
  }

  @override
  List<Object?> get props => [
    id,
    habitId,
    type,
    date,
    note,
    trigger,
    emotion,
    location,
    intensityLevel,
    durationMinutes,
    feltGuilty,
    lessonsLearned,
    recoveryPlan,
    createdAt,
    updatedAt,
  ];

  @override
  String toString() {
    return 'Relapse(id: $id, habitId: $habitId, type: $type, '
        'date: $date, intensityLevel: $intensityLevel)';
  }
}
