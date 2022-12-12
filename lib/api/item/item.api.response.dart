import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'item.api.response.type.dart';

part 'item.api.response.freezed.dart';
part 'item.api.response.g.dart';

@freezed
class ItemResponse with _$ItemResponse {
  factory ItemResponse({
    @Default(null) int? descendants,
    @Default(null) int? parent,
    @Default(null) String? text,
    @Default(null) int? poll,
    @Default(null) int? score,
    @Default(null) String? title,
    @Default(null) String? url,
    @Default(false) bool deleted,
    @Default(false) bool dead,
    @Default([]) List<int> kids,
    @Default([]) List<int> parts,
    required String by,
    required int id,
    required int time,
    required ItemResponseType type,
  }) = _ItemResponse;

  factory ItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemResponseFromJson(json);
}
