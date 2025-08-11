part of 'transition_framework.dart';

Page<T> heroTransition<T extends Object?>({
  required Widget child,
  int? duration,
  String? name,
  Object? arguments,
  String? restorationId,
}) {
  return CustomTransitionPage<T>(
    child: child,
    name: name,
    arguments: arguments,
    restorationId: restorationId,
    transitionDuration: TransitionConfig.getDuration(duration),
    reverseTransitionDuration: TransitionConfig.getDuration(duration),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.1, 0.0), end: Offset.zero)
            .animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
        child: child,
      );
    },
  );
}
