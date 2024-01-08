part of '../home_page.dart';

class CounterStateNotifier extends StateNotifier<int?> {
  CounterStateNotifier(super.state);
  void increment() => state = state == null ? 1 : state + 1;
}
