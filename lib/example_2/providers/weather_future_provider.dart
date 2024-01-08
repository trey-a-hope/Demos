part of '../weather_page.dart';

const unknownWeatherEmoji = '🤷';

final weatherFutureProvider = FutureProvider<WeatherEmoji>((ref) {
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
