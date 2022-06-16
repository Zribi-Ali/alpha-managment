import 'User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Comment.g.dart';

@JsonSerializable(explicitToJson: true)
class Comment {
  @JsonKey(name: '_id')
  final String id;
  final String? content;
  User user;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  Comment(
      {this.content,
      required this.id,
      required this.user,
      this.updatedAt,
      this.createdAt});

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
