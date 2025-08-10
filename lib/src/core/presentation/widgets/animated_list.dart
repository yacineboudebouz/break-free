import 'package:flutter/material.dart';

class AppAnimatedList extends StatefulWidget {
  const AppAnimatedList({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.duration = const Duration(milliseconds: 600),
    this.staggerDelay = 100,
    this.physics,
    this.padding,
    this.separatorBuilder,
  });
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final Duration duration;
  final int staggerDelay;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

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
          (widget.itemCount * widget.staggerDelay) +
          widget.duration.inMilliseconds,
    );
    _controller = AnimationController(vsync: this, duration: totalDuration);
    _setupAnimations();
    _controller.forward();
  }

  void _setupAnimations() {
    _animations = List.generate(widget.itemCount, (index) {
      final delay = index * widget.staggerDelay;
      final totalDuration = widget.itemCount * widget.staggerDelay + 300;

      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            delay / totalDuration,
            (delay + 300) / totalDuration,
            curve: Curves.easeOutBack,
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
            (widget.itemCount * widget.staggerDelay) +
            widget.duration.inMilliseconds,
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
            final animValue = animation.value;
            return Transform.translate(
              offset: Offset(0, 100 * (1 - animValue)), // Increased offset
              child: Transform.scale(
                scale: 0.3 + (0.7 * animValue), // More dramatic scale
                child: widget.itemBuilder(context, index),
              ),
            );
          },
        );
      },
    );
  }
}
