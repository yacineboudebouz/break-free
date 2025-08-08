part of 'app_colors.dart';

class AppColorsDark extends AppColors {
  @override
  Color get primaryColor => const Color(0xFF818CF8); // Indigo-400

  @override
  Color get secondaryColor => const Color(0xFFA78BFA); // Violet-400

  @override
  Color get tertiaryColor => const Color(0xFF22D3EE); // Cyan-400

  // Screen Colors
  @override
  Color get scaffoldBGColor => const Color(0xFF0F172A); // Slate-900

  @override
  Color get appBarColor => const Color(0xFF1E293B); // Slate-800

  @override
  Color get bottomNavigationBarColor => const Color(0xFF1E293B); // Slate-800

  @override
  Color get dialogColor => const Color(0xFF334155); // Slate-700

  @override
  Color get dividerColor => const Color(0xFF475569); // Slate-600

  // Icon Colors
  @override
  Color get iconColor => const Color(0xFF94A3B8); // Slate-400

  // Card Colors
  @override
  Color get cardBGColor => const Color(0xFF1E293B); // Slate-800

  @override
  Color get cardShadowColor => const Color(0x4D000000); // Black with 30% opacity

  // Custom Colors
  @override
  CustomColors get customColors => const CustomColors(
    loadingIndicatorColor: Color(0xFF818CF8), // Indigo-400
  );

  @override
  Color get textPrimaryColor => Color(0xFFF1F5F9); // Slate-100

  @override
  Color get textSecondaryColor => Color(0xFFCBD5E1); // Slate-300
}
