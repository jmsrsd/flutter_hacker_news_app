import 'package:flutter/foundation.dart';
import 'package:flutter_hacker_news_app/src/utils/next_tick.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../utils/value_coder.dart';
import 'swr_hook.dart';

typedef StorageLoader = Box<String>;

SWRHook<StorageHook<T>> useStorage<T>(String key, ValueCoder<T> coder) {
  final reloading = useState(0);

  return useSWR([key, reloading.value], () async {
    final loader = await Hive.openBox<String>(key);

    return StorageHook<T>(
      key,
      cache: loader.values.map(coder.decode).toList(),
      coder: coder,
      reloading: reloading,
      loader: loader,
    );
  });
}

class StorageHook<T> {
  final String key;
  late final List<T> _cache;
  late final ValueCoder<T> _coder;
  late final ValueNotifier<int>? _reloading;
  late final StorageLoader _loader;

  StorageHook(
    this.key, {
    required List<T> cache,
    required ValueCoder<T> coder,
    required ValueNotifier<int>? reloading,
    required StorageLoader loader,
  }) {
    _cache = cache;
    _coder = coder;
    _reloading = reloading;
    _loader = loader;
  }

  void reload() {
    _reloading?.value += 1;
  }

  bool get isLoading {
    return _loader.isOpen == false;
  }

  List<T> getAll() {
    return isLoading ? _cache : _loader.values.map(_coder.decode).toList();
  }

  T? get(String key) {
    if (isLoading) {
      return null;
    }

    try {
      return _coder.decode(_loader.get(key) ?? '');
    } catch (e) {
      return null;
    }
  }

  Future<void> post(T value) async {
    while (isLoading) {
      await nextTick();
    }

    await put(const Uuid().v4(), value);
    reload();
  }

  Future<void> put(String key, T value) async {
    while (isLoading) {
      await nextTick();
    }

    await _loader.put(key, _coder.encode(value));
    reload();
  }

  Future<void> delete(String key) async {
    while (isLoading) {
      await nextTick();
    }

    await _loader.delete(key);
    reload();
  }

  Future<void> deleteAll() async {
    while (isLoading) {
      await nextTick();
    }

    await _loader.clear();
    reload();
  }
}
