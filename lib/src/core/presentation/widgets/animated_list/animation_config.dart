import 'package:flutter/material.dart';

enum AnimationType {
  slideUp,
  slideDown,
  slideLeft,
  slideRight,
  scale,
  fade,
  slideUpScale,
  slideUpFade,
  scaleFade,
  slideUpScaleFade,
  bounce,
  rotate,
  custom,
}

class AnimationConfig {
  final AnimationType type;
  final Curve curve;
  final Duration duration;
  final int staggerDelay;
  final double slideDistance;
  final double initialScale;
  final double finalScale;
  final double initialOpacity;
  final double finalOpacity;
  final double rotationAngle;

  final Widget Function(Widget child, double animationValue)? customBuilder;

  const AnimationConfig({
    this.type = AnimationType.slideUpScaleFade,
    this.curve = Curves.easeOutBack,
    this.duration = const Duration(milliseconds: 600),
    this.staggerDelay = 100,
    this.slideDistance = 100.0,
    this.initialScale = 0.3,
    this.finalScale = 1.0,
    this.initialOpacity = 0.0,
    this.finalOpacity = 1.0,
    this.rotationAngle = 0.5,
    this.customBuilder,
  });

  // here i can add as many i want
  static const fadeIn = AnimationConfig(
    type: AnimationType.fade,
    curve: Curves.easeOut,
    duration: Duration(milliseconds: 400),
  );

  static const slideUpGentle = AnimationConfig(
    type: AnimationType.slideUp,
    curve: Curves.easeOutQuart,
    slideDistance: 30.0,
  );

  static const bounceIn = AnimationConfig(
    type: AnimationType.bounce,
    curve: Curves.bounceOut,
    duration: Duration(milliseconds: 800),
  );

  static const scaleIn = AnimationConfig(
    type: AnimationType.scale,
    curve: Curves.elasticOut,
    initialScale: 0.0,
  );

  static const slideLeftFade = AnimationConfig(
    type: AnimationType.slideLeft,
    curve: Curves.easeOutCubic,
    slideDistance: 50.0,
  );
}
