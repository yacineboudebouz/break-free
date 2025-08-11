class AddRelapse {
  final int habitId;
  final DateTime relapseDate;
  final String? note;
  AddRelapse({required this.habitId, required this.relapseDate, this.note});

  AddRelapse copyWith({int? habitId, DateTime? relapseDate, String? note}) {
    return AddRelapse(
      habitId: habitId ?? this.habitId,
      relapseDate: relapseDate ?? this.relapseDate,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'habit_id': habitId,
      'relapse_date': relapseDate.toIso8601String(),
      'note': note,
    };
  }
}
