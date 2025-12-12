import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/features/skills/data/repository/skills_repository.dart';
import 'package:bad_habit_killer/src/features/skills/domain/practice_session_model.dart';
import 'package:bad_habit_killer/src/features/skills/domain/skill_model.dart';
part 'multi_skills.g.dart';

@Riverpod(keepAlive: true)
class MultiSkills extends _$MultiSkills {
  @override
  FutureOr<List<SkillModel>> build() async {
    return await ref.watch(allSkillsProvider.future);
  }

  void addSkill(SkillModel skill) {
    state = state.whenData((skills) => [...skills, skill]);
  }

  void addPracticeSessionToSkill(PracticeSessionModel session, int id) {
    if (state.hasValue) {
      final currentSkills = state.value!;
      final updatedSkills = currentSkills.map((skill) {
        if (skill.id == id) {
          return skill.copyWith(sessions: [...skill.sessions, session]);
        }
        return skill;
      }).toList();
      state = AsyncValue.data(updatedSkills);
    }
  }

  void updateSkill(SkillModel skill) {
    if (state.hasValue) {
      final currentSkills = state.value!;
      final updatedSkills = currentSkills.map((s) {
        if (s.id == skill.id) {
          return skill;
        }
        return s;
      }).toList();
      state = AsyncValue.data(updatedSkills);
    }
  }

  Future<void> deleteSkill(int skillId) async {
    await ref.watch(skillsRepositoryProvider).deleteSkill(skillId);
    if (state.hasValue) {
      final currentSkills = state.value!;
      final updatedSkills = currentSkills
          .where((s) => s.id != skillId)
          .toList();
      state = AsyncValue.data(updatedSkills);
    }
  }

  void deletePracticeSessionFromSkill(int sessionId, int skillId) {
    if (state.hasValue) {
      final currentSkills = state.value!;
      final updatedSkills = currentSkills.map((skill) {
        if (skill.id == skillId) {
          final updatedSessions = skill.sessions
              .where((session) => session.id != sessionId)
              .toList();
          return skill.copyWith(sessions: updatedSessions);
        }
        return skill;
      }).toList();
      state = AsyncValue.data(updatedSkills);
    }
  }
}
