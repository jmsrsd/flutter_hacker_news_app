import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/src/components/item_list_tile.dart';
import 'package:flutter_hacker_news_app/src/hooks/async_hook.dart';
import 'package:flutter_hacker_news_app/src/hooks/open_url_hook.dart';
import 'package:flutter_hacker_news_app/src/utils/evalutate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _cacheProvider = Provider((ref) {
  return <int>[];
});

class StoriesListView extends HookConsumerWidget {
  final AsyncHook<List<int>> query;

  const StoriesListView({
    super.key,
    required this.query,
  });

  @override
  Widget build(context, ref) {
    final cache = ref.read(_cacheProvider);

    if (query.data != null) {
      cache.clear();
      cache.addAll(query.data ?? []);
    }

    final openUrl = useOpenUrl();

    final isLoading = [
      query.isLoading,
      openUrl.isLoading,
      openUrl.isLoading,
    ].reduce((v, e) {
      return e || v;
    });

    return Center(
      child: evaluate(() {
        if (isLoading && cache.isEmpty) {
          return const CircularProgressIndicator();
        }

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: kToolbarHeight * 2),
          itemCount: cache.length,
          itemBuilder: (context, index) {
            return ItemListTile(id: cache[index]);
          },
        );
      }),
    );
  }
}
