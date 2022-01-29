import 'package:commons_flutter/utils/app_string_utils.dart';

abstract class RegexUtils {
  static const String timeRegex = r"\d{2}:\d{2}";

  static RegExp _create(String regex,
      {bool caseSensitive = false, bool multiLine = false}) {
    return RegExp(
      regex,
      caseSensitive: caseSensitive,
      multiLine: multiLine,
    );
  }

  static bool isStringMatch(String? value, String regexValue,
      {bool caseSensitive = false, bool multiLine = false}) {
    value = AppStringUtils.defaultValue(value);

    var regex =
        _create(regexValue, caseSensitive: caseSensitive, multiLine: multiLine);
    return regex.hasMatch(value);
  }

  static String? extractStringMatch(String? value, String regexValue,
      {bool caseSensitive = false, bool multiLine = false}) {
    value = AppStringUtils.defaultValue(value);

    var regex =
        _create(regexValue, caseSensitive: caseSensitive, multiLine: multiLine);

    return regex.stringMatch(value);
  }
}
