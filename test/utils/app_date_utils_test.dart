import 'package:commons_flutter/utils/app_date_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[AppDateUtils]', () {
    group('[formatDate]', () {
      test('should return a date formated as yyyy-MM-dd HH:mm:ss', () {
        var date = DateTime(2022, 1, 20, 12, 00, 00);
        var formated = AppDateUtils.formatDate(date);
        expect(formated, equals("2022-01-20 12:00:00"));
      });
      test(
          'if no date is provided should return now date formated as yyyy-MM-dd HH:mm:ss',
          () {
        var date = DateTime.now();
        var formated = AppDateUtils.formatDate(null);
        expect(
            formated,
            equals(
                "${date.year}-${date.month < 10 ? "0${date.month}" : date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}"));
      });
    });

    group('[stringToFormatedDate]', () {
      test('should return a string date formated as dd/MM/yyyy HH:mm', () {
        var formated = AppDateUtils.stringToFormatedDate("2008-01-12 12:00:00");
        expect(formated, equals("12/01/2008 às 12:00"));
      });
    });
    group('[stringToDate]', () {
      test('should parse a string to valid date', () {
        var date = AppDateUtils.stringToDate("2008-01-15 12:00:00");
        expect(date.year, 2008);
        expect(date.month, 1);
        expect(date.day, 15);
        expect(date.hour, 12);
        expect(date.minute, 00);
      });
    });
    group('[stringToDate]', () {
      test('should return false in case day is different', () {
        var date1 = DateTime.now();
        var date2 = DateTime.now().add(Duration(days: 1));

        expect(AppDateUtils.isSameDate(date1, date2), isFalse);
      });
      test('should return false in case month is different', () {
        var date1 = DateTime.now();
        var date2 = DateTime(date1.year, date1.month + 1, date1.day, date1.hour,
            date1.minute, date1.second);

        expect(AppDateUtils.isSameDate(date1, date2), isFalse);
      });
      test('should return false in case year is different', () {
        var date1 = DateTime.now();

        var date2 = DateTime(date1.year + 1, date1.month, date1.day, date1.hour,
            date1.minute, date1.second);

        expect(AppDateUtils.isSameDate(date1, date2), isFalse);
      });
      test('should return true in case minutes is different', () {
        var date1 = DateTime.now();
        var date2 = DateTime.now().add(const Duration(minutes: 1));

        expect(AppDateUtils.isSameDate(date1, date2), isTrue);
      });
      test('should return true in case hours is different', () {
        var date1 = DateTime.now();
        var date2 = DateTime.now().add(const Duration(hours: 1));

        expect(AppDateUtils.isSameDate(date1, date2), isTrue);
      });
    });
  });
}
