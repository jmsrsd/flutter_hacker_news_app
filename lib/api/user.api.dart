import 'dart:convert';

import 'package:http/http.dart' as http;

class UserResponse {
  final String id;
  final DateTime created;
  final int karma;
  final String about;
  final List<int> submitted;

  UserResponse({
    required this.id,
    required this.created,
    required this.karma,
    required this.about,
    required this.submitted,
  });
}

class UserRequest {
  UserRequest._();

  static Future<UserResponse> get({required String userId}) async {
    final response = await http.get(
      Uri.parse(
        'https://hacker-news.firebaseio.com/v0/user/'
        '$userId.json',
      ),
    );
    final data = Map.of(jsonDecode(response.body));
    final id = data['id'].toString();
    final created = int.parse(data['created'].toString());
    final karma = int.parse(data['karma'].toString());
    final about = data['about'].toString();
    final submitted = List.of(
      data['submitted'],
    ).map((e) => e as int).toList();

    return UserResponse(
      id: id,
      created: DateTime.fromMillisecondsSinceEpoch(created * 1000),
      karma: karma,
      about: about,
      submitted: submitted,
    );
  }
}
