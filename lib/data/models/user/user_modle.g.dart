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
      uid: json['uid'] as String?,
      bio: json['bio'] as String?,
    );

Map<String, dynamic> _$AmataUserToJson(AmataUser instance) => <String, dynamic>{
      'userName': instance.userName,
      'emailAddrress': instance.emailAddrress,
      'uid': instance.uid,
      'profileUrl': instance.profileUrl,
      'bio': instance.bio,
      'savedArticles': instance.savedArticles,
    };
