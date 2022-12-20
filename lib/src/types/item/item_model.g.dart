// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ItemModel _$$_ItemModelFromJson(Map<String, dynamic> json) => _$_ItemModel(
      by: json['by'] as String?,
      descendants: json['descendants'] as int?,
      id: json['id'] as int?,
      kids: (json['kids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      url: json['url'] as String?,
      parts: (json['parts'] as List<dynamic>?)?.map((e) => e as int).toList(),
      title: json['title'] as String?,
      poll: json['poll'] as int?,
      score: json['score'] as int?,
      text: json['text'] as String?,
      time: json['time'] as int?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$_ItemModelToJson(_$_ItemModel instance) =>
    <String, dynamic>{
      'by': instance.by,
      'descendants': instance.descendants,
      'id': instance.id,
      'kids': instance.kids,
      'url': instance.url,
      'parts': instance.parts,
      'title': instance.title,
      'poll': instance.poll,
      'score': instance.score,
      'text': instance.text,
      'time': instance.time,
      'type': instance.type,
    };
