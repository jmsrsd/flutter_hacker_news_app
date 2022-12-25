abstract class DataSource<T> {
  Future<void> connect();

  Future<void> disconnect();

  Future<T?> get(String key);

  Future<void> post(T value);

  Future<void> put(String key, T value);

  Future<void> delete(String key);
}

class DefaultDataSource<T> extends DataSource<T?> {
  @override
  Future<void> connect() async {}

  @override
  Future<void> delete(String key) async {}

  @override
  Future<void> disconnect() async {}

  @override
  Future<T?> get(String key) async {
    return null;
  }

  @override
  Future<void> post(T? value) async {}

  @override
  Future<void> put(String key, T? value) async {}
}
