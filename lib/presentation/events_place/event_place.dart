import 'package:barangay_adittion_hills_app/common/widgets/column_field_text.dart';
import 'package:barangay_adittion_hills_app/common/widgets/textfield_validator/textfield_validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/new_venue_dialog.dart';

final _formKey = GlobalKey<FormState>();

class EventPlacePage extends StatefulWidget {
  const EventPlacePage({super.key});

  @override
  State<EventPlacePage> createState() => _EventPlacePageState();
}

class _EventPlacePageState extends State<EventPlacePage> {
  bool isClicked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffE6E6E6),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Event Venue',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Color(0xff0a0a0a),
                              fontSize: 24,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                    color: Colors.white),
                child: const SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: ColumnFieldText(
                                  fieldText: 'Name',
                                ),
                              ),
                              Expanded(
                                child: ColumnFieldText(
                                  fieldText: 'Address',
                                ),
                              ),
                              Expanded(
                                child: ColumnFieldText(
                                  fieldText: 'Available',
                                ),
                              ),
                              Expanded(
                                child: ColumnFieldText(
                                  fieldText: 'Price',
                                ),
                              ),
                              Expanded(
                                child: ColumnFieldText(
                                  fieldText: 'Actions',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                          height: 2,
                        ),
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
        floatingActionButton: Container(
          padding: const EdgeInsets.only(right: 32, bottom: 32),
          child: FloatingActionButton(
            onPressed: () {
              newVenueDialogBox(context, _formKey);
            },
            backgroundColor: Colors.blueGrey.shade900,
            shape: const CircleBorder(),
            tooltip: 'New Venue',
            child: const Icon(
              Icons.add_rounded,
              size: 24,
              color: Colors.white,
            ),
          ),
        ));
  }
}
