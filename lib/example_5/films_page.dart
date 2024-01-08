import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'models/film.dart';
part 'notifiers/films_state_notifier.dart';
part 'providers/all_films_state_notifier_provider.dart';
part 'providers/favorite_films_provider.dart';
part 'providers/not_favorite_films_provider.dart';
part 'providers/favorite_status_state_provider.dart';
part 'enums/favorite_status.dart';

const allFilms = [
  Film(
    id: '1',
    title: 'The Shawshank Redemption',
    description: 'Description for The Shawshank Redemption',
    isFavorite: false,
  ),
  Film(
    id: '2',
    title: 'The Godfather',
    description: 'Description for The Godfather',
    isFavorite: false,
  ),
  Film(
    id: '3',
    title: 'The Godfather II',
    description: 'Description for The Godfather II',
    isFavorite: false,
  ),
  Film(
    id: '4',
    title: 'Jurrasic Park',
    description: 'Description for Jurrasic Park',
    isFavorite: false,
  ),
];

class FilmsPage extends ConsumerWidget {
  const FilmsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Films Page'),
      ),
      body: Column(
        children: [
          const FilterWidget(),
          Consumer(
            builder: (context, ref, child) {
              final filter = ref.watch(favoriteStatusStateProvider);
              switch (filter) {
                case FavoriteStatus.all:
                  return FilmsWidget(provider: allFilmsStateNotifierProvider);
                case FavoriteStatus.favorite:
                  return FilmsWidget(provider: favoriteFilmsProvider);
                case FavoriteStatus.notFavorite:
                  return FilmsWidget(provider: notFavoriteFilmsProvider);
              }
            },
          )
          // FilmsWidget(provider: provider)
        ],
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) {
        return DropdownButton(
          value: ref.watch(favoriteStatusStateProvider),
          items: FavoriteStatus.values.map((fs) {
            return DropdownMenuItem(
              value: fs,
              child: Text(
                fs.toString().split('.').last,
              ),
            );
          }).toList(),
          onChanged: (FavoriteStatus? value) {
            ref.read(favoriteStatusStateProvider.state).state = value!;
          },
        );
      }),
    );
  }
}

class FilmsWidget extends ConsumerWidget {
  final AlwaysAliveProviderBase<List<Film>> provider;
  const FilmsWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return Expanded(
      child: films.isEmpty
          ? const Center(child: Text('No films in this category.'))
          : ListView.builder(
              itemCount: films.length,
              itemBuilder: ((context, index) {
                final film = films[index];

                final favoriteIcon = film.isFavorite
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border);
                return ListTile(
                  title: Text(film.title),
                  subtitle: Text(film.description),
                  trailing: IconButton(
                    icon: favoriteIcon,
                    onPressed: () {
                      final isFavorite = !film.isFavorite;

                      ref.read(allFilmsStateNotifierProvider.notifier).update(
                            film,
                            isFavorite,
                          );
                    },
                  ),
                );
              }),
            ),
    );
  }
}
