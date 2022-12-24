import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef MutationFetcher = Dio;

typedef Mutation<T> = Future<void> Function(
  T? input,
  MutationFetcher fetcher,
);

MutationHook<T> useMutation<T>(Mutation<T> mutation) {
  final loading = useState(0);
  final isLoading = loading.value > 0;

  return MutationHook<T>(
    isLoading: isLoading,
    mutate: ([T? input]) async {
      if (isLoading) {
        return;
      }

      final fetcher = MutationFetcher();
      loading.value++;
      await mutation(input, fetcher);
      loading.value--;
      fetcher.close();
    },
  );
}

class MutationHook<T> {
  final bool isLoading;
  final Future<void> Function([T? input]) mutate;

  MutationHook({
    required this.isLoading,
    required this.mutate,
  });
}
