// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'start_date': startDate,
      'description': description,
      'color': color,
      'relapses': relapses.map((x) => x.toMap()).toList(),
    };
  }

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'] as int,
      name: map['name'] as String,
      startDate: DateTime.parse(map['start_date'] as String),
      description: map['description'] as String,
      color: map['color'] as String,
      relapses: List<RelapseModel>.from(
        (map['relapses'] as List<dynamic>).map<RelapseModel>(
          (x) => RelapseModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
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

  String toJson() => json.encode(toMap());

  factory HabitModel.fromJson(String source) =>
      HabitModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HabitModel(id: $id, name: $name, startDate: $startDate, description: $description, color: $color,)';
  }

  @override
  bool operator ==(covariant HabitModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.startDate == startDate &&
        other.description == description &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        startDate.hashCode ^
        description.hashCode ^
        color.hashCode;
  }
}
