import 'package:proequine/core/utils/extensions.dart';

class Validator {
  String? password;
  static String? requiredValidator(String? value) {
    if (value == null) {
      return ''.tra;
    }

    if (value == 'null') {
      return ''.tra;
    }
    if (value.trim().isEmpty) {
      return ''.tra;
    }
    return null;
  }
  static String? validateHorseNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null; // No value entered, no error
    }

    try {
      int horsesNumber = int.parse(value);
      if (horsesNumber < 1 || horsesNumber > 20) {
        return 'Horse number must be a number between 1 and 20.';
      }
    } catch (e) {
      return 'Invalid number'; // Value cannot be parsed as an integer
    }

    return null;
  }


  static String? phoneValidator(String? value) {
    if (value != null) {
      if (value.startsWith('0')) {
        return '';
      }
      if (!RegExp(
        r'(^(?:[+0]9)?[0-9]{8,12}$)',
      ).hasMatch(value.trim())) {
        return ''.tra;
      }
      if (value.isEmpty) {
        return ''.tra;
      }
    }
    return null;
  }

  static String? countryCodeValidator(String? value) {
    if (value != null) {
      if (!RegExp(
        r'^\+(?:[0-9] ?){0,2}[0-9]$',
      ).hasMatch(value.trim())) {
        return ''.tra;
      }
      if (value.isEmpty) {
        return ''.tra;
      }
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value!.trim().isEmpty) {
      return ''.tra;
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value.trim())) {
      return ''.tra;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value != null) {
      if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
          .hasMatch(value.trim())) {
        return ''
            .tra;
      }
      if (value.isEmpty) {
        return ''.tra;
      }
    }
    return null;
  }
}
