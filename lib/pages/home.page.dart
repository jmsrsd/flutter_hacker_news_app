import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/models/item/item.model.dart';
import 'package:flutter_hacker_news_app/utils/cache.dart';
import 'package:flutter_hacker_news_app/utils/uncatch.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

import '../hooks/fetch.hook.dart';
import '../models/stories/stories.model.dart';
import '../utils/api.dart';
import '../utils/with_separator.dart';

class MyHomePage extends HookWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  static final _cachedStories = Cache<Stories>();
  static final _cachedItems = Cache<Item>();

  @override
  Widget build(BuildContext context) {
    final storiesFetcher = useState(Api.topStories);
    final fetchStories = storiesFetcher.value;
    final storiesFetch = useFetch([
      fetchStories,
      _cachedStories.isAbsent([fetchStories]),
    ], () async {
      if (_cachedStories.isAbsent([fetchStories])) {
        _cachedStories.set([fetchStories], await fetchStories());
      }
      return _cachedStories.get([fetchStories]) ?? <int>[];
    }, onRefetch: () {
      _cachedStories.invalidate([fetchStories]);
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: storiesFetch.refetch,
            icon: const Icon(Icons.refresh),
          ),
        ].map((e) {
          return Container(
            padding: const EdgeInsets.only(bottom: kToolbarHeight),
            height: kToolbarHeight,
            alignment: Alignment.center,
            child: e,
          );
        }).toList(),
        toolbarHeight: kToolbarHeight * 2,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(
            top: kToolbarHeight,
          ),
          child: Text(title),
        ),
        bottom: AppBar(
          centerTitle: true,
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: withSeparator(
                separator: const SizedBox(width: 8),
                children: {
                  'TOP': Api.topStories,
                  'BEST': Api.bestStories,
                  'NEW': Api.newStories,
                }.entries.map((e) {
                  return TextButton(
                    onPressed: fetchStories == e.value
                        ? null
                        : () {
                            storiesFetcher.value = e.value;
                            storiesFetch.refetch();
                          },
                    child: Text(e.key),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
      body: Builder(builder: (context) {
        if (storiesFetch.isFetching) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final ids = storiesFetch.fetched.data ?? [];
        return RefreshIndicator(
          onRefresh: () async {
            storiesFetch.refetch();
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(
              top: kToolbarHeight * 0.0,
              bottom: kToolbarHeight * 2.0,
            ),
            itemCount: ids.length,
            itemBuilder: (context, index) {
              return HookBuilder(
                builder: (context) {
                  final id = ids.elementAt(index);
                  final fetch = useFetch([
                    id,
                    _cachedItems.isAbsent([id]),
                  ], () async {
                    if (_cachedItems.isAbsent([id])) {
                      _cachedItems.set([id], await Api.item(id: id));
                    }
                    return _cachedItems.get([id]);
                  }, onRefetch: () {
                    _cachedItems.invalidate([id]);
                  });
                  final item = fetch.fetched.data;
                  final itemTime = DateTime.fromMillisecondsSinceEpoch(
                    (item?.time ?? 0) * 1000,
                  );
                  return ListTile(
                    onTap: () {
                      uncatch(() async {
                        final url = Uri.parse(
                          '${_cachedItems.get([id])?.url}',
                        );
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      });
                      fetch.refetch();
                    },
                    leading: AspectRatio(
                      aspectRatio: 1.0,
                      child: Center(
                        child: fetch.isFetching
                            ? const SizedBox.square(
                                dimension: 24,
                                child: CircularProgressIndicator(),
                              )
                            : Text('${item?.score}'),
                      ),
                    ),
                    title: Text(fetch.isFetching ? '' : '${item?.title}'),
                    subtitle: Text(
                      fetch.isFetching
                          ? ''
                          : [
                              '${item?.by}',
                              [
                                itemTime.year,
                                itemTime.month,
                                itemTime.day,
                              ].join('/'),
                            ].join(' • '),
                    ),
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}
