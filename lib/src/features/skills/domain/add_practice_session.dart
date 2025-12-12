class AddPracticeSession {
  final int skillId;
  final DateTime practiceDate;
  final int durationMinutes;
  final String? note;

  AddPracticeSession({
    required this.skillId,
    required this.practiceDate,
    required this.durationMinutes,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'skill_id': skillId,
      'practice_date': practiceDate.toIso8601String(),
      'duration_minutes': durationMinutes,
      'note': note,
    };
  }
}
