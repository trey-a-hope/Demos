import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:demos/extensions/_extensions.dart';

class CounterStateNotifier extends StateNotifier<int?> {
  CounterStateNotifier(super.state);
  void increment() => state = state == null ? 1 : state + 1;
}
