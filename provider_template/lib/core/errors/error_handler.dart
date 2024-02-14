import 'dart:io';
import 'package:dio/dio.dart';
import 'package:juno_provider_base_project/config/config.dart';
import 'package:juno_provider_base_project/core/errors/errors.dart';
import 'package:juno_provider_base_project/core/values/values.dart';
import 'package:logger/logger.dart';

mixin ErrorHandler {
  /// Supported exception map to failure
  ///
  /// - FormatException => JsonFormatFailure
  /// - ConnectionUnavailableException => ConnectionUnavailableFailure
  /// - ServerErrorException => ServerFailure
  /// - UnhandledServerErrorException => UnhandledServerFailure

  Failure mapExceptionToFailure(Exception exception) {
    if (exception is InternalServerErrorException) {
      return InternalServerFailure(message: exception.message);
    }
    if (exception is ServiceUnavailableException) {
      return ServiceUnavilableFailure(message: exception.message);
    }
    if (exception is ForbiddenException) {
      return ForbiddenFailure(message: exception.message);
    }
    if (exception is NotFoundException) {
      return NotFoundFailure(message: exception.message);
    }
    if (exception is UnauthorizedException) {
      return UnauthorizedFailure(message: exception.message);
    }
    if (exception is BadRequestException) {
      return BadRequestFailure(message: exception.message);
    }
    if (exception is UnhandledServerException) {
      return UnhandledServerFailure(message: exception.message);
    }
    if (exception is UnhandledException) {
      return UnhandledFailure(
          className: exception.runtimeType.toString(),
          message: exception.message);
    }
    if (exception is NoInternetConnectionException) {
      return NoInternetConnectionFailure(message: exception.message);
    }
    if (exception is TimeoutException) {
      return TimeoutFailure(message: exception.message);
    }
    if (exception is BadCertificateException) {
      return BadCertificateFailure(message: exception.message);
    }
    if (exception is BadResponseException) {
      return BadResponseFailure(message: exception.message);
    }
    if (exception is CancellationException) {
      return CancellationFailure(message: exception.message);
    }

    if (exception is FormatException) {
      return JsonFormatFailure(message: exception.message);
    }

    return UnhandledFailure(
        className: exception.runtimeType.toString(),
        message: AppStrings.unhandledError);
  }

  Exception handleDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(message: dioError.message ?? '');

      case DioExceptionType.badCertificate:
        return BadCertificateException(message: dioError.message ?? '');

      case DioExceptionType.badResponse:
        return BadResponseException(message: dioError.message ?? '');

      case DioExceptionType.cancel:
        return CancellationException(message: dioError.message ?? '');

      case DioExceptionType.connectionError:
        return NoInternetConnectionException(message: dioError.message ?? '');

      case DioExceptionType.unknown:
        return _parseDioErrorResponse(dioError.response!);
    }
  }

  Exception _parseDioErrorResponse(Response response) {
    final Logger logger = FlavorConfig.instance.logger;

    int statusCode = -1;
    String? serverMessage;

    try {
      statusCode = response.data['statusCode'];

      serverMessage = response.data['statusMessage'];
    } catch (e, s) {
      logger.i('$e');
      logger.i(s.toString());

      if (e is FormatException) {
        return JsonFormatException(e.message);
      }

      serverMessage = e.toString();
    }

    switch (statusCode) {
      case HttpStatus.serviceUnavailable:
        return ServiceUnavailableException(
            message: serverMessage ?? '', statusCode: statusCode);
      case HttpStatus.notFound:
        return NotFoundException(
            message: serverMessage ?? '', statusCode: statusCode);
      case HttpStatus.unauthorized:
        return UnauthorizedException(
            message: serverMessage ?? '', statusCode: statusCode);
      case HttpStatus.forbidden:
        return ForbiddenException(
            message: serverMessage ?? '', statusCode: statusCode);
      case HttpStatus.badRequest:
        return BadRequestException(
            message: serverMessage ?? '', statusCode: statusCode);
      case HttpStatus.internalServerError:
        return InternalServerErrorException(
            message: serverMessage ?? '', statusCode: statusCode);
      default:
        return UnhandledServerException(
            statusCode: statusCode, message: serverMessage ?? '');
    }
  }

  Exception unHandledError(String error, StackTrace? stackTrace) {
    final logger = FlavorConfig.instance.logger;
    logger.e('Unhandled exception: $error');

    return UnhandledException(message: error, stackTrace: stackTrace);
  }
}
