class RelapseModel {
  int id;
  DateTime date;
  String? note;
  RelapseModel({required this.id, required this.date, this.note});

  RelapseModel copyWith({int? id, DateTime? date, String? note}) {
    return RelapseModel(
      id: id ?? this.id,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'note': note,
    };
  }

  factory RelapseModel.fromMap(Map<String, dynamic> map) {
    return RelapseModel(
      id: map['id'] as int,
      date: DateTime.parse(map['relapse_date'] as String),
      note: map['note'] != null ? map['note'] as String : null,
    );
  }

  @override
  String toString() {
    return 'RelapseModel(id: $id, date: $date, note: $note)';
  }
}
