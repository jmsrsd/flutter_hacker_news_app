import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/api/item/item.api.response.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Item extends HookWidget {
  final ItemResponse data;
  final void Function()? onTap;

  const Item({
    super.key,
    required this.data,
    this.onTap,
  });

  @override
  Widget build(context) {
    return ListTile(
      onTap: onTap,
      isThreeLine: true,
      title: Text(data.title ?? ''),
      subtitle: Text(
        [
          [
            '${data.score ?? '...'}',
            'points',
            'by',
            data.by,
          ].map((e) => e.trim()).join(' '),
          data.url ?? '',
        ].join('\n'),
      ),
    );
  }
}
