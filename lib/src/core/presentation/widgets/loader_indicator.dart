import 'dart:math';
import 'package:flutter/material.dart';

class LoaderIndicator extends StatefulWidget {
  const LoaderIndicator({
    super.key,
    this.size = 40.0,
    this.color,
    this.strokeWidth = 4.0,
    this.dotCount = 8,
    this.animationDuration = const Duration(milliseconds: 1200),
  });

  final double size;
  final Color? color;
  final double strokeWidth;
  final int dotCount;
  final Duration animationDuration;

  @override
  State<LoaderIndicator> createState() => _LoaderIndicatorState();
}

class _LoaderIndicatorState extends State<LoaderIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).primaryColor;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (context, child) {
          return CustomPaint(
            painter: RotatingDotsPainter(
              rotation: _rotationAnimation.value,
              color: color,
              dotCount: widget.dotCount,
              strokeWidth: widget.strokeWidth,
            ),
            size: Size(widget.size, widget.size),
          );
        },
      ),
    );
  }
}

class RotatingDotsPainter extends CustomPainter {
  final double rotation;
  final Color color;
  final int dotCount;
  final double strokeWidth;

  RotatingDotsPainter({
    required this.rotation,
    required this.color,
    required this.dotCount,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth;
    final dotRadius = strokeWidth / 2;

    for (int i = 0; i < dotCount; i++) {
      final angle = (2 * pi / dotCount) * i + rotation;
      final opacity = (i / dotCount) * 0.8 + 0.2;

      final dotCenter = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      final paint = Paint()
        ..color = color.withOpacity(opacity)
        ..style = PaintingStyle.fill
        ..isAntiAlias = true;

      canvas.drawCircle(dotCenter, dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(RotatingDotsPainter oldDelegate) {
    return oldDelegate.rotation != rotation ||
        oldDelegate.color != color ||
        oldDelegate.dotCount != dotCount ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
