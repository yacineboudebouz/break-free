part of '../../../../main.dart';

Future<ProviderContainer> _mainInitializer() async {
  _setupLogger();

  final container = ProviderContainer(observers: [ProviderLogger()]);
  return container;
}

void _setupLogger() {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord r) {
    if (r.loggerName.isEmpty) {
      loggerOnDataCallback()?.call(r);
    }
  });
}
