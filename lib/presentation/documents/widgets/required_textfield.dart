import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RequiredTextField extends StatefulWidget {
  const RequiredTextField({
    super.key,
    required this.textController,
    this.inputFormatter,
    this.inputValidator,
    this.textInputType,
    this.maxLines,
    required this.isRequired,
    this.hintText,
    this.helperText,
    this.prefixText,
  });

  final TextEditingController textController;
  final List<TextInputFormatter>? inputFormatter;
  final String? Function(String?)? inputValidator;
  final TextInputType? textInputType;
  final int? maxLines;
  final bool isRequired;
  final String? hintText;
  final String? helperText;
  final String? prefixText;

  @override
  State<RequiredTextField> createState() => _RequiredTextFieldState();
}

class _RequiredTextFieldState extends State<RequiredTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.justify,
      readOnly: !widget.isRequired ? true : false,
      maxLines: widget.maxLines,
      keyboardType: widget.textInputType,
      controller: widget.textController,
      validator: widget.inputValidator,
      inputFormatters: widget.inputFormatter,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color(0xff1B2533),
        ),
      ),
      decoration: InputDecoration(
          prefixText: widget.prefixText,
          prefixStyle: GoogleFonts.inter(
              textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          )),
          helperText: widget.helperText,
          helperStyle: GoogleFonts.inter(
              textStyle: TextStyle(fontSize: 10, color: Color(0XFF8E99AA))),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Color(0xff1B2533),
            ),
          ),
          fillColor: Colors.white,
          filled: false,
          errorStyle: GoogleFonts.inter(
              textStyle: TextStyle(
            color: Color(0xffE45D3A),
          )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Color(0XFF8E99AA), width: 1)),
          hoverColor: Colors.transparent,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Color(0xffE45D3A), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Color(0XFF8E99AA), width: 1.75))),
    );
  }
}
