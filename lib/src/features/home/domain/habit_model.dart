import 'package:bad_habit_killer/src/features/home/domain/relapse_model.dart';

class HabitModel {
  final int id;
  final String name;
  final DateTime startDate;
  final String description;
  final String color;
  final List<RelapseModel> relapses;

  HabitModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.description,
    required this.color,
    required this.relapses,
  });

  HabitModel copyWith({
    int? id,
    String? name,
    DateTime? startDate,
    String? description,
    String? color,
  }) {
    return HabitModel(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      description: description ?? this.description,
      color: color ?? this.color,
      relapses: List<RelapseModel>.from(relapses),
    );
  }

  factory HabitModel.fromMapWithRelapses(
    Map<String, dynamic> map, {
    required List<RelapseModel> relapses,
  }) => HabitModel(
    id: map['id'] as int,
    name: map['name'] as String,
    startDate: DateTime.parse(map['start_date'] as String),
    description: map['description'] as String,
    color: map['color'] as String,
    relapses: relapses,
  );
}
