import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  String id;

  Post.fromSnapshot(DocumentSnapshot snapshot);

  Map<String, dynamic> toJson(){
    return {};
  }
}