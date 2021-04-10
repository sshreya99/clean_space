import 'package:cloud_firestore/cloud_firestore.dart';

class Complaint{
  String id;

  Complaint.fromSnapshot(DocumentSnapshot snapshot);

  Map<String, dynamic> toJson(){
    return {};
  }
}