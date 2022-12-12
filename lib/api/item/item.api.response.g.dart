// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.api.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ItemResponse _$$_ItemResponseFromJson(Map<String, dynamic> json) =>
    _$_ItemResponse(
      descendants: json['descendants'] as int? ?? null,
      parent: json['parent'] as int? ?? null,
      text: json['text'] as String? ?? null,
      poll: json['poll'] as int? ?? null,
      score: json['score'] as int? ?? null,
      title: json['title'] as String? ?? null,
      url: json['url'] as String? ?? null,
      deleted: json['deleted'] as bool? ?? false,
      dead: json['dead'] as bool? ?? false,
      kids: (json['kids'] as List<dynamic>?)?.map((e) => e as int).toList() ??
          const [],
      parts: (json['parts'] as List<dynamic>?)?.map((e) => e as int).toList() ??
          const [],
      by: json['by'] as String,
      id: json['id'] as int,
      time: json['time'] as int,
      type: $enumDecode(_$ItemResponseTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$_ItemResponseToJson(_$_ItemResponse instance) =>
    <String, dynamic>{
      'descendants': instance.descendants,
      'parent': instance.parent,
      'text': instance.text,
      'poll': instance.poll,
      'score': instance.score,
      'title': instance.title,
      'url': instance.url,
      'deleted': instance.deleted,
      'dead': instance.dead,
      'kids': instance.kids,
      'parts': instance.parts,
      'by': instance.by,
      'id': instance.id,
      'time': instance.time,
      'type': _$ItemResponseTypeEnumMap[instance.type]!,
    };

const _$ItemResponseTypeEnumMap = {
  ItemResponseType.story: 'story',
  ItemResponseType.comment: 'comment',
  ItemResponseType.job: 'job',
  ItemResponseType.poll: 'poll',
  ItemResponseType.pollopt: 'pollopt',
};
