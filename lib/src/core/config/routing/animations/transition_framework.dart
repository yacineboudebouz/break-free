import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'fade_transition.dart';
part 'slide_transition.dart';
part 'scale_transition.dart';
part 'hero_transition.dart';
// we use that to make our class reusable as much as possible

class TransitionConfig {
  TransitionConfig._();
  static const int defaultDuration = 300;
  static const int fastduration = 200;
  static const int slowDuration = 500;

  static Duration getDuration(int? duration) {
    return Duration(milliseconds: duration ?? defaultDuration);
  }
}
