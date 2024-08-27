import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPageV2 extends StatefulWidget {
  const SignupPageV2({super.key});

  @override
  State<SignupPageV2> createState() => _SignupPageV2State();
}

class _SignupPageV2State extends State<SignupPageV2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Form(
                      child: Column(
                    children: [
                      heading1('Heading 1'),
                      heading2('Heading 2'),
                      heading3('Heading 3'),
                      CustomButton(
                        height: 100,
                        width: 500,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      )
                    ],
                  )),
                )),
          ),
          Expanded(
              child: Container(
            color: Colors.red,
          ))
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double width;
  const CustomButton({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: backgroundColor),
    );
  }
}

Widget heading1(String text) {
  return Text(text,
      style: GoogleFonts.inter(
        fontSize: 36,
        color: Color(0xff1B2533),
        fontWeight: FontWeight.w700,
      ));
}

Widget heading2(String text) {
  return Text(text,
      style: GoogleFonts.inter(
        fontSize: 24,
        color: Color(0xff1B2533),
        fontWeight: FontWeight.w600,
      ));
}

Widget heading3(String text) {
  return Text(text,
      style: GoogleFonts.inter(
        fontSize: 16,
        color: Color(0xff1B2533),
        fontWeight: FontWeight.w500,
      ));
}
