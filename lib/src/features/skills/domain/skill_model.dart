// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bad_habit_killer/src/core/presentation/extensions/datetime_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/database_colors.dart';
import 'package:bad_habit_killer/src/features/skills/domain/practice_session_model.dart';
import 'package:flutter/material.dart';

class SkillModel {
  final int id;
  final String name;
  final DateTime startDate;
  final String description;
  final String color;
  final int targetHours;
  final List<PracticeSessionModel> sessions;

  SkillModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.description,
    required this.color,
    required this.targetHours,
    required this.sessions,
  });

  SkillModel copyWith({
    int? id,
    String? name,
    DateTime? startDate,
    String? description,
    String? color,
    int? targetHours,
    List<PracticeSessionModel>? sessions,
  }) {
    return SkillModel(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      description: description ?? this.description,
      color: color ?? this.color,
      targetHours: targetHours ?? this.targetHours,
      sessions: sessions ?? this.sessions,
    );
  }

  factory SkillModel.fromMapWithSessions(
    Map<String, dynamic> map, {
    required List<PracticeSessionModel> sessions,
  }) => SkillModel(
    id: map['id'] as int,
    name: map['name'] as String,
    startDate: DateTime.parse(map['start_date'] as String),
    description: map['description'] as String? ?? '',
    color: map['color'] as String,
    targetHours: map['target_hours'] as int? ?? 10000,
    sessions: sessions,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'start_date': startDate.toIso8601String(),
      'description': description,
      'color': color,
      'target_hours': targetHours,
    };
  }

  int get totalMinutesPracticed {
    return sessions.fold(0, (sum, session) => sum + session.durationMinutes);
  }

  double get totalHoursPracticed {
    return totalMinutesPracticed / 60;
  }

  double get progressPercentage {
    return (totalHoursPracticed / targetHours * 100).clamp(0, 100);
  }

  int get daysActive {
    return DateTime.now().difference(startDate).inDays;
  }

  double get hoursRemainingToMastery {
    return (targetHours - totalHoursPracticed).clamp(0, targetHours.toDouble());
  }

  Color get colorValue {
    return DatabaseColors.fromString(color);
  }

  // Calculate average practice time per day
  double get averageMinutesPerDay {
    if (daysActive == 0) return 0;
    return totalMinutesPracticed / daysActive;
  }

  // Get recent practice sessions (last 7 days)
  List<PracticeSessionModel> get recentSessions {
    final sevenDaysAgo = DateTime.now().subtract(Duration(days: 7));
    return sessions.where((s) => s.practiceDate.isAfter(sevenDaysAgo)).toList();
  }

  // Calculate streak (consecutive days with practice)
  int get currentStreak {
    if (sessions.isEmpty) return 0;

    final sortedSessions = List<PracticeSessionModel>.from(sessions)
      ..sort((a, b) => b.practiceDate.compareTo(a.practiceDate));

    int streak = 0;
    DateTime checkDate = DateTime.now().startOfDay;

    for (var session in sortedSessions) {
      if (session.practiceDate.startOfDay == checkDate ||
          session.practiceDate.startOfDay ==
              checkDate.subtract(Duration(days: 1))) {
        streak++;
        checkDate = session.practiceDate.startOfDay.subtract(Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  // Get milestone achievements (1000, 2000, 3000, etc.)
  List<int> get achievedMilestones {
    List<int> milestones = [];
    int hours = totalHoursPracticed.floor();
    for (int i = 1000; i <= 10000; i += 1000) {
      if (hours >= i) {
        milestones.add(i);
      }
    }
    return milestones;
  }

  int? get nextMilestone {
    int hours = totalHoursPracticed.floor();
    for (int i = 1000; i <= 10000; i += 1000) {
      if (hours < i) {
        return i;
      }
    }
    return null;
  }
}
