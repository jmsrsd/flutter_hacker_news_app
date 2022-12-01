import 'dart:convert';

import '../models/item/item.model.dart';
import 'package:http/http.dart' as http;

class Api {
  Api._();

  static Future<Item> item({
    required int id,
  }) async {
    return Item.fromJson(await _JsonApi('item/$id.json').get());
  }

  static Future<Map<String, dynamic>> user({
    required String id,
  }) async {
    return await _JsonApi('user/$id.json').get();
  }

  static Future<int> maxItem() async {
    return await _IdApi('maxitem.json').get();
  }

  static Future<List<int>> topStories() async {
    return await _IdsApi('topstories.json').get();
  }

  static Future<List<int>> newStories() async {
    return await _IdsApi('newstories.json').get();
  }

  static Future<List<int>> bestStories() async {
    return await _IdsApi('beststories.json').get();
  }

  static Future<List<int>> askStories() async {
    return await _IdsApi('askstories.json').get();
  }

  static Future<List<int>> showStories() async {
    return await _IdsApi('showstories.json').get();
  }

  static Future<List<int>> jobStories() async {
    return await _IdsApi('jobstories.json').get();
  }
}

class _Api<T> {
  late final Uri url;
  final T Function(String body) decoder;

  _Api({
    required String endpoint,
    required this.decoder,
  }) {
    url = Uri.parse('https://hacker-news.firebaseio.com/v0/$endpoint');
  }

  Future<T> get() async {
    return await http.get(url).then((response) {
      return decoder(response.body);
    });
  }
}

class _JsonApi extends _Api<Map<String, dynamic>> {
  _JsonApi(String endpoint)
      : super(
          endpoint: endpoint,
          decoder: (body) => jsonDecode(body),
        );
}

class _IdApi extends _Api<int> {
  _IdApi(String endpoint)
      : super(
          endpoint: endpoint,
          decoder: (body) => int.parse(body),
        );
}

class _IdsApi extends _Api<List<int>> {
  _IdsApi(String endpoint)
      : super(
          endpoint: endpoint,
          decoder: (body) {
            body = body.replaceAll('[', '');
            body = body.replaceAll(']', '');
            return body
                .split(',')
                .map((e) => e.trim())
                .map((e) => int.parse(e))
                .toList();
          },
        );
}
