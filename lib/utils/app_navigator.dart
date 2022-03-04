import 'package:flutter/widgets.dart';

abstract class AppNavigator {
  static late AppNavigator _instance;

  static init(AppNavigator instance) {
    _instance = instance;
  }

  Future<T?> push<T extends Object>(String routeName, {Object? arguments});

  Future<T?> pushAndRemoveUntil<T extends Object>(
      String newRouteName, bool Function(Route<dynamic>) predicate,
      {Object? arguments});

  static Future<T?> pushNamed<T extends Object>(String routeName,
      {Object? arguments}) async {
    return await _instance.push(routeName, arguments: arguments);
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object>(
      String newRouteName, bool Function(Route<dynamic>) predicate,
      {Object? arguments}) {
    return _instance.pushAndRemoveUntil(newRouteName, predicate,
        arguments: arguments);
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
