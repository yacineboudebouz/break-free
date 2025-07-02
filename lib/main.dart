import 'package:bad_habit_killer/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/core/config/services/logger.dart';
import 'package:logging/logging.dart';
import 'src/core/config/providers/shared_preferences_provider.dart';
import 'src/core/config/providers/provider_observer.dart';
part 'src/core/config/services/main_initializer.dart';

void main() async {
  final container = await _mainInitializer();
  runApp(UncontrolledProviderScope(container: container, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _EagerInitialization(child: App());
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = <AsyncValue>[ref.watch(sharedPreferencesProvider)];

    if (values.every((value) => value.hasValue || value.hasError)) {
      return child;
    }

    return const SizedBox();
  }
}
