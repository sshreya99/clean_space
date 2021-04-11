import 'package:clean_space/utils/extensions/string_extension.dart';

class AuthValidators {
  static String validatePassword(String value) {
    if (value.length < 6) {
      return "Password is must be at least 6 characters!";
    }
    return null;
  }

  static String validateEmail(String value) {
    if (value.isEmpty) {
      return "Email is required!";
    } else if (!value.isEmail) {
      return "Email is not valid!";
    }
    return null;
  }

  static String validateEmpty(String value, String keyName) {
    return value.isEmpty ? "$keyName is required!" : null;
  }

  static String validatePhone(String value) {
    if(value.isNotEmpty){
      if (value.length != 10) {
        return "Phone is should be exactly of 10 digits!";
      } else if (!value.isNumeric) {
        return "Phone is not valid!";
      }
    }
    return null;
  }

  static String validateConfirmPassword(String value, String otherPassword) {
    if (value.length < 6) {
      return "Password is must be atleast 6 characters!";
    } else if (value != otherPassword) {
      return "Both password must be the same!";
    }
    return null;
  }
}
