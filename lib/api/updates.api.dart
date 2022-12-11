import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdatesResponse {
  final List<int> items;
  final List<String> profiles;

  UpdatesResponse({
    required this.items,
    required this.profiles,
  });
}

class UpdatesRequest {
  UpdatesRequest._();

  static Future<UpdatesResponse> get() async {
    final response = await http.get(
      Uri.parse('https://hacker-news.firebaseio.com/v0/updates.json'),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final items = List.of(data['items']);
    final profiles = List.of(data['profiles']);
    return UpdatesResponse(
      items: List.of(items.map((e) => e as int)),
      profiles: List.of(List.of(profiles).map((e) => e as String)),
    );
  }
}
