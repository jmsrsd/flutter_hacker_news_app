import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hacker_news_app/src/utils/is_equatable.dart';
import 'package:flutter_hacker_news_app/src/utils/noop.dart';
import 'package:flutter_hacker_news_app/src/utils/uncatch.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

AsyncHook<T> useAsync<T>(List keys, Future<T> Function() fetcher) {
  final invalidation = useState(0);

  keys = [...keys, invalidation.value].where((key) {
    return isEquatable(key);
  }).toList();

  final future = useFuture(
    useMemoized(fetcher, keys),
  );

  return AsyncHook(
    invalidation: invalidation,
    future: future,
  );
}

class AsyncHook<T> extends Equatable {
  late final ValueNotifier<int> _invalidation;
  late final AsyncSnapshot<T> _future;

  AsyncHook({
    required ValueNotifier<int> invalidation,
    required AsyncSnapshot<T> future,
  }) {
    _invalidation = invalidation;
    _future = future;
  }

  bool get isLoading {
    return _future.connectionState != ConnectionState.done;
  }

  T? get data {
    return _future.data;
  }

  Object? get error {
    return _future.error;
  }

  void invalidate() {
    uncatch(() => _invalidation.value++);
  }

  bool get isInvalidated {
    try {
      _invalidation.addListener(noop);
      _invalidation.removeListener(noop);
      return false;
    } catch (e) {
      return true;
    }
  }

  @override
  List<Object?> get props {
    return [_future];
  }
}
