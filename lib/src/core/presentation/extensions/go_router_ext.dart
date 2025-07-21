import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension Router on BuildContext {
  void goNamed(String name) {
    GoRouter.of(this).goNamed(name);
  }

  void popN(int n) {
    for (var i = 0; i < n; i++) {
      GoRouter.of(this).pop();
    }
  }

  void pop() {
    GoRouter.of(this).pop();
  }
}
