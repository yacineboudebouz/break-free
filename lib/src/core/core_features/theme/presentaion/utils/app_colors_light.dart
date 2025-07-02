part of 'app_colors.dart';

class AppColorsLight extends AppColors {
  @override
  Color get primaryColor => const Color(0xFF6366F1); // Indigo-500

  @override
  Color get secondaryColor => const Color(0xFF8B5CF6); // Violet-500

  @override
  Color get tertiaryColor => const Color(0xFF06B6D4); // Cyan-500

  // Screen Colors
  @override
  Color get scaffoldBGColor => const Color(0xFFFAFAFA); // Gray-50

  @override
  Color get appBarColor => const Color(0xFFFFFFFF); // White

  @override
  Color get bottomNavigationBarColor => const Color(0xFFFFFFFF); // White

  @override
  Color get dialogColor => const Color(0xFFFFFFFF); // White

  @override
  Color get dividerColor => const Color(0xFFE5E7EB); // Gray-200

  // Icon Colors
  @override
  Color get iconColor => const Color(0xFF6B7280); // Gray-500

  // Card Colors
  @override
  Color get cardBGColor => const Color(0xFFFFFFFF); // White

  @override
  Color get cardShadowColor => const Color(0x1A000000); // Black with 10% opacity

  // Custom Colors
  @override
  CustomColors get customColors => const CustomColors(
    loadingIndicatorColor: Color(0xFF6366F1), // Indigo-500
  );
}
