import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    // Remove all non-numeric characters
    newText = newText.replaceAll(RegExp(r'[^0-9]'), '');

    // Format the input as YYYY/MM/DD
    if (newText.length >= 5) {
      newText = newText.substring(0, 4) + '/' + newText.substring(4);
    }
    if (newText.length >= 8) {
      newText = newText.substring(0, 7) + '/' + newText.substring(7);
    }

    // Limit input to YYYY/MM/DD format (10 characters)
    if (newText.length > 10) {
      newText = newText.substring(0, 10);
    }

    // Validate the month and day parts
    if (newText.length >= 7) {
      String month = newText.substring(5, 7);
      int monthInt = int.tryParse(month) ?? 0;

      // Ensure month is between 01 and 12
      if (monthInt < 1 || monthInt > 12) {
        newText = oldValue.text;
      }
    }

    if (newText.length == 10) {
      String day = newText.substring(8, 10);
      int dayInt = int.tryParse(day) ?? 0;

      // Ensure day is between 01 and 31
      if (dayInt < 1 || dayInt > 31) {
        newText = oldValue.text;
      }
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class AddressInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    // Count the number of slashes
    int slashCount = newText.split('/').length - 1;

    // Allow at most 4 slashes (Street/Barangay/City/Province/Country)
    if (slashCount > 4) {
      return oldValue;
    }

    // Ensure that there are no consecutive slashes
    if (newText.contains("//")) {
      return oldValue;
    }

    // Ensure no empty parts (e.g., Street//City/Province/Country)
    List<String> parts = newText.split('/');
    for (String part in parts) {
      if (part.isEmpty && parts.length > 1) {
        return oldValue;
      }
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
