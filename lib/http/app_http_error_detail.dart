class AppHttpErrorDetail {
  final String? url;
  final String? baseUrl;
  final String? path;
  final String? httpMethod;
  final Map<String, dynamic>? headers;
  final int? statusCode;
  final dynamic requestPayload;
  final String? errorMessage;
  final DateTime dateTime;
  final dynamic originalError;

  AppHttpErrorDetail({
    this.url,
    this.baseUrl,
    this.path,
    this.httpMethod,
    this.headers,
    this.statusCode,
    this.requestPayload,
    this.errorMessage,
    this.originalError,
    required this.dateTime,
  });
}
