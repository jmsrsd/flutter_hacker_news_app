import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/src/api/item_api.dart';
import 'package:flutter_hacker_news_app/src/hooks/open_url_hook.dart';
import 'package:flutter_hacker_news_app/src/types/item/item_model.dart';
import 'package:flutter_hacker_news_app/src/utils/evalutate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _cacheProvider = Provider((ref) {
  return <int, ItemModel?>{};
});

class ItemListTile extends HookConsumerWidget {
  final int id;

  const ItemListTile({
    super.key,
    required this.id,
  });

  @override
  Widget build(context, ref) {
    final openUrl = useOpenUrl();

    final cache = ref.read(_cacheProvider);
    final item = useItemQuery(id);

    cache[id] = item.data ?? cache[id];
    var data = cache[id];

    if (data == null) {
      return const ListTile(
        title: SizedBox(),
        subtitle: SizedBox(),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: SizedBox.square(
            dimension: 24,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    cache[id] = item.data ?? cache[id];
    data = cache[id];

    return ListTile(
      onTap: evaluate(() {
        if (data?.url == null) {
          return null;
        }
        return () => openUrl.mutate(data?.url);
      }),
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(
          context,
        ).colorScheme.secondary,
        child: Text(data?.score.toString() ?? ''),
      ),
      trailing: evaluate(() {
        if (item.isLoading == false) {
          return null;
        }

        return const CircleAvatar(
          backgroundColor: Colors.transparent,
          child: SizedBox.square(
            dimension: 24,
            child: CircularProgressIndicator(),
          ),
        );
      }),
      title: Text(
        data?.title ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        [
          data?.by,
          data?.type,
          evaluate(() {
            final time = data?.time;

            if (time == null) {
              return null;
            }

            final date = DateTime.fromMillisecondsSinceEpoch(
              time * 1000,
            );

            final year = '${date.year}'.padLeft(4, '0');
            final month = '${date.month}'.padLeft(2, '0');
            final day = '${date.day}'.padLeft(2, '0');

            return '$year/$month/$day';
          }),
          data?.url,
        ].where((e) => e != null).join(' :: '),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
