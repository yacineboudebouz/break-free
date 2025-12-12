// ignore_for_file: public_member_api_docs, sort_constructors_first

class PracticeSessionModel {
  final int id;
  final int skillId;
  final DateTime practiceDate;
  final int durationMinutes;
  final String? note;

  PracticeSessionModel({
    required this.id,
    required this.skillId,
    required this.practiceDate,
    required this.durationMinutes,
    this.note,
  });

  PracticeSessionModel copyWith({
    int? id,
    int? skillId,
    DateTime? practiceDate,
    int? durationMinutes,
    String? note,
  }) {
    return PracticeSessionModel(
      id: id ?? this.id,
      skillId: skillId ?? this.skillId,
      practiceDate: practiceDate ?? this.practiceDate,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      note: note ?? this.note,
    );
  }

  factory PracticeSessionModel.fromMap(Map<String, dynamic> map) {
    return PracticeSessionModel(
      id: map['id'] as int,
      skillId: map['skill_id'] as int,
      practiceDate: DateTime.parse(map['practice_date'] as String),
      durationMinutes: map['duration_minutes'] as int,
      note: map['note'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'skill_id': skillId,
      'practice_date': practiceDate.toIso8601String(),
      'duration_minutes': durationMinutes,
      'note': note,
    };
  }

  String get formattedDuration {
    final hours = durationMinutes ~/ 60;
    final minutes = durationMinutes % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }
}
