import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'Formation.g.dart';

@JsonSerializable(explicitToJson: true)
class Formation {
  @JsonKey(name: '_id')
  final String? id;
  final String? description;
  final String? duree;
  final String? nom;
  final String? img;
  @JsonKey(name: 'date_fin')
  final String? datefin;
  @JsonKey(name: 'date_debut')
  final String? datedebut;
  final String? prix;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final String? type;

  Formation(
      {this.id,
      this.img,
      this.description,
      this.duree,
      this.nom,
      this.datefin,
      this.datedebut,
      this.prix,
      this.updatedAt,
      this.createdAt,
      this.type});

  factory Formation.fromJson(Map<String, dynamic> json) =>
      _$FormationFromJson(json);
  Map<String, dynamic> toJson() => _$FormationToJson(this);
}














/*
import 'package:alpha/Models/User.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Formation.g.dart';

@JsonSerializable(explicitToJson: true)
class Formation {
  @JsonKey(name: '_id')
  final String? id;
  final String description;
  final String? duree;
  final String nom;
  @JsonKey(name: 'date_fin')
  final String? datefin;
  @JsonKey(name: 'date_debut')
  final String? datedebut;
  final String? prix;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final String type;
  // @JsonKey(name: 'etudiant')
  // List<User>? etudiant;
  @JsonKey(name: 'proffeseur')
  User proffeseur;

  Formation({
    required this.type,
    required this.description,
    this.id,
    this.duree,
    this.datefin,
    required this.nom,
    this.prix,
    this.datedebut,
    //this.etud,
    required this.prof,
    this.createdAt,
    this.updatedAt,
  });

  factory Formation.fromJson(Map<String, dynamic> json) =>
      _$FormationFromJson(json);
  Map<String, dynamic> toJson() => _$FormationToJson(this);
}

 */