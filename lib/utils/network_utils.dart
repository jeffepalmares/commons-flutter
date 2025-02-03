import 'package:commons_flutter/exceptions/no_internet_error.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkUtils {
  static Future<bool> hasInternetConnection() async {
    try {
      bool result = await InternetConnection().hasInternetAccess;
      return result;
    } catch (err) {
      // ignore: avoid_print
      print(err);
      return false;
    }
  }

  static Future<bool> isWifi() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      return connectivityResult.contains(ConnectivityResult.wifi);
    } catch (err) {
      // ignore: avoid_print
      print(err);
      return true;
    }
  }

  static Future<void> validateInternet() async {
    var hasInternet = await hasInternetConnection();
    if (!hasInternet) {
      throw NoInternetConnectionError();
    }
  }
}
