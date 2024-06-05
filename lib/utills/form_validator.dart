class Validator {
  static String? validateField({required String value, String? fieldName}) {
    if (value.isEmpty) {
      return '${fieldName ?? 'Field'} can\'t be empty';
    }

    return null;
  }

  static String? validatePhone({required String phoneNum}) {
    String phone = phoneNum.replaceAll("+977 ", "");

    if (phone.isEmpty) {
      return 'Phone Number can\'t be empty';
    }
    RegExp regMobleExp = RegExp(r'^\d{10}');

    if (!regMobleExp.hasMatch(phone)) {
      return "Please input valid Mobile Number";
    }

    return null;
  }

  static String? validateEmail({required String email}) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String password}) {
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = password.contains(RegExp(r'[a-z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacter =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    final hasMinLength = password.length >= 8;
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (!hasMinLength) {
      return 'Enter a password with length at least 8';
    } else if (!hasUpperCase) {
      return 'Password must contain at least a uppercase';
    } else if (!hasLowerCase) {
      return 'Password must contain at least a lowercase';
    } else if (!hasNumber) {
      return 'Password must contain at least a number';
    } else if (!hasSpecialCharacter) {
      return 'Password must contain at least a Special Character';
    }

    return null;
  }

  bool isValidPassword(String password) {
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = password.contains(RegExp(r'[a-z]'));
    final hasSpecialCharacter =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    final hasMinLength = password.length >= 8;

    return hasUpperCase && hasLowerCase && hasSpecialCharacter && hasMinLength;
  }

  static String? confirmPassword(
      {required String password, required String confirmpassword}) {
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password != confirmpassword) {
      return 'Confirm password not matched!';
    }

    return null;
  }
}
