import 'package:flutter/widgets.dart';

extension SizeExtension on BuildContext {
  /// Returns the width of the current context.
  double get width => MediaQuery.of(this).size.width;

  /// Returns the height of the current context.
  double get height => MediaQuery.of(this).size.height;

  /// Returns the aspect ratio of the current context.
  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;

  /// Returns the device pixel ratio of the current context.
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;
}
