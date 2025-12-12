import 'package:bad_habit_killer/src/core/core_features/database/app_database.dart';
import 'package:bad_habit_killer/src/features/skills/domain/add_practice_session.dart';
import 'package:bad_habit_killer/src/features/skills/domain/create_skill.dart';
import 'package:bad_habit_killer/src/features/skills/domain/practice_session_model.dart';
import 'package:bad_habit_killer/src/features/skills/domain/skill_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'skills_datasource.g.dart';

@riverpod
SkillsDatasource skillsDatasource(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return SkillsDatasource(database);
}

class SkillsDatasource {
  final AppDatabase database;
  SkillsDatasource(this.database);

  Future<int> createSkill(CreateSkillModel skill) async {
    return await database.insert(DatabaseTables.skills, skill.toMap());
  }

  Future<List<SkillModel>> getAllSkills() async {
    final List<Map<String, dynamic>> skills = await database.query(
      DatabaseTables.skills,
    );
    List<SkillModel> skillModels = [];
    for (var skill in skills) {
      final skillId = skill['id'];

      final List<Map<String, dynamic>> sessions = await database.query(
        DatabaseTables.practiceSessions,
        where: 'skill_id = ?',
        whereArgs: [skillId],
        orderBy: 'practice_date DESC',
      );
      List<PracticeSessionModel> sessionModels = sessions.map((session) {
        return PracticeSessionModel.fromMap(session);
      }).toList();
      SkillModel skillModel = SkillModel.fromMapWithSessions(
        skill,
        sessions: sessionModels,
      );
      skillModels.add(skillModel);
    }
    return skillModels;
  }

  Future<int> addPracticeSession(AddPracticeSession session) async {
    return await database.insert(
      DatabaseTables.practiceSessions,
      session.toMap(),
    );
  }

  Future<void> updateSkill(SkillModel skill) async {
    await database.update(
      DatabaseTables.skills,
      skill.toMap(),
      where: 'id = ?',
      whereArgs: [skill.id],
    );
  }

  Future<void> deleteSkill(int skillId) async {
    await database.delete(
      DatabaseTables.skills,
      where: 'id = ?',
      whereArgs: [skillId],
    );
    await database.delete(
      DatabaseTables.practiceSessions,
      where: 'skill_id = ?',
      whereArgs: [skillId],
    );
  }

  Future<void> deletePracticeSession(int id) async {
    await database.delete(
      DatabaseTables.practiceSessions,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<SkillModel> getSkillById(int id) async {
    final List<Map<String, dynamic>> skills = await database.query(
      DatabaseTables.skills,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (skills.isEmpty) {
      throw Exception('Skill not found');
    }
    final skill = skills.first;
    final List<Map<String, dynamic>> sessions = await database.query(
      DatabaseTables.practiceSessions,
      where: 'skill_id = ?',
      whereArgs: [id],
      orderBy: 'practice_date DESC',
    );
    List<PracticeSessionModel> sessionModels = sessions.map((session) {
      return PracticeSessionModel.fromMap(session);
    }).toList();
    return SkillModel.fromMapWithSessions(skill, sessions: sessionModels);
  }
}
