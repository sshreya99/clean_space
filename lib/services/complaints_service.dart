import 'package:clean_space/app/locator.dart';
import 'package:clean_space/models/complaint.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/models/area.dart';
import 'package:clean_space/services/firestore_service.dart';
import 'package:clean_space/utils/constants/firebase/firestore_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ComplaintsServiceBase {
  Stream<List<Complaint>> getAllComplaints();

  Stream<List<Complaint>> getAllComplaintsOf(UserProfile complaint);

  Stream<List<Complaint>> getComplaintsByArea(Location area);

  Future<int> getComplaintsByAreaCount(Location area);

  Future<Complaint> getComplaint(id);

  Future<void> createComplaint(Complaint complaint);

  Future<void> deleteComplaint(id);

  Future<void> updateComplaint(Complaint complaint);
}

class ComplaintsService implements ComplaintsServiceBase{

  FirestoreService _firestoreService = locator<FirestoreService>();
  String complaintsCollectionPath = FireStoreCollections.complaints;
  FirebaseFirestore _firestore = locator<FirebaseFirestore>();


  @override
  Future<void> createComplaint(Complaint complaint) {
    return _firestoreService.addData(complaintsCollectionPath, complaint.toJson());
  }

  @override
  Future<void> deleteComplaint(id) {
    String path = "$complaintsCollectionPath/$id";
    return _firestoreService.deleteDocument(path);
  }

  @override
  Stream<List<Complaint>> getAllComplaints() {
    return _firestoreService.collectionStream(complaintsCollectionPath, (snapshot) => Complaint.fromSnapshot(snapshot));
  }

  @override
  Stream<List<Complaint>> getAllComplaintsOf(UserProfile user) {
    return _firestoreService.getDataStreamFromQuerySnapShotStream<Complaint>(
        _firestore.collection(complaintsCollectionPath).where("author", isEqualTo: user.uid).snapshots(),
            (snapshot) => Complaint.fromSnapshot(snapshot)
    );
  }

  @override
  Future<Complaint> getComplaint(id) {
    String path = "$complaintsCollectionPath/$id";
    return _firestoreService.getDocument<Complaint>(path, (snapshot) => Complaint.fromSnapshot(snapshot));
  }

  @override
  Stream<List<Complaint>> getComplaintsByArea(Location area) {
    // TODO: implement getComplaintsByArea
    throw UnimplementedError();
  }

  @override
  Future<int> getComplaintsByAreaCount(Location area) {
    // TODO: implement getComplaintsByAreaCount
    throw UnimplementedError();
  }

  @override
  Future<void> updateComplaint(Complaint complaint) {
    String path = "$complaintsCollectionPath/${complaint.id}";
    return _firestoreService.updateData(path, complaint.toJson());
  }

}

