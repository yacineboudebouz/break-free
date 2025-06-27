import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_router.dart';
import 'app_routes.dart';

part 'navigation_providers.g.dart';

/// Navigation service for handling app navigation
@riverpod
NavigationService navigationService(NavigationServiceRef ref) {
  final router = ref.watch(appRouterProvider);
  return NavigationService(router);
}

class NavigationService {
  final GoRouter _router;

  const NavigationService(this._router);

  /// Navigate to home screen
  void goHome() {
    _router.go(AppRoutes.home);
  }

  /// Navigate to habit detail screen
  void goToHabitDetail(String habitId) {
    _router.go(AppRoutes.getHabitDetailRoute(habitId));
  }

  /// Navigate to add habit screen
  void goToAddHabit() {
    _router.go(AppRoutes.addHabit);
  }

  /// Navigate to edit habit screen
  void goToEditHabit(String habitId) {
    _router.go(AppRoutes.getEditHabitRoute(habitId));
  }

  /// Navigate to articles screen
  void goToArticles() {
    _router.go(AppRoutes.articles);
  }

  /// Navigate to article detail screen
  void goToArticleDetail(String articleId) {
    _router.go(AppRoutes.getArticleDetailRoute(articleId));
  }

  /// Navigate to settings screen
  void goToSettings() {
    _router.go(AppRoutes.settings);
  }

  /// Navigate to credits screen
  void goToCredits() {
    _router.go(AppRoutes.credits);
  }

  /// Navigate back (pop current route)
  void goBack() {
    if (_router.canPop()) {
      _router.pop();
    } else {
      // If can't pop, go to home
      goHome();
    }
  }

  /// Push a route and return result
  Future<T?> push<T extends Object?>(String location) {
    return _router.push<T>(location);
  }

  /// Replace current route
  void replace(String location) {
    _router.pushReplacement(location);
  }
}

/// Provider for current route information
@riverpod
String currentRoute(CurrentRouteRef ref) {
  final router = ref.watch(appRouterProvider);
  return router.routeInformationProvider.value.uri.toString();
}

/// Provider to check if we can navigate back
@riverpod
bool canPop(CanPopRef ref) {
  final router = ref.watch(appRouterProvider);
  return router.canPop();
}
