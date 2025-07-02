import 'package:bad_habit_killer/src/core/config/services/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

const _riverpodEmoji = '🏞️ ';

class ProviderLogger extends ProviderObserver {
  ProviderLogger() : _logger = Logger('Riverpod') {
    _logger.level = Level
        .FINER; //Turn off logging for messages whose level is under this level.
    _logger.onRecord.listen(loggerOnDataCallback(prefix: _riverpodEmoji));
  }

  final Logger _logger;

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (value is AsyncError) return;

    _logger.fine(
      '➕ DidAddProvider: ${provider.name}\n'
      '=> value: $value',
    );
  }

  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (newValue is AsyncError) return;

    _logger.finer(
      '🔄 DidUpdateProvider: ${provider.name}\n'
      '=> oldValue: $previousValue\n'
      '=> newValue: $newValue',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<dynamic> provider,
    ProviderContainer container,
  ) {
    _logger.fine('🗑️ DidDisposeProvider: ${provider.name}');
  }
}
