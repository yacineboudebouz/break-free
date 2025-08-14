import 'package:bad_habit_killer/src/core/presentation/widgets/animated_list/animation_config.dart';
import 'package:flutter/material.dart';
part 'animated_list_helper.dart';

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

  void _initializeController() {
    final totalDuration = Duration(
      milliseconds:
          (widget.itemCount * widget.animationConfig.staggerDelay) +
          widget.animationConfig.duration.inMilliseconds,
    );
    _controller = AnimationController(vsync: this, duration: totalDuration);
    _setupAnimations();
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
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
      _controller.reset();
      _setupAnimations();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              widget.animationConfig,
            );
          },
        );
      },
    );
  }
}
