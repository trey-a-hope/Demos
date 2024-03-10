import 'package:demos/notifiers/selected_fruit_notifier.dart';
import 'package:demos/notifiers/question_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Providers {
  static final questionStateNotifier =
      NotifierProvider<QuestionStateNotifier, QuestionState>(
    QuestionStateNotifier.new,
  );

  static final selectedFruitNotifier =
      NotifierProvider<SelectedFruitNotifier, String?>(
    SelectedFruitNotifier.new,
  );
}
