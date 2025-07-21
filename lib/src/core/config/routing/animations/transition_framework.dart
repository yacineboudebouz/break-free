import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'fade_transition.dart';
part 'slide_transition.dart';
part 'scale_transition.dart';

// we use that to make our class reusable as much as possible
Duration defaultTransitionDuration = const Duration(milliseconds: 1000);
Duration getDuration(int? duration) {
  if (duration == null) {
    return defaultTransitionDuration;
  }
  return Duration(milliseconds: duration);
}
