import 'package:demos/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DemoPage extends ConsumerWidget {
  DemoPage({super.key});

  final gemini = Gemini.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
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
              ElevatedButton(
                onPressed: () => _streamGenerateContent(),
                child: const Text('Generate'),
              )
            ],
          ),
        ),
      );

  void _streamGenerateContent() {
    final prompt =
        'Give me a short rap about the fruit Cherry, but do not use the word Cherry in the rap.';

    gemini.streamGenerateContent(
      prompt,
      generationConfig: GenerationConfig(
        temperature: 1,
        maxOutputTokens: 500,
      ),
      safetySettings: [],
    ).listen((event) {});
  }
}
