import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/features/skills/data/repository/skills_repository.dart';
import 'package:bad_habit_killer/src/features/skills/domain/create_skill.dart';
import 'package:bad_habit_killer/src/features/skills/providers/multi_skills.dart';

part 'create_skill.g.dart';

@riverpod
class CreateSkill extends _$CreateSkill {
  @override
  FutureOr<void> build() {}

  Future<void> createSkill(CreateSkillModel skill) async {
    try {
      state = AsyncLoading();
      final createdSkill = await ref
          .read(skillsRepositoryProvider)
          .createSkill(skill);
      ref.read(multiSkillsProvider.notifier).addSkill(createdSkill);
      state = AsyncData(null);
    } catch (e, tr) {
      state = AsyncError(e, tr);
    }
  }
}
