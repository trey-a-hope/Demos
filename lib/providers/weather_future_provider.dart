// UI reads this.
import 'package:demos/config/typedefs.dart';
import 'package:demos/enums/city_enum.dart';
import 'package:demos/providers/current_city_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const unknownWeatherEmoji = '🤷';

final weatherProvider = FutureProvider<WeatherEmoji>((ref) {
  final city = ref.watch(currentCityStateProvider);
  if (city != null) {
    return getWeather(city);
  } else {
    return unknownWeatherEmoji;
  }
});

Future<WeatherEmoji> getWeather(City city) => Future.delayed(
      const Duration(seconds: 1),
      () => {
        City.stockholm: '❄️',
        City.paris: '🌧️',
        City.tokyo: '☁️',
      }[city]!,
    );
