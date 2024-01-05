import 'package:hooks_riverpod/hooks_riverpod.dart';

// This provider doesn't change.
// It can be refresh or invalidated.
final dateTimeProvider = Provider<DateTime>(
  (ref) => DateTime.now(),
);
