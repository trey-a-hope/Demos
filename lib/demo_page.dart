import 'package:demos/constants/globals.dart';
import 'package:demos/providers.dart';
import 'package:demos/notifiers/question_state_notifier.dart';
import 'package:demos/widgets/result_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DemoPage extends ConsumerWidget {
  const DemoPage({super.key});

  Widget _buildButtonLayout({
    required QuestionState questionState,
    required TextEditingController controller,
    required void Function() start,
    required void Function() submit,
  }) {
    switch (questionState) {
      case QuestionState.notStarted:
        return Expanded(
          child: ElevatedButton(
            onPressed: start,
            child: const Text('Start'),
          ),
        );

      case QuestionState.loading:
        return const Expanded(
          child: ElevatedButton(
            onPressed: null,
            child: Text('Loading...'),
          ),
        );

      case QuestionState.answering:
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'What fruit is this rap about?',
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
                  onPressed: () => submit(),
                  icon: const Icon(
                    Icons.send,
                  ),
                ),
              ),
            ),
          ),
        );
      case QuestionState.correct:
      case QuestionState.incorrect:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    final questionState = ref.watch(Providers.questionStateNotifier);
    final selectedFruit = ref.watch(Providers.selectedFruitNotifier);

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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (questionState == QuestionState.correct) ...[
                ResultView(
                  fruit: selectedFruit!,
                  correct: true,
                )
              ],
              if (questionState == QuestionState.incorrect) ...[
                ResultView(
                  fruit: selectedFruit!,
                  correct: false,
                )
              ],
              if (questionState != QuestionState.correct &&
                  questionState != QuestionState.incorrect) ...[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                          } else {
                            return const Text('Let\'s Get Started!');
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      _buildButtonLayout(
                        controller: controller,
                        questionState: questionState,
                        start: () {
                          // Set to loading state.
                          ref
                              .read(Providers.questionStateNotifier.notifier)
                              .updateState(QuestionState.loading);

                          // Get a random fruit.
                          ref
                              .read(Providers.selectedFruitNotifier.notifier)
                              .getRandomFruit();
                        },
                        submit: () {
                          final choiceFruit = controller.text;
                          if (selectedFruit!.name == choiceFruit) {
                            ref
                                .read(Providers.questionStateNotifier.notifier)
                                .updateState(QuestionState.correct);
                          } else {
                            ref
                                .read(Providers.questionStateNotifier.notifier)
                                .updateState(QuestionState.incorrect);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
