// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      fcmToken: json['fcmToken'] as String?,
      created:
          const TimestampConverter().fromJson(json['created'] as Timestamp),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'fcmToken': instance.fcmToken,
      'created': const TimestampConverter().toJson(instance.created),
    };
