import 'package:dio/dio.dart';
import 'package:flutter_hacker_news_app/src/api/api.dart';
import 'package:flutter_hacker_news_app/src/hooks/query_hook.dart';
import 'package:flutter_hacker_news_app/src/types/item/item_model.dart';

Future<ItemModel> itemQuery(int id, QueryFetcher fetcher) async {
  final endpoint = ['/item/', id, '.json'].join();

  final response = await fetcher.get(
    [apiBaseUrl, endpoint].join(),
    options: Options(
      responseType: ResponseType.json,
    ),
  );

  return ItemModel.fromJson(response.data);
}
