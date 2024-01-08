part of '../films_page.dart';

final favoriteFilmsProvider = Provider<List<Film>>(
  (ref) => ref
      .watch(allFilmsStateNotifierProvider)
      .where((element) => element.isFavorite)
      .toList(),
);
