import 'package:freezed_annotation/freezed_annotation.dart';
part 'cache_exception_type.dart';
part 'app_exception.freezed.dart';

// i made this extensible so that we can add more exceptions in the future
// if i want to add backend support, i can just add another factory
@freezed
class AppException with _$AppException implements Exception {
  const factory AppException.cacheException({
    required CacheExceptionType type,
    String? message,
    int? code,
  }) = CacheException;
}
