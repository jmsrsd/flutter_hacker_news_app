import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/api/item/item.api.response.dart';
import 'package:flutter_hacker_news_app/utils/evaluate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../api/item/item.api.response.type.dart';

class Item extends HookWidget {
  final ItemResponse? data;
  final void Function()? onTap;
  final bool loading;

  const Item({
    super.key,
    required this.data,
    this.onTap,
    this.loading = false,
  });

  String useSubtitle() {
    var score = data?.score.toString();
    score =
        score == null ? '' : '$score point${int.parse(score) > 1 ? 's' : ''}';

    final by = data?.by == null ? '' : 'by ${data?.by}';
    final url = (data?.url ?? ' // / ')
        .split('//')
        .elementAt(1)
        .split('/')
        .elementAt(0)
        .trim();
    final time = evaluate(() {
      final minutes = data?.time == null
          ? -1
          : DateTime.now()
              .difference(
                DateTime.fromMillisecondsSinceEpoch((data?.time ?? 0) * 1000),
              )
              .inMinutes;

      if (minutes < 0) {
        return '';
      }

      if (minutes < 60) {
        final value = minutes;
        return value < 1
            ? 'just now'
            : '$value minute${value > 1 ? 's' : ''} ago';
      }
      if (minutes < 60 * 24) {
        final value = minutes ~/ 60;
        return '$value hour${value > 1 ? 's' : ''} ago';
      }
      if (minutes < 60 * 24 * 30) {
        final value = minutes ~/ (60 * 24);
        return '$value day${value > 1 ? 's' : ''} ago';
      }
      if (minutes < 60 * 24 * 30 * 12) {
        final value = minutes ~/ (60 * 24 * 30);
        return '$value month${value > 1 ? 's' : ''} ago';
      }
      final value = minutes ~/ (60 * 24 * 30 * 12);
      return '$value year${value > 1 ? 's' : ''} ago';
    });

    return '$score $by $time ${url.isEmpty ? url : '($url)'}'
        .split(' ')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .join(' ');
  }

  String useEmoji() {
    switch (data?.type) {
      case ItemResponseType.story:
        final title = '${data?.title}'.toLowerCase();

        if (title.startsWith('ask hn:') || title.startsWith('tell hn:')) {
          return '🗣️';
        }

        if (title.startsWith('show hn:')) {
          return '🎁';
        }

        return '📰';
      case ItemResponseType.comment:
        return '📝';
      case ItemResponseType.job:
        return '💼';
      case ItemResponseType.poll:
        return '🗳️';
      case ItemResponseType.pollopt:
        return '🗳️';
      default:
        return '';
    }
  }

  @override
  Widget build(context) {
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: ListTile(
        key: ValueKey(loading),
        onTap: loading ? null : onTap,
        leading: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return loading == false
                ? SizedBox(child: child)
                : Transform.rotate(
                    angle: animation.value * 2 * math.pi,
                    child: child,
                  );
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Text(loading ? '⏳' : useEmoji()),
          ),
        ),
        trailing: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: data?.url == null ? null : const Text('🔗'),
        ),
        title: Text(
          data?.title ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          useSubtitle(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
