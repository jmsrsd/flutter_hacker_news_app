import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/src/hooks/mutation_hook.dart';
import 'package:flutter_hacker_news_app/src/hooks/query_hook.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

int _counter = 0;

class CounterPage extends HookConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(context, ref) {
    final counterQuery = useQuery(
      _counter,
      (input, fetcher) async {
        await Future.delayed(const Duration(milliseconds: 700));
        return input;
      },
    );

    final incrementCounter = useMutation((input, fetcher) async {
      await Future.delayed(const Duration(milliseconds: 700));
      _counter++;
      counterQuery.invalidate();
    });

    final resetCounter = useMutation((input, fetcher) async {
      await Future.delayed(const Duration(milliseconds: 700));
      _counter = 0;
      counterQuery.invalidate();
    });

    final isLoading = [
      counterQuery.isLoading,
      incrementCounter.isLoading,
      resetCounter.isLoading,
    ].reduce((v, e) => v || e);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    counterQuery.data.toString(),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  ElevatedButton(
                    onPressed: resetCounter.mutate,
                    child: const Text('RESET'),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter.mutate,
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
