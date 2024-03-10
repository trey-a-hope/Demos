import 'package:flutter_riverpod/flutter_riverpod.dart';

enum QuestionState { notStarted, loading, answering, correct, incorrect }

class QuestionStateNotifier extends Notifier<QuestionState> {
  @override
  QuestionState build() => QuestionState.notStarted;

  void updateState(QuestionState questionState) {
    state = questionState;
  }
}
