part of 'transition_framework.dart';

CustomTransitionPage<T> scaleTransition<T>({
  required Widget child,
  int? duration,
}) => CustomTransitionPage<T>(
  child: child,
  transitionDuration: getDuration(duration),
  transitionsBuilder: (context, animation, secondaryAnimation, child) =>
      ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1).animate(animation),
        child: child,
      ),
);
