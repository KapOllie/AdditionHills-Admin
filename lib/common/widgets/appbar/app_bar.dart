// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text.rich(TextSpan(children: [
          TextSpan(
              text: 'Logo',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Color(0xff0a0a0a),
                      fontSize: 20,
                      fontWeight: FontWeight.w500))),
          TextSpan(
              text: 'Name',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Color(0xff2294F2),
                      fontSize: 20,
                      fontWeight: FontWeight.w500)))
        ])));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
