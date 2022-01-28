import 'http_request_config.dart';

abstract class AppHttpClient {
  Future get<T>(String url, {HttpRequestConfig options});
  Future<T?> post<T>(String url, {data, HttpRequestConfig? options});
  Future<T?> patch<T>(String url, {data, HttpRequestConfig? options});
  Future<T?> delete<T>(String url, {data, HttpRequestConfig? options});
}