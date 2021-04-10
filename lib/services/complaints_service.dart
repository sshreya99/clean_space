import 'package:clean_space/app/locator.dart';
import 'package:clean_space/models/complaint.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/models/area.dart';
import 'package:clean_space/services/firestore_service.dart';
import 'package:clean_space/utils/constants/firebase/firestore_collections.dart';

abstract class ComplaintsServiceBase {
  Stream<Complaint> getAllComplaints();

  Stream<Complaint> getAllComplaintsOf(UserProfile complaint);

  Stream<Complaint> getComplaintsByArea(Area area);

  Future<int> getComplaintsByAreaCount(Area area);

  Future<Complaint> getComplaint(id);

  Future<void> createComplaint(Complaint complaint);

  Future<void> deleteComplaint(id);

  Future<void> updateComplaint(Complaint complaint);
}

class ComplaintsService implements ComplaintsServiceBase{

  FirestoreService _firestoreService = locator<FirestoreService>();
  String complaintsCollectionPath = FireStoreCollections.complaints;

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
  Stream<Complaint> getAllComplaints() {
    return _firestoreService.getAllDocuments(complaintsCollectionPath, (snapshot) => Complaint.fromSnapshot(snapshot));
  }

  @override
  Stream<Complaint> getAllComplaintsOf(UserProfile complaint) {
    // TODO: implement getAllComplaintsOf
    throw UnimplementedError();
  }

  @override
  Future<Complaint> getComplaint(id) {
    String path = "$complaintsCollectionPath/$id";
    return _firestoreService.getDocument<Complaint>(path, (snapshot) => Complaint.fromSnapshot(snapshot));
  }

  @override
  Stream<Complaint> getComplaintsByArea(Area area) {
    // TODO: implement getComplaintsByArea
    throw UnimplementedError();
  }

  @override
  Future<int> getComplaintsByAreaCount(Area area) {
    // TODO: implement getComplaintsByAreaCount
    throw UnimplementedError();
  }

  @override
  Future<void> updateComplaint(Complaint complaint) {
    String path = "$complaintsCollectionPath/${complaint.id}";
    return _firestoreService.updateData(path, complaint.toJson());
  }

}

