import 'package:http/http.dart' as http;

typedef MaxItemResponse = int;

class MaxItemRequest {
  MaxItemRequest._();

  static Future<MaxItemResponse> get() async {
    final response = await http.get(
      Uri.parse('https://hacker-news.firebaseio.com/v0/maxitem.json'),
    );
    return int.parse(response.body);
  }
}
