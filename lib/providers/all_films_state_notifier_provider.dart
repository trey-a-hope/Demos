import 'package:demos/models/film.dart';
import 'package:demos/notifiers/films_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final allFilmsStateNotifierProvider =
    StateNotifierProvider<FilmsStateNotifier, List<Film>>(
  (ref) => FilmsStateNotifier(),
);
