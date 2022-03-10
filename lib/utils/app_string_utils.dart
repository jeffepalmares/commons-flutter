import 'package:random_string_generator/random_string_generator.dart';

class AppStringUtils {
  static final RandomStringGenerator _stringGenerate3 = RandomStringGenerator(
    hasAlpha: true,
    alphaCase: AlphaCase.MIXED_CASE,
    hasDigits: true,
    hasSymbols: false,
    fixedLength: 3,
    mustHaveAtLeastOneOfEach: false,
  );
  static final RandomStringGenerator _stringGenerate5 = RandomStringGenerator(
    hasAlpha: true,
    alphaCase: AlphaCase.MIXED_CASE,
    hasDigits: true,
    hasSymbols: false,
    fixedLength: 5,
    mustHaveAtLeastOneOfEach: false,
  );

  static bool isNotEmptyOrNull(String? value) {
    return !isEmptyOrNull(value);
  }

  static bool isEmptyOrNull(String? value) {
    return (value == null || value.isEmpty);
  }

  static String defaultValue(String? value, {String? defaultValue}) {
    return value ?? (defaultValue ?? "");
  }

  static String random() {
    return "${_stringGenerate3.generate()}-${_stringGenerate5.generate()}-${_stringGenerate3.generate()}";
  }

  static int stringToNumber(String? value) {
    try {
      return int.parse(value ?? '0');
    } catch (e) {
      return 0;
    }
  }

  static String reverseString(String? value) {
    try {
      value = defaultValue(value);
      value = value.split('').reversed.join();
      return value;
    } catch (e) {
      return "";
    }
  }
}
