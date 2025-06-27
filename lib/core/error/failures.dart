import 'package:equatable/equatable.dart';

/// Abstract base class for all failures in the application
/// Failures represent expected errors that can occur during business operations
abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

/// Database-related failures
class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message, super.code});

  @override
  String toString() => 'DatabaseFailure(message: $message, code: $code)';
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});

  @override
  String toString() => 'CacheFailure(message: $message, code: $code)';
}

/// Validation failures
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    required super.message,
    super.code,
    this.fieldErrors,
  });

  @override
  List<Object?> get props => [message, code, fieldErrors];

  @override
  String toString() =>
      'ValidationFailure(message: $message, code: $code, fieldErrors: $fieldErrors)';
}

/// General server or unexpected failures
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});

  @override
  String toString() => 'ServerFailure(message: $message, code: $code)';
}

/// File system related failures
class FileSystemFailure extends Failure {
  const FileSystemFailure({required super.message, super.code});

  @override
  String toString() => 'FileSystemFailure(message: $message, code: $code)';
}

/// Unexpected failures for unforeseen errors
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({required super.message, super.code});

  @override
  String toString() => 'UnexpectedFailure(message: $message, code: $code)';
}
