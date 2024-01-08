part of '../films_page.dart';

final allFilmsStateNotifierProvider =
    StateNotifierProvider<FilmsStateNotifier, List<Film>>(
  (ref) => FilmsStateNotifier(),
);
