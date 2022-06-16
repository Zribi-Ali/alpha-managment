import 'package:json_annotation/json_annotation.dart';
import 'Formation.dart';
import 'Cours.dart';
import 'User.dart';

part 'Classe.g.dart';

@JsonSerializable(explicitToJson: true)
class Class {
  @JsonKey(name: '_id')
  final String id;
  final String? nom;
  final String? duree;
  @JsonKey(name: 'formation')
  Formation forma;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  List<User>? etudiant;
  List<User>? proffeseur;
  List<Courss>? cours;

  Class(
      {this.nom,
      this.cours,
      this.proffeseur,
      this.etudiant,
      required this.id,
      this.duree,
      required this.forma,
      this.updatedAt,
      this.createdAt});

  factory Class.fromJson(Map<String, dynamic> json) => _$ClassFromJson(json);
  Map<String, dynamic> toJson() => _$ClassToJson(this);
}
