import 'app_error.dart';
import 'exceptions_messages.dart';

class NoInternetConnectionError extends AppError {
  NoInternetConnectionError() : super(ExcepetionMessage.noInternetError);

  @override
  String toString() {
    return "AppError [${super.message}]";
  }
}
