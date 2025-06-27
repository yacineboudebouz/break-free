// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relapse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelapseModel _$RelapseModelFromJson(Map<String, dynamic> json) => RelapseModel(
  id: json['id'] as String,
  habitId: json['habitId'] as String,
  type: $enumDecode(_$RelapseTypeEnumMap, json['type']),
  date: DateTime.parse(json['date'] as String),
  note: json['note'] as String?,
  trigger: json['trigger'] as String?,
  emotion: json['emotion'] as String?,
  location: json['location'] as String?,
  intensityLevel: (json['intensityLevel'] as num?)?.toInt(),
  durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
  feltGuilty: json['feltGuilty'] as bool? ?? false,
  lessonsLearned: json['lessonsLearned'] as String?,
  recoveryPlan: json['recoveryPlan'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$RelapseModelToJson(RelapseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'habitId': instance.habitId,
      'type': _$RelapseTypeEnumMap[instance.type]!,
      'date': instance.date.toIso8601String(),
      'note': instance.note,
      'trigger': instance.trigger,
      'emotion': instance.emotion,
      'location': instance.location,
      'intensityLevel': instance.intensityLevel,
      'durationMinutes': instance.durationMinutes,
      'feltGuilty': instance.feltGuilty,
      'lessonsLearned': instance.lessonsLearned,
      'recoveryPlan': instance.recoveryPlan,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$RelapseTypeEnumMap = {
  RelapseType.relapse: 'relapse',
  RelapseType.success: 'success',
  RelapseType.missed: 'missed',
  RelapseType.reset: 'reset',
};
