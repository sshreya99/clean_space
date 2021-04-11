import 'package:auto_route/auto_route.dart';
import 'package:clean_space/models/area.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  bool isComplaint = false;
  String imageUrl;
  String content;
  String category;
  Location location;
  String author;
  List<String> likes;
  DateTime createdAt;
  DateTime updatedAt;

  @override
  String toString() {
    return 'Post{id: $id, isComplaint: $isComplaint, imageUrl: $imageUrl, content: $content, category: $category, location: $location, author: $author, likes: $likes, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

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
    this.isComplaint = false,
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
      createdAt: map['createdAt'] == null ? null : DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] == null ? null : DateTime.parse(map['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "imageUrl": imageUrl,
      "content": content,
      "category": category,
      "author": author,
      "likes": likes,
      "location": location?.toStringForDatabase(),
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }
}
