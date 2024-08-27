import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FieldLabel {
  Widget requiredFieldLabel(String fieldLabelText) {
    return Text.rich(TextSpan(children: [
      TextSpan(
        text: '*',
        style: GoogleFonts.inter(
          textStyle: TextStyle(color: Color(0xffDD3409), fontSize: 14),
          fontWeight: FontWeight.w600,
        ),
      ),
      TextSpan(
        text: fieldLabelText,
        style: GoogleFonts.inter(
            textStyle: TextStyle(color: Color(0xff1B2533), fontSize: 14),
            fontWeight: FontWeight.w600),
      ),
    ]));
  }

  Widget noteRequired() {
    return Text(
      'Note: All fields marked with an asterisk (*) are required',
      style: GoogleFonts.inter(
        textStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }

  Widget headText(String textTitle) {
    return Text(
      textTitle,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
          color: Color(0xff1B2533),
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
