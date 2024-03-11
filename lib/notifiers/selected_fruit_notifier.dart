import 'dart:math';

import 'package:demos/constants/globals.dart';
import 'package:demos/models/fruit.dart';
import 'package:demos/notifiers/question_state_notifier.dart';
import 'package:demos/providers.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedFruitNotifier extends Notifier<Fruit?> {
  var gemini = Gemini.instance;

  @override
  Fruit? build() => null;

  void getRandomFruit() {
    final index = Random().nextInt(Globals.fruits.length);
    final fruit = Globals.fruits[index];

    _query(fruit);

    state = fruit;
  }

  void _query(Fruit fruit) {
    // Build prompt.
    final prompt =
        'Give me a short rap about the fruit ${fruit.name}, but do not use the word ${fruit.name} in the rap.';

    gemini.streamGenerateContent(
      prompt,
      generationConfig: GenerationConfig(
        /*
        Temperature controls the degree of randomness in token selection. 
        Lower temperatures are good for prompts that require a less 
        open-ended or creative response, while higher temperatures can lead 
        to more diverse or creative results. A temperature of 0 means that
        the highest probability tokens are always selected.
        */
        temperature: 1.0,
        maxOutputTokens: 512,
      ),
      safetySettings: [
        // View the SafetyCategory and SafetyThreshold enums in their classes.
        SafetySetting(
          category: SafetyCategory.dangerous,
          threshold: SafetyThreshold.blockNone,
        ),
        SafetySetting(
          category: SafetyCategory.harassment,
          threshold: SafetyThreshold.blockLowAndAbove,
        ),
        SafetySetting(
          category: SafetyCategory.hateSpeech,
          threshold: SafetyThreshold.blockMediumAndAbove,
        ),
        SafetySetting(
          category: SafetyCategory.sexuallyExplicit,
          threshold: SafetyThreshold.blockOnlyHigh,
        ),
      ],
    ).listen(
      (contentStream) {
        // Set state to selecting.
        ref
            .read(Providers.questionStateNotifier.notifier)
            .updateState(QuestionState.answering);
      },
    );
  }
}
