import 'package:cloud_firestore/cloud_firestore.dart';

class Complaint{
  String id;
  String imageUrl;

  Complaint.fromSnapshot(DocumentSnapshot snapshot);

  Map<String, dynamic> toJson(){
    return {};
  }
}