import 'package:timeago/timeago.dart';

class MyCustomMessages extends LookupMessages {
  static const String _message = 'or something like that..';

  @override
  String aDay(int hours) {
    // TODO: implement aDay
    throw UnimplementedError();
  }

  @override
  String aboutAMinute(int minutes) {
    // TODO: implement months
    throw UnimplementedError();
  }

  @override
  String aboutAMonth(int days) {
    // TODO: implement aboutAMonth
    throw UnimplementedError();
  }

  @override
  String aboutAYear(int year) {
    // TODO: implement aboutAYear
    throw UnimplementedError();
  }

  @override
  String aboutAnHour(int minutes) {
    // TODO: implement aboutAnHour
    throw UnimplementedError();
  }

  @override
  String days(int days) {
    // TODO: implement days
    throw UnimplementedError();
  }

  @override
  String hours(int hours) {
    // TODO: implement hours
    throw UnimplementedError();
  }

  @override
  String lessThanOneMinute(int seconds) {
    // TODO: implement months
    throw UnimplementedError();
  }

  @override
  String minutes(int minutes) => '${minutes}m $_message';

  @override
  String months(int months) {
    // TODO: implement months
    throw UnimplementedError();
  }

  @override
  String prefixAgo() => 'I think it was like';

  @override
  String prefixFromNow() => 'It was probably like';

  @override
  String suffixAgo() => 'in the past...';

  @override
  String suffixFromNow() => 'in the future...';

  @override
  String years(int years) {
    // TODO: implement years
    throw UnimplementedError();
  }
}
