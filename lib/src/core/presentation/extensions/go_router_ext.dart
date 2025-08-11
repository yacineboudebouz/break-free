import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension Router on BuildContext {
  void goNamed(String name, {Map<String, String> pathParameters = const {}}) {
    GoRouter.of(this).goNamed(name, pathParameters: pathParameters);
  }

  void popN(int n) {
    for (var i = 0; i < n; i++) {
      GoRouter.of(this).pop();
    }
  }

  /// pop the latest `route` in the stack
  void popG() {
    GoRouter.of(this).pop();
  }
}
