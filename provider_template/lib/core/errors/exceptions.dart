abstract class BaseException implements Exception {
  final String message;
  final int statusCode;

  BaseException({this.message = '', this.statusCode = 0});
}

/// Throw when the API is returning HTTP 5xx
///
/// [statusCode] The error status returned by API.
/// Useful to either report to the Crashlytics, Sentry
/// or show in the UI so that it shown in the screenshot if user send to support
///
/// [statusCode] HTTP status code
///
/// [message] raw response return from API
class InternalServerErrorException extends BaseException {
  InternalServerErrorException({required String message, int statusCode = 0})
      : super(message: message, statusCode: statusCode);

  @override
  String toString() =>
      'ServerErrorException(statusCode: $statusCode, message: $message)';
}

class ServiceUnavailableException extends BaseException {
  ServiceUnavailableException(
      {required String message, required int statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String toString() =>
      'ServiceUnavailableException(statusCode: $statusCode, message: $message)';
}

class ForbiddenException extends BaseException {
  ForbiddenException({required String message, required int statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String toString() =>
      'ForbiddenException(statusCode: $statusCode, message: $message)';
}

class NotFoundException extends BaseException {
  NotFoundException({required String message, required int statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String toString() =>
      'NotFoundException(statusCode: $statusCode, message: $message)';
}

class UnauthorizedException extends BaseException {
  UnauthorizedException({required String message, required int statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String toString() =>
      'UnauthorizedException(statusCode: $statusCode, message: $message)';
}

class BadRequestException extends BaseException {
  BadRequestException({required String message, required int statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String toString() =>
      'UnauthorizedException(statusCode: $statusCode, message: $message)';
}

class UnhandledServerException extends BaseException {
  UnhandledServerException({required String message, required int statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String toString() =>
      'UnhandledServerException(statusCode: $statusCode, message: $message)';
}

/// Throw when API is returning API status that beyond our handling
/// or something we did not handle it
///
///
/// [body] raw response return from API
class UnhandledException extends BaseException {
  final StackTrace? stackTrace;
  UnhandledException({required String message, this.stackTrace})
      : super(message: message);
}

/// Throw when there is no internet connection available
class NoInternetConnectionException extends BaseException {
  NoInternetConnectionException({required String message})
      : super(message: message);
}

class TimeoutException extends BaseException {
  TimeoutException({required String message}) : super(message: message);
}

class BadCertificateException extends BaseException {
  BadCertificateException({required String message}) : super(message: message);
}

class BadResponseException extends BaseException {
  BadResponseException({required String message}) : super(message: message);
}

class CancellationException extends BaseException {
  CancellationException({required String message}) : super(message: message);
}

class JsonFormatException extends BaseException {
  JsonFormatException(String message) : super(message: message);
}

/*
 Database related exceptions
*/
class CacheException implements Exception {
  final String message;
  CacheException({required this.message});
}

// Exception to throw for local database implementation
class LocalDataBaseException extends BaseException {}
