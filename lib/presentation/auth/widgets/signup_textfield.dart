import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupTextField extends StatefulWidget {
  const SignupTextField({
    super.key,
    this.helperText,
    this.suffixIcon,
    required this.isNotPasswordField,
    this.inputFormatter,
    this.validator,
    this.prefixText,
    required this.controller,
  });
  final String? helperText;
  final Icon? suffixIcon;
  final bool isNotPasswordField;
  final List<TextInputFormatter>? inputFormatter;
  final String? Function(String?)? validator;
  final String? prefixText;
  final TextEditingController controller;

  @override
  State<SignupTextField> createState() => _SignupTextFieldState();
}

class _SignupTextFieldState extends State<SignupTextField> {
  bool isObscure = true; // Initially obscure for password fields

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscuringCharacter: '*',
      textAlign: TextAlign.left,
      inputFormatters: widget.inputFormatter,
      obscureText: widget.isNotPasswordField ? false : isObscure,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color(0xff1B2533),
        ),
      ),
      decoration: InputDecoration(
        prefixText: widget.prefixText,
        suffixIcon: widget.isNotPasswordField
            ? null
            : IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure; // Toggle password visibility
                  });
                },
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Color(0XFF8E99AA),
                ),
              ),
        helperText: widget.helperText,
        helperStyle: GoogleFonts.inter(
          textStyle: TextStyle(
            fontSize: 10,
            color: Color(0XFF8E99AA),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Color(0XFF8E99AA), width: 1),
        ),
        hoverColor: Colors.transparent,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Color(0XFF8E99AA), width: 1.75),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Color(0xffE45D3A), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Color(0XFF8E99AA), width: 1.75),
        ),
      ),
      validator: widget.validator,
    );
  }
}
