import 'package:demos/extensions/num_extensions.dart';
import 'package:demos/extensions/bool_extensions.dart';

import 'package:demos/providers/counter_state_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void testIt() {
    final int? int1 = 1;
    final int int2 = 1;
    final result = int1 + int2;

    bool online = false;
    bool selfish = true;

    bool total = online * selfish;
    debugPrint('$total');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          // Using the local "ref" and Consumer to prevent unnecessary rebuilds of the entire Scaffold.
          builder: (context, ref, child) {
            final int? count = ref.watch(counterStateNotifierProvider);
            final text = count == null ? 'Press the button' : count.toString();
            return Text(text);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed:
                ref.read(counterStateNotifierProvider.notifier).increment,
            child: const Text(
              'Increment Counter',
            ),
          ),
        ],
      ),
    );
  }
}
