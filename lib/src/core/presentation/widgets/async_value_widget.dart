import 'package:bad_habit_killer/src/core/presentation/widgets/error_widget.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/loader_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget extends ConsumerWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.onRetry,
  });
  final AsyncValue value;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value.when(
      data: (data) => data,
      loading: () => LoaderIndicator(),
      error: (error, stackTrace) {
        return AppErrorWidget(error: error, onRetry: onRetry);
      },
    );
  }
}
