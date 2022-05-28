import 'package:commons_flutter/exceptions/app_error.dart';
import 'package:dio/dio.dart';

import 'app_http_error_detail.dart';

abstract class ErrorHttpInterceptor extends Interceptor {
  void errorInterceptor(AppHttpErrorDetail errorDetail);

  void handleCustomError(AppError error) {
    if (error.data is RequestOptions) {
      var request = error.data as RequestOptions;
      errorInterceptor(AppHttpErrorDetail(
          dateTime: DateTime.now(),
          baseUrl: request.baseUrl,
          errorMessage: error.message,
          headers: request.headers,
          httpMethod: request.method,
          originalError: error,
          path: request.path,
          requestPayload: request.data,
          statusCode: 200,
          url: request.uri.toString()));
    }
  }
}
