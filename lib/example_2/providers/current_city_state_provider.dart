part of '../weather_page.dart';

// UI writes to and reads from this.
final currentCityStateProvider = StateProvider<City?>(
  (ref) => null,
);
