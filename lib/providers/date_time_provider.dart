import 'package:hooks_riverpod/hooks_riverpod.dart';

final dateTimeProvider = Provider<DateTime>(
  (ref) => DateTime.now(),
);
