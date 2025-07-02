import 'package:bad_habit_killer/src/core/core_features/theme/presentaion/utils/custom_colors.dart';
import 'package:flutter/material.dart';

part 'app_colors_dark.dart';
part 'app_colors_light.dart';

abstract class AppColors {
  Color get primaryColor;
  Color get secondaryColor;
  Color get tertiaryColor;

  /// Screen
  Color get scaffoldBGColor;
  Color get appBarColor;
  Color get bottomNavigationBarColor;
  Color get dialogColor;
  Color get dividerColor;

  /// icon
  Color get iconColor;

  /// card
  Color get cardBGColor;
  Color get cardShadowColor;

  /// other colors
  CustomColors get customColors;
}
