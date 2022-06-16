import 'package:json_annotation/json_annotation.dart';
import 'Classe.dart';
import 'User.dart';

part 'Cours.g.dart';

@JsonSerializable(explicitToJson: true)
class Courss {
  @JsonKey(name: '_id')
  final String id;
  User user;
  String classe;
  String content;

  Courss(this.id, this.user, this.classe, this.content);

  factory Courss.fromJson(Map<String, dynamic> json) => _$CourssFromJson(json);
  Map<String, dynamic> toJson() => _$CourssToJson(this);
}
