part of 'transition_framework.dart';

CustomTransitionPage<T> slideRightTransition<T>({
  required Widget child,
  int? duration,
}) => CustomTransitionPage<T>(
  child: child,
  transitionDuration: getDuration(duration),
  transitionsBuilder: (context, animation, secondaryAnimation, child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
);
