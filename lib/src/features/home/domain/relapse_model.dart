// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RelapseModel {
  int id;
  DateTime date;
  String note;
  RelapseModel({required this.id, required this.date, required this.note});

  RelapseModel copyWith({int? id, DateTime? date, String? note}) {
    return RelapseModel(
      id: id ?? this.id,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'date': date, 'note': note};
  }

  factory RelapseModel.fromMap(Map<String, dynamic> map) {
    return RelapseModel(
      id: map['id'] as int,
      date: DateTime.parse(map['date'] as String),
      note: map['note'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RelapseModel.fromJson(String source) =>
      RelapseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RelapseModel(id: $id, date: $date, note: $note)';

  @override
  bool operator ==(covariant RelapseModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.date == date && other.note == note;
  }

  @override
  int get hashCode => id.hashCode ^ date.hashCode ^ note.hashCode;
}
