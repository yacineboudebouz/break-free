import 'package:bad_habit_killer/src/core/presentation/widgets/animated_list/animation_config.dart';
import 'package:flutter/material.dart';

class AppAnimatedList extends StatefulWidget {
  const AppAnimatedList({
    super.key,
    required this.itemBuilder,
    required this.itemCount,

    this.staggerDelay = 100,
    this.physics,
    this.padding,
    this.separatorBuilder,
    this.animationConfig = const AnimationConfig(),
    this.reverse = false,
  });
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final AnimationConfig animationConfig;
  final int staggerDelay;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final bool reverse;
  @override
  State<AppAnimatedList> createState() => _AppAnimatedListState();
}

class _AppAnimatedListState extends State<AppAnimatedList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    final totalDuration = Duration(
      milliseconds:
          (widget.itemCount * widget.animationConfig.staggerDelay) +
          widget.animationConfig.duration.inMilliseconds,
    );
    _controller = AnimationController(vsync: this, duration: totalDuration);
    _setupAnimations();
    _controller.forward();
  }

  void _setupAnimations() {
    _animations = List.generate(widget.itemCount, (index) {
      final actualIndex = widget.reverse
          ? (widget.itemCount - 1 - index)
          : index;
      final delay = actualIndex * widget.animationConfig.staggerDelay;
      final totalDuration =
          widget.itemCount * widget.animationConfig.staggerDelay +
          widget.animationConfig.duration.inMilliseconds;

      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            delay / totalDuration,
            (delay + widget.animationConfig.duration.inMilliseconds) /
                totalDuration,
            curve: widget.animationConfig.curve,
          ),
        ),
      );
    });
  }

  @override
  void didUpdateWidget(covariant AppAnimatedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemCount != oldWidget.itemCount) {
      final totalDuration = Duration(
        milliseconds:
            (widget.itemCount * widget.animationConfig.staggerDelay) +
            widget.animationConfig.duration.inMilliseconds,
      );
      _controller.dispose();
      _controller = AnimationController(vsync: this, duration: totalDuration);
      _setupAnimations();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics:
          widget.physics ??
          BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: widget.itemCount,
      padding: widget.padding,
      separatorBuilder:
          widget.separatorBuilder ??
          (context, index) => const SizedBox.shrink(),
      itemBuilder: (context, index) {
        final animation = index < _animations.length
            ? _animations[index]
            : AlwaysStoppedAnimation(1.0);

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return _buildAnimatedItem(
              child ?? widget.itemBuilder(context, index),
              animation.value,
            );
          },
        );
      },
    );
  }

  Widget _buildAnimatedItem(Widget child, double animationValue) {
    final config = widget.animationConfig;

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
}
