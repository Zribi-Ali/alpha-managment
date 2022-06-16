// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String,
      nom: json['nom'] as String?,
      prenom: json['prenom'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      receipt: json['receipt'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'nom': instance.nom,
      'prenom': instance.prenom,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      '_id': instance.id,
      'receipt': instance.receipt,
    };
