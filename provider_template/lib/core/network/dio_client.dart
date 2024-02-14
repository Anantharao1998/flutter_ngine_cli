import 'package:dio/dio.dart';
import 'package:juno_provider_base_project/config/config.dart';
import 'package:juno_provider_base_project/core/errors/errors.dart';
import 'package:juno_provider_base_project/core/network/interceptors/interceptors.dart';
import 'package:juno_provider_base_project/core/network/util/pretty_dio_logger.dart';
import 'package:juno_provider_base_project/core/values/values.dart';
import 'util/connection_checker.dart';

abstract class DioClient {
  Future<Response<dynamic>> get(String uri,
      {String? fullUrl,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      ProgressCallback? onReceiveProgress,
      bool authorization = true,
      int? timeout});

  Future<Response<dynamic>> post(String uri,
      {required dynamic body,
      String? fullUrl,
      Map<String, dynamic>? headers,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool authorization = true,
      int? timeout});

  Future<Response<dynamic>> put(String uri,
      {required dynamic body,
      String? fullUrl,
      Map<String, dynamic>? headers,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool authorization = true,
      int? timeout});

  Future<Response<dynamic>> delete(String uri,
      {required dynamic body,
      String? fullUrl,
      Map<String, dynamic>? headers,
      bool authorization = true,
      int? timeout});

  Future<Response<dynamic>> download(String uri, String savePath,
      {String? fullUrl,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      ProgressCallback? onReceiveProgress,
      bool authorization = true,
      int? timeout});
}

class DioClientImpl implements DioClient {
  final Dio dio;
  Dio? tokenDio; // Dio instance to be used for refreshToken only
  final String _baseUrl = Environment.apiUrl;
  final ConnectionChecker connectionChecker;

  static const int _maxLineWidth = 90;

  static final _prettyDioLogger = PrettyDioLogger(
      requestHeader: !FlavorConfig
          .isProduction, // print requestHeader if only on DEV or UAT environment
      requestBody: true,
      responseBody: !FlavorConfig
          .isProduction, // print responseBody if only on DEV or UAT environment
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: _maxLineWidth);

  DioClientImpl({required this.dio, required this.connectionChecker}) {
    tokenDio = Dio();

    dio
      ..options.baseUrl = _baseUrl
      ..options.connectTimeout =
          const Duration(seconds: ApiConstants.connectTimeoutInMs)
      ..options.receiveTimeout =
          const Duration(seconds: ApiConstants.receiveTimeoutInMs)
      ..interceptors.add(RequestHeaderInterceptor())
      ..interceptors.add(UserAgentClientInterceptor());

    tokenDio!
      ..options.connectTimeout =
          const Duration(seconds: ApiConstants.connectTimeoutInMs)
      ..options.receiveTimeout =
          const Duration(seconds: ApiConstants.receiveTimeoutInMs);

    if (!FlavorConfig.isProduction) {
      dio.interceptors.add(_prettyDioLogger);

      tokenDio!.interceptors.add(_prettyDioLogger);
    }
  }

  @override
  Future<Response<dynamic>> get(String uri,
      {String? fullUrl,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      ProgressCallback? onReceiveProgress,
      bool authorization = false,
      int? timeout}) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': authorization
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    return await dio.get(fullUrl ?? uri,
        queryParameters: queryParameters,
        options: Options(headers: headers, extra: extra),
        onReceiveProgress: onReceiveProgress);
  }

  @override
  Future<Response<dynamic>> post(String uri,
      {required dynamic body,
      String? fullUrl,
      Map<String, dynamic>? headers,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool authorization = false,
      int? timeout}) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': authorization
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      tokenDio!.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    return await dio.post(fullUrl ?? uri,
        data: body,
        options: Options(headers: headers, extra: extra),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  @override
  Future<Response<dynamic>> put(String uri,
      {required dynamic body,
      String? fullUrl,
      Map<String, dynamic>? headers,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool authorization = false,
      int? timeout}) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': authorization
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    return await dio.put(fullUrl ?? uri,
        data: body,
        options: Options(headers: headers, extra: extra),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  @override
  Future<Response<dynamic>> delete(String uri,
      {required dynamic body,
      String? fullUrl,
      Map<String, dynamic>? headers,
      bool authorization = true,
      int? timeout}) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': authorization
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    return await dio.delete(fullUrl ?? uri,
        data: body, options: Options(headers: headers, extra: extra));
  }

  @override
  Future<Response<dynamic>> download(String uri, String savePath,
      {String? fullUrl,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      ProgressCallback? onReceiveProgress,
      bool authorization = false,
      int? timeout}) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': authorization
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    return await dio.download(fullUrl ?? uri, savePath,
        queryParameters: queryParameters,
        options: Options(headers: headers, extra: extra),
        onReceiveProgress: onReceiveProgress);
  }

  /// helper function to check if mobile has connection before making API request
  Future<void> _throwExceptionIfNoConnection() async {
    if (await connectionChecker.isConnected() == NetworkStatus.offline) {
      throw NoInternetConnectionException(
          message: AppStrings.noInternetConnection);
    }
  }
}
