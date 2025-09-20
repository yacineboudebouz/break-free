import 'package:bad_habit_killer/src/core/presentation/constants/app_assets.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String image;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.image,
  });

  static List<OnboardingModel> onboardingItems = [
    OnboardingModel(
      title: 'Welcome to Break Free',
      description:
          'If you suffer from bad habits and want to be superhuman, you are at the right place.',
      image: AppAssets.superHuman,
    ),
    OnboardingModel(
      title: 'Track Your Habits',
      description:
          'Track how much time you quit your bad habits and improve your life.',
      image: AppAssets.timemanagement,
    ),
    OnboardingModel(
      title: 'Key to Success',
      description:
          'Consistency is the key to success. Stay consistent and achieve your goals.',
      image: AppAssets.success,
    ),
  ];
}
