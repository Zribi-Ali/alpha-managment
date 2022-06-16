import 'dart:convert';
import 'package:alpha/Models/User.dart';
import 'package:json_annotation/json_annotation.dart';
import 'Comment.dart';

part 'Publication.g.dart';

@JsonSerializable(explicitToJson: true)
class Publiucation {
  final String? nom;
  final String? content;
  final String? titre;
  List<Comment>? comments;
  final List? likers;
  @JsonKey(name: '_id')
  final String? id;
  User? user;
  var createdAt;
  var updatedAt;
  String? img;
  //final Likers? likes;

  Publiucation(
      {this.id,
      this.nom,
      this.img,
      this.content,
      this.comments,
      this.titre,
      this.likers,
      this.user,
      this.createdAt,
      this.updatedAt});

  factory Publiucation.fromJson(Map<String, dynamic> json) =>
      _$PubliucationFromJson(json);
  Map<String, dynamic> toJson() => _$PubliucationToJson(this);
}
