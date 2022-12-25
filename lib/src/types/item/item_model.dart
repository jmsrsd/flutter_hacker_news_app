import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  factory ItemModel({
    String? by,
    int? descendants,
    int? id,
    List<int>? kids,
    String? url,
    List<int>? parts,
    String? title,
    int? poll,
    int? score,
    String? text,
    int? time,
    String? type,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
}
