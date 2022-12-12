import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hacker_news_app/utils/noop.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Async<T> useAsync<T>(
  List<dynamic> keys,
  Future<T> Function() loader, {
  void Function() onRefresh = noop,
}) {
  final refreshing = useState(0);
  keys = [T, refreshing.value, ...keys];
  return Async<T>(
    snapshot: useFuture<T>(
      useMemoized<Future<T>>(loader, keys),
    ),
    refresh: useCallback(() {
      onRefresh();
      refreshing.value++;
    }, keys),
  );
}

enum AsyncStatus {
  loading,
  error,
  done,
}

class Async<T> {
  late final AsyncSnapshot<T> _snapshot;
  final void Function() refresh;

  Async({
    required AsyncSnapshot<T> snapshot,
    required this.refresh,
  }) {
    _snapshot = snapshot;
  }

  bool get hasLoaded => _snapshot.connectionState == ConnectionState.done;
  bool get hasError => _snapshot.hasError;
  bool get hasData => _snapshot.hasData;

  Object? get error => _snapshot.error;
  T? get data => _snapshot.data;
  T get requireData => _snapshot.requireData;

  AsyncStatus get status {
    if (!hasLoaded) {
      return AsyncStatus.loading;
    }
    return hasError ? AsyncStatus.error : AsyncStatus.done;
  }
}
