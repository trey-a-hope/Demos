import 'package:demos/enums/favorite_status.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final favoriteStatusStateProvider = StateProvider<FavoriteStatus>(
  (ref) => FavoriteStatus.all,
);
