import 'Formation.dart';
import 'Publication.dart';
import 'package:json_annotation/json_annotation.dart';
import 'Formation.dart';

part 'User.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String? nom;
  final String? prenom;
  final String? email;
  final String? password;
  final String? role;
  @JsonKey(name: '_id')
  final String id;
  final String? receipt;

  User({
    required this.id,
    this.nom,
    this.prenom,
    this.email,
    this.password,
    this.role,
    this.receipt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
