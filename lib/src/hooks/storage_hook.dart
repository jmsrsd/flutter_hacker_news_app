import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/value_coder.dart';
import 'query_hook.dart';

typedef StorageFetcher = Box<String>;

QueryHook<Storage<T>> useStorage<T>(String key, ValueCoder<T> coder) {
  final refetching = useState(0);

  return useQuery([key, refetching.value], () async {
    while (Hive.isBoxOpen(key)) {
      await Future.delayed(Duration.zero);
    }

    final fetcher = await Hive.openBox<String>(key);

    return Storage(
      key,
      cache: fetcher.values.map(coder.decode).toList(),
      coder: coder,
      refetching: refetching,
      fetcher: fetcher,
    );
  });
}

class Storage<T> {
  final String key;
  late final List<T> _cache;
  late final ValueCoder<T> _coder;
  late final ValueNotifier<int> _refetching;
  late final StorageFetcher _fetcher;

  Storage(
    this.key, {
    required List<T> cache,
    required ValueCoder<T> coder,
    required ValueNotifier<int> refetching,
    required StorageFetcher fetcher,
  }) {
    _cache = cache;
    _coder = coder;
    _refetching = refetching;
    _fetcher = fetcher;
  }

  void refetch() {
    _fetcher.close();
    _refetching.value += 1;
  }

  bool get isFetching {
    return _fetcher.isOpen == false;
  }

  List<T> getAll() {
    return isFetching ? _cache : _fetcher.values.map(_coder.decode).toList();
  }

  void post(T value) async {
    while (isFetching) {
      await Future.delayed(Duration.zero);
    }

    await _fetcher.add(_coder.encode(value));
    refetch();
  }

  void put(int index, T value) async {
    while (isFetching) {
      await Future.delayed(Duration.zero);
    }

    await _fetcher.putAt(index, _coder.encode(value));
    refetch();
  }

  void delete(int index) async {
    while (isFetching) {
      await Future.delayed(Duration.zero);
    }

    await _fetcher.deleteAt(index);
    refetch();
  }
}
