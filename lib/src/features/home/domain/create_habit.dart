// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateHabitModel {
  final String name;
  final String description;
  final String color;
  final String startDate;
  CreateHabitModel({
    required this.name,
    required this.description,
    required this.color,
    required this.startDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'color': color,
      'start_date': startDate,
    };
  }

  CreateHabitModel copyWith({
    String? name,
    String? description,
    String? color,
    String? startDate,
  }) {
    return CreateHabitModel(
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      startDate: startDate ?? this.startDate,
    );
  }

  factory CreateHabitModel.fromMap(Map<String, dynamic> map) {
    return CreateHabitModel(
      name: map['name'] as String,
      description: map['description'] as String,
      color: map['color'] as String,
      startDate: map['start_date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateHabitModel.fromJson(String source) =>
      CreateHabitModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreateHabitModel(name: $name, description: $description, color: $color, startDate: $startDate)';
  }

  @override
  bool operator ==(covariant CreateHabitModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.color == color &&
        other.startDate == startDate;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        color.hashCode ^
        startDate.hashCode;
  }
}
