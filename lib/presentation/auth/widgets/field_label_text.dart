import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelField extends StatelessWidget {
  const LabelField({
    required this.labelText,
    super.key,
  });

  final String labelText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 4),
      child: Text(
        labelText,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Color(0xff2294F2),
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
