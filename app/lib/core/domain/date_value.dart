import 'package:nimbus/core/domain/value_objects/failures.dart';
import 'package:nimbus/core/domain/value_objects/validators.dart';
import 'package:nimbus/core/domain/value_objects/value_object.dart';
import 'package:nimbus/core/utils/datetime_extension.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

typedef FoldedString = Either<ValueFailure<String>, String>;

class DateValue extends ValueObject<String> {
  DateValue.create(String value)
      : super(validateDateString(value: value).andThen(formatDateValue(value)));

  static FoldedString formatDateValue(String dateString) {
    return Right(DateTime.parse(dateString).toLocal().toString());
  }

  DateTime fromDateValueToDateTime() {
    return DateTime.parse(getValue().toString());
  }

  bool isSameDate(DateValue date) {
    DateTime thisDate = fromDateValueToDateTime();
    DateTime dateTime = date.fromDateValueToDateTime();

    return dateTime.year == thisDate.year &&
        dateTime.month == thisDate.month &&
        dateTime.day == thisDate.day;
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  String parseToDdMmYyyyDate() {
    DateTime parsedDate = DateTime.parse(getValue());

    String dayWithPad =
        DateFormat.d().format(parsedDate).toString().padLeft(2, '0');

    String day = DateFormat.EEEE().format(parsedDate).toString();

    String monthWithPad =
        DateFormat.M().format(parsedDate).toString().padLeft(2, '0');

    int year = DateTime.parse(getValue()).year;

    return '$day, $dayWithPad.$monthWithPad.$year';
  }

  String parseToDdMmYyDate() {
    DateTime parsedDate = DateTime.parse(getValue());

    String dayWithPad =
        DateFormat.d().format(parsedDate).toString().padLeft(2, '0');

    String day = DateFormat.EEEE().format(parsedDate).toString();

    String monthWithPad =
        DateFormat.M().format(parsedDate).toString().padLeft(2, '0');

    int year = DateTime.parse(getValue()).year % 100;

    return '$day, $dayWithPad.$monthWithPad.$year';
  }

  String formatDateWithWeekday() {
    DateTime parsedDate = DateTime.parse(getValue());
    final formatter = DateFormat('EEEE, dd.MM.yyyy');
    return formatter.format(parsedDate);
  }

  String getTime() {
    DateTime parsedDate = DateTime.parse(getValue());

    return DateFormat.jm().format(parsedDate);
  }

  bool isToday() {
    DateTime date = DateTime.parse(getValue());
    DateTime now = DateTime.now();
    return date.isSameDate(now);
  }

  bool isTomorrow() {
    DateTime date = DateTime.parse(getValue());
    DateTime now = DateTime.now().add(const Duration(days: 1));
    return date.isSameDate(now);
  }

  bool isInTheFuture() {
    DateTime date = DateTime.parse(getValue());
    DateTime now = DateTime.now();
    return date.compareTo(now) > 0;
  }

  bool isAfter(DateValue compareDate) {
    DateTime date = DateTime.parse(getValue());
    DateTime compareDateParsed = DateTime.parse(compareDate.getValue());
    return date.compareTo(compareDateParsed) > 0;
  }

  bool isBefore(DateValue compareDate) {
    DateTime date = DateTime.parse(getValue());
    DateTime compareDateParsed = DateTime.parse(compareDate.getValue());
    return date.compareTo(compareDateParsed) < 0;
  }

  String getFormattedDate() {
    DateTime parsedDate = DateTime.parse(getValue());
    return DateFormat('dd.MM.yy').format(parsedDate);
  }

  DateValue addDays(int days) {
    return DateValue.create(
      fromDateValueToDateTime().add(Duration(days: days)).toString(),
    );
  }

  DateValue subsctractDays(int days) {
    return DateValue.create(
      fromDateValueToDateTime().subtract(Duration(days: days)).toString(),
    );
  }
}
