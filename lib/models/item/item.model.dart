import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.model.freezed.dart';
part 'item.model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  factory ItemModel({
    @Default(null) int? id,
    @Default(null) bool? deleted,
    @Default(null) String? type,
    @Default(null) String? by,
    @Default(null) int? time,
    @Default(null) String? text,
    @Default(null) bool? dead,
    @Default(null) int? parent,
    @Default(null) int? poll,
    @Default(null) List<int>? kids,
    @Default(null) String? url,
    @Default(null) int? score,
    @Default(null) String? title,
    @Default(null) List<int>? parts,
    @Default(null) int? descendant,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
}
