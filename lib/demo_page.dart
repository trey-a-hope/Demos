import 'package:demos/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DemoPage extends ConsumerWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    final content = ref.watch(Providers.contentNotifier);
    final contentNotifier = ref.read(Providers.contentNotifier.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini'),
        leading: IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: content.when(
                  data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(data[index]),
                    ),
                  ),
                  error: (error, stackTrace) => Text('Error: $error'),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'Enter a prompt here.',
                    border: const OutlineInputBorder(),
                    prefix: IconButton(
                      onPressed: () => controller.clear(),
                      icon: const Icon(
                        Icons.cancel,
                      ),
                    ),
                    suffix: IconButton(
                      onPressed: () =>
                          contentNotifier.submitSearch(controller.text),
                      icon: const Icon(
                        Icons.send,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
