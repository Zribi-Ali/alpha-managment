// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Cours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Courss _$CourssFromJson(Map<String, dynamic> json) => Courss(
      json['_id'] as String,
      User.fromJson(json['user'] as Map<String, dynamic>),
      json['classe'] as String,
      json['content'] as String,
    );

Map<String, dynamic> _$CourssToJson(Courss instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user.toJson(),
      'classe': instance.classe,
      'content': instance.content,
    };
