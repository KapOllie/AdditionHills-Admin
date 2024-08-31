import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/common/widgets/column_field_text.dart';
import 'package:barangay_adittion_hills_app/common/widgets/field_label/text_field.dart';
import 'package:barangay_adittion_hills_app/models/equipment_requests/equipment_requests.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EventEquipmentRequestsPage extends StatefulWidget {
  const EventEquipmentRequestsPage({super.key});

  @override
  State<EventEquipmentRequestsPage> createState() =>
      _EventEquipmentRequestsPageState();
}

class _EventEquipmentRequestsPageState
    extends State<EventEquipmentRequestsPage> {
  TextEditingController searchEquip = TextEditingController();
  DatabaseService _databaseService = DatabaseService();
  FieldLabel equipmentRequestText = FieldLabel();
  String _sortBy = 'All';
  String request = '';
  @override
  void initState() {
    super.initState();
    searchEquip.addListener(() {
      setState(() {
        request = searchEquip.text.toLowerCase();
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
            equipmentRequestText.headText('Event Equipment Requests'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                                  request = value;
                                },
                                controller: searchEquip,
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
                                      'Search event equipment requests by sender name',
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
                      Expanded(child: ColumnFieldText(fieldText: 'Item')),
                      Expanded(
                          child: ColumnFieldText(fieldText: 'Date Requested')),
                      Expanded(
                          child: ColumnFieldText(fieldText: 'Pickup Date')),
                      Expanded(child: ColumnFieldText(fieldText: 'Status')),
                      Expanded(child: ColumnFieldText(fieldText: 'Actions')),
                    ],
                  ),
                )),
            SizedBox(
              height: 300,
              child: StreamBuilder(
                  stream: _databaseService.getEquipmentRequests(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    List<dynamic> allEquipmentRequests =
                        snapshot.data?.docs ?? [];

                    // Filter the list based on the searchValue
                    if (searchEquip.text.isNotEmpty) {
                      allEquipmentRequests =
                          allEquipmentRequests.where((request) {
                        EquipmentRequestsModel model = request.data();
                        return model.requesterName
                            .toLowerCase()
                            .contains(searchEquip.text.toLowerCase());
                      }).toList();
                    }

                    // Sort the list based on the selected criteria
                    if (_sortBy != 'All') {
                      allEquipmentRequests.sort((a, b) {
                        EquipmentRequestsModel modelA = a.data();
                        EquipmentRequestsModel modelB = b.data();
                        return modelA.request_status
                            .compareTo(modelB.request_status);
                      });
                      if (_sortBy == 'Approved') {
                        allEquipmentRequests = allEquipmentRequests
                            .where((request) =>
                                request.data().request_status == 'Approved')
                            .toList();
                      } else if (_sortBy == 'Pending') {
                        allEquipmentRequests = allEquipmentRequests
                            .where((request) =>
                                request.data().request_status == 'Pending')
                            .toList();
                      } else if (_sortBy == 'Declined') {
                        allEquipmentRequests = allEquipmentRequests
                            .where((request) =>
                                request.data().request_status == 'Declined')
                            .toList();
                      }
                    }

                    return ListView.builder(
                        itemCount: allEquipmentRequests.length,
                        itemBuilder: (BuildContext context, int index) {
                          EquipmentRequestsModel model =
                              allEquipmentRequests[index].data();
                          String id = allEquipmentRequests[index].id;

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
                                      message: id,
                                      child: Text(
                                        id,
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
                                      model.requestEquipment.toString(),
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
                                      model.request_status,
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
                                            // viewVenueRequest(
                                            //     model, index, venueId);
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
                                                    .deleteEquipReq(id);

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
}
