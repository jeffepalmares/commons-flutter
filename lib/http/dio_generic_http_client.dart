import 'package:commons_flutter/constants/lib_constants.dart';
import 'package:commons_flutter/exceptions/app_error.dart';
import 'package:commons_flutter/utils/app_string_utils.dart';
import 'package:dio/dio.dart';
import 'app_http_client.dart';
import 'app_interceptor.dart';
import 'http_request_config.dart';

class DioHttpClient implements AppHttpClient {
  Dio? _dio;
  String Function()? _getToken;
  DioHttpClient(String baseUrl, {int? timeout, String Function()? getToken}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: timeout ?? LibConstants.defaultTimeoutTenSeconds,
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
      //AppAnalyticsUtils.log(name, parameters)
      var headers = options?.headers ?? {};
      var token = options?.token ?? (_getToken != null ? _getToken!() : null);
      if (!AppStringUtils.isEmptyOrNull(token)) {
        headers['Authorization'] = 'Bearer $token';
      }
      var response = await _dio!.request(
        url,
        data: data,
        options: Options(
            method: method,
            headers: headers,
            receiveTimeout:
                options?.timeout ?? LibConstants.defaultTimeoutTenSeconds,
            contentType: options?.contentType ?? "application/json"),
        onReceiveProgress: options?.receiveProgress,
      );
      if (response.data != null) {
        if (response.data['status'] == 'erro') {
          throw AppError(response.data['mensagem']);
        }
        return response.data as T;
      }
      return null;
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
