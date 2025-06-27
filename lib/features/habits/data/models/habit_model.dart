import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/habit.dart';

part 'habit_model.g.dart';

/// Data model for Habit entity with JSON and SQLite support
///
/// This model extends the domain Habit entity and adds serialization
/// capabilities for database storage and JSON import/export.
@JsonSerializable()
class HabitModel extends Habit {
  const HabitModel({
    required super.id,
    required super.name,
    required super.description,
    required super.type,
    required super.category,
    required super.createdAt,
    required super.updatedAt,
    super.lastRelapseDate,
    required super.startDate,
    super.currentStreak = 0,
    super.bestStreak = 0,
    super.totalRelapses = 0,
    super.totalSuccessDays = 0,
    super.isActive = true,
    super.targetDays,
    super.notes,
  });

  /// Creates a HabitModel from a Habit entity
  factory HabitModel.fromEntity(Habit habit) {
    return HabitModel(
      id: habit.id,
      name: habit.name,
      description: habit.description,
      type: habit.type,
      category: habit.category,
      createdAt: habit.createdAt,
      updatedAt: habit.updatedAt,
      lastRelapseDate: habit.lastRelapseDate,
      startDate: habit.startDate,
      currentStreak: habit.currentStreak,
      bestStreak: habit.bestStreak,
      totalRelapses: habit.totalRelapses,
      totalSuccessDays: habit.totalSuccessDays,
      isActive: habit.isActive,
      targetDays: habit.targetDays,
      notes: habit.notes,
    );
  }

  /// Creates a HabitModel from JSON
  factory HabitModel.fromJson(Map<String, dynamic> json) =>
      _$HabitModelFromJson(json);

  /// Converts this model to JSON
  Map<String, dynamic> toJson() => _$HabitModelToJson(this);

  /// Creates a HabitModel from a SQLite database map
  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      type: HabitType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => HabitType.bad,
      ),
      category: HabitCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => HabitCategory.other,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      lastRelapseDate: map['last_relapse_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['last_relapse_date'] as int)
          : null,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['start_date'] as int),
      currentStreak: map['current_streak'] as int? ?? 0,
      bestStreak: map['best_streak'] as int? ?? 0,
      totalRelapses: map['total_relapses'] as int? ?? 0,
      totalSuccessDays: map['total_success_days'] as int? ?? 0,
      isActive: (map['is_active'] as int? ?? 1) == 1,
      targetDays: map['target_days'] as int?,
      notes: map['notes'] as String?,
    );
  }

  /// Converts this model to a SQLite database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.name,
      'category': category.name,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'last_relapse_date': lastRelapseDate?.millisecondsSinceEpoch,
      'start_date': startDate.millisecondsSinceEpoch,
      'current_streak': currentStreak,
      'best_streak': bestStreak,
      'total_relapses': totalRelapses,
      'total_success_days': totalSuccessDays,
      'is_active': isActive ? 1 : 0,
      'target_days': targetDays,
      'notes': notes,
    };
  }

  /// Creates a copy of this model with updated values
  @override
  HabitModel copyWith({
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
    return HabitModel(
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

  /// Converts this model to a domain entity
  Habit toEntity() {
    return Habit(
      id: id,
      name: name,
      description: description,
      type: type,
      category: category,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastRelapseDate: lastRelapseDate,
      startDate: startDate,
      currentStreak: currentStreak,
      bestStreak: bestStreak,
      totalRelapses: totalRelapses,
      totalSuccessDays: totalSuccessDays,
      isActive: isActive,
      targetDays: targetDays,
      notes: notes,
    );
  }

  @override
  String toString() {
    return 'HabitModel(id: $id, name: $name, type: $type, category: $category, '
        'currentStreak: $currentStreak, isActive: $isActive)';
  }
}
