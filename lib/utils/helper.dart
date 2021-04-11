import 'dart:io';

import 'package:clean_space/models/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
const String _isFirstTimeUserKey = "isFirstTimeUser";
Future<bool> isFirstTimeUser() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  return sharedPreferences.getBool(_isFirstTimeUserKey) ?? true;
}

Future<bool> markAsNotFirstTimeUser() async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();

  return sharedPreferences.setBool(_isFirstTimeUserKey, false);
}

String genImageName(File image, {UserProfile currentUser}) {
  String imageName = "";
  if(currentUser?.uid != null){
    imageName += currentUser.uid + ".";
  }

  imageName += Uuid().v4() + ".";
  imageName += path.basename(image.path).split(".").last;
  return imageName;
}