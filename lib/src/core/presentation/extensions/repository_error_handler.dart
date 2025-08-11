import 'package:bad_habit_killer/src/core/config/error/app_exception.dart';
import 'package:sqflite/sqflite.dart';

extension RepositoryErrorHandler on Object? {
  Future<T> executeWithErrorHandling<T>(
    Future<T> Function() operation, {
    CacheExceptionType? specificErrorType,
    bool throwForTest = false,
  }) async {
    try {
      if (throwForTest) {
        throw AppException.cacheException(
          type: specificErrorType ?? CacheExceptionType.unknown,
          message: 'Test exception thrown',
        );
      }

      return await operation();
    } on DatabaseException catch (e) {
      throw AppException.cacheException(
        type: specificErrorType ?? CacheExceptionType.unknown,
        message: e.toString(),
      );
    } catch (e) {
      if (e is AppException) {
        rethrow;
      } else {
        throw AppException.cacheException(
          type: CacheExceptionType.unknown,
          message: e.toString(),
        );
      }
    }
  }
}
