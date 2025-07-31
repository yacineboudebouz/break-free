import 'package:bad_habit_killer/src/core/config/error/app_exception.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';

// here we gonna automate the error handling so this will take care of the error messages
// rather than repeating the same error messages in every repository
extension AppErrorExt on Object {
  String errorMessage() {
    final error = this;
    if (error is AppException) {
      return error.map(cacheException: (ex) => ex.cacheErrorMessage());
    }
    return 'An unexpected error occurred'.hardcoded;
  }
}

extension _CacheErrorExt on CacheException {
  String cacheErrorMessage() {
    return switch (type) {
      CacheExceptionType.habitNotFound => 'Habit not found'.hardcoded,
      CacheExceptionType.getAllHabitsFailed =>
        'Failed to get all habits'.hardcoded,
      CacheExceptionType.getHabitFailed => 'Failed to get habit'.hardcoded,
      CacheExceptionType.createHabitFailed =>
        'Failed to create habit'.hardcoded,
      CacheExceptionType.unknown => 'Unknown error occurred'.hardcoded,
    };
  }
}
