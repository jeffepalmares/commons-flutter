import 'package:commons_flutter/constants/lib_constants.dart';
import 'package:commons_flutter/exceptions/app_error.dart';
import 'package:commons_flutter/utils/app_string_utils.dart';
import 'package:commons_flutter/utils/network_utils.dart';
import 'package:dio/dio.dart';
import 'app_http_client.dart';
import 'app_interceptor.dart';
import 'http_request_config.dart';

class DioHttpClient implements AppHttpClient {
  Dio? _dio;
  String Function()? _getToken;
  int? _timeout;
  DioHttpClient(String baseUrl, {int? timeout, String Function()? getToken}) {
    _timeout = timeout ?? LibConstants.defaultTimeoutTenSeconds;
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
    ));

    _getToken = getToken;
    _dio?.interceptors.add(AppInterceptor());
  }

  @override
  Future<T?> delete<T>(String url, {data, HttpRequestConfig? options}) {
    return _executeRequest("DELETE", url, null, options);
  }

  @override
  Future<T?> get<T>(String url, {HttpRequestConfig? options}) {
    return _executeRequest("GET", url, null, options);
  }

  @override
  Future<T?> patch<T>(String url, {data, HttpRequestConfig? options}) {
    return _executeRequest("PATCH", url, data, options);
  }

  @override
  Future<T?> post<T>(String url, {data, HttpRequestConfig? options}) {
    return _executeRequest("POST", url, data, options);
  }

  Future<T?> _executeRequest<T>(
      String method, String url, data, HttpRequestConfig? options) async {
    try {
      //TODO AppAnalyticsUtils.log(name, parameters)
      await NetworkUtils.validateInternet();
      var configOptions = _getRequestOptions(method, url, data, options);
      var response = await _dio!.request(
        url,
        data: data,
        options: configOptions,
        onReceiveProgress: options?.receiveProgress,
      );
      if (response.data != null) {
        if (HttpResponseType.bytes != options?.responseType) {
          if (response.data['status'] == 'erro') {
            throw AppError(response.data['mensagem']);
          }
        } else {
          return response as T;
        }
        return response.data;
      }
      return null;
    } catch (err) {
      //TODO AppAnalyticsUtils.log(name, parameters)
      rethrow;
    }
  }

  Options _getRequestOptions(
      String method, String url, data, HttpRequestConfig? options) {
    var headers = options?.headers ?? {};
    var token = options?.token ?? (_getToken != null ? _getToken!() : null);
    if (!AppStringUtils.isEmptyOrNull(token)) {
      headers['Authorization'] = 'Bearer $token';
    }
    headers['Content-Type'] = options?.contentType ?? "application/json";
    return Options(
      method: method,
      headers: headers,
      responseType: _getResponseType(options?.responseType),
      receiveTimeout: _timeout,
    );
  }

  ResponseType? _getResponseType(HttpResponseType? type) {
    if (type == null) return null;
    switch (type) {
      case HttpResponseType.bytes:
        return ResponseType.bytes;
      case HttpResponseType.stream:
        return ResponseType.stream;
      case HttpResponseType.plain:
        return ResponseType.plain;
      default:
        return ResponseType.json;
    }
  }
}
