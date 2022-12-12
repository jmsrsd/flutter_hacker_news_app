import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Async<T> useAsync<T>(
  List<dynamic> keys,
  Future<T> Function() loader, {
  void Function()? onRefresh,
}) {
  final refreshing = useState(0);
  keys = [T, refreshing.value, ...keys];
  return Async<T>(
    value: useFuture<T>(
      useMemoized<Future<T>>(loader, keys),
    ),
    refresh: useCallback(() {
      (onRefresh ?? () {})();
      refreshing.value++;
    }, keys),
  );
}

class Async<T> {
  final AsyncSnapshot<T> value;
  final void Function() refresh;

  Async({
    required this.value,
    required this.refresh,
  });

  bool get isLoading {
    return value.connectionState != ConnectionState.done;
  }
}
