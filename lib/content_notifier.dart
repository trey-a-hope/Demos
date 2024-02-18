import 'dart:async';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentNotifier extends AsyncNotifier<List<String>> {
  final gemini = Gemini.instance;

  @override
  FutureOr<List<String>> build() => [];

  void clear() => state = const AsyncData([]);

  void submitSearch(String search) {
    state = AsyncData(
      [...state.value!],
    );

    state = const AsyncLoading();

    gemini.streamGenerateContent(search).handleError((e) {
      if (e is GeminiException) {
        state = AsyncError(e.toString(), StackTrace.current);
      }
    }).listen(
      (value) {
        if (value.output != null) {
          state = AsyncData(
            [
              ...state.value!,
              value.output!,
            ],
          );
        }
      },
    );
  }
}
