class Validation {
  final int minLength;
  final int maxLength;
  final bool allowSpecialChar;
  final bool allowEmpty;
  final String? value;
  final String validationType;
  Validation(
      {required this.value,
      required this.validationType,
      required this.minLength,
      required this.maxLength,
      this.allowSpecialChar = false,
      this.allowEmpty = false});
  String? length() {
    if (value!.length > maxLength) {
      return "$validationType field cannot have more than $maxLength characters";
    }
    if (value!.length < minLength) {
      return "$validationType field cannot have less than $minLength characters";
    }
    return null;
  }

  String? empty() {
    if (value!.isEmpty) {
      return "$validationType field cannot be empty";
    }
    return null;
  }

  String? specialCharacters() {
    RegExp regex = RegExp(r'^[a-zA-Z0-9_ ]+$');
    if (!regex.hasMatch(value.toString())) {
      return '$validationType field should not have special characters';
    }
    return null;
  }
}

class EmailValidation extends Validation {
  EmailValidation({
    required super.value,
    required super.validationType,
    required super.minLength,
    required super.maxLength,
  });

  String? domainValidation() {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    if (!emailRegex.hasMatch(value!)) {
      return "Please Enter a Valid $validationType";
    }
    var domainSplit = value?.split("@");
    if (domainSplit![1] != "iic.edu.np") {
      return "Domain of iic.edu.np is only supported";
    }
    return null;
  }
}

class PasswordValidation extends Validation {
  String? password2;
  PasswordValidation(
      {required super.value,
      required super.validationType,
      required super.minLength,
      required super.maxLength,
      this.password2});

  String? passwordSecurity() {
    RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');
    String valueStr = value.toString();
    bool hasUppercase = false;
    for (int i = 0; i < valueStr.length; i++) {
      if (valueStr[i] == valueStr[i].toUpperCase()) {
        hasUppercase = true;
        break;
      }
    }
    if (!hasUppercase) {
      return "Add one Capital Character to Increase Security";
    } else if (regex.hasMatch(valueStr)) {
      return "Add Special Characters to Increase Security";
    } else {
      return null;
    }
  }

  String? reEnterPass(String pass) {
    if (pass != value) {
      return "$validationType field donot match";
    }
    return null;
  }
}

class NameValidation extends Validation {
  NameValidation(
      {required super.value,
      required super.validationType,
      required super.minLength,
      required super.maxLength});
  fullNameValidation() {
    String validationName = value!.trim();
    for (var element in validationName.runes) {
      String checkNumber = String.fromCharCode(element);
      if (double.tryParse(checkNumber) != null) {
        return "$validationType Field cannot have numbers";
      }
    }
    var nameGet = validationName.split(" ");
    if (nameGet.length < 2) {
      return "$validationType Field Should Contain Full Name";
    } else if (nameGet.length > 2) {
      return "$validationType Field Should Only Have Forename and Surname";
    } else if (nameGet[0].toString().length < 3) {
      return "ForeName Should have atleast 3 characters";
    } else if (nameGet[1].toString().length < 2) {
      return "Surname should have atleast 2 characters";
    }
    return null;
  }
}
