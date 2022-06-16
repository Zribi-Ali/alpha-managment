// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      content: json['content'] as String?,
      id: json['_id'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'user': instance.user.toJson(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };
