import 'package:bad_habit_killer/src/core/presentation/constants/app_assets.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/loader_indicator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
      home: AppScaffold(
        paddingH: Sizes.paddingH20,
        paddingV: Sizes.paddingV20,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Sizes.spacing8,
          children: [
            Center(
              child: Text(
                'Bad Habit Killer'.hardcoded,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Image.asset(AppAssets.splash),
            const LoaderIndicator(),
          ],
        ),
      ),
    );
  }
}
