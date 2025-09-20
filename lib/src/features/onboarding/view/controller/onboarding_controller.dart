import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:bad_habit_killer/src/features/onboarding/data/repository/onboarding_repository.dart';
import 'package:bad_habit_killer/src/features/onboarding/view/controller/onboarding_state.dart';
part 'onboarding_controller.g.dart';

@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  OnboardingState build() {
    return OnboardingState.initial();
  }

  void goToNext() {
    if (state.currentPage < state.totalPages - 1) {
      state = state.copyWith(currentPage: state.currentPage + 1);
    }
  }

  Future<void> getStarted(Function onComplete) async {
    await ref.read(onboardingRepositoryProvider).completeOnboarding();
    onComplete();
  }

  Future<void> handleClick(Function onComplete) async {
    if (state.currentPage < state.totalPages - 1) {
      goToNext();
    } else {
      await getStarted(onComplete);
    }
  }

  bool get isVisitedOnboarding {
    return ref.read(onboardingRepositoryProvider).isOnboardingCompleted();
  }
}
