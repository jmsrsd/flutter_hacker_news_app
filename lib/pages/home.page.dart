import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/api/item/item.api.request.dart';
import 'package:flutter_hacker_news_app/api/item/item.api.response.dart';
import 'package:flutter_hacker_news_app/api/stories.api.dart';
import 'package:flutter_hacker_news_app/components/item.component.dart';
import 'package:flutter_hacker_news_app/models/item/item.model.dart';
import 'package:flutter_hacker_news_app/utils/cache.dart';
import 'package:flutter_hacker_news_app/utils/uncatch.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

import '../hooks/async.hook.dart';
import '../models/stories/stories.model.dart';
import '../utils/api.dart';
import '../utils/with_separator.dart';

class MyHomePageTabBarView extends HookWidget {
  final Map<String, List<int>> storiesCache = {};
  final Map<int, ItemResponse> itemCache = {};
  final StoriesRequest request;

  MyHomePageTabBarView({
    super.key,
    required this.request,
  });

  @override
  Widget build(context) {
    final stories = useAsync([request.endpoint], () async {
      final data = storiesCache[request.endpoint];
      if (data != null) return data;
      storiesCache[request.endpoint] = await request.get();
      return storiesCache[request.endpoint];
    });
    final ids = stories.data ?? [];
    final items = ids.map((id) {
      return HookBuilder(
        key: ValueKey(id),
        builder: (context) {
          final item = useAsync([id], () async {
            final data = itemCache[id];
            if (data != null) return data;
            itemCache[id] = await ItemRequest.get(id);
            return itemCache[id];
          });
          final data = item.data;
          return data == null
              ? const ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: CircularProgressIndicator(),
                  ),
                  title: Text(''),
                  subtitle: Text(''),
                )
              : Item(
                  key: ValueKey(id),
                  data: data,
                  onTap: data.url == null
                      ? null
                      : () {
                          uncatch(() async {
                            await launchUrl(
                              Uri.parse('${data.url}'),
                              mode: LaunchMode.externalApplication,
                            );
                          });
                          item.refresh();
                        },
                );
        },
      );
    }).toList();

    if (!stories.hasLoaded) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        storiesCache.clear();
        itemCache.clear();
        stories.refresh();
      },
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'TOP': MyHomePageTabBarView(
        key: const ValueKey('top'),
        request: StoriesRequest.top(),
      ),
      'NEW': MyHomePageTabBarView(
        key: const ValueKey('new'),
        request: StoriesRequest.newOrLatest(),
      ),
      'BEST': MyHomePageTabBarView(
        key: const ValueKey('best'),
        request: StoriesRequest.best(),
      ),
    };

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.onSurface,
            tabs: List.of(
              tabs.keys.map((e) => Tab(text: e)),
            ),
          ),
        ),
        body: TabBarView(
          children: List.of(tabs.values),
        ),
      ),
    );
  }
}

class _MyHomePage extends HookWidget {
  const _MyHomePage({
    required this.title,
  });

  final String title;

  static final _cachedStories = Cache<Stories>();
  static final _cachedItems = Cache<ItemModel>();

  @override
  Widget build(BuildContext context) {
    final storiesFetcher = useState(Api.topStories);
    final fetchStories = storiesFetcher.value;
    final storiesFetch = useAsync([
      fetchStories,
      _cachedStories.isAbsent([fetchStories]),
    ], () async {
      if (_cachedStories.isAbsent([fetchStories])) {
        _cachedStories.set([fetchStories], await fetchStories());
      }
      return _cachedStories.get([fetchStories]) ?? <int>[];
    }, onRefresh: () {
      _cachedStories.invalidate([fetchStories]);
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: storiesFetch.refresh,
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
                            storiesFetch.refresh();
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
        if (!storiesFetch.hasLoaded) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final ids = storiesFetch.data ?? [];
        return RefreshIndicator(
          onRefresh: () async {
            storiesFetch.refresh();
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
                  final fetch = useAsync([
                    id,
                    _cachedItems.isAbsent([id]),
                  ], () async {
                    if (_cachedItems.isAbsent([id])) {
                      _cachedItems.set([id], await Api.item(id: id));
                    }
                    return _cachedItems.get([id]);
                  }, onRefresh: () {
                    _cachedItems.invalidate([id]);
                  });
                  final item = fetch.data;
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
                      fetch.refresh();
                    },
                    leading: AspectRatio(
                      aspectRatio: 1.0,
                      child: Center(
                        child: !fetch.hasLoaded
                            ? const SizedBox.square(
                                dimension: 24,
                                child: CircularProgressIndicator(),
                              )
                            : Text('${item?.score}'),
                      ),
                    ),
                    title: Text(!fetch.hasLoaded ? '' : '${item?.title}'),
                    subtitle: Text(
                      !fetch.hasLoaded
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
