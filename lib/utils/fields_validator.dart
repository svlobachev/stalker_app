import 'package:flutter/foundation.dart';

class FieldsValidator {
  bool validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      if (kDebugMode) {
        print("validateEmail: false");
      }
      return false;
    } else {
      if (kDebugMode) {
        print("validateEmail: true");
      }
      return true;
    }
  }

  bool validatePassword(String? value) {
    String pattern =
        r'((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#&$%]).[0-9!@#$%^&*a-zA-Z]{6,30})';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      if (kDebugMode) {
        print("validatePassword: false");
      }
      return false;
    } else {
      if (kDebugMode) {
        print("validatePassword: true");
      }
      return true;
    }
  }

  bool validateConfirmPassword(String? value, String? value1) {
    if (value! != value1!) {
      if (kDebugMode) {
        print("validateConfirmPassword: false");
      }
      return false;
    } else {
      if (kDebugMode) {
        print("validateConfirmPassword: true");
      }
      return true;
    }
  }

  bool validateName(String? value) {
    String pattern = r'^[a-zA-Z0-9_.]{1,30}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      if (kDebugMode) {
        print("validateName: false");
      }
      return false;
    } else {
      if (kDebugMode) {
        print("validateName: true");
      }
      return true;
    }
  }
}
