class AppError implements Exception {
  String message;
  AppError(this.message);

  @override
  String toString() {
    return "AppError [$message]";
  }
}
