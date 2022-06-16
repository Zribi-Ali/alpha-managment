import 'package:alpha/Models/User.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'Evenement.g.dart';

@JsonSerializable()
class Evenement {
  @JsonKey(name: '_id')
  final String id;
  final String? nom;
  final String? img;
  final String? date;
  final String? prix;
  final String? description;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  List? participant;
  Evenement(
      {required this.id,
      this.description,
      this.participant,
      this.updatedAt,
      this.createdAt,
      this.img,
      this.date,
      this.prix,
      this.nom});

  factory Evenement.fromJson(Map<String, dynamic> json) =>
      _$EvenementFromJson(json);
  Map<String, dynamic> toJson() => _$EvenementToJson(this);
}
