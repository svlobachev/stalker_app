class FieldsValidator {
  bool validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return false;
    } else {
      return true;
    }
  }

  bool validatePassword(String? value) {
    // (?=.*[0-9]) - строка содержит хотя бы одно число;
    // (?=.*[!@#$%^&*]) - строка содержит хотя бы один спецсимвол;
    // (?=.*[a-z]) - строка содержит хотя бы одну латинскую букву в нижнем регистре;
    // (?=.*[A-Z]) - строка содержит хотя бы одну латинскую букву в верхнем регистре;
    // [0-9a-zA-Z!@#$%^&*]{6,} - строка состоит не менее, чем из 6 вышеупомянутых символов.
    String pattern =
        r'((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).[0-9!@#$%^&*a-zA-Z]{6,30})';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return false;
    } else {
      return true;
    }
  }
}
