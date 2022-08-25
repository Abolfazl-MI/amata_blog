import 'package:blog_app/data/models/articles/article_modle.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_modle.g.dart';

@JsonSerializable()
class AmataUser {
  String? userName;
  String? emailAddrress;
  String? password;
  String? profileUrl;
  List<Article>? savedArticles;

  AmataUser(
      {this.emailAddrress,
      this.password,
      this.profileUrl,
      this.savedArticles,
      this.userName});

  factory AmataUser.fromJson(Map<String, dynamic> json) =>
      _$AmataUserFromJson(json);

  Map<String, dynamic> toJson() => _$AmataUserToJson(this);

  AmataUser copyWith(
          {String? emailAddres,
          String? password,
          String? profileUrlm,
          List<Article>? savedArticles}) =>
      AmataUser(
          profileUrl: profileUrl ?? this.profileUrl,
          emailAddrress: emailAddrress ?? this.emailAddrress,
          password: password ?? this.password,
          savedArticles: savedArticles ?? this.savedArticles);
}
