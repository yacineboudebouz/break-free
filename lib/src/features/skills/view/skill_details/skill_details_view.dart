import 'package:bad_habit_killer/src/core/config/routing/app_router.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/datetime_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/widget_ref_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/animated_list/animated_list.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/async_value_widget.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/interactive_layer/interactive_layer.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/progress_widget.dart';
import 'package:bad_habit_killer/src/features/skills/domain/add_practice_session.dart';
import 'package:bad_habit_killer/src/features/skills/domain/skill_model.dart';
import 'package:bad_habit_killer/src/features/skills/providers/single_skill.dart';
import 'package:bad_habit_killer/src/features/skills/providers/skill_controller.dart';
import 'package:bad_habit_killer/src/features/skills/view/widgets/practice_session_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
part 'skill_details_view_helper.dart';

class SkillDetailsView extends StatefulHookConsumerWidget {
  const SkillDetailsView({super.key, required this.id});

  final int id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SkillDetailsViewState();
}

class _SkillDetailsViewState extends ConsumerState<SkillDetailsView> {
  @override
  Widget build(BuildContext context) {
    final skillAsync = ref.watch(singleSkillProvider(widget.id));
    final controller = ref.watch(skillControllerProvider);
    final noteController = useTextEditingController();
    final practiceDate = useState<DateTime>(DateTime.now());
    final durationMinutes = useState<int>(60);
    ref.listenAndHandleState(skillControllerProvider);

    return AppScaffold(
      body: AsyncValueWidget(
        value: skillAsync,
        data: (skill) => Column(
          children: [
            Container(
              height: context.height * 0.12,
              padding: const EdgeInsets.all(Sizes.spacing16),
              child: Padding(
                padding: const EdgeInsets.only(top: Sizes.paddingV24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, size: Sizes.icon28),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          skill.name,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, size: Sizes.icon28),
                      onPressed: () {
                        context.pushNamed(
                          AppRouter.editSkill.name,
                          extra: skill,
                          pathParameters: {"skillId": skill.id.toString()},
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: context.height * 0.3,
                    child: Hero(
                      tag: 'progress_${widget.id}',
                      child: ProgressWidget(
                        ringColor: Theme.of(context).cardColor,
                        strokeWidth: Sizes.borderWidth16,
                        value: skill.progressPercentage / 100,
                        color: skill.colorValue,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  child: Column(
                    children: [
                      Text(
                        "Target Hours",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        skill.targetHours.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: skill.colorValue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _buildStatsSection(context, skill),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.paddingH32,
                vertical: Sizes.paddingV8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ColumnItem(
                    title: 'Practiced'.hardcoded,
                    value: '${skill.totalHoursPracticed.toStringAsFixed(1)}h',
                    color: skill.colorValue,
                  ),
                  InteractiveLayer(
                    config: InteractionConfig.scaleIn,
                    child: FloatingActionButton(
                      heroTag: 'practice_button',
                      backgroundColor: skill.colorValue,
                      onPressed: controller.isLoading
                          ? null
                          : () {
                              _addPracticeSession(
                                ref,
                                skill,
                                context,
                                practiceDate,
                                durationMinutes,
                                noteController,
                              );
                            },
                      child: controller.isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Icon(Icons.add, size: Sizes.icon28),
                    ),
                  ),
                  _ColumnItem(
                    title: 'Remaining'.hardcoded,
                    value:
                        '${skill.hoursRemainingToMastery.toStringAsFixed(0)}h',
                    color: skill.colorValue,
                  ),
                ],
              ),
            ),
            gapH12,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingH32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Practice History".hardcoded,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (skill.sessions.isNotEmpty)
                    Text(
                      "${skill.sessions.length} sessions".hardcoded,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingH8),
              child: Divider(),
            ),
            Expanded(
              child: skill.sessions.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 64,
                            color: Colors.grey,
                          ),
                          gapH16,
                          Text(
                            "No practice sessions yet".hardcoded,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          gapH8,
                          Text(
                            "Tap the + button to log your first session!"
                                .hardcoded,
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : AppAnimatedList(
                      itemBuilder: (_, index) {
                        final session = skill.sessions[index];
                        return Dismissible(
                          key: Key('session_${session.id}'),
                          onDismissed: (direction) {
                            _deleteSession(ref, session.id, skill.id, context);
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: Sizes.paddingH16),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          child: PracticeSessionWidget(
                            session: session,
                            color: skill.colorValue,
                          ),
                        );
                      },
                      itemCount: skill.sessions.length,
                    ),
            ),
          ],
        ),
        onRetry: () {},
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, SkillModel skill) {
    final color = skill.colorValue;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.paddingH16,
        vertical: Sizes.paddingV8,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.spacing16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(
                    icon: Icons.local_fire_department,
                    label: 'Streak',
                    value: '${skill.currentStreak} days',
                    color: color,
                  ),
                  _StatItem(
                    icon: Icons.trending_up,
                    label: 'Avg/Day',
                    value: '${skill.averageMinutesPerDay.toStringAsFixed(0)}m',
                    color: color,
                  ),
                  _StatItem(
                    icon: Icons.calendar_today,
                    label: 'Active',
                    value: '${skill.daysActive} days',
                    color: color,
                  ),
                ],
              ),
              if (skill.nextMilestone != null) ...[
                gapH12,
                LinearProgressIndicator(
                  value: (skill.totalHoursPracticed % 1000) / 1000,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
                gapH8,
                Text(
                  'Next milestone: ${skill.nextMilestone}h (${((skill.nextMilestone! - skill.totalHoursPracticed).toStringAsFixed(0))}h to go)',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ColumnItem extends StatelessWidget {
  const _ColumnItem({
    required this.title,
    required this.value,
    required this.color,
  });
  final String title;
  final String value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: theme.textTheme.bodyMedium),
        Text(
          value,
          style: theme.textTheme.titleMedium!.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        gapH4,
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
