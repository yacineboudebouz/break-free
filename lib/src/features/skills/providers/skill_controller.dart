import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/features/skills/data/repository/skills_repository.dart';
import 'package:bad_habit_killer/src/features/skills/domain/add_practice_session.dart';
import 'package:bad_habit_killer/src/features/skills/domain/skill_model.dart';
import 'package:bad_habit_killer/src/features/skills/providers/single_skill.dart';
part 'skill_controller.g.dart';

@riverpod
class SkillController extends _$SkillController {
  @override
  FutureOr<void> build() {}

  Future<void> addPracticeSession(AddPracticeSession session) async {
    try {
      state = AsyncLoading();
      final skill = await ref
          .read(skillsRepositoryProvider)
          .addPracticeSession(session);
      ref
          .read(singleSkillProvider(session.skillId).notifier)
          .addPracticeSession(skill.sessions.first);
      state = AsyncData(null);
    } catch (e, tr) {
      state = AsyncError(e, tr);
    }
  }

  Future<void> updateSkill(SkillModel skill) async {
    try {
      state = AsyncLoading();
      await ref.read(skillsRepositoryProvider).updateSkill(skill);
      ref.read(singleSkillProvider(skill.id).notifier).updateSkill(skill);
      state = AsyncData(null);
    } catch (e, tr) {
      state = AsyncError(e, tr);
    }
  }

  Future<void> deletePracticeSession(int sessionId, int skillId) async {
    try {
      state = AsyncLoading();
      await ref.read(skillsRepositoryProvider).deletePracticeSession(sessionId);
      ref
          .read(singleSkillProvider(skillId).notifier)
          .deletePracticeSession(sessionId);
      state = AsyncData(null);
    } catch (e, tr) {
      state = AsyncError(e, tr);
    }
  }
}
