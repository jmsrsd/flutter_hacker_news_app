import 'package:flutter/widgets.dart';
import 'package:flutter_hacker_news_app/src/utils/is_equatable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

SWRHook<T> useSWR<T>(List keys, Future<T> Function() fetcher) {
  final invalidation = useState(0);

  keys = [...keys, invalidation.value].where((key) {
    return isEquatable(key);
  }).toList();

  final loader = useFuture(
    useMemoized(fetcher, keys),
  );

  return SWRHook(
    invalidation: invalidation,
    loader: loader,
  );
}

class SWRHook<T> {
  late final ValueNotifier<int> _invalidation;
  late final AsyncSnapshot<T> _loader;

  SWRHook({
    required ValueNotifier<int> invalidation,
    required AsyncSnapshot<T> loader,
  }) {
    _invalidation = invalidation;
    _loader = loader;
  }

  bool get isLoading {
    return _loader.connectionState != ConnectionState.done;
  }

  T? get data {
    return _loader.data;
  }

  Object? get error {
    return _loader.error;
  }

  void invalidate() {
    _invalidation.value += 1;
  }
}
