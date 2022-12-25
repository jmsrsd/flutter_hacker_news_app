import 'package:dio/dio.dart';
import 'package:flutter_hacker_news_app/src/api/api.dart';
import 'package:flutter_hacker_news_app/src/hooks/async_hook.dart';
import 'package:flutter_hacker_news_app/src/hooks/query_hook.dart';
import 'package:flutter_hacker_news_app/src/types/data_source.dart';

class TopStoriesDataSource extends DataSource<List<int>> {
  late final Dio _dio;

  TopStoriesDataSource({
    required Dio dio,
  }) {
    _dio = dio;
  }

  @override
  Future<void> connect() async {}

  @override
  Future<void> disconnect() async {
    _dio.close();
  }

  @override
  Future<List<int>?> get(String key) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        [apiBaseUrl, '/topstories.json'].join(),
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      return response.data?.map((e) => '$e').map(int.parse).toList();
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return null;
    }
  }

  @override
  Future<void> post(List<int> value) async {}

  @override
  Future<void> put(String key, List<int> value) async {}

  @override
  Future<void> delete(String key) async {}
}

Future<List<int>> fetchTopStories(
  void input,
  DataSource<List<int>>? dataSource,
) async {
  final data = await dataSource?.get('');
  return data ?? [];
}

AsyncHook<List<int>> useTopStoriesQuery() {
  return useQuery(
    null,
    TopStoriesDataSource(dio: Dio()),
    fetchTopStories,
  );
}
