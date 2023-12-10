import 'package:timeago/timeago.dart';

class MyCustomMessages implements LookupMessages {
  static const String _message = 'or something like that..';

  @override
  String prefixAgo() => 'I think it was like';
  @override
  String prefixFromNow() => 'It was probably like';
  @override
  String suffixAgo() => 'in the past...';
  @override
  String suffixFromNow() => 'in the future...';
  @override
  String lessThanOneMinute(int seconds) => 'now $_message';
  @override
  String aboutAMinute(int minutes) => '${minutes}m $_message';
  @override
  String minutes(int minutes) => '${minutes}m $_message';
  @override
  String aboutAnHour(int minutes) => '${minutes}m $_message';
  @override
  String hours(int hours) => '${hours}h $_message';
  @override
  String aDay(int hours) => '${hours}h $_message';
  @override
  String days(int days) => '${days}d $_message';
  @override
  String aboutAMonth(int days) => '${days}d $_message';
  @override
  String months(int months) => '${months}mo $_message';
  @override
  String aboutAYear(int year) => '${year}y $_message';
  @override
  String years(int years) => '${years}y $_message';
  @override
  String wordSeparator() => ' ';
}
