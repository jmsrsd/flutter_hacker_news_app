abstract class DataSource<T> {
  Future<void> connect();

  Future<void> disconnect();

  Future<T?> get(String key);

  Future<void> post(T value);

  Future<void> put(String key, T value);

  Future<void> delete(String key);
}
