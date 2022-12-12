import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/api/item.api.dart';
import 'package:flutter_hacker_news_app/hooks/async.hook.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Item extends HookWidget {
  final int id;

  const Item({super.key, required this.id});

  @override
  Widget build(context) {
    final response = useAsync([id], () {
      return ItemRequest.get(id);
    });

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: response.hasLoaded
            ? Text(response.data?.score.toString() ?? '-')
            : const CircularProgressIndicator(),
      ),
    );
  }
}
