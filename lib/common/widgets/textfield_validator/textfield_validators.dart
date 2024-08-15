import 'package:flutter/services.dart';

List<TextInputFormatter> onlyUnsignedNumbers(int length) {
  // Formatter to disallow leading zeroes unless it's a single '0'
  final disallowZero = FilteringTextInputFormatter.deny(
    RegExp(r'^0[0-9]'),
  );

  // Formatter to restrict input to numbers and decimal point
  final numberFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'^\d*\.?\d*$'),
  );

  return [
    numberFormatter,
    TextInputFormatter.withFunction(
        (TextEditingValue oldValue, TextEditingValue newValue) {
      final newValueText = newValue.text;

      // Disallow leading zeros unless it's just "0"
      if (newValueText.length > 1 &&
          newValueText.startsWith('0') &&
          !newValueText.startsWith('0.')) {
        newValue = disallowZero.formatEditUpdate(oldValue, newValue);
        if (newValue.text.isEmpty) {
          return oldValue;
        }
      }

      // Check if the input is valid with a decimal point
      if (newValueText.contains('.') && newValueText.split('.').length > 2) {
        return oldValue; // Invalid input if there are more than one decimal point
      }

      // Restrict input length to the specified length, considering the decimal point
      if (newValueText.length > length && !newValueText.contains('.')) {
        return oldValue; // Exceeds the allowed length
      }

      // Return the new value if it's valid
      return newValue;
    }),
  ];
}
