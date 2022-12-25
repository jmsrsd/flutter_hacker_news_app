import 'package:flutter_hacker_news_app/src/types/data_source.dart';
import 'package:flutter_hacker_news_app/src/types/fetcher.dart';

import 'async_hook.dart';

AsyncHook<TO> useQuery<TI, TO>({
  TI? input,
  DataSource<TO>? dataSource,
  required Fetcher<TI, TO> fetcher,
}) {
  return useAsync<TO>([input, fetcher], () async {
    await dataSource?.connect();
    final output = await fetcher(input, dataSource);
    await dataSource?.disconnect();
    return output;
  });
}
