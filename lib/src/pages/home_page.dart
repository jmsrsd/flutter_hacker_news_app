import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/src/api/item_api.dart';
import 'package:flutter_hacker_news_app/src/api/stories_api.dart';
import 'package:flutter_hacker_news_app/src/hooks/mutation_hook.dart';
import 'package:flutter_hacker_news_app/src/types/item/item_model.dart';
import 'package:flutter_hacker_news_app/src/utils/evalutate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

final itemsProvider = Provider((ref) {
  return <int, ItemModel?>{};
});

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(context, ref) {
    final topStories = useTopStoriesQuery();

    final topStoriesIds = topStories.data ?? [];

    final openUrl = useMutation<String>(
      fetcher: (url, _) async {
        if (url == null) {
          return;
        }

        await launchUrlString(url, mode: LaunchMode.externalApplication);
      },
    );

    final isLoading = [
      topStories.isLoading,
      openUrl.isLoading,
      openUrl.isLoading,
    ].reduce((v, e) {
      return e || v;
    });

    final items = ref.read(itemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HackerNews'),
        actions: [
          IconButton(
            onPressed: topStories.invalidate,
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: Center(
        child: evaluate(() {
          if (isLoading) {
            return const CircularProgressIndicator();
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: kToolbarHeight * 2),
            itemCount: topStoriesIds.length,
            itemBuilder: (context, index) {
              final id = topStoriesIds[index];
              return HookBuilder(
                builder: (context) {
                  final item = useItemQuery(id);

                  items[index] = item.data ?? items[index];
                  var data = items[index];

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

                  items[index] = item.data ?? items[index];
                  data = items[index];

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
                },
              );
            },
          );
        }),
      ),
    );
  }
}
