import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Fetch<T> useFetch<T>(
  List<dynamic> keys,
  Future<T> Function() fetcher, {
  void Function()? onRefetch,
}) {
  final refetching = useState(0);
  keys = [T, refetching.value, ...keys];
  return Fetch<T>(
    fetched: useFuture<T>(useMemoized<Future<T>>(fetcher, keys)),
    refetch: useCallback(() {
      (onRefetch ?? () {})();
      refetching.value++;
    }, keys),
  );
}

class Fetch<T> {
  final AsyncSnapshot<T> fetched;
  final void Function() refetch;

  Fetch({
    required this.fetched,
    required this.refetch,
  });

  bool get isFetching {
    return fetched.connectionState != ConnectionState.done;
  }
}
