import 'package:demos/models/fruit.dart';
import 'package:demos/notifiers/ui_state_notifier.dart';
import 'package:demos/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ResultsView extends ConsumerWidget {
  final bool correct;
  final Fruit fruit;

  const ResultsView({
    required this.correct,
    required this.fruit,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
        width: double.infinity,
        height: double.infinity,
        color: correct ? fruit.color : Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            fruit.lottie,
            Text(
              correct ? 'Bingo!' : 'Sorry',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
            Text(
              correct
                  ? 'You picked ${fruit.name}.'
                  : 'The answer was ${fruit.name}...',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const Gap(32),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(Providers.uiStateNotifier.notifier)
                    .updateState(UIState.notStarted);
              },
              child: const Text('Try Again'),
            )
          ],
        ),
      );
}
