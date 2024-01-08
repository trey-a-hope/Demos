part of '../films_page.dart';

// StateNotifier vs. ChangeNotifier.
// StateNotifier updates when state is changed,
// whereas ChangeNotifier is updated when notifyListeners
// is called.

class FilmsStateNotifier extends StateNotifier<List<Film>> {
  // Pass in all films by default.
  FilmsStateNotifier() : super(allFilms);

  void update(Film film, bool isFavorite) {
    state = state
        .map((thisFilm) => thisFilm.id == film.id
            ? film.copyWith(isFavorite: isFavorite)
            : thisFilm)
        .toList();
  }
}
