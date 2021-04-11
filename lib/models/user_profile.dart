import 'package:clean_space/models/area.dart';
import 'package:flutter/foundation.dart';

class UserProfile {
  String uid;
  // String fullName;
  String username;
  String email;
  String phone;
  String avatarUrl;
  Location location;
  String bio = "";
  DateTime createdAt;
  DateTime updatedAt;


  @override
  String toString() {
    return 'UserProfile{uid: $uid, username: $username, email: $email, phone: $phone, avatarUrl: $avatarUrl, location: $location, bio: $bio, createdAt: $createdAt, updatedAt: $updatedAt}';
  }


  UserProfile({
    this.uid,
    // this.fullName,
    @required this.username,
    @required this.email,
    this.phone,
    this.avatarUrl,
    this.location,
    this.bio,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map, String uid) {
    if (map == null) return null;
    return UserProfile(
      uid: uid,
      // fullName: map['fullName'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      avatarUrl: map['avatarUrl'] as String,
      location: (map['location']) == null ? null  : Location.fromString(map['location']),
      bio: map['bio'] as String,
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
      // 'fullName': this.fullName,
      'username': this.username,
      'email': this.email,
      'phone': this.phone,
      'bio': this.bio,
      'location': this.location?.toStringForDatabase(),
      'avatarUrl': this.avatarUrl,
      'createdAt': this.createdAt?.toIso8601String(),
      'updatedAt': this.updatedAt?.toIso8601String(),
    };
  }
}
