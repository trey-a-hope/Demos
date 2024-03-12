import 'package:demos/notifiers/ui_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Providers {
  static final uiStateNotifier =
      NotifierProvider<UIStateNotifier, UIState>(UIStateNotifier.new);
}
