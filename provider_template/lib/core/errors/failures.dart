abstract class Failure {
  final String message;
  final int? statusCode;
  Failure({required this.message, this.statusCode});

  String get detailedMessage;

  /// returning current class name as error type
  String get errorType => runtimeType.toString();
}

/// Throw if body string return is in valid json format, which cause it has the issue when trying to decode
/// Mostly will be thrown at data layer.
class JsonFormatFailure extends Failure {
  JsonFormatFailure({required String message}) : super(message: message);

  @override
  String get detailedMessage => '$message [err: json_err]';
}

/// Mobile is not connecting to wifi or data connection
class NoInternetConnectionFailure extends Failure {
  NoInternetConnectionFailure({String? message})
      : super(message: message ?? 'No internet connection');

  @override
  String get detailedMessage => message;
}

/// Thrown if server http status is 5xx
class InternalServerFailure extends Failure {
  InternalServerFailure({
    required String message,
    int? statusCode,
  }) : super(message: message, statusCode: statusCode);

  @override
  String get detailedMessage => '$message [statusCode: ${statusCode ?? 0}]';
}

/// Thrown if the status code return is not being handled
class UnhandledServerFailure extends Failure {
  UnhandledServerFailure({required String message, int? statusCode = 0})
      : super(message: message, statusCode: statusCode);

  @override
  String get detailedMessage =>
      '$message [err: unhandle_err] [statusCode: $statusCode]';
}

/// Thrown if some exception is not being handle properly
class UnhandledFailure extends Failure {
  final String className;
  final StackTrace? stackTrace;
  UnhandledFailure(
      {required this.className, required String message, this.stackTrace})
      : super(message: message);

  @override
  String get detailedMessage =>
      '$message ${stackTrace.toString()}\n[err: unhandle_failure] \n[className: $className]';
}

class ServiceUnavilableFailure extends Failure {
  ServiceUnavilableFailure({required String message, int? statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String get detailedMessage => message;
}

class ForbiddenFailure extends Failure {
  ForbiddenFailure({required String message, int? statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String get detailedMessage => message;
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({required String message, int? statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String get detailedMessage => message;
}

class TimeoutFailure extends Failure {
  TimeoutFailure({required String message}) : super(message: message);

  @override
  String get detailedMessage => message;
}

class BadCertificateFailure extends Failure {
  BadCertificateFailure({required String message, int? statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String get detailedMessage => message;
}

class BadResponseFailure extends Failure {
  BadResponseFailure({required String message, int? statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String get detailedMessage => message;
}

class CancellationFailure extends Failure {
  CancellationFailure({required String message, int? statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String get detailedMessage => message;
}

class BadRequestFailure extends Failure {
  BadRequestFailure({required String message, int? statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String get detailedMessage => message;
}

class NotFoundFailure extends Failure {
  NotFoundFailure({required String message, int? statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String get detailedMessage => message;
}
