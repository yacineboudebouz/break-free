// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bad_habit_killer/src/core/presentation/extensions/datetime_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/features/home/domain/event_model.dart';
import 'package:flutter/services.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/database_colors.dart';
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
    List<RelapseModel>? relapses,
  }) {
    return HabitModel(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      description: description ?? this.description,
      color: color ?? this.color,
      relapses: relapses ?? this.relapses,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'start_date': startDate.toString(),
      'description': description,
      'color': color,
    };
  }

  Color get colorValue {
    return DatabaseColors.fromString(color);
  }

  int get attempt => relapses.length + 1;
  DateTime get lastRelapseDate {
    if (relapses.isEmpty) {
      return startDate;
    }
    final sortedByDate =
        relapses.where((relapse) => relapse.date.isAfter(startDate)).toList()
          ..sort((a, b) => a.date.compareTo(b.date));
    return sortedByDate.last.date;
  }

  int get currentProgress {
    final differenceInSeconds = DateTime.now()
        .difference(lastRelapseDate)
        .inSeconds;
    return differenceInSeconds;
  }

  int get record {
    if (relapses.isEmpty) {
      return currentProgress ~/ 86400;
    }
    final maxDays = relapses.fold<int>(0, (max, relapse) {
      final daysSinceLastRelapse = relapse.date.difference(startDate).inDays;
      return daysSinceLastRelapse > max ? daysSinceLastRelapse : max;
    });
    return maxDays;
  }

  int get goal {
    return goals.firstWhere((goal) => goal > currentProgress / 86400);
  }

  double get progress {
    final goalValue = goal.toDouble() * 86400;
    return (currentProgress / goalValue).clamp(0.0, 1.0);
  }

  List<EventModel>? _cachedEvents;

  List<EventModel> get events {
    if (_cachedEvents != null) {
      return _cachedEvents!;
    }

    List<EventModel> list = [];
    final _relapses = relapses.toList();

    // Sort relapses by ascending date for proper streak calculation
    _relapses.sort((a, b) => a.date.compareTo(b.date));

    list.add(
      EventModel(
        id: 999,
        date: startDate,
        type: EventType.firstDate,
        note: "A new journey begins!".hardcoded,
      ),
    );
    DateTime prevDate = startDate;
    for (var relapse in _relapses) {
      final streakDuration = relapse.date.difference(prevDate);
      list.add(
        EventModel(
          id: relapse.id,
          date: relapse.date,
          note:
              relapse.note ??
              'Streak before relapse: ${relapse.date.differenceFormatted(prevDate)}',
          type: EventType.relapse,
        ),
      );
      prevDate = relapse.date;
    }
    list.sort((a, b) => b.date.compareTo(a.date));

    _cachedEvents = list;
    return list;
  }

  static List<int> goals = [
    3,
    7,
    14,
    21,
    30,
    60,
    90,
    120,
    150,
    180,
    210,
    240,
    270,
    300,
    330,
    365,
    730,
    995,
    1095,
    1460,
    1825,
    2190,
    2555,
    2920,
    3285,
    3650,
    4015,
    4380,
    4745,
    5110,
    5475,
    5840,
    6205,
    6570,
    6935,
    7300,
  ];

  @override
  String toString() {
    return 'HabitModel(id: $id, name: $name, startDate: $startDate, description: $description, color: $color, relapses: $relapses)';
  }
}
