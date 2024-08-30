// ignore_for_file: prefer_const_constructors

import 'package:barangay_adittion_hills_app/presentation/auth/widgets/sidemenu_list_tile.dart';
import 'package:barangay_adittion_hills_app/presentation/home/bloc/admin_menu_item_state.dart';
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

    return BlocBuilder<AdminMenuItemBlocs, AdminMenuItemState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Drawer(
            elevation: 4,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: DrawerHeader(
                      child: Center(
                          child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Requ',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              color: Color(0xff1B2533),
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                            ))),
                        TextSpan(
                            text: '/Ease',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              color: Color(0xff8963EF),
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                            )))
                      ]))),
                    ),
                  ),
                  AdminDrawerListTile(
                      textColor: Color(0xff1B2533),
                      padding: 0,
                      fontSize: 14,
                      listTileTitle: 'Dashboard',
                      selected: state.index == 0,
                      onTap: () {
                        bloc.add(const NavigateToEvent(0));
                      },
                      tileIcon: Icon(
                        Icons.space_dashboard_rounded,
                        color: Color(0xff1B2533),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          'Maintenance',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Container(
                          height: 1,
                          color: Colors.grey,
                        ))
                      ],
                    ),
                  ),
                  AdminDrawerListTile(
                    textColor: Color(0xff1B2533),
                    fontSize: 14,
                    padding: 28,
                    listTileTitle: 'Documents',
                    selected: state.index == 1,
                    onTap: () {
                      bloc.add(NavigateToEvent(1));
                    },
                  ),
                  AdminDrawerListTile(
                    textColor: Color(0xff1B2533),
                    fontSize: 14,
                    padding: 28,
                    listTileTitle: 'Event Equipment',
                    selected: state.index == 2,
                    onTap: () {
                      bloc.add(NavigateToEvent(2));
                    },
                  ),
                  AdminDrawerListTile(
                    textColor: Color(0xff1B2533),
                    fontSize: 14,
                    padding: 28,
                    listTileTitle: 'Event Venues',
                    selected: state.index == 3,
                    onTap: () {
                      bloc.add(NavigateToEvent(3));
                    },
                  ),
                  AdminDrawerListTile(
                    textColor: Color(0xff1B2533),
                    fontSize: 14,
                    padding: 28,
                    listTileTitle: 'Announcements',
                    selected: state.index == 4,
                    onTap: () {
                      bloc.add(NavigateToEvent(4));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Text(
                          'Transaction',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Container(
                          height: 1,
                          color: Colors.grey,
                        ))
                      ],
                    ),
                  ),
                  AdminDrawerListTile(
                    textColor: Color(0xff1B2533),
                    fontSize: 14,
                    padding: 28,
                    listTileTitle: 'Document Requests',
                    selected: state.index == 5,
                    onTap: () {
                      bloc.add(NavigateToEvent(5));
                    },
                  ),
                  AdminDrawerListTile(
                    textColor: Color(0xff1B2533),
                    fontSize: 14,
                    padding: 28,
                    listTileTitle: 'Venue Requests',
                    selected: state.index == 6,
                    onTap: () {
                      bloc.add(NavigateToEvent(6));
                    },
                  ),
                  AdminDrawerListTile(
                    textColor: Color(0xff1B2533),
                    fontSize: 14,
                    padding: 28,
                    listTileTitle: 'Event Equipment Requests',
                    selected: state.index == 7,
                    onTap: () {
                      bloc.add(NavigateToEvent(7));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Text(
                          'Account',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Container(
                          height: 1,
                          color: Colors.grey,
                        ))
                      ],
                    ),
                  ),
                  AdminDrawerListTile(
                    textColor: Color(0xff1B2533),
                    fontSize: 14,
                    padding: 0,
                    listTileTitle: 'My Profile',
                    selected: state.index == 8,
                    onTap: () {
                      bloc.add(NavigateToEvent(8));
                    },
                    tileIcon: Icon(
                      Icons.account_circle_rounded,
                      color: Color(0xff1B2533),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
