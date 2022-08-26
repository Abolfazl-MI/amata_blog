// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_modle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AmataUser _$AmataUserFromJson(Map<String, dynamic> json) => AmataUser(
      emailAddrress: json['emailAddrress'] as String?,
      profileUrl: json['profileUrl'] as String?,
      savedArticles: (json['savedArticles'] as List<dynamic>?)
          ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$AmataUserToJson(AmataUser instance) => <String, dynamic>{
      'userName': instance.userName,
      'emailAddrress': instance.emailAddrress,
      'profileUrl': instance.profileUrl,
      'savedArticles': instance.savedArticles,
    };
