import 'package:shared_preferences/shared_preferences.dart';

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
