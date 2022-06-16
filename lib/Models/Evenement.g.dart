// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Evenement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evenement _$EvenementFromJson(Map<String, dynamic> json) => Evenement(
      id: json['_id'] as String,
      description: json['description'] as String?,
      participant: json['participant'] as List<dynamic>?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      img: json['img'] as String?,
      date: json['date'] as String?,
      prix: json['prix'] as String?,
      nom: json['nom'] as String?,
    );

Map<String, dynamic> _$EvenementToJson(Evenement instance) => <String, dynamic>{
      '_id': instance.id,
      'nom': instance.nom,
      'img': instance.img,
      'date': instance.date,
      'prix': instance.prix,
      'description': instance.description,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'participant': instance.participant,
    };
