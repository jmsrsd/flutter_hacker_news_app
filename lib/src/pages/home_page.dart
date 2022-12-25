import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/src/api/ask_stories_api.dart';
import 'package:flutter_hacker_news_app/src/api/best_stories_api.dart';
import 'package:flutter_hacker_news_app/src/api/job_stories_api.dart';
import 'package:flutter_hacker_news_app/src/api/new_stories_api.dart';
import 'package:flutter_hacker_news_app/src/api/show_stories_api.dart';
import 'package:flutter_hacker_news_app/src/api/top_stories_api.dart';
import 'package:flutter_hacker_news_app/src/components/stories_list_view.dart';
import 'package:flutter_hacker_news_app/src/hooks/async_hook.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(context, ref) {
    final tabIndex = useState(0);

    final storiesQueries = <String, AsyncHook<List<int>>>{
      'TOP': useTopStoriesQuery(),
      'NEW': useNewsStoriesQuery(),
      'BEST': useBestStoriesQuery(),
      'ASK': useAskStoriesQuery(),
      'SHOW': useShowStoriesQuery(),
      'JOB': useJobStoriesQuery(),
    };

    final storiesQuery = storiesQueries.values.elementAt(tabIndex.value);

    final isLoading = [
      storiesQuery.isLoading,
    ].reduce((v, e) => v || e);

    return DefaultTabController(
      length: storiesQueries.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HackerNews'),
          actions: [
            IconButton(
              onPressed: isLoading ? null : storiesQuery.invalidate,
              icon: isLoading
                  ? const SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(),
                    )
                  : const Icon(Icons.refresh_outlined),
            ),
          ],
          bottom: TabBar(
            onTap: (index) {
              tabIndex.value = index;
            },
            tabs: storiesQueries.keys.map((e) {
              return Tab(text: e);
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: storiesQueries.values.map((e) {
            return StoriesListView(
              query: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}
