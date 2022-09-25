import 'package:blog_app/data/models/articles/article_modle.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_modle.g.dart';

@JsonSerializable()
class AmataUser {
  String? userName;
  String? emailAddrress;
  String? uid;
  String? profileUrl;
  String? bio;
  List<Article>? savedArticles;

  AmataUser(
      {this.emailAddrress,
      this.profileUrl,
      this.savedArticles,
      this.userName,
      this.uid,
      this.bio});

  factory AmataUser.fromJson(Map<String, dynamic> json) =>
      _$AmataUserFromJson(json);

  Map<String, dynamic> toJson() => _$AmataUserToJson(this);

}
