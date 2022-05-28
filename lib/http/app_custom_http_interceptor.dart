import 'package:commons_flutter/http/http_interceptor.dart';
import 'package:dio/dio.dart';

import 'app_http_error_detail.dart';

class AppCustomHttpInterceptor extends Interceptor {
  final ErrorHttpInterceptor customInterceptor;

  AppCustomHttpInterceptor(this.customInterceptor);

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    AppHttpErrorDetail detail = AppHttpErrorDetail(
      errorMessage: err.message,
      headers: err.requestOptions.headers,
      httpMethod: err.requestOptions.method,
      requestPayload: err.requestOptions.data,
      statusCode: err.response?.statusCode,
      baseUrl: err.requestOptions.baseUrl,
      path: err.requestOptions.path,
      url: '${err.requestOptions.baseUrl}${err.requestOptions.path}',
      originalError: err,
      dateTime: DateTime.now(),
    );

    customInterceptor.errorInterceptor(detail);
    handler.next(err);
  }
}
