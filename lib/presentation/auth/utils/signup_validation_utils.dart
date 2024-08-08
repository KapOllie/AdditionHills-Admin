// lib/utils/validation_utils.dart

import 'package:flutter/material.dart';

String? validatePassword(String? value) {
  final regex =
      RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$');
  if (value == null || value.isEmpty) {
    return 'Password is required';
  } else if (!regex.hasMatch(value)) {
    return 'Password must be at least 8 characters long and include numbers and special characters';
  }
  return null;
}

String? validateConfirmPassword(
    String? value, TextEditingController passwordController) {
  if (value == null || value.isEmpty) {
    return 'Passwords do not match';
  } else if (value != passwordController.text) {
    return 'Passwords do not match';
  }
  return null;
}

String? validateEmail(String? value) {
  final regex = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  if (value == null || value.isEmpty) {
    return 'Email is required';
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? validateBirthday(String? value) {
  if (value == null || value.isEmpty) {
    return 'Birthday is required';
  }
  final birthDate = DateTime.tryParse(value);
  if (birthDate == null) {
    return 'Enter a valid date';
  }
  final age = DateTime.now().difference(birthDate).inDays ~/ 365;
  if (age < 18) {
    return 'You must be at least 18 years old';
  }
  return null;
}

String? validateName(String? value) {
  final regex = RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$');
  if (value == null || value.isEmpty) {
    return 'Name is required';
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid name (letters and spaces only)';
  }
  return null;
}
