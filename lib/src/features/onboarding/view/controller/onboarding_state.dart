import 'package:bad_habit_killer/src/features/onboarding/domain/onboarding_model.dart';

class OnboardingState {
  final int currentPage;
  final int totalPages;
  final List<OnboardingModel> pageContents = OnboardingModel.onboardingItems;

  OnboardingState({required this.currentPage, required this.totalPages});

  factory OnboardingState.initial() {
    return OnboardingState(currentPage: 0, totalPages: 3);
  }

  bool get isLastPage => currentPage == totalPages - 1;

  OnboardingState copyWith({int? currentPage, int? totalPages}) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  OnboardingModel get currentContent => pageContents[currentPage];
  String get currentText => isLastPage ? 'Get Started' : 'Next';
}
