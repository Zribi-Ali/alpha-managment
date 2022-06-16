// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Formation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Formation _$FormationFromJson(Map<String, dynamic> json) => Formation(
      id: json['_id'] as String?,
      img: json['img'] as String?,
      description: json['description'] as String?,
      duree: json['duree'] as String?,
      nom: json['nom'] as String?,
      datefin: json['date_fin'] as String?,
      datedebut: json['date_debut'] as String?,
      prix: json['prix'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$FormationToJson(Formation instance) => <String, dynamic>{
      '_id': instance.id,
      'description': instance.description,
      'duree': instance.duree,
      'nom': instance.nom,
      'img': instance.img,
      'date_fin': instance.datefin,
      'date_debut': instance.datedebut,
      'prix': instance.prix,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'type': instance.type,
    };
