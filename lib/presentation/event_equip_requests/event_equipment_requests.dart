import 'package:barangay_adittion_hills_app/common/widgets/column_field_text.dart';
import 'package:barangay_adittion_hills_app/common/widgets/field_label/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventEquipmentRequestsPage extends StatefulWidget {
  const EventEquipmentRequestsPage({super.key});

  @override
  State<EventEquipmentRequestsPage> createState() =>
      _EventEquipmentRequestsPageState();
}

class _EventEquipmentRequestsPageState
    extends State<EventEquipmentRequestsPage> {
  FieldLabel equipmentRequestText = FieldLabel();
  String _sortBy = 'All';
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () {
                          // addNewItem(context);
                        },
                        child: Container(
                          width: 180,
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: Center(
                            child: Text(
                              '+ New Transaction',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: Color(0xff1B2533), fontSize: 14)),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                                // controller: searchEquipment,
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
            )
          ],
        ),
      ),
    );
  }
}
