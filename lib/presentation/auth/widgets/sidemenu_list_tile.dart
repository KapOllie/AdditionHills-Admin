import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDrawerListTile extends StatelessWidget {
  final String listTileTitle;
  final VoidCallback onTap;
  final Color textColor;
  final double fontSize;
  final double padding;
  final Icon? tileIcon;
  final bool selected;

  const AdminDrawerListTile({
    super.key,
    required this.listTileTitle,
    required this.onTap,
    required this.textColor,
    required this.fontSize,
    required this.padding,
    this.tileIcon,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      leading: tileIcon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                tileIcon!.icon,
                color: selected ? Colors.white : Color(0xff1B2533),
              ),
            )
          : null,
      title: Text(
        listTileTitle,
        style: GoogleFonts.inter(
          textStyle: TextStyle(
            color: selected ? Colors.white : textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: padding),
      selectedTileColor: Color(0xff6B3CEB),
    );
  }
}
