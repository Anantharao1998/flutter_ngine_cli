import 'package:dio/dio.dart';

import 'package:juno_provider_base_project/config/config.dart';
import 'package:juno_provider_base_project/core/errors/errors.dart';
import 'package:juno_provider_base_project/core/network/dio_client.dart';
import 'package:juno_provider_base_project/dependency_injection.dart';
import 'package:logger/logger.dart';

abstract class BaseRemoteDataSource with ErrorHandler {
  final DioClient dioClient = locator.get<DioClient>();

  final Logger _logger = FlavorConfig.instance.logger;

  Future<Response<T>> callApiWithErrorParser<T>(Future<Response<T>> api) async {
    try {
      final Response<T> response = await api;

      return response;
    } on DioException catch (dioError) {
      final Exception exception = handleDioError(dioError);
      _logger.e(
          'Throwing error from BaseRemoteDataSource: >>>>>>> $exception : ${(exception as BaseException).message}');
      throw exception;
    } catch (error, stackTrace) {
      _logger.e('Generic error: >>>>>>> $error');

      if (error is BaseException) {
        rethrow;
      }

      throw unHandledError('$error', stackTrace);
    }
  }
}
