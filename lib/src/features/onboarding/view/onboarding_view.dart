import 'package:animate_do/animate_do.dart';
import 'package:bad_habit_killer/src/core/config/routing/app_router.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/go_router_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/helpers/app_gaps.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:bad_habit_killer/src/features/onboarding/view/controller/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final theme = Theme.of(context);
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: context.height * 0.12, width: double.infinity),
          FadeIn(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Text(
                state.currentContent.title,
                key: ValueKey<String>(state.currentContent.title),
                style: theme.textTheme.headlineMedium,
              ),
            ),
          ),
          gapH12,
          FadeInDown(
            delay: const Duration(milliseconds: 500),

            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Lottie.asset(
                state.currentContent.image,
                height: context.height * 0.4,
                key: ValueKey<String>(state.currentContent.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingH24),
            child: FadeInUp(
              delay: const Duration(milliseconds: 800),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Text(
                  state.currentContent.description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                  key: ValueKey<String>(state.currentContent.description),
                ),
              ),
            ),
          ),
          gapH12,
          Padding(
            padding: const EdgeInsets.all(Sizes.paddingH12),
            child: ElevatedButton(
              onPressed: () {
                ref
                    .read(onboardingControllerProvider.notifier)
                    .handleClick(
                      () => context.goReplaceNamed(AppRouter.home.name),
                    );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, Sizes.marginH64),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.radius12),
                  side: BorderSide(color: Colors.blue),
                ),
                overlayColor: Colors.blue,
              ),
              child: Text(
                state.currentText,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
