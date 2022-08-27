import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:patreon/converters/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    /// The unique id of the user.
    required String uid,

    /// The user's email.
    required String email,

    /// Firebase Cloud Message token for push notifications.
    String? fcmToken,

    /// Time the user was created.
    @TimestampConverter() required DateTime created,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

//flutter pub run build_runner build --delete-conflicting-outputs