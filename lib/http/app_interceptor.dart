import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logRequest(options);
    options.headers['startRequest'] = DateTime.now().microsecondsSinceEpoch;
    options.path = Uri.encodeFull(options.path);
    debugPrint("[REQUEST]::[PATH]::${options.baseUrl}${options.path}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logResponse(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    // AppAnalytics.log(name: 'http-error', parameters: {
    //   'statusCode': err.response?.statusCode,
    //   'path': err.requestOptions.path,
    //   'errorMessage': err.message,
    //   'error': err.response?.data?.toString() ?? "-",
    // });
    handler.next(err);
  }

  _logResponse(Response response) {
    try {
      debugPrint(
          "[RESPONSE]::[${response.statusCode}]::[${(response.requestOptions.baseUrl + response.requestOptions.path)}]");
      var startRequest = response.requestOptions.headers['startRequest'];
      if (startRequest != null) {
        var result = DateTime.now()
            .difference(DateTime.fromMicrosecondsSinceEpoch(startRequest))
            .inMilliseconds;
        debugPrint("[Request Duration]::[$result ms]");
      }
      debugPrint("[Headers]");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _logRequest(RequestOptions options) {
    debugPrint(
        "--> ${options.method.toUpperCase()} ${(options.baseUrl) + (options.path)}");
    debugPrint("Headers:");
    options.headers.forEach((k, v) => print('$k: $v'));
    if (options.data != null) {
      debugPrint("Body: ${options.data}");
    }
  }
}
