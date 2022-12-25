import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/src/hooks/mutation_hook.dart';
import 'package:flutter_hacker_news_app/src/hooks/query_hook.dart';
import 'package:flutter_hacker_news_app/src/utils/delay.dart';
import 'package:flutter_hacker_news_app/src/utils/evalutate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final counterProvder = StateProvider((ref) {
  return 0;
});

class CounterPage extends HookConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(context, ref) {
    final counterController = ref.read(counterProvder.notifier);

    final counter = useQuery(
      input: counterController.state,
      fetcher: (input, _) async {
        await delay(700);
        return input;
      },
    );

    final incrementCounter = useMutation<void>(
      fetcher: (_, __) async {
        await delay(700);
        counterController.update((state) => state + 1);
        counter.invalidate();
      },
    );

    final resetCounter = useMutation<void>(
      fetcher: (_, __) async {
        await delay(700);
        counterController.update((state) => 0);
        counter.invalidate();
      },
    );

    final isLoading = [
      counter.isLoading,
      incrementCounter.isLoading,
      resetCounter.isLoading,
    ].reduce((v, e) => v || e);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: evaluate(() {
          if (isLoading) {
            return const CircularProgressIndicator();
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                counter.data.toString(),
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: resetCounter.mutate,
                child: const Text('RESET'),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter.mutate,
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
