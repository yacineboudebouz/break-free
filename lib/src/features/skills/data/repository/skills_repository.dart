// ignore_for_file: unused_catch_clause

import 'package:bad_habit_killer/src/core/config/error/app_exception.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/repository_error_handler.dart';
import 'package:bad_habit_killer/src/features/skills/data/datasource/skills_datasource.dart';
import 'package:bad_habit_killer/src/features/skills/domain/add_practice_session.dart';
import 'package:bad_habit_killer/src/features/skills/domain/create_skill.dart';
import 'package:bad_habit_killer/src/features/skills/domain/skill_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'skills_repository.g.dart';

@riverpod
Future<List<SkillModel>> allSkills(Ref ref) async {
  final skillsRepository = ref.watch(skillsRepositoryProvider);
  return await skillsRepository.getAllSkills();
}

@riverpod
SkillsRepository skillsRepository(Ref ref) {
  final skillsDatasource = ref.watch(skillsDatasourceProvider);
  return SkillsRepository(skillsDatasource);
}

class SkillsRepository {
  final SkillsDatasource skillsDatasource;
  SkillsRepository(this.skillsDatasource);

  Future<SkillModel> createSkill(CreateSkillModel skill) async {
    final skillId = await executeWithErrorHandling(
      () => skillsDatasource.createSkill(skill),
      specificErrorType: CacheExceptionType.createHabitFailed,
    );
    return SkillModel(
      id: skillId,
      name: skill.name,
      startDate: skill.startDate,
      description: skill.description,
      color: skill.color,
      targetHours: skill.targetHours,
      sessions: [],
    );
  }

  Future<List<SkillModel>> getAllSkills() async {
    return await executeWithErrorHandling(
      () => skillsDatasource.getAllSkills(),
      specificErrorType: CacheExceptionType.getAllHabitsFailed,
    );
  }

  Future<SkillModel> addPracticeSession(AddPracticeSession session) async {
    await executeWithErrorHandling(
      () => skillsDatasource.addPracticeSession(session),
      specificErrorType: CacheExceptionType.addRelapseFailed,
    );
    return await skillsDatasource.getSkillById(session.skillId);
  }

  Future<void> updateSkill(SkillModel skill) async {
    await executeWithErrorHandling(
      () => skillsDatasource.updateSkill(skill),
      specificErrorType: CacheExceptionType.updateHabitFailed,
    );
  }

  Future<void> deleteSkill(int skillId) async {
    await executeWithErrorHandling(
      () => skillsDatasource.deleteSkill(skillId),
      specificErrorType: CacheExceptionType.deleteHabitFailed,
    );
  }

  Future<void> deletePracticeSession(int id) async {
    await executeWithErrorHandling(
      () => skillsDatasource.deletePracticeSession(id),
      specificErrorType: CacheExceptionType.deleteRelapseFailed,
    );
  }

  Future<SkillModel> getSkillById(int id) async {
    return await executeWithErrorHandling(
      () => skillsDatasource.getSkillById(id),
      specificErrorType: CacheExceptionType.getHabitFailed,
    );
  }
}
