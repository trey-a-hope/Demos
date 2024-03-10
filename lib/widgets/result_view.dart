import 'package:demos/notifiers/question_state_notifier.dart';
import 'package:demos/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class ResultView extends ConsumerWidget {
  const ResultView({
    super.key,
    required this.fruit,
    required this.correct,
  });

  final String fruit;
  final bool correct;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Expanded(
        child: Container(
          width: double.infinity,
          color: correct ? Colors.green : Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                  height: 200,
                  width: 200,
                  'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),
              Text(
                correct ? 'Bingo!' : 'Sorry',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                correct ? 'You picked $fruit.' : 'The answer was $fruit...',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              const Gap(32),
              ElevatedButton(
                onPressed: () {
                  //               ref
                  // .read(Providers.contentNotifier.notifier)
                  // .updateState(QuestionState.notStarted);
                  ref
                      .read(Providers.questionStateNotifier.notifier)
                      .updateState(QuestionState.notStarted);
                },
                child: const Text('Try Again'),
              )
            ],
          ),
        ),
      );
}
