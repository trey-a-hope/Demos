part of '../home_page.dart';

final counterStateNotifierProvider =
    StateNotifierProvider<CounterStateNotifier, int?>(
  (ref) => CounterStateNotifier(null),
);
