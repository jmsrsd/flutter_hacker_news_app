import 'dart:convert';

import 'package:http/http.dart' as http;

import 'item.api.response.dart';
import 'item.api.response.type.dart';

class ItemRequest {
  ItemRequest._();

  static Future<ItemResponse> get(int itemId) async {
    final response = await http.get(
      Uri.parse(
        'https://hacker-news.firebaseio.com/v0/item/'
        '$itemId.json',
      ),
    );

    return ItemResponse.fromJson(jsonDecode(response.body));
  }
}
