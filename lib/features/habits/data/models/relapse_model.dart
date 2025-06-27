import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/relapse.dart';

part 'relapse_model.g.dart';

/// Data model for Relapse entity with JSON and SQLite support
///
/// This model extends the domain Relapse entity and adds serialization
/// capabilities for database storage and JSON import/export.
@JsonSerializable()
class RelapseModel extends Relapse {
  const RelapseModel({
    required super.id,
    required super.habitId,
    required super.type,
    required super.date,
    super.note,
    super.trigger,
    super.emotion,
    super.location,
    super.intensityLevel,
    super.durationMinutes,
    super.feltGuilty = false,
    super.lessonsLearned,
    super.recoveryPlan,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Creates a RelapseModel from a Relapse entity
  factory RelapseModel.fromEntity(Relapse relapse) {
    return RelapseModel(
      id: relapse.id,
      habitId: relapse.habitId,
      type: relapse.type,
      date: relapse.date,
      note: relapse.note,
      trigger: relapse.trigger,
      emotion: relapse.emotion,
      location: relapse.location,
      intensityLevel: relapse.intensityLevel,
      durationMinutes: relapse.durationMinutes,
      feltGuilty: relapse.feltGuilty,
      lessonsLearned: relapse.lessonsLearned,
      recoveryPlan: relapse.recoveryPlan,
      createdAt: relapse.createdAt,
      updatedAt: relapse.updatedAt,
    );
  }

  /// Creates a RelapseModel from JSON
  factory RelapseModel.fromJson(Map<String, dynamic> json) =>
      _$RelapseModelFromJson(json);

  /// Converts this model to JSON
  Map<String, dynamic> toJson() => _$RelapseModelToJson(this);

  /// Creates a RelapseModel from a SQLite database map
  factory RelapseModel.fromMap(Map<String, dynamic> map) {
    return RelapseModel(
      id: map['id'] as String,
      habitId: map['habit_id'] as String,
      type: RelapseType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => RelapseType.relapse,
      ),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      note: map['note'] as String?,
      trigger: map['trigger'] as String?,
      emotion: map['emotion'] as String?,
      location: map['location'] as String?,
      intensityLevel: map['intensity_level'] as int?,
      durationMinutes: map['duration_minutes'] as int?,
      feltGuilty: (map['felt_guilty'] as int? ?? 0) == 1,
      lessonsLearned: map['lessons_learned'] as String?,
      recoveryPlan: map['recovery_plan'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  /// Converts this model to a SQLite database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'habit_id': habitId,
      'type': type.name,
      'date': date.millisecondsSinceEpoch,
      'note': note,
      'trigger': trigger,
      'emotion': emotion,
      'location': location,
      'intensity_level': intensityLevel,
      'duration_minutes': durationMinutes,
      'felt_guilty': feltGuilty ? 1 : 0,
      'lessons_learned': lessonsLearned,
      'recovery_plan': recoveryPlan,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  /// Creates a copy of this model with updated values
  @override
  RelapseModel copyWith({
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
    return RelapseModel(
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

  /// Converts this model to a domain entity
  Relapse toEntity() {
    return Relapse(
      id: id,
      habitId: habitId,
      type: type,
      date: date,
      note: note,
      trigger: trigger,
      emotion: emotion,
      location: location,
      intensityLevel: intensityLevel,
      durationMinutes: durationMinutes,
      feltGuilty: feltGuilty,
      lessonsLearned: lessonsLearned,
      recoveryPlan: recoveryPlan,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  String toString() {
    return 'RelapseModel(id: $id, habitId: $habitId, type: $type, '
        'date: $date, intensityLevel: $intensityLevel)';
  }
}
