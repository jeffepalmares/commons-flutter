class AppError implements Exception {
  String message;
  dynamic data;
  AppError(this.message, {this.data});

  @override
  String toString() {
    return "AppError [$message]";
  }
}
