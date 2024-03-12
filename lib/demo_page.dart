import 'dart:math';

import 'package:demos/constants/globals.dart';
import 'package:demos/models/fruit.dart';
import 'package:demos/notifiers/ui_state_notifier.dart';
import 'package:demos/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DemoPage extends ConsumerStatefulWidget {
  const DemoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DemoPageState();
}

class _DemoPageState extends ConsumerState<DemoPage> {
  final gemini = Gemini.instance;
  final controller = TextEditingController();
  late Fruit fruit;

  Widget _buildButton(UIState uiState) {
    switch (uiState) {
      case UIState.notStarted:
        return ElevatedButton(
          onPressed: () {
            ref
                .read(Providers.uiStateNotifier.notifier)
                .updateState(UIState.loading);

            _streamGenerateContent();
          },
          child: const Text('Let\'s Get Started'),
        );
      case UIState.loading:
        return const ElevatedButton(
          onPressed: null,
          child: Text('Loading...'),
        );
      case UIState.loaded:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Which fruit is this rap about?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              prefix: IconButton(
                onPressed: () => controller.clear(),
                icon: const Icon(
                  Icons.cancel,
                ),
              ),
              suffix: IconButton(
                onPressed: () {
                  if (controller.text == fruit.name) {
                    ref
                        .read(Providers.uiStateNotifier.notifier)
                        .updateState(UIState.correct);
                  } else {
                    ref
                        .read(Providers.uiStateNotifier.notifier)
                        .updateState(UIState.incorrect);
                  }
                },
                icon: const Icon(
                  Icons.send,
                ),
              ),
            ),
          ),
        );
      case UIState.correct:
      case UIState.incorrect:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final uiState = ref.watch(Providers.uiStateNotifier);

    if (uiState == UIState.correct) {
      return const Center(child: Text('Correct'));
    }

    if (uiState == UIState.incorrect) {
      return const Center(child: Text('Incorrect'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fruit Rap',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: SingleChildScrollView(
                  child: GeminiResponseTypeView(
                    builder: (context, child, response, loading) {
                      if (loading) {
                        return Globals.lottieFruitBasket;
                      }

                      if (response != null) {
                        return Text(
                          response,
                          style: const TextStyle(fontSize: 20),
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ),
            _buildButton(uiState),
          ],
        ),
      ),
    );
  }

  void _streamGenerateContent() {
    fruit = Globals.fruits[Random().nextInt(Globals.fruits.length)];

    final prompt =
        'Give me a short rap about the fruit ${fruit.name}, but do not use the word ${fruit.name} in the rap.';

    gemini.streamGenerateContent(
      prompt,
      generationConfig: GenerationConfig(
        temperature: 1,
        maxOutputTokens: 500,
      ),
      safetySettings: [
        SafetySetting(
          category: SafetyCategory.hateSpeech,
          threshold: SafetyThreshold.blockLowAndAbove,
        ),
      ],
    ).listen((event) {
      ref.read(Providers.uiStateNotifier.notifier).updateState(UIState.loaded);
    });
  }
}
