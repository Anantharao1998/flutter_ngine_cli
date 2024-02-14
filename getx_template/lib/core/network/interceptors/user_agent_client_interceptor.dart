import 'package:dio/dio.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

class UserAgentClientInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Add User-Agent Client Hints
    final Map<String, String> userAgentClintHintsData =
        await userAgentClientHintsHeader();

    options.headers.addAll({
      'User-Agent': await userAgent(),
      'Sec-CH-UA-Mobile': userAgentClintHintsData['Sec-CH-UA-Mobile'],
    });

    return handler.next(options);
  }
}
