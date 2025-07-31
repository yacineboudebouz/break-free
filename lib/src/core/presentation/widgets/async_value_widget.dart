import 'package:bad_habit_killer/src/core/presentation/widgets/error_widget.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/loader_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.onRetry,
    required this.data,
  });
  final AsyncValue<T> value;
  final VoidCallback onRetry;
  final Widget Function(T) data;
  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnRefresh: true,
      data: data,
      loading: () => LoaderIndicator(),
      error: (error, stackTrace) {
        return AppErrorWidget(error: error, onRetry: onRetry);
      },
    );
  }
}
