import 'dart:io';
import 'package:clean_space/app/locator.dart';
import 'package:clean_space/errors/failure.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/utils/constants/firebase/firebase_storage_buckets.dart';
import 'package:clean_space/utils/constants/firebase/firestore_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserProfileService {
  // Firebase instances
  static FirebaseFirestore _firebaseFireStore = locator<FirebaseFirestore>();
  static FirebaseStorage _firebaseStorage = locator<FirebaseStorage>();

  // References
  final CollectionReference _userProfiles =
      _firebaseFireStore.collection(FireStoreCollections.userProfiles);

  final _userProfileAvatarBucket =
      _firebaseStorage.ref(FirebaseStorageBuckets.userProfileAvatars);

  Future<UserProfile> getUserProfile(String uid) async {
    try {
      final snapshot = await _userProfiles.doc(uid).get();
      return UserProfile.fromMap(snapshot.data(), uid);
    } on FirebaseException catch (e) {
      print("A firebase exception has occured: $e");
      throw Failure(message: e.message);
    } on FormatException catch (e) {
      print("A FormatException has occured: $e");
      throw Failure(
          message: "could not get user profile, please try again later!");
    }
  }

  Future<bool> isUsernameAlreadyTaken(String userName)async{
    userName = userName.trim().toLowerCase();

    //! Warning: to just count the number we should not perform below operation -
    // each document "costs" one read. However, we will only get either 0 or 1 for the query so
    // no worries for this function. ref: https://stackoverflow.com/questions/46554091/cloud-firestore-collection-count
    final querySnapshot =  await _firebaseFireStore.collection(FireStoreCollections.userProfiles).where("username",isEqualTo: userName).get();
    return querySnapshot.size != 0;
  }

  Future<String> getEmailFromUsername(String userName)async{
    userName = userName.trim().toLowerCase();

    final querySnapshot =  await _firebaseFireStore.collection(FireStoreCollections.userProfiles).where("username",isEqualTo: userName).get();
    if(querySnapshot.size == 0){
      throw Failure(message: "No user found for the given username!");
    }

    if(querySnapshot.size != 1){
      throw Failure(message: "Multiple users found for the given username!");
    }

    UserProfile userProfile = UserProfile.fromMap(querySnapshot.docs.first.data(), querySnapshot.docs.first.id);
    return userProfile.email;
  }

  /// [createUserProfile] has same functionality as [updateUserProfile].
  Future<bool> createUserProfile(UserProfile userProfile) =>
      updateUserProfile(userProfile..createdAt = DateTime.now());

  Future<bool> updateUserProfile(UserProfile userProfile) async {
    try {
      userProfile.updatedAt = DateTime.now();
      await _userProfiles.doc(userProfile.uid).set(userProfile.toMap()).timeout(
            Duration(seconds: 15),
            onTimeout: () => throw Failure(message: "Retry, timeout exceeded!"),
          );
      return true;
    } on FirebaseException catch (e) {
      print("A firebase exception has occured: $e");
      throw Failure(message: e.message);
    } on FormatException catch (e) {
      print("A FormatException has occured: $e");
      throw Failure(
          message: "could not get user profile, please try again later!");
    }
  }

  Future<String> uploadAvatarImageAndGetDownloadableUrl(
      File image, String imageName) async {
    final imageReference = _userProfileAvatarBucket.child(imageName);
    try {
      await imageReference.putFile(image);
      return imageReference.getDownloadURL();
    } on FirebaseException catch (e) {
      print("A firebase exception has occured: $e");
      throw Failure(message: e.message);
    }
  }

  Future<bool> updateAvatarImageInUserProfile(String uid, String url) async {
    try {
      await _userProfiles
          .doc(uid)
          .update({_FirestoreUserProfileKeys.avatarUrl: url});
      return true;
    } on FirebaseException catch (e) {
      print("A firebase exception has occured: $e");
      throw Failure(message: e.message);
    }
  }

  Future<void> deleteAvatarImage(String imageUrl) async {
    // TODO: check for required error handling//
    Reference photoRef = _firebaseStorage.refFromURL(imageUrl);
    await photoRef.delete();
  }
}

class _FirestoreUserProfileKeys {
  static const String avatarUrl = "avatarUrl";
}
