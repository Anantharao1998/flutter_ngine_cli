import 'dart:io';
import 'package:dio/dio.dart';
import 'package:juno_provider_base_project/core/services/services.dart';
import 'package:juno_provider_base_project/core/values/values.dart';
import 'package:juno_provider_base_project/dependency_injection.dart';

class RequestHeaderInterceptor extends Interceptor {
  final StorageService _storageService = locator.get<StorageService>();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final Map<String, dynamic> extra = options.extra;
    final bool authorization = extra['authorization'];
    final String? accessToken = _storageService.getString(AppStrings.keyToken);

    options.headers[HttpHeaders.contentTypeHeader] =
        ApiConstants.contentTypeJson;

    if (authorization && accessToken != null) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }
}
