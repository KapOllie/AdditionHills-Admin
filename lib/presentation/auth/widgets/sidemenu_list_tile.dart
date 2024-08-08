import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDrawerListTile extends StatelessWidget {
  const AdminDrawerListTile({
    super.key,
    required this.listTileTitle,
    required this.tileIcon,
    required this.onTap,
  });
  final String listTileTitle;
  final Icon tileIcon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        listTileTitle,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        )),
      ),
      onTap: onTap,
      leading: tileIcon,
      iconColor: Colors.white,
    );
  }
}
