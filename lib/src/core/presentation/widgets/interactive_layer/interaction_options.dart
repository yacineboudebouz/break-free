// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'interactive_layer.dart';

enum InteractionType { none, scaleIn, scaleOut, glow, lift, fade, bounce }

class InteractionConfig {
  final InteractionType type;
  final Duration duration;
  final Curve curve;
  final double intensity;
  final Color? glowColor;
  final double? glowRadius;
  final Offset? liftOffset;

  const InteractionConfig({
    this.type = InteractionType.none,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.glowColor,
    this.glowRadius,
    this.liftOffset,
    this.intensity = 1.0,
  });

  /// here some predifind interaction for common use
  // TODO: i can add more if needed and this is can be package in the future
  static const scaleIn = InteractionConfig(
    type: InteractionType.scaleIn,
    intensity: 0.95,
  );

  static const scaleOut = InteractionConfig(
    type: InteractionType.scaleOut,
    intensity: 1.05,
  );

  static const glow = InteractionConfig(
    type: InteractionType.glow,
    glowColor: Colors.white,
    glowRadius: 10.0,
  );

  static const lift = InteractionConfig(
    type: InteractionType.lift,
    liftOffset: Offset(0, -10),
  );

  static const fade = InteractionConfig(type: InteractionType.fade);

  InteractionConfig copyWith({
    InteractionType? type,
    Duration? duration,
    Curve? curve,
    double? intensity,
    Color? glowColor,
    double? glowRadius,
    Offset? liftOffset,
  }) {
    return InteractionConfig(
      type: type ?? this.type,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      intensity: intensity ?? this.intensity,
      glowColor: glowColor ?? this.glowColor,
      glowRadius: glowRadius ?? this.glowRadius,
      liftOffset: liftOffset ?? this.liftOffset,
    );
  }
}
