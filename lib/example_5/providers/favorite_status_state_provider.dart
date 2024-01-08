part of '../films_page.dart';

final favoriteStatusStateProvider = StateProvider<FavoriteStatus>(
  (ref) => FavoriteStatus.all,
);
