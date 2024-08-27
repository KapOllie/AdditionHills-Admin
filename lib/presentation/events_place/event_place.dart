import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/common/widgets/column_field_text.dart';
import 'package:barangay_adittion_hills_app/common/widgets/field_label/text_field.dart';
import 'package:barangay_adittion_hills_app/common/widgets/textfield_validator/textfield_validators.dart';
import 'package:barangay_adittion_hills_app/models/venue/event_venue.dart';
import 'package:barangay_adittion_hills_app/presentation/events_place/widgets/edit_venue_dialog.dart';
import 'package:barangay_adittion_hills_app/presentation/events_place/widgets/view_venue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/new_venue_dialog.dart';

class EventPlacePage extends StatefulWidget {
  const EventPlacePage({super.key});

  @override
  State<EventPlacePage> createState() => _EventPlacePageState();
}

class _EventPlacePageState extends State<EventPlacePage> {
  FieldLabel venueText = FieldLabel();
  final DatabaseService _databaseService = DatabaseService();
  bool isClicked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff0ebf8),
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
                  children: [venueText.headText('Event Venue')],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                    color: Colors.white,
                  ),
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
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: _databaseService.getVenues(),
                          builder: (context, snapshot) {
                            List eventVenues = snapshot.data?.docs ?? [];
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (!snapshot.hasData ||
                                snapshot.data?.docs.isEmpty == true) {
                              return const Center(
                                  child: Text('No venues available'));
                            }

                            if (eventVenues.isEmpty) {
                              return Center(
                                child: Text('Empty'),
                              );
                            }

                            return ListView.builder(
                              itemCount: eventVenues.length,
                              itemBuilder: (BuildContext context, int index) {
                                EventVenue eventVenue =
                                    eventVenues[index].data();
                                String eventVenueId =
                                    eventVenues[index].id.toString();
                                debugPrint(eventVenueId);

                                return Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 0.5,
                                        color: Color(0xffE6E6E6),
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    title: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => viewVenue(context,
                                                eventVenue, eventVenueId),
                                            child: Text(
                                              eventVenue.venueName,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                  color: Color(0xff0a0a0a),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            eventVenue.venueAddress,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: Color(0xff0a0a0a),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '0',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: Color(0xff0a0a0a),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            eventVenue.venuePrice,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: Color(0xff0a0a0a),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    editVenueDialogBox(
                                                        context,
                                                        _databaseService,
                                                        eventVenueId,
                                                        eventVenue);
                                                  },
                                                  icon: Icon(Icons
                                                      .mode_edit_outline_rounded)),
                                              IconButton(
                                                  onPressed: () {
                                                    deleteVenueDialogBox(
                                                        context,
                                                        _databaseService,
                                                        eventVenueId);
                                                  },
                                                  icon: Icon(Icons
                                                      .remove_circle_outline_rounded)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Container(
          padding: const EdgeInsets.only(right: 32, bottom: 32),
          child: FloatingActionButton(
            onPressed: () {
              newVenueDialogBox(context, _databaseService);
            },
            backgroundColor: Color(0xff6B3CEB),
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

  void deleteVenueDialogBox(
      BuildContext context, DatabaseService _databaseService, String eventId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning_rounded,
            color: Color(0xffDC143C),
            size: 48,
          ),
          title: Text(
            'Are your sure?',
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    color: Color(0xff0a0a0a), fontWeight: FontWeight.w600),
                fontSize: 20),
          ),
          content: Text(
            'Do you really want to delete this venue?\nThis process cannot be undone.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    color: Color(0xff0a0a0a), fontWeight: FontWeight.w400),
                fontSize: 12),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Abort')),
            TextButton(
                onPressed: () {
                  _databaseService.deleteVenue(eventId);
                  Navigator.pop(context);
                },
                child: const Text('Delete')),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }
}
