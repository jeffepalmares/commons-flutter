import 'package:commons_flutter/utils/app_string_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("[AppStringUtils]", () {
    group('[isEmptyOrNull]', () {
      test('In case send null should return true', () {
        expect(AppStringUtils.isEmptyOrNull(null), isTrue);
      });
      test('In case send empty string should return true', () {
        expect(AppStringUtils.isEmptyOrNull(""), isTrue);
        expect(AppStringUtils.isEmptyOrNull(''), isTrue);
      });
      test('In case send empty optional value string should return true', () {
        String? test;
        expect(AppStringUtils.isEmptyOrNull(test), isTrue);
      });
      test('In case send a valid value should return false', () {
        expect(AppStringUtils.isEmptyOrNull("value"), isFalse);
        expect(AppStringUtils.isEmptyOrNull('value'), isFalse);
      });
    });
    group('[isNotEmptyOrNull]', () {
      test('In case send null should return false', () {
        expect(AppStringUtils.isNotEmptyOrNull(null), isFalse);
      });
      test('In case send empty string should return false', () {
        expect(AppStringUtils.isNotEmptyOrNull(""), isFalse);
        expect(AppStringUtils.isNotEmptyOrNull(''), isFalse);
      });
      test('In case send empty optional value string should return false', () {
        String? test;
        expect(AppStringUtils.isNotEmptyOrNull(test), isFalse);
      });
      test('In case send a valid value should return true', () {
        expect(AppStringUtils.isNotEmptyOrNull("value"), isTrue);
        expect(AppStringUtils.isNotEmptyOrNull('value'), isTrue);
      });
    });

    group('[defaultValue]', () {
      test('In case send valid value should return the same value', () {
        String test = '';
        expect(AppStringUtils.defaultValue(test), equals(test));
        expect(AppStringUtils.defaultValue(test, defaultValue: "something"),
            equals(test));
      });
      test(
          'In case send null value and no default value be provided should return an empty string',
          () {
        String? test;
        expect(AppStringUtils.defaultValue(null), equals(""));
        expect(AppStringUtils.defaultValue(test), equals(""));
      });

      test(
          'In case send null value and provide a default value this provided value should be returned',
          () {
        String? test;
        String defaultValue = "default";
        expect(AppStringUtils.defaultValue(null, defaultValue: defaultValue),
            equals(defaultValue));
        expect(AppStringUtils.defaultValue(test, defaultValue: defaultValue),
            equals(defaultValue));
      });
    });

    group('random', () {
      test('should return a random string', () {
        var value = AppStringUtils.random();
        expect(value, isNotEmpty);
        expect(value, isNotNull);
      });
    });

    group('stringToNumber', () {
      test('in case value is null should return 0', () {
        var value = AppStringUtils.stringToNumber(null);
        expect(value, 0);
      });
      test('in case value is an empty string should return 0', () {
        var value = AppStringUtils.stringToNumber("");
        expect(value, 0);
      });
      test('in case is an null optiona value string should return 0', () {
        String? param;
        var value = AppStringUtils.stringToNumber(param);
        expect(value, 0);
      });
      test('in case pass a alphabetic value should return 0', () {
        var value = AppStringUtils.stringToNumber("te");
        expect(value, 0);
      });
    });
  });
}
