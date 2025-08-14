part of 'animated_list.dart';

Widget _buildAnimatedItem(
  Widget child,
  double animationValue,
  AnimationConfig config,
) {
  switch (config.type) {
    case AnimationType.slideUp:
      return Transform.translate(
        offset: Offset(0, config.slideDistance * (1 - animationValue)),
        child: child,
      );

    case AnimationType.slideDown:
      return Transform.translate(
        offset: Offset(0, -config.slideDistance * (1 - animationValue)),
        child: child,
      );

    case AnimationType.slideLeft:
      return Transform.translate(
        offset: Offset(config.slideDistance * (1 - animationValue), 0),
        child: child,
      );

    case AnimationType.slideRight:
      return Transform.translate(
        offset: Offset(-config.slideDistance * (1 - animationValue), 0),
        child: child,
      );

    case AnimationType.scale:
      final scale =
          config.initialScale +
          (config.finalScale - config.initialScale) * animationValue;
      return Transform.scale(scale: scale, child: child);

    case AnimationType.fade:
      final opacity =
          config.initialOpacity +
          (config.finalOpacity - config.initialOpacity) * animationValue;
      return Opacity(opacity: opacity, child: child);

    case AnimationType.slideUpScale:
      final scale =
          config.initialScale +
          (config.finalScale - config.initialScale) * animationValue;
      return Transform.translate(
        offset: Offset(0, config.slideDistance * (1 - animationValue)),
        child: Transform.scale(scale: scale, child: child),
      );

    case AnimationType.slideUpFade:
      final opacity =
          config.initialOpacity +
          (config.finalOpacity - config.initialOpacity) * animationValue;
      return Transform.translate(
        offset: Offset(0, config.slideDistance * (1 - animationValue)),
        child: Opacity(opacity: opacity, child: child),
      );

    case AnimationType.scaleFade:
      final scale =
          config.initialScale +
          (config.finalScale - config.initialScale) * animationValue;
      final opacity =
          config.initialOpacity +
          (config.finalOpacity - config.initialOpacity) * animationValue;
      return Opacity(
        opacity: opacity,
        child: Transform.scale(scale: scale, child: child),
      );

    case AnimationType.slideUpScaleFade:
      final scale =
          config.initialScale +
          (config.finalScale - config.initialScale) * animationValue;
      final opacity =
          config.initialOpacity +
          (config.finalOpacity - config.initialOpacity) * animationValue;
      return Transform.translate(
        offset: Offset(0, config.slideDistance * (1 - animationValue)),
        child: Opacity(
          opacity: opacity < 1 ? opacity : 1,
          child: Transform.scale(scale: scale, child: child),
        ),
      );

    case AnimationType.bounce:
      final bounceValue = Curves.bounceOut.transform(animationValue);
      return Transform.scale(scale: bounceValue, child: child);

    case AnimationType.rotate:
      return Transform.rotate(
        angle: config.rotationAngle * (1 - animationValue),
        child: child,
      );

    case AnimationType.custom:
      return config.customBuilder?.call(child, animationValue) ?? child;
  }
}
