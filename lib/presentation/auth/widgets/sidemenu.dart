// ignore_for_file: prefer_const_constructors

import 'package:barangay_adittion_hills_app/presentation/auth/widgets/sidemenu_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/bloc/admin_menu_item_blocs.dart';
import '../../home/bloc/admin_menu_item_event.dart';

class AdminSidemenu extends StatefulWidget {
  const AdminSidemenu({super.key});

  @override
  State<AdminSidemenu> createState() => _AdminSidemenuState();
}

class _AdminSidemenuState extends State<AdminSidemenu> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AdminMenuItemBlocs>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Drawer(
        elevation: 4,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DrawerHeader(
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
                          color: Colors.blue,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        )))
                  ]))),
                ),
              ),
              AdminDrawerListTile(
                fontSize: 14,
                padding: 0,
                listTileTitle: 'Profile',
                onTap: () {
                  // bloc.add(NavigateToEvent(1));
                },
                tileIcon: Icon(
                  Icons.account_circle_rounded,
                  color: Color(0xff1D1929),
                ),
              ),
              AdminDrawerListTile(
                  padding: 0,
                  fontSize: 14,
                  listTileTitle: 'Dashboard',
                  onTap: () {
                    bloc.add(const NavigateToEvent(0));
                  },
                  tileIcon: Icon(
                    Icons.space_dashboard_rounded,
                    color: Color(0xff1D1929),
                  )),
              AdminDrawerListTile(
                fontSize: 14,
                padding: 0,
                listTileTitle: 'Accounts',
                onTap: () {
                  bloc.add(NavigateToEvent(1));
                },
                tileIcon: Icon(
                  Icons.manage_accounts_rounded,
                  color: Color(0xff1D1929),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ExpansionTile(
                  maintainState: true,
                  textColor: Color(0xff1D1929),
                  collapsedTextColor: Color(0xff1D1929),
                  iconColor: Color(0xff1D1929),
                  collapsedIconColor: Color(0xff1D1929),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  backgroundColor: Color(0xfffafafa),
                  leading: Icon(Icons.build_circle_rounded),
                  title: Text(
                    'Maintenance',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      fontSize: 14,
                    )),
                  ),
                  children: [
                    AdminDrawerListTile(
                      fontSize: 12,
                      padding: 28,
                      listTileTitle: 'Documents',
                      onTap: () {
                        bloc.add(NavigateToEvent(2));
                      },
                    ),
                    AdminDrawerListTile(
                      fontSize: 12,
                      padding: 28,
                      listTileTitle: 'Event Equipment',
                      onTap: () {
                        bloc.add(NavigateToEvent(4));
                      },
                    ),
                    AdminDrawerListTile(
                      fontSize: 12,
                      padding: 28,
                      listTileTitle: 'Event Venues',
                      onTap: () {
                        // bloc.add(NavigateToEvent(3));
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ExpansionTile(
                  maintainState: true,
                  textColor: Color(0xff1D1929),
                  collapsedTextColor: Color(0xff1D1929),
                  iconColor: Color(0xff1D1929),
                  collapsedIconColor: Color(0xff1D1929),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  backgroundColor: Color(0xfffafafa),
                  leading: Icon(Icons.swap_vertical_circle_rounded),
                  title: Text(
                    'Transaction',
                    style:
                        GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14)),
                  ),
                  children: [
                    AdminDrawerListTile(
                      fontSize: 12,
                      padding: 28,
                      listTileTitle: 'Document Requests',
                      onTap: () {
                        // bloc.add(NavigateToEvent(3));
                      },
                    ),
                    AdminDrawerListTile(
                      fontSize: 12,
                      padding: 28,
                      listTileTitle: 'Venue Requests',
                      onTap: () {
                        // bloc.add(NavigateToEvent(3));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
