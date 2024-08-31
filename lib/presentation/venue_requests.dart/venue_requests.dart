import 'dart:convert';

import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/common/widgets/column_field_text.dart';
import 'package:barangay_adittion_hills_app/common/widgets/field_label/text_field.dart';
import 'package:barangay_adittion_hills_app/models/venue_requests/venue_requests_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class VenueRequestsPage extends StatefulWidget {
  const VenueRequestsPage({super.key});

  @override
  State<VenueRequestsPage> createState() => _VenueRequestsPageState();
}

class _VenueRequestsPageState extends State<VenueRequestsPage> {
  FieldLabel venueRequestText = FieldLabel();
  DatabaseService _databaseService = DatabaseService();
  String _sortBy = 'All'; // Default sorting criteria
  TextEditingController searchValue = TextEditingController();
  String request = '';
  @override
  void initState() {
    super.initState();
    searchValue.addListener(() {
      setState(() {
        request = searchValue.text.toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0ebf8),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16.0),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            venueRequestText.headText('Venue Requests'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: InkWell(
                    //     onTap: () {
                    //       // addNewItem(context);
                    //     },
                    //     child: Container(
                    //       width: 180,
                    //       padding: EdgeInsets.symmetric(horizontal: 8.0),
                    //       decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.grey.shade300),
                    //         borderRadius: BorderRadius.all(Radius.circular(4)),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           '+ New Venue Request',
                    //           style: GoogleFonts.inter(
                    //               textStyle: TextStyle(
                    //                   color: Color(0xff1B2533), fontSize: 14)),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      width: 400,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          left: BorderSide(color: Color(0xffdadce0)),
                          top: BorderSide(color: Color(0xffdadce0)),
                          bottom: BorderSide(color: Color(0xffdadce0)),
                          right: BorderSide(color: Color(0xffdadce0)),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: TextField(
                                onChanged: (value) {
                                  print(value);
                                },
                                controller: searchValue,
                                style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                    color: Color(0xff202124),
                                    fontSize: 14,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText:
                                      'Search event venue requests by sender name',
                                  hintStyle: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                      color: Color(0xff202124),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                cursorColor: const Color(0xff202124),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(color: Color(0xffdadce0)),
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.search_rounded),
                              onPressed: () {
                                debugPrint('Search tapped');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(4), // Rounded corners
                            border: Border.all(
                                color: Colors.grey.shade300), // Border color
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12), // Adjust padding as needed
                          child: DropdownButtonHideUnderline(
                            // Hides the default underline
                            child: DropdownButton<String>(
                              value: _sortBy,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _sortBy = newValue!;
                                });
                              },
                              items: <String>[
                                'All',
                                'Approved',
                                'Pending',
                                'Declined'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                      left: BorderSide(color: Color(0xffdadce0), width: 1),
                      right: BorderSide(color: Color(0xffdadce0), width: 1),
                      bottom: BorderSide(color: Color(0xffdadce0), width: 1),
                      top: BorderSide(color: Color(0xffdadce0), width: 1)),
                  borderRadius: BorderRadius.zero,
                  color: Colors.white,
                ),
                child: const ListTile(
                  title: Row(
                    children: [
                      Expanded(child: ColumnFieldText(fieldText: 'Request ID')),
                      Expanded(child: ColumnFieldText(fieldText: 'Sender')),
                      Expanded(child: ColumnFieldText(fieldText: 'Venue Name')),
                      Expanded(
                          child: ColumnFieldText(fieldText: 'Date Requested')),
                      Expanded(
                          child: ColumnFieldText(fieldText: 'Selected Date')),
                      Expanded(child: ColumnFieldText(fieldText: 'Status')),
                      Expanded(child: ColumnFieldText(fieldText: 'Actions')),
                    ],
                  ),
                )),
            SizedBox(
              height: 300,
              child: StreamBuilder(
                  stream: _databaseService.fetchVenueRequests(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    List allVenueRequests = snapshot.data?.docs ?? [];

                    // Filter the list based on the searchValue
                    if (searchValue.text.isNotEmpty) {
                      allVenueRequests = allVenueRequests.where((request) {
                        VenueRequestsModel model = request.data();
                        return model.requesterName
                                .toLowerCase()
                                .contains(searchValue.text.toLowerCase()) ||
                            model.venueName
                                .toLowerCase()
                                .contains(searchValue.text.toLowerCase());
                      }).toList();
                    }

                    // Sort the list based on the selected criteria
                    if (_sortBy != 'All') {
                      allVenueRequests.sort((a, b) {
                        VenueRequestsModel modelA = a.data();
                        VenueRequestsModel modelB = b.data();
                        return modelA.requestStatus
                            .compareTo(modelB.requestStatus);
                      });
                      if (_sortBy == 'Approved') {
                        allVenueRequests = allVenueRequests
                            .where((request) =>
                                request.data().requestStatus == 'Approved')
                            .toList();
                      } else if (_sortBy == 'Pending') {
                        allVenueRequests = allVenueRequests
                            .where((request) =>
                                request.data().requestStatus == 'Pending')
                            .toList();
                      } else if (_sortBy == 'Declined') {
                        allVenueRequests = allVenueRequests
                            .where((request) =>
                                request.data().requestStatus == 'Declined')
                            .toList();
                      }
                    }

                    return ListView.builder(
                        itemCount: allVenueRequests.length,
                        itemBuilder: (BuildContext context, int index) {
                          VenueRequestsModel model =
                              allVenueRequests[index].data();
                          String venueId = allVenueRequests[index].id;

                          return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xffE6E6E6)),
                              ),
                            ),
                            child: ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Tooltip(
                                      message: venueId,
                                      child: Text(
                                        venueId,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                              color: Color(0xff1B2533),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      model.requesterName,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            color: Color(0xff1B2533),
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      model.venueName,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            color: Color(0xff1B2533),
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Tooltip(
                                      message: DateFormat(
                                              'yyyy-MM-dd \'at\' hh:mm a')
                                          .format(model.requestDate.toDate()),
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        DateFormat('yyyy-MM-dd \'at\' hh:mm a')
                                            .format(model.requestDate.toDate()),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                              color: Color(0xff1B2533),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      model.requestSelectedDate,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            color: Color(0xff1B2533),
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      model.requestStatus,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            color: Color(0xff1B2533),
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            viewVenueRequest(
                                                model, index, venueId);
                                          },
                                          tooltip: 'View',
                                          icon: Icon(
                                            Icons.open_in_new_rounded,
                                            color: Colors.yellow,
                                          )),
                                      IconButton(
                                        tooltip: 'Delete',
                                        onPressed: () async {
                                          // Show the confirmation dialog
                                          bool confirmDeletion =
                                              await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Confirm Deletion'),
                                                content: Text(
                                                    'Are you sure you want to permanently delete this request?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      // Close the dialog and return false (abort deletion)
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text('Abort'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      // Close the dialog and return true (confirm deletion)
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );

                                          // If the user confirmed deletion, proceed with the deletion process
                                          if (confirmDeletion == true) {
                                            bool success =
                                                await _databaseService
                                                    .deleteVenueRequest(
                                                        venueId);

                                            if (success) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Request deleted successfully!'),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Failed to delete request.'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        icon: Icon(
                                          Icons.delete_rounded,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }

  void viewVenueRequest(VenueRequestsModel model, int index, String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.center,
            child: Material(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                height: MediaQuery.of(context).size.height - 100,
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close_sharp)),
                    ),
                    Center(
                      child: Text(
                        'Venue Request',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 28,
                              color: Color(0xff1B2533),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Request ID: $id',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        color: Color(0xff1B2533),
                        fontSize: 12,
                      )),
                    ),
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ))),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      'Venue: ${model.venueName}',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        color: Color(0xff1B2533),
                        fontSize: 16,
                      )),
                    ),
                    Text(
                      'Requested by: ${model.requesterName}',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        color: Color(0xff1B2533),
                        fontSize: 16,
                      )),
                    ),
                    Text(
                      'Purpose: ${model.requestPurpose}',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        color: Color(0xff1B2533),
                        fontSize: 16,
                      )),
                    ),
                    Text(
                      'Phone: ${model.requesterContact}',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        color: Color(0xff1B2533),
                        fontSize: 16,
                      )),
                    ),
                    Text(
                      'Email: ${model.requesterEmail}',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        color: Color(0xff1B2533),
                        fontSize: 16,
                      )),
                    ),
                    Text(
                      'Date Requested: ${DateFormat('yyyy-MM-dd \'at\' \nhh:mm a').format(model.requestDate.toDate())}',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        color: Color(0xff1B2533),
                        fontSize: 16,
                      )),
                    ),
                    Text(
                      'Selected Date: ${model.requestSelectedDate}',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        color: Color(0xff1B2533),
                        fontSize: 16,
                      )),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      'Status: ${model.requestStatus}',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        color: Color(0xff1B2533),
                        fontSize: 16,
                      )),
                    ),
                    if (model.requestStatus == 'Pending')
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final updatedStatus =
                                      model.copyWith(requestStatus: "Declined");

                                  bool success = await _databaseService
                                      .updateVenueRequest(id, updatedStatus);

                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Request $id successfully declined!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Failed to update request status.'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }

                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 40,
                                  width: 150,
                                  decoration:
                                      BoxDecoration(color: Color(0XFFDD3409)),
                                  child: Center(
                                    child: Text(
                                      'Decline',
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  final updatedStatus =
                                      model.copyWith(requestStatus: "Approved");
                                  _databaseService.updateVenueRequest(
                                      id, updatedStatus);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 40,
                                  width: 150,
                                  decoration:
                                      BoxDecoration(color: Color(0xff189877)),
                                  child: Center(
                                    child: Text(
                                      'Approve',
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
