import 'package:demos/notifiers/counter_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final counterStateNotifierProvider =
    StateNotifierProvider<CounterStateNotifier, int?>(
  (ref) => CounterStateNotifier(null),
);
