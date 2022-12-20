import 'query_hook.dart';

import 'package:dio/dio.dart';

typedef RequestFetcher = Dio;

typedef Request<T> = Future<T> Function(
  String url,
  RequestFetcher fetcher,
);

QueryHook<T> useRequest<T>(String url, Request<T> request) {
  return useQuery([url], () async {
    final fetcher = RequestFetcher();

    final response = await request(url, fetcher);

    fetcher.close();

    return response;
  });
}
