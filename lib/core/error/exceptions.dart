library;

/// Database-related exceptions
class DatabaseException implements Exception {
  final String message;
  final int? code;
  final Exception? cause;

  const DatabaseException({required this.message, this.code, this.cause});

  @override
  String toString() =>
      'DatabaseException(message: $message, code: $code, cause: $cause)';
}

/// Cache-related exceptions
class CacheException implements Exception {
  final String message;
  final int? code;
  final Exception? cause;

  const CacheException({required this.message, this.code, this.cause});

  @override
  String toString() =>
      'CacheException(message: $message, code: $code, cause: $cause)';
}

/// Validation exceptions
class ValidationException implements Exception {
  final String message;
  final Map<String, String>? fieldErrors;

  const ValidationException({required this.message, this.fieldErrors});

  @override
  String toString() =>
      'ValidationException(message: $message, fieldErrors: $fieldErrors)';
}

/// File system exceptions
class FileSystemException implements Exception {
  final String message;
  final String? path;
  final Exception? cause;

  const FileSystemException({required this.message, this.path, this.cause});

  @override
  String toString() =>
      'FileSystemException(message: $message, path: $path, cause: $cause)';
}

/// JSON parsing exceptions
class JsonParsingException implements Exception {
  final String message;
  final String? json;
  final Exception? cause;

  const JsonParsingException({required this.message, this.json, this.cause});

  @override
  String toString() =>
      'JsonParsingException(message: $message, json: $json, cause: $cause)';
}
