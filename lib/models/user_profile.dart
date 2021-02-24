import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part "user_profile.g.dart";

@JsonSerializable()
class UserProfile {
  @JsonKey(ignore: true)
  String uid;
  String fullName;
  String email;
  String phone;
  String city;
  String department;
  String avatarUrl;
  DateTime createdAt;
  DateTime updatedAt;

  UserProfile(
      {this.uid,
      @required this.fullName,
      @required this.email,
      this.phone,
      this.city,
      this.createdAt,
      this.department,
      this.updatedAt});

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
