import 'package:bad_habit_killer/src/core/config/services/local_storage/local_storage_service.dart';
import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
part 'onboarding_repository.g.dart';

@riverpod
OnboardingRepository onboardingRepository(Ref ref) {
  return OnboardingRepository(ref.watch(localStorageServiceProvider));
}

class OnboardingRepository {
  final LocalStorageService _localStorageService;
  const OnboardingRepository(this._localStorageService);

  Future<void> completeOnboarding() async {
    await _localStorageService.saveOnboardingCompleted(true);
  }

  bool isOnboardingCompleted() {
    return _localStorageService.getOnboardingCompleted() ?? false;
  }
}
