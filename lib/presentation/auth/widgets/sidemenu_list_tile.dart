import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDrawerListTile extends StatelessWidget {
  const AdminDrawerListTile(
      {super.key,
      required this.padding,
      required this.listTileTitle,
      required this.onTap,
      this.tileIcon,
      required this.fontSize,
      this.textColor,
      this.hoverColor});
  final String listTileTitle;
  final Icon? tileIcon;
  final Function()? onTap;
  final double padding;
  final double fontSize;
  final Color? textColor;
  final Color? hoverColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        hoverColor: hoverColor,
        title: Padding(
          padding: EdgeInsets.only(left: padding),
          child: Text(
            listTileTitle,
            style: GoogleFonts.inter(
                textStyle: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w400,
              fontSize: fontSize,
            )),
          ),
        ),
        onTap: onTap,
        leading: tileIcon,
        iconColor: Colors.white,
      ),
    );
  }
}
