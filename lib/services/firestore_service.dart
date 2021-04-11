import 'package:clean_space/errors/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{


  static FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  Future<void> setData(String path, Map<String, dynamic> data) {
    return _tryFutureOrThrowFailure<void>(() async {
      final docRef = _firebaseFireStore.doc(path);
      print("$path : $data");
      await docRef.set(data).timeout(
        Duration(seconds: 15),
        onTimeout: () => throw Failure(message: "Retry, timeout exceeded!"),
      );
    });
  }

  Future<void> addData(String collectionPath, Map<String, dynamic> data) {
    return _tryFutureOrThrowFailure<void>(() async {
      final collectionRef = _firebaseFireStore.collection(collectionPath);
      print("$collectionPath : $data");
      await collectionRef.add(data).timeout(
        Duration(seconds: 15),
        onTimeout: () => throw Failure(message: "Retry, timeout exceeded!"),
      );
    });
  }

  Future<void> updateData(String path, Map<String, dynamic> data) {
    return _tryFutureOrThrowFailure<void>(() async {
      final docRef = _firebaseFireStore.doc(path);
      print("[updateData - $path, $data]: Updating Data...");
      await docRef.update(data).timeout(
        Duration(seconds: 15),
        onTimeout: () => throw Failure(message: "Retry, timeout exceeded!"),
      );
    });
  }

  Future<T> getDocument<T>(
      String path, T builder(DocumentSnapshot snapshot)) async {
    return _tryFutureOrThrowFailure<T>(() async {
      final docRef = _firebaseFireStore.doc(path);
      final snapshot = await docRef.get();
      return builder(snapshot);
    });
  }

  Stream<T> getAllDocuments<T>(
      String collectionPath,T builder(DocumentSnapshot snapshot)) {
    final docRef = _firebaseFireStore.doc(collectionPath);
    return docRef.snapshots().map<T>((snapshot) => builder(snapshot));

  }

  Future<void> deleteDocument(
      String path) async {
    return _tryFutureOrThrowFailure<void>(() async {
      final docRef = _firebaseFireStore.doc(path);
     await docRef.delete();
    });
  }

  Future<T> _tryFutureOrThrowFailure<T>(
      Future<T> Function() methodToTry) async {
    try {
      return await methodToTry();
    } on FirebaseException catch (e) {
      print("A firebase exception has occurred: $e");
      throw Failure(message: e.message);
    } on FormatException catch (e) {
      print("A FormatException has occurred: $e");
      throw Failure(message: "Internal error occured, please try again later!");
    }
  }
}