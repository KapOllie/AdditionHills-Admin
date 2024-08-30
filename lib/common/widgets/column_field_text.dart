import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColumnFieldText extends StatelessWidget {
  const ColumnFieldText({
    super.key,
    required this.fieldText,
  });
  final String fieldText;
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      fieldText,
      style: GoogleFonts.inter(
        textStyle: TextStyle(
            color: Color(0xff1B2533),
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
