/// Standard `soft_converter` exception.
class SoftConverterException implements Exception {
  /// Creates a new [SoftConverterException].
  const SoftConverterException([this.message]);

  /// Exception message.
  final dynamic message;

  @override
  String toString() {
    if (message == null) return 'Exception';
    return 'Exception: $message';
  }
}

/// Exception from a `soft_converter` process.
class SoftConverterProcessException extends SoftConverterException {
  /// Creates a new [SoftConverterProcessException].
  const SoftConverterProcessException(super.message, {required this.code});

  /// Error code.
  final int code;

  @override
  String toString() {
    if (message == null) return 'Exception';
    return 'Exception: $message. Error code: $code';
  }
}

/// “Path not found” exception from `soft_converter`.
class SoftConverterPathNotFound extends SoftConverterException {
  /// Creates a new [SoftConverterPathNotFound].
  SoftConverterPathNotFound(super.message, {required this.path});

  /// File or Directory path.
  final String path;

  @override
  String toString() {
    if (message == null) return 'Exception';
    return 'Exception: $message. Path: $path';
  }
}
