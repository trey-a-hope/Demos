import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'providers/ticker_stream_provider.dart';
part 'providers/names_stream_provider.dart';

class TimePage extends ConsumerWidget {
  const TimePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Page'),
      ),
      body: names.when(
        data: (names) {
          return ListView.builder(
            itemCount: names.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(names[index]),
            ),
          );
        },
        error: (error, stackTrace) =>
            const Text('Reached the end of the list.'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
