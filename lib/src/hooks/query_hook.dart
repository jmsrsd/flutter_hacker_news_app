import 'package:flutter_hacker_news_app/src/types/data_source.dart';
import 'package:flutter_hacker_news_app/src/types/fetcher.dart';
import 'package:flutter_hacker_news_app/src/utils/next_tick.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'async_hook.dart';

AsyncHook<TO> useQuery<TI, TO>({
  TI? input,
  DataSource<TO>? dataSource,
  required Fetcher<TI, TO> fetcher,
}) {
  final autoValidation = useMemoized(() {
    return _AutoInvalidation(
      duration: const Duration(seconds: 10),
    )..init();
  }, []);

  final hook = useAsync<TO>([input], () async {
    await dataSource?.connect();
    final output = await fetcher(input, dataSource);
    await dataSource?.disconnect();
    return output;
  });

  if (hook.isInvalidated == false) {
    autoValidation.add(hook);
  }

  return hook;
}

class _AutoInvalidation {
  final _queries = <MapEntry<int, AsyncHook>>[];

  final Duration duration;

  _AutoInvalidation({
    required this.duration,
  });

  void init() async {
    while (_queries.isEmpty) {
      await nextTick();
    }

    while (_queries.isNotEmpty) {
      await nextTick();

      invalidateAll();
    }

    invalidateAll();
  }

  void add(AsyncHook hook) async {
    if (_queries.map((e) => e.value).contains(hook)) {
      return;
    }

    final timer = DateTime.now().add(duration).millisecondsSinceEpoch;
    _queries.add(MapEntry(timer, hook));
  }

  void invalidateAll() {
    _queries.removeWhere((query) {
      return query.value.isInvalidated;
    });

    final invalids = _queries.where((e) {
      return e.key <= DateTime.now().millisecondsSinceEpoch;
    }).where((e) {
      return e.value.isLoading == false;
    }).toList();

    for (final invalid in invalids) {
      invalid.value.invalidate();
    }

    _queries.removeWhere((query) {
      return invalids.map((invalid) {
        return invalid.key;
      }).contains(query.key);
    });
  }
}
