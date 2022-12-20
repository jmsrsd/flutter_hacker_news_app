import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/src/hooks/request_hook.dart';
import 'package:flutter_hacker_news_app/src/types/item/item_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final topStoriesQuery = useRequest(
      'https://hacker-news.firebaseio.com/v0',
      (url, fetcher) async {
        final fetchOptions = Options(
          responseType: ResponseType.json,
        );

        final ids = await Future(() async {
          return await fetcher.get(
            '$url' '/topstories.json',
            options: fetchOptions,
          );
        }).then((response) {
          return List.of(response.data).map((e) => int.parse('$e')).toList();
        });

        return await Future.wait(
          ids.map((id) async {
            final response = await fetcher.get(
              '$url' '/item/' '$id' '.json',
              options: fetchOptions,
            );
            return ItemModel.fromJson(response.data);
          }),
        );
      },
    );

    final topStories = topStoriesQuery.data ?? [];

    final isLoading = topStoriesQuery.isFetching;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HackerNews'),
        actions: [
          IconButton(
            onPressed: topStoriesQuery.refetch,
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: kToolbarHeight * 2),
                itemCount: topStories.length,
                itemBuilder: (context, index) {
                  final story = topStories[index];
                  return ListTile(
                    onTap: story.url == null
                        ? null
                        : () {
                            launchUrlString(
                              story.url.toString(),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Theme.of(context).colorScheme.secondary,
                      child: Text(story.score.toString()),
                    ),
                    title: Text(
                      story.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      [story.type, story.url]
                          .where((e) => e != null)
                          .join(' :: '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
