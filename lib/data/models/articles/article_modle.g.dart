// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_modle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      body: json['body'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'coverImageUrl': instance.coverImageUrl,
    };
