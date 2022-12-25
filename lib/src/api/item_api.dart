import 'package:dio/dio.dart';
import 'package:flutter_hacker_news_app/src/api/api.dart';
import 'package:flutter_hacker_news_app/src/hooks/async_hook.dart';
import 'package:flutter_hacker_news_app/src/hooks/query_hook.dart';
import 'package:flutter_hacker_news_app/src/types/data_source.dart';
import 'package:flutter_hacker_news_app/src/types/item/item_model.dart';

class ItemDataSource extends DataSource<ItemModel> {
  late final Dio _dio;

  ItemDataSource({required Dio dio}) {
    _dio = dio;
  }

  @override
  Future<void> connect() async {}

  @override
  Future<void> disconnect() async {
    _dio.close();
  }

  @override
  Future<ItemModel?> get(String key) async {
    final id = int.parse(key);

    final response = await _dio.get<Map<String, dynamic>>(
      [apiBaseUrl, '/item/', id, '.json'].join(),
      options: Options(
        responseType: ResponseType.json,
      ),
    );

    final data = response.data;

    if (data == null) {
      return null;
    }

    return ItemModel.fromJson(data);
  }

  @override
  Future<void> post(ItemModel value) async {}

  @override
  Future<void> put(String key, ItemModel value) async {}

  @override
  Future<void> delete(String key) async {}
}

Future<ItemModel> fetchItem(
  int id,
  DataSource<ItemModel>? dataSource,
) async {
  final data = await dataSource?.get(id.toString());
  return data ?? ItemModel();
}

AsyncHook<ItemModel> useItemQuery(int id) {
  return useQuery(
    id,
    ItemDataSource(dio: Dio()),
    fetchItem,
  );
}
