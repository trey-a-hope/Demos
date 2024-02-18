import 'package:demos/content_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Providers {
  static final contentNotifier =
      AsyncNotifierProvider<ContentNotifier, List<String>>(
    ContentNotifier.new,
  );
}
