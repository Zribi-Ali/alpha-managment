// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Publication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Publiucation _$PubliucationFromJson(Map<String, dynamic> json) => Publiucation(
      id: json['_id'] as String?,
      nom: json['nom'] as String?,
      img: json['img'] as String?,
      content: json['content'] as String?,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      titre: json['titre'] as String?,
      likers: json['likers'] as List<dynamic>?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$PubliucationToJson(Publiucation instance) =>
    <String, dynamic>{
      'nom': instance.nom,
      'content': instance.content,
      'titre': instance.titre,
      'comments': instance.comments?.map((e) => e.toJson()).toList(),
      'likers': instance.likers,
      '_id': instance.id,
      'user': instance.user?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'img': instance.img,
    };
