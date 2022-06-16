// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Classe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Class _$ClassFromJson(Map<String, dynamic> json) => Class(
      nom: json['nom'] as String?,
      cours: (json['cours'] as List<dynamic>?)
          ?.map((e) => Courss.fromJson(e as Map<String, dynamic>))
          .toList(),
      proffeseur: (json['proffeseur'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      etudiant: (json['etudiant'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String,
      duree: json['duree'] as String?,
      forma: Formation.fromJson(json['formation'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ClassToJson(Class instance) => <String, dynamic>{
      '_id': instance.id,
      'nom': instance.nom,
      'duree': instance.duree,
      'formation': instance.forma.toJson(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'etudiant': instance.etudiant?.map((e) => e.toJson()).toList(),
      'proffeseur': instance.proffeseur?.map((e) => e.toJson()).toList(),
      'cours': instance.cours?.map((e) => e.toJson()).toList(),
    };
