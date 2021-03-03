import 'package:flutter/foundation.dart';

class UserProfile {
  String uid;
  String fullName;
  String username;
  String email;
  String phone;
  String avatarUrl;
  DateTime createdAt;
  DateTime updatedAt;

  UserProfile({
    this.uid,
    this.fullName,
    @required this.username,
    @required this.email,
    this.phone,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map, String uid) {
    if (map == null) return null;
    return UserProfile(
      uid: uid,
      fullName: map['fullName'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      avatarUrl: map['avatarUrl'] as String,
      createdAt: map['createdAt'] == null
          ? null
          : DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] == null
          ? null
          : DateTime.parse(map['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': this.fullName,
      'username': this.username,
      'email': this.email,
      'phone': this.phone,
      'avatarUrl': this.avatarUrl,
      'createdAt': this.createdAt?.toIso8601String(),
      'updatedAt': this.updatedAt?.toIso8601String(),
    };
  }
}
