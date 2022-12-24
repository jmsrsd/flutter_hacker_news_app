import 'package:dio/dio.dart';

import 'swr_hook.dart';

typedef QueryFetcher = Dio;

typedef Query<TInput, TResponse> = Future<TResponse> Function(
  TInput input,
  QueryFetcher fetcher,
);

SWRHook<TResponse> useQuery<TInput, TResponse>(
  TInput input,
  Query<TInput, TResponse> query,
) {
  return useSWR<TResponse>([input, query], () async {
    final fetcher = QueryFetcher();
    final response = await query(input, fetcher);
    fetcher.close();
    return response;
  });
}
