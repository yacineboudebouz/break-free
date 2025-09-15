import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/animated_list/animated_list.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/animated_list/animation_config.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:bad_habit_killer/src/features/help/domain/advice_model.dart';
import 'package:bad_habit_killer/src/features/help/view/widgets/advice_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelpView extends ConsumerWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      body: Column(
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
                  Center(
                    child: Text(
                      "Help".hardcoded,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  gapW48,
                ],
              ),
            ),
          ),
          Expanded(
            child: AppAnimatedList(
              animationConfig: AnimationConfig.slideLeftFade.copyWith(
                duration: Duration(milliseconds: 600),
                slideDistance: 250,
              ),
              itemBuilder: (context, index) {
                final advice = AdviceModel.advices[index];
                return AdviceWidget(advice: advice);
              },
              itemCount: AdviceModel.advices.length,
            ),
          ),
        ],
      ),
    );
  }
}
