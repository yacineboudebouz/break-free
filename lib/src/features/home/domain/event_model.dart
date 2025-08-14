import 'package:flutter/material.dart';

enum EventType { relapse, note, firstDate }

class EventModel {
  final int id;
  final DateTime date;
  final String? note;
  final EventType type;

  EventModel({
    required this.id,
    required this.date,
    this.note,
    required this.type,
  });

  @override
  String toString() {
    return 'EventModel(id: $id, date: $date, note: $note, type: $type)';
  }

  IconData get icon {
    switch (type) {
      case EventType.relapse:
        return Icons.replay_outlined;
      case EventType.note:
        return Icons.note;
      case EventType.firstDate:
        return Icons.calendar_today;
    }
  }
}
