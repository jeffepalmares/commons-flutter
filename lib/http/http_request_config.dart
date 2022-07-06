enum HttpResponseType { json, stream, plain, bytes }

class HttpRequestConfig {
  Map<String, dynamic>? headers;
  String? contentType;
  String? token;
  int? timeout;
  String? baseUrl;
  HttpResponseType? responseType;
  Function(int count, int total)? receiveProgress;

  HttpRequestConfig({
    this.headers,
    this.contentType,
    this.token,
    this.timeout,
    this.responseType,
    this.baseUrl,
    this.receiveProgress,
  });
}
