import 'package:flutter/material.dart';

CustomColors customColors(BuildContext context) =>
    Theme.of(context).extension<CustomColors>()!;

class CustomColors extends ThemeExtension<CustomColors> {
  final Color? loadingIndicatorColor;
  const CustomColors({required this.loadingIndicatorColor});
  @override
  ThemeExtension<CustomColors> copyWith({Color? loadingIndicatorColor}) {
    return CustomColors(
      loadingIndicatorColor:
          loadingIndicatorColor ?? this.loadingIndicatorColor,
    );
  }

  @override
  ThemeExtension<CustomColors> lerp(
    covariant ThemeExtension<CustomColors>? other,
    double t,
  ) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      loadingIndicatorColor: Color.lerp(
        loadingIndicatorColor,
        other.loadingIndicatorColor,
        t,
      ),
    );
  }
}
