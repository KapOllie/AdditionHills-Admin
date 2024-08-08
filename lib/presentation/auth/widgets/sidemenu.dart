// ignore_for_file: prefer_const_constructors

import 'package:barangay_adittion_hills_app/presentation/auth/widgets/sidemenu_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/bloc/admin_menu_item_blocs.dart';
import '../../home/bloc/admin_menu_item_event.dart';

class AdminSidemenu extends StatelessWidget {
  const AdminSidemenu({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AdminMenuItemBlocs>(context);

    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: const Color(0xff2294F2),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                  child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Logo',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      color: Color(0xff0a0a0a),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ))),
                TextSpan(
                    text: 'Name',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    )))
              ]))),
            ),
            AdminDrawerListTile(
              listTileTitle: 'Dashboard',
              tileIcon: const Icon(
                Icons.dashboard_rounded,
              ),
              onTap: () {
                bloc.add(const NavigateToEvent(0));
              },
            ),
            AdminDrawerListTile(
              listTileTitle: 'Accounts',
              tileIcon: const Icon(
                Icons.manage_accounts_rounded,
              ),
              onTap: () {
                bloc.add(NavigateToEvent(1));
              },
            ),
            AdminDrawerListTile(
              listTileTitle: 'Documents',
              tileIcon: const Icon(
                Icons.file_open_rounded,
              ),
              onTap: () {
                bloc.add(NavigateToEvent(2));
              },
            ),
            AdminDrawerListTile(
              listTileTitle: 'Requests',
              tileIcon: const Icon(
                Icons.request_page_rounded,
                size: 24,
              ),
              onTap: () {
                // bloc.add(NavigateToEvent(3));
              },
            ),
            AdminDrawerListTile(
              listTileTitle: 'Event Equipment',
              tileIcon: const Icon(
                Icons.chair_rounded,
                size: 24,
              ),
              onTap: () {
                bloc.add(NavigateToEvent(4));
              },
            ),
            AdminDrawerListTile(
              listTileTitle: 'Event Places',
              tileIcon: const Icon(
                Icons.place_rounded,
                size: 24,
              ),
              onTap: () {
                // bloc.add(NavigateToEvent(3));
              },
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
