part of 'transition_framework.dart';

CustomTransitionPage<T> fadeTransition<T>({
  required Widget child,
  int? duration,
}) => CustomTransitionPage<T>(
  child: child,

  transitionDuration: getDuration(duration),
  transitionsBuilder: (context, animation, secondaryAnimation, child) =>
      FadeTransition(opacity: animation, child: child),
);
