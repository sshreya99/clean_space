import 'package:clean_space/app/locator.dart';
import 'package:clean_space/errors/failure.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/services/user_profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clean_space/utils/extensions/string_extension.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = locator<FirebaseAuth>();

  final UserProfileService _userProfileService = locator<UserProfileService>();

  User get currentFirebaseUser => _firebaseAuth.currentUser;

  bool get isUserLoggedIn => currentFirebaseUser != null;

  Future<UserProfile> get currentUserProfile async {
    if (!isUserLoggedIn) return null;
    return await _userProfileService.getUserProfile(currentFirebaseUser.uid);
  }

  Future<void> _deleteCurrentAuthUser() async {
    try {
      if (!isUserLoggedIn) return;
      return currentFirebaseUser.delete();
    } on FirebaseAuthException catch (e) {
      print("A firebase auth exception has occured: $e");
      throw Failure(message: _getErrorMessageFromFirebaseException(e));
    } on FirebaseException catch (e) {
      print("A firebase exception has occured: $e");
      throw Failure(message: e.message);
    }
  }

  Future<UserProfile> signInWithEmailAndPassword(
      String emailOrUsername, String password) async {
    try {
      String email = emailOrUsername;
      if(!emailOrUsername.isEmail){
        email = await _userProfileService.getEmailFromUsername(emailOrUsername);
      }
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await currentUserProfile;
    } on FirebaseAuthException catch (e) {
      print("A firebase auth exception has occured: $e");
      throw Failure(message: _getErrorMessageFromFirebaseException(e));
    } on FirebaseException catch (e) {
      print("A firebase exception has occured: $e");
      throw Failure(message: e.message);
    }
  }

  Future<UserProfile> signUpWithEmailAndPassword(
      UserProfile userProfile, password) async {
    try {
      
      final UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: userProfile.email,
        password: password,
      );
      userProfile.uid = result.user.uid;
      await _userProfileService.createUserProfile(userProfile);
      return userProfile;
    } on FirebaseAuthException catch (e) {
      print("A firebase auth exception has occured: $e");
      throw Failure(message: _getErrorMessageFromFirebaseException(e));
    } on FirebaseException catch (e) {
      print("A firebase exception has occured: $e");
      await _deleteCurrentAuthUser();
      throw Failure(message: e.message);
    } on Failure {
      rethrow;
    }
  }

  Future<bool> sendForgotPasswordEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      print("A firebase auth exception has occured: $e");
      throw Failure(message: _getErrorMessageFromFirebaseException(e));
    } on FirebaseException catch (e) {
      print("A firebase exception has occured: $e");
      throw Failure(message: e.message);
    }
  }

  Future<void> signOut() => _firebaseAuth.signOut();

  Future<void> changePassword(String newPassword) async {
    try {

      await currentFirebaseUser.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      print("A firebase auth exception has occured: $e");
      throw Failure(message: _getErrorMessageFromFirebaseException(e));
    } on FirebaseException catch (e) {
      print("A firebase exception has occured: $e");
      throw Failure(message: e.message);
    }
  }

  String _getErrorMessageFromFirebaseException(
      FirebaseAuthException exception) {
    switch (exception.code.toLowerCase()) {
      case 'email-already-in-use':
        return 'An account already exists for the email you\'re trying to use. Login instead.';
      case 'invalid-email':
        return 'The email you\'re using is invalid. Please use a valid email.';
      case 'operation-not-allowed':
        return 'The authentication is not enabled on Firebase. Please enable the Authentitcation type on Firebase';
      case 'weak-password':
        return 'Your password is too weak. Please use a stronger password.';
      case 'wrong-password':
        return 'You seemed to have entered the wrong password. Double check it and try again.';
      case 'user_not_found':
        return 'No user found, try sign up insted!';
      case 'network_request_failed':
        return 'Make sure you connected with the internet!';
      case 'requires_recent_login':
        return 'Re-login is required!';
      default:
        return exception.message ??
            'Something went wrong on our side. Please try again';
    }
  }


}
