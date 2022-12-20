import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/api/item/item.api.request.dart';
import 'package:flutter_hacker_news_app/api/item/item.api.response.dart';
import 'package:flutter_hacker_news_app/api/stories.api.dart';
import 'package:flutter_hacker_news_app/components/item.component.dart';
import 'package:flutter_hacker_news_app/models/item/item.model.dart';
import 'package:flutter_hacker_news_app/utils/cache.dart';
import 'package:flutter_hacker_news_app/utils/evaluate.dart';
import 'package:flutter_hacker_news_app/utils/uncatch.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

import '../hooks/async.hook.dart';
import '../models/stories/stories.model.dart';
import '../utils/api.dart';
import '../utils/with_separator.dart';

class HomePageBody extends HookWidget {
  final Map<String, List<int>> storiesCache;
  final Map<int, ItemResponse> itemCache;
  final StoriesRequest request;

  const HomePageBody({
    super.key,
    required this.request,
    required this.storiesCache,
    required this.itemCache,
  });

  Async<List<int>> useStories() {
    return useAsync([request.endpoint], () async {
      final data = storiesCache[request.endpoint];
      if (data != null) return data;
      storiesCache[request.endpoint] = await request.get();
      return storiesCache[request.endpoint] ?? [];
    }, onRefresh: () {
      storiesCache.clear();
      itemCache.clear();
    });
  }

  Async<ItemResponse> useItem(int id) {
    return useAsync([id], () async {
      final data = itemCache[id];
      if (data != null) return data;
      itemCache[id] = await ItemRequest.get(id);
      return itemCache[id]!;
    }, onRefresh: () {
      itemCache.remove(id);
    });
  }

  @override
  Widget build(context) {
    final stories = useStories();
    final ids = stories.data ?? [];
    final items = useMemoized(() {
      return List.of(ids.map((id) {
        return HookBuilder(
          key: ValueKey(id),
          builder: (context) {
            final item = useItem(id);
            final data = item.data;
            return Item(
              key: ValueKey(id),
              loading: item.hasLoaded == false,
              data: data,
              onTap: data?.url == null
                  ? null
                  : () {
                      uncatch(() async {
                        await launchUrl(
                          Uri.parse('${data?.url}'),
                          mode: LaunchMode.externalApplication,
                        );
                      });
                      item.refresh();
                    },
            );
          },
        );
      }));
    }, [stories.hasLoaded]);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: evaluate(() {
        if (!stories.hasLoaded) {
          return const Align(
            alignment: Alignment.topCenter,
            child: LinearProgressIndicator(),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            stories.refresh();
          },
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return items[index];
            },
          ),
        );
      }),
    );
  }
}

class HomePage extends HookWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(context) {
    final refreshing = useState(0);
    final storiesCache = useState(<String, List<int>>{});
    final itemCache = useState(<int, ItemResponse>{});
    final tabs = useMemoized(() {
      return {
        '📈 TOP': StoriesRequest.top(),
        '✉️ NEW': StoriesRequest.newOrLatest(),
        '🏆 BEST': StoriesRequest.best(),
        '🎁 SHOW': StoriesRequest.show(),
        '🗣️ ASK': StoriesRequest.ask(),
        '💼 JOB': StoriesRequest.job(),
      };
    });

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: () {
              storiesCache.value.clear();
              itemCache.value.clear();
              refreshing.value++;
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: SizedBox.square(
                    dimension: 24,
                    child: CachedNetworkImage(
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      imageUrl: 'https://upload.wikimedia.org'
                          '/wikipedia/commons/thumb/b/b2/Y_Combinator_logo.svg'
                          '/240px-Y_Combinator_logo.svg.png',
                    ),
                  ),
                ),
                Text(title),
              ],
            ),
          ),
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.onSurface,
            tabs: List.of(
              tabs.keys.map((e) {
                return Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: evaluate(() {
                      final parts = e.split(' ');
                      final emoji = parts[0];
                      final label = parts[1];

                      return [
                        Text(
                          emoji,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          label,
                          style: const TextStyle(fontSize: 10),
                        ),
                        const SizedBox(height: 4),
                      ];
                    }),
                  ),
                );
              }),
            ),
          ),
        ),
        body: Builder(
          builder: (context) {
            final children = List.of(
              tabs.entries.map((e) {
                return HomePageBody(
                  key: ValueKey(e.key),
                  request: e.value,
                  itemCache: itemCache.value,
                  storiesCache: storiesCache.value,
                );
              }),
            );

            return TabBarView(
              key: ValueKey(refreshing.value),
              children: children,
            );
          },
        ),
      ),
    );
  }
}
