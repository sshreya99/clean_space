import 'package:auto_route/auto_route.dart';
import 'package:clean_space/models/area.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String imageUrl;
  String content;
  String category;
  Location location;
  String author;
  List<String> likes;
  DateTime createdAt;
  DateTime updatedAt;

  Post({
    this.id,
    @required this.imageUrl,
    this.content,
    @required this.category,
    @required this.location,
    @required this.author,
    this.likes,
    this.createdAt,
    this.updatedAt,
  });

  factory Post.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;

    return Post.fromMap(snapshot.data(), snapshot.id);
  }

  factory Post.fromMap(Map<String, dynamic> map, String id) {
    if (map == null) return null;
    return Post(
      id: id,
      imageUrl: map['imageUrl'],
      content: map['content'] ?? "",
      category: map['category'],
      author: map['author'],
      likes: map['likes'] != null && map['likes'] is List
          ? map['likes'].cast<String>()
          : [],
      location: Location.fromString(map['location'] as String),
      createdAt: map['createdAt'] ?? DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] ?? DateTime.parse(map['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "imageUrl": imageUrl,
      "content": content,
      "category": category,
      "author": author,
      "likes": likes,
      "location": location?.toStringForDatabase(),
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}
