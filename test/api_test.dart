import 'dart:convert';

import 'package:flutter_hacker_news_app/api/maxitem.api.dart';
import 'package:flutter_hacker_news_app/api/stories.api.dart';
import 'package:flutter_hacker_news_app/api/updates.api.dart';
import 'package:flutter_hacker_news_app/api/user.api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'utils.dart';

void main() {
  runTests({
    'API': {
      'Item': {
        'GET': () async {
          throw UnimplementedError();
        },
      },
      'User': {
        'GET': () async {
          final response = await UserRequest.get(userId: 'jl');

          expect(response.id, equals('jl'));
          expect(
            response.created.millisecondsSinceEpoch,
            equals(1173923446 * 1000),
          );
          expect(response.karma.runtimeType, equals(int));
          expect(response.about.runtimeType, equals(String));
          expect(response.submitted.runtimeType, equals(List<int>));
        },
      },
      'Max Item': {
        'GET': () async {
          final response = await MaxItemRequest.get();
          expect(response.runtimeType, equals(int));
        },
      },
      'Updates': {
        'GET': () async {
          final response = await UpdatesRequest.get();
          final items = response.items;
          final profiles = response.profiles;

          expect(items.runtimeType, equals(List<int>));
          expect(profiles.runtimeType, equals(List<String>));
        },
      },
      'Stories': {
        'Ask': {
          'GET': () async {
            final request = StoriesRequest.ask();
            expect(request.endpoint, equals('askstories.json'));
            final response = await request.get();
            expect(response.runtimeType, equals(List<int>));
          },
        },
        'Show': {
          'GET': () async {
            final request = StoriesRequest.show();
            expect(request.endpoint, equals('showstories.json'));
            final response = await request.get();
            expect(response.runtimeType, equals(List<int>));
          },
        },
        'Job': {
          'GET': () async {
            final request = StoriesRequest.job();
            expect(request.endpoint, equals('jobstories.json'));
            final response = await request.get();
            expect(response.runtimeType, equals(List<int>));
          },
        },
        'Top': {
          'GET': () async {
            final request = StoriesRequest.top();
            expect(request.endpoint, equals('topstories.json'));
            final response = await request.get();
            expect(response.runtimeType, equals(List<int>));
          },
        },
        'New': {
          'GET': () async {
            final request = StoriesRequest.newOrLatest();
            expect(request.endpoint, equals('newstories.json'));
            final response = await request.get();
            expect(response.runtimeType, equals(List<int>));
          },
        },
        'Best': {
          'GET': () async {
            final request = StoriesRequest.best();
            expect(request.endpoint, equals('beststories.json'));
            final response = await request.get();
            expect(response.runtimeType, equals(List<int>));
          },
        },
      },
    },
  });
}
