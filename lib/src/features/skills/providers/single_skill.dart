import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/features/skills/domain/practice_session_model.dart';
import 'package:bad_habit_killer/src/features/skills/domain/skill_model.dart';
import 'package:bad_habit_killer/src/features/skills/providers/multi_skills.dart';
part 'single_skill.g.dart';

@Riverpod(keepAlive: true)
class SingleSkill extends _$SingleSkill {
  @override
  FutureOr<SkillModel> build(int id) async {
    final skills = await ref.read(multiSkillsProvider.future);
    return skills.firstWhere((skill) => skill.id == id);
  }

  void addPracticeSession(PracticeSessionModel session) {
    state = state.whenData((skill) {
      final updatedSessions = [...skill.sessions, session];
      final updatedSkill = skill.copyWith(sessions: updatedSessions);
      return updatedSkill;
    });
    ref
        .read(multiSkillsProvider.notifier)
        .addPracticeSessionToSkill(session, state.value!.id);
  }

  void updateSkill(SkillModel skill) {
    state = state.whenData((existingSkill) {
      return existingSkill.copyWith(
        name: skill.name,
        startDate: skill.startDate,
        description: skill.description,
        color: skill.color,
        targetHours: skill.targetHours,
      );
    });
    ref.read(multiSkillsProvider.notifier).updateSkill(skill);
  }

  void deletePracticeSession(int id) {
    final skill = state.whenData((skill) {
      final updatedSessions = skill.sessions
          .where((session) => session.id != id)
          .toList();
      final updatedSkill = skill.copyWith(sessions: updatedSessions);
      return updatedSkill;
    });
    state = AsyncValue.data(skill.value!);
    ref
        .read(multiSkillsProvider.notifier)
        .deletePracticeSessionFromSkill(id, state.value!.id);
  }
}
