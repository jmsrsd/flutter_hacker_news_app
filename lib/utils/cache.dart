class _Cached {
  final Type type;
  final List<dynamic> keys;
  final dynamic value;
  final DateTime expiredAt;

  _Cached({
    required this.type,
    required this.keys,
    required this.value,
    required this.expiredAt,
  });

  bool areKeysMatched(Type otherType, List<dynamic> otherKeys) {
    return keys.map(otherKeys.contains).reduce((v, e) {
          return v && e;
        }) &&
        type == otherType;
  }
}

class Cache<T> {
  static final _self = <_Cached>[];

  T? get(List<dynamic> keys) {
    try {
      _self.removeWhere((e) => e.expiredAt.isBefore(DateTime.now()));
      final cached = _self.firstWhere((e) => e.areKeysMatched(T, keys));
      if (cached.expiredAt.isBefore(DateTime.now())) {
        _self.removeWhere((e) => e.areKeysMatched(T, keys));
        return null;
      }
      return cached.value as T?;
    } catch (e) {
      return null;
    }
  }

  void set(List<dynamic> keys, T value) {
    _self.add(
      _Cached(
        type: T,
        keys: keys,
        value: value,
        expiredAt: DateTime.now().add(
          const Duration(minutes: 1),
        ),
      ),
    );
  }

  void invalidate(List<dynamic> keys) {
    _self.removeWhere((e) => e.areKeysMatched(T, keys));
  }

  bool isAbsent(List<dynamic> keys) {
    return get(keys) == null;
  }
}
