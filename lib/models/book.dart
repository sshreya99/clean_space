import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String id;
  String title = "";
  String author = "";
  String description = "";
  List genres = [];
  String imageUrl;

  Book({this.id, this.title, this.author, this.genres, this.imageUrl});

  Book.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.id;
    title = snapshot["title"] as String;
    author = snapshot["author"] as String;
    description = snapshot["description"] as String;
    genres = snapshot["genres"]?.cast<String>() ?? [];
    imageUrl = snapshot["imageUrl"] as String;
  }

//  Book.fromMap(Map<String, dynamic> snapshot) {
//    print(snapshot["title"]);
//    title = snapshot["title"];
//    author = snapshot["author"];
//    genres = snapshot["genres"];
//    imageUrl = snapshot["imageUrl"];
//  }

  Map<String, dynamic> toMap() {
    return {
      "title": this.title,
      "description": this.description,
      "author": this.author,
      "genres": this.genres,
      "imageUrl": this.imageUrl,
    };
  }

  @override
  String toString() {
    return 'Book{title: $title, author: $author, genres: $genres, imageUrl: $imageUrl}';
  }
}
