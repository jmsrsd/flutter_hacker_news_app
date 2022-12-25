import 'package:flutter_hacker_news_app/src/types/data_source.dart';
import 'package:flutter_hacker_news_app/src/types/fetcher.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

MutationHook<T?> useMutation<T>(
  DataSource<void>? dataSource,
  Fetcher<T?, void> fetcher,
) {
  final loading = useState(0);
  final isLoading = loading.value > 0;

  return MutationHook<T>(
    isLoading: isLoading,
    mutate: ([T? input]) async {
      if (isLoading) {
        return;
      }

      await dataSource?.connect();
      loading.value++;
      await fetcher(input, dataSource);
      loading.value--;
      await dataSource?.disconnect();
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
