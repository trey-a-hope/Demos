import 'package:demos/models/film.dart';
import 'package:demos/providers/all_films_state_notifier_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final favoriteFilmsProvider = Provider<List<Film>>(
  (ref) => ref
      .watch(allFilmsStateNotifierProvider)
      .where((element) => element.isFavorite)
      .toList(),
);
