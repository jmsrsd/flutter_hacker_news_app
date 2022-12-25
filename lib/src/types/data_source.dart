abstract class DataSource<T> {
  Future<void> connect() async {}

  Future<void> disconnect() async {}

  Future<T?> get(Map<String, dynamic> params) async => null;

  Future<void> post(Map<String, dynamic> params) async {}

  Future<void> put(Map<String, dynamic> params) async {}

  Future<void> delete(Map<String, dynamic> params) async {}
}
