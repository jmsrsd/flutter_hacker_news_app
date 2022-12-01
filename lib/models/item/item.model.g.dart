// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Item _$$_ItemFromJson(Map<String, dynamic> json) => _$_Item(
      id: json['id'] as int? ?? null,
      deleted: json['deleted'] as bool? ?? null,
      type: json['type'] as String? ?? null,
      by: json['by'] as String? ?? null,
      time: json['time'] as int? ?? null,
      text: json['text'] as String? ?? null,
      dead: json['dead'] as bool? ?? null,
      parent: json['parent'] as int? ?? null,
      poll: json['poll'] as int? ?? null,
      kids: (json['kids'] as List<dynamic>?)?.map((e) => e as int).toList() ??
          null,
      url: json['url'] as String? ?? null,
      score: json['score'] as int? ?? null,
      title: json['title'] as String? ?? null,
      parts: (json['parts'] as List<dynamic>?)?.map((e) => e as int).toList() ??
          null,
      descendant: json['descendant'] as int? ?? null,
    );

Map<String, dynamic> _$$_ItemToJson(_$_Item instance) => <String, dynamic>{
      'id': instance.id,
      'deleted': instance.deleted,
      'type': instance.type,
      'by': instance.by,
      'time': instance.time,
      'text': instance.text,
      'dead': instance.dead,
      'parent': instance.parent,
      'poll': instance.poll,
      'kids': instance.kids,
      'url': instance.url,
      'score': instance.score,
      'title': instance.title,
      'parts': instance.parts,
      'descendant': instance.descendant,
    };
