import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupField extends StatefulWidget {
  const SignupField({
    this.iconButton,
    required this.controller,
    this.validator,
    this.inputDecoration,
    super.key,
    this.obscuringText,
    this.obscuredText = false,
    this.inputFormatter,
    this.hintText,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final InputDecoration? inputDecoration;
  final IconButton? iconButton;
  final String? obscuringText;
  final bool obscuredText;
  final List<TextInputFormatter>? inputFormatter;
  final String? hintText;

  @override
  State<SignupField> createState() => _SignupFieldState();
}

class _SignupFieldState extends State<SignupField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatter,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: Color(0xff818A91),
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
        ),
      ),
      controller: widget.controller,
      decoration: widget.inputDecoration?.copyWith(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            fillColor: const Color(0xffE3F2FC),
            filled: true,
            suffixIcon: widget.iconButton,
          ) ??
          InputDecoration(
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            fillColor: const Color(0xffE3F2FC),
            filled: true,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: widget.iconButton,
            ),
          ),
      validator: widget.validator,
      obscureText: widget.obscuredText,
      obscuringCharacter: widget.obscuringText ?? '•', // Default to '•' if null
    );
  }
}
