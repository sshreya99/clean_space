import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part "user_profile.g.dart";

@JsonSerializable()
class UserProfile {
  @JsonKey(ignore: true)
  String uid;
  String fullName;
  String username;
  String email;
  String phone;
  String avatarUrl;
  DateTime createdAt;
  DateTime updatedAt;

  UserProfile(
      {this.uid,
      this.fullName,
      @required this.username,
      @required this.email,
      this.phone,
      this.avatarUrl,
      this.createdAt,
      this.updatedAt});

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
