import 'package:demos/enums/city_enum.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// UI writes to and reads from this.
final currentCityStateProvider = StateProvider<City?>(
  (ref) => null,
);
