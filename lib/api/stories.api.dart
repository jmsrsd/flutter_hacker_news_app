import 'dart:convert';

import 'package:http/http.dart' as http;

typedef StoriesResponse = List<int>;

class StoriesRequest {
  static const String baseUrl = 'https://hacker-news.firebaseio.com/v0/';
  final String endpoint;

  StoriesRequest._(this.endpoint);

  factory StoriesRequest.ask() {
    return StoriesRequest._('askstories.json');
  }

  factory StoriesRequest.show() {
    return StoriesRequest._('showstories.json');
  }

  factory StoriesRequest.job() {
    return StoriesRequest._('jobstories.json');
  }

  factory StoriesRequest.best() {
    return StoriesRequest._('beststories.json');
  }

  factory StoriesRequest.newOrLatest() {
    return StoriesRequest._('newstories.json');
  }

  factory StoriesRequest.top() {
    return StoriesRequest._('topstories.json');
  }

  Future<StoriesResponse> get() async {
    final response = await http.get(Uri.parse(baseUrl + endpoint));
    final data = jsonDecode(response.body);
    return List.of(data).map((e) => e as int).toList();
  }
}
