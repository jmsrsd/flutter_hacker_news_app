import 'package:dio/dio.dart';
import 'package:flutter_hacker_news_app/src/api/api.dart';
import 'package:flutter_hacker_news_app/src/hooks/query_hook.dart';

Future<List<int>> topStoriesQuery(
  void input,
  QueryFetcher fetcher,
) async {
  const endpoint = '/topstories.json';

  final fetchOptions = Options(
    responseType: ResponseType.json,
  );

  return await Future(() async {
    return await fetcher.get(
      [apiBaseUrl, endpoint].join(),
      options: fetchOptions,
    );
  }).then((response) {
    return List.of(response.data).map((e) {
      return int.parse('$e');
    }).toList();
  });
}
