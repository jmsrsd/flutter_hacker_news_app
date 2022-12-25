import 'package:flutter_hacker_news_app/src/types/data_source.dart';
import 'package:flutter_hacker_news_app/src/types/fetcher.dart';
import 'package:flutter_hacker_news_app/src/utils/delay.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'async_hook.dart';

AsyncHook<TO> useQuery<TI, TO>({
  TI? input,
  DataSource<TO>? dataSource,
  required Fetcher<TI, TO> fetcher,
}) {
  final autoValidation = useMemoized(() {
    return _AutoInvalidation()..init();
  }, []);

  final hook = useAsync<TO>([input], () async {
    await dataSource?.connect();
    final output = await fetcher(input, dataSource);
    await dataSource?.disconnect();
    return output;
  });

  autoValidation.add(hook);

  return hook;
}

class _AutoInvalidation {
  final _queries = <MapEntry<int, AsyncHook>>[];

  void init() async {
    while (true) {
      await delay(1);

      final invalids = _queries.where((e) {
        return e.key <= DateTime.now().millisecondsSinceEpoch;
      }).where((e) {
        return e.value.isLoading == false;
      }).toList();

      for (final invalid in invalids) {
        final hook = invalid.value;
        hook.invalidate();
      }

      _queries.removeWhere((e) {
        return invalids.map((e) => e.key).contains(e.key);
      });
    }
  }

  void add(AsyncHook hook) async {
    const duration = Duration(seconds: 10);
    final timer = DateTime.now().add(duration).millisecondsSinceEpoch;
    _queries.add(MapEntry(timer, hook));
  }
}
