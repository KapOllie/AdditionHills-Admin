import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget headText(String textTitle) {
  return Text(
    textTitle,
    style: GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Color(0xff0a0a0a),
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
