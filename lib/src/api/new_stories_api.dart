import 'package:dio/dio.dart';
import 'package:flutter_hacker_news_app/src/api/api.dart';
import 'package:flutter_hacker_news_app/src/hooks/async_hook.dart';
import 'package:flutter_hacker_news_app/src/hooks/query_hook.dart';
import 'package:flutter_hacker_news_app/src/types/data_source.dart';

AsyncHook<List<int>> useNewsStoriesQuery() {
  return useQuery(
    dataSource: NewsStoriesDataSource(dio: Dio()),
    fetcher: fetchNewsStories,
  );
}

Future<List<int>> fetchNewsStories(
  void input,
  DataSource<List<int>>? dataSource,
) async {
  final data = await dataSource?.get({});
  return data ?? [];
}

class NewsStoriesDataSource extends DataSource<List<int>> {
  late final Dio _dio;

  NewsStoriesDataSource({
    required Dio dio,
  }) {
    _dio = dio;
  }

  @override
  Future<void> disconnect() async {
    _dio.close();
  }

  @override
  Future<List<int>?> get(Map<String, dynamic> params) async {
    try {
      final response = await _dio.get<List>(
        [apiBaseUrl, '/newstories.json'].join(),
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      return response.data?.map((e) => '$e').map(int.parse).toList();
    } catch (e) {
      return null;
    }
  }
}
