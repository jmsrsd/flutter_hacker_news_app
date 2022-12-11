import 'dart:convert';

import 'package:http/http.dart' as http;

enum ItemType {
  story,
  comment,
  job,
  poll,
  pollopt,
}

class ItemResponse {
  final String by;
  final int? descendants;
  final int id;
  final List<int> kids;
  final int? parent;
  final List<int> parts;
  final String? text;
  final int? poll;
  final int? score;
  final DateTime time;
  final String? title;
  final ItemType type;
  final String? url;
  final bool deleted;
  final bool dead;

  ItemResponse({
    required this.by,
    required this.descendants,
    required this.id,
    required this.kids,
    required this.parent,
    required this.parts,
    required this.text,
    required this.poll,
    required this.score,
    required this.time,
    required this.title,
    required this.type,
    required this.url,
    required this.deleted,
    required this.dead,
  });
}

class ItemRequest {
  ItemRequest._();

  static Future<ItemResponse> get(int itemId) async {
    final response = await http.get(
      Uri.parse(
        'https://hacker-news.firebaseio.com/v0/item/'
        '$itemId.json',
      ),
    );

    final data = Map.of(jsonDecode(response.body));

    final by = data['by'].toString();
    final descendants = int.tryParse(data['descendants'].toString());
    final id = int.parse(data['id'].toString());
    final kids = List.of(
      data['kids'] ?? [],
    ).map((e) => e as int).toList();
    final parent = int.tryParse(data['parent'].toString());
    final parts = List.of(
      data['parts'] ?? [],
    ).map((e) => e as int).toList();
    final text = data['text'] as String?;
    final poll = int.tryParse(data['poll'].toString());
    final score = int.tryParse(data['score'].toString());
    final time = int.parse(data['time'].toString());
    final title = data['title'] as String?;
    final type = ItemType.values.byName(data['type'].toString());
    final url = data['url'] as String?;
    final deleted = data['deleted'] == true;
    final dead = data['dead'] == true;

    return ItemResponse(
      by: by,
      descendants: descendants,
      id: id,
      kids: kids,
      parent: parent,
      parts: parts,
      text: text,
      poll: poll,
      score: score,
      time: DateTime.fromMillisecondsSinceEpoch(time * 1000),
      title: title,
      type: type,
      url: url,
      deleted: deleted,
      dead: dead,
    );
  }
}
