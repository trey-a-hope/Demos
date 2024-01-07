import 'package:demos/notifiers/person_change_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final personChangeNotifierProvider = ChangeNotifierProvider(
  (ref) => PersonChangeNotifier(),
);
