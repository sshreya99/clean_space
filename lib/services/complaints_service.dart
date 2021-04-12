import 'dart:io';

import 'package:clean_space/app/locator.dart';
import 'package:clean_space/errors/failure.dart';
import 'package:clean_space/models/post.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/models/area.dart';
import 'package:clean_space/services/firestore_service.dart';
import 'package:clean_space/utils/constants/firebase/firebase_storage_buckets.dart';
import 'package:clean_space/utils/constants/firebase/firestore_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ComplaintsServiceBase {
  Stream<List<Post>> getAllComplaints();

  Stream<List<Post>> getAllComplaintsOf(UserProfile complaint);

  Stream<List<Post>> getComplaintsByArea(Location location);

  Future<int> getComplaintsByAreaCount(Location location);

  Future<Post> getComplaint(id);

  Future<void> createComplaint(Post complaint);

  Future<void> deleteComplaint(id);

  Future<void> updateComplaint(Post complaint);
}

class ComplaintsService implements ComplaintsServiceBase{

  FirestoreService _firestoreService = locator<FirestoreService>();
  String complaintsCollectionPath = FireStoreCollections.complaints;
  static FirebaseStorage _firebaseStorage = locator<FirebaseStorage>();
  FirebaseFirestore _firestore = locator<FirebaseFirestore>();

  final _postImagesBucket =
  _firebaseStorage.ref(FirebaseStorageBuckets.postsImages);

  @override
  Future<void> createComplaint(Post complaint) {
    return _firestoreService.addData(complaintsCollectionPath, complaint.toMap());
  }

  @override
  Future<void> deleteComplaint(id) {
    String path = "$complaintsCollectionPath/$id";
    return _firestoreService.deleteDocument(path);
  }

  @override
  Stream<List<Post>> getAllComplaints() {
    return _firestoreService.collectionStream(complaintsCollectionPath, (snapshot) => Post.fromSnapshot(snapshot)..isComplaint = true);
  }

  @override
  Stream<List<Post>> getAllComplaintsOf(UserProfile user) {
    return _firestoreService.getDataStreamFromQuerySnapShotStream<Post>(
        _firestore.collection(complaintsCollectionPath).where("author", isEqualTo: user.uid).orderBy("createdAt", descending: true).snapshots(),
            (snapshot) => Post.fromSnapshot(snapshot)..isComplaint = true
    );
  }

  @override
  Future<Post> getComplaint(id) {
    String path = "$complaintsCollectionPath/$id";
    return _firestoreService.getDocument<Post>(path, (snapshot) => Post.fromSnapshot(snapshot));
  }

  @override
  Stream<List<Post>> getComplaintsByArea(Location location) {
    return _firestoreService.getDataStreamFromQuerySnapShotStream<Post>(
        _firestore.collection(complaintsCollectionPath).where("location", isEqualTo: location.toStringForDatabase()).orderBy("createdAt", descending: true).snapshots(),
            (snapshot) => Post.fromSnapshot(snapshot)
    );
  }

  @override
  Future<int> getComplaintsByAreaCount(Location location) async{
    List<Post> posts =  await getComplaintsByArea(location).first;
    return posts.length;
  }

  @override
  Future<void> updateComplaint(Post complaint) {
    String path = "$complaintsCollectionPath/${complaint.id}";
    return _firestoreService.updateData(path, complaint.toMap());
  }

  Future<String> uploadImageAndGetDownloadableUrl(
      File image, String imageName) async {
    final imageReference = _postImagesBucket.child(imageName);
    try {
      await imageReference.putFile(image);
      return imageReference.getDownloadURL();
    } on FirebaseException catch (e) {
      print("A firebase exception has occurred: $e");
      throw Failure(message: e.message);
    }
  }
  Future<List<String>> getAllLocationsFromComplaints()async{
    final qs = await _firestore.collection(complaintsCollectionPath).get();
    return qs.docs.map<String>((p) => p['location'] as String).toSet().toList();
  }
}

