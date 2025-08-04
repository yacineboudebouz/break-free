import 'dart:math';

import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:flutter/material.dart';

/// this widget is created from scratch
/// i can just provide a color and progress value
class ProgressWidget extends StatelessWidget {
  const ProgressWidget({super.key, required this.value, required this.color});
  final double value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: ProgressPainter(color: color, progress: value),
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  ProgressPainter({required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final notCompleted = progress < 100.0;
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = Sizes.borderWidth12;
    final radius = size.width / 2 - strokeWidth * 1.5;

    if (notCompleted) {
      final backgroundPaint = Paint()
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = Colors.white
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, backgroundPaint);
    }

    final glowPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth * 1.1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8);

    final forgroundPaint = Paint()
      ..color = color
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      glowPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * 2 - pi / 2,
      2 * pi * progress,
      false,
      forgroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
