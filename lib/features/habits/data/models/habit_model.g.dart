// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitModel _$HabitModelFromJson(Map<String, dynamic> json) => HabitModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$HabitTypeEnumMap, json['type']),
  category: $enumDecode(_$HabitCategoryEnumMap, json['category']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  lastRelapseDate: json['lastRelapseDate'] == null
      ? null
      : DateTime.parse(json['lastRelapseDate'] as String),
  startDate: DateTime.parse(json['startDate'] as String),
  currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
  bestStreak: (json['bestStreak'] as num?)?.toInt() ?? 0,
  totalRelapses: (json['totalRelapses'] as num?)?.toInt() ?? 0,
  totalSuccessDays: (json['totalSuccessDays'] as num?)?.toInt() ?? 0,
  isActive: json['isActive'] as bool? ?? true,
  targetDays: (json['targetDays'] as num?)?.toInt(),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$HabitModelToJson(HabitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$HabitTypeEnumMap[instance.type]!,
      'category': _$HabitCategoryEnumMap[instance.category]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'lastRelapseDate': instance.lastRelapseDate?.toIso8601String(),
      'startDate': instance.startDate.toIso8601String(),
      'currentStreak': instance.currentStreak,
      'bestStreak': instance.bestStreak,
      'totalRelapses': instance.totalRelapses,
      'totalSuccessDays': instance.totalSuccessDays,
      'isActive': instance.isActive,
      'targetDays': instance.targetDays,
      'notes': instance.notes,
    };

const _$HabitTypeEnumMap = {HabitType.bad: 'bad', HabitType.good: 'good'};

const _$HabitCategoryEnumMap = {
  HabitCategory.health: 'health',
  HabitCategory.productivity: 'productivity',
  HabitCategory.social: 'social',
  HabitCategory.personal: 'personal',
  HabitCategory.addiction: 'addiction',
  HabitCategory.fitness: 'fitness',
  HabitCategory.mindfulness: 'mindfulness',
  HabitCategory.other: 'other',
};
