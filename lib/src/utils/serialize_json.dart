import 'dart:convert';

serializeJson(dynamic json) {
  return jsonDecode(jsonEncode(json));
}
