import 'package:json_annotation/json_annotation.dart';

part 'article_modle.g.dart';

@JsonSerializable()
class Article {
  String? title;
  String? body;
  String? coverImageUrl;
  Article({this.body, this.coverImageUrl, this.title});

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  Article copyWith({String? title, String? body, String? coverImageUrl}) {
    return Article(
      title: title??this.title,
      body: body??this.body, 
      coverImageUrl:coverImageUrl??this.coverImageUrl
    );
  }
}
