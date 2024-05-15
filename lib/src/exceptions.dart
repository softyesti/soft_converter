class SoftConverterException implements Exception {
  SoftConverterException([this.message]);

  final dynamic message;

  @override
  String toString() {
    if (message == null) return 'Exception';
    return 'Exception: $message';
  }
}

class SoftConverterProcessException extends SoftConverterException {
  SoftConverterProcessException(super.message, {required this.code});

  final int code;

  @override
  String toString() {
    if (message == null) return 'Exception';
    return 'Exception: $message. Error code: $code';
  }
}

class SoftConverterPathNotFound extends SoftConverterException {
  SoftConverterPathNotFound(super.message, {required this.path});

  final String path;

  @override
  String toString() {
    if (message == null) return 'Exception';
    return 'Exception: $message. Path: $path';
  }
}
