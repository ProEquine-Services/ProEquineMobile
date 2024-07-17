import 'package:flutter/cupertino.dart';

bool validateHorses(List<TextEditingController> controllers) {
  for (var controller in controllers) {
    if (controller.text.trim() == 'Select a horse') {
      return false; // Validation failed
    }
  }
  return true; // Validation passed
}

bool isListNotEmpty(List<String> genders) {
  return genders.every((item) =>
  item.isNotEmpty);
}