import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  Future<List<Map<String, dynamic>>> fetchApprovedRequests(
      int year, int month) async {
    print(month.toString());
    print(year.toString());

    final startDate = DateTime(year, month + 1, 1);
    final endDate = DateTime(year, month + 2, 1);

    print(startDate.toString());
    print(endDate.toString());
    final querySnapshot = await FirebaseFirestore.instance
        .collection('document_requests')
        .where('request_status', isEqualTo: 'Approved')
        .where('pickup_date', isGreaterThanOrEqualTo: startDate)
        .where('pickup_date', isLessThan: endDate)
        .get();
    print(querySnapshot.docs.map((doc) => doc.data()).toList());
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      data['pickup_date'] = DateFormat('MMMM dd, yyyy')
          .format((data['pickup_date'] as Timestamp).toDate());

      data['date_requested'] = DateFormat('MMMM dd, yyyy')
          .format((data['date_requested'] as Timestamp).toDate());

      return data;
    }).toList();
  }

  Future<pw.Document> generatePdf(List<Map<String, dynamic>> requests) async {
    final pdf = pw.Document();

    final totalFee = requests.fold(
        0.0, (sum, request) => sum + (request['fee'] as num).toDouble());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Addition Hills',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  )),
              pw.Text('Mandaluyong City',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.normal,
                  )),
              // Header Section
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border(
                      bottom: pw.BorderSide()), // Adds a bottom border
                ),
                padding: pw.EdgeInsets.only(bottom: 10),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    // Assuming you have a logo to add here
                    // pw.Image(pw.MemoryImage(
                    //     logoBytes)), // Replace `logoBytes` with your actual logo bytes
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Monthly Collection',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.normal,
                            )),
                        pw.Text('${selectedMonth + 1}/$selectedYear',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.normal,
                            )),
                      ],
                    ),
                    pw.Text('Date: ${DateTime.now().toString()}',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.normal,
                        )),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(), // Adds borders to the table
                children: [
                  // Table Header
                  pw.TableRow(
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(), // Adds borders to the row
                    ),
                    children: [
                      pw.Container(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text('Date Requested'),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text('Requester Name'),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text('Pickup Date'),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text('Document Title'),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text('Fee'),
                      ),
                    ],
                  ),
                  // Table Rows
                  ...requests.map((request) {
                    return pw.TableRow(
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(), // Adds borders to the row
                      ),
                      children: [
                        pw.Container(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text(request['date_requested']),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text(request['requester_name']),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text(request['pickup_date']),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text(request['document_title']),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.all(4),
                          child:
                              pw.Text('${request['fee'].toStringAsFixed(2)}'),
                        ),
                      ],
                    );
                  }).toList(),
                  // Total Fee Footer
                  pw.TableRow(
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(), // Adds borders to the row
                    ),
                    children: [
                      pw.Container(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text(''),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text(''),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text(''),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text('Total Fee Collected:'),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text('${totalFee.toStringAsFixed(2)}'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  String _selectedValuePDF = 'Document';
  String _selectedValue = 'Document';
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  int selectedMonth = 0;
  int selectedYear = 2022;
  Future<Map<String, int>> fetchRequestCounts(String collectionName) async {
    final pendingSnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .where('request_status', whereIn: ['pending', 'Pending']).get();

    final approvedSnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .where('request_status', whereIn: ['approved', 'Approved']).get();

    final deniedSnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .where('request_status',
            whereIn: ['denied', 'Declined', 'Denied']).get();

    return {
      'pending': pendingSnapshot.docs.length,
      'approved': approvedSnapshot.docs.length,
      'denied': deniedSnapshot.docs.length,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0ebf8),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 1.0, color: Colors.grey[300]!),
                      ),
                    ),
                    height: 600,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.swap_vert_circle_sharp),
                            Text(
                              'Requests',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                width: 200,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValue = newValue!;
                                    });
                                  },
                                  value: _selectedValue,
                                  items: <String>[
                                    'Document',
                                    'Venue',
                                    'Equipment'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: GoogleFonts.inter(
                                            textStyle: TextStyle(fontSize: 14)),
                                      ),
                                    );
                                  }).toList(),
                                  dropdownColor: Colors.white,
                                  elevation: 4,
                                  isDense: true,
                                  iconSize: 30.0,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        FutureBuilder<Map<String, int>>(
                          future:
                              fetchRequestCounts(_selectedValue == 'Document'
                                  ? 'document_requests'
                                  : _selectedValue == 'Venue'
                                      ? 'venue_requests'
                                      : 'equipment_requests'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: SizedBox(
                                  height: 150,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  width: 1.5,
                                                  color: Colors.grey[300]!)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1.5,
                                                  color: Colors.grey[300]!)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1.5,
                                                  color: Colors.grey[300]!)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final counts = snapshot.data!;
                              return SizedBox(
                                height: 150,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.5,
                                                color: Colors.grey[300]!)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              counts['pending'].toString(),
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      fontSize: 36,
                                                      color:
                                                          Color(0xffFFC550))),
                                            ),
                                            Text(
                                              'Pending',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Color(0xffFFC550))),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.5,
                                                color: Colors.grey[300]!)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              counts['approved'].toString(),
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      fontSize: 36,
                                                      color:
                                                          Color(0xff189877))),
                                            ),
                                            Text(
                                              'Approved',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Color(0xff189877))),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.5,
                                                color: Colors.grey[300]!)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              counts['denied'].toString(),
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      fontSize: 36,
                                                      color:
                                                          Color(0XFFDD3409))),
                                            ),
                                            Text(
                                              'Denied',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Color(0XFFDD3409))),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            Icon(Icons.file_download),
                            Text(
                              'Generate Reports',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400)),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                width: 200,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValuePDF = newValue!;
                                    });
                                  },
                                  value: _selectedValuePDF,
                                  items: <String>[
                                    'Document',
                                    'Venue',
                                    'Equipment'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: GoogleFonts.inter(
                                            textStyle: TextStyle(fontSize: 14)),
                                      ),
                                    );
                                  }).toList(),
                                  dropdownColor: Colors.white,
                                  elevation: 4,
                                  isDense: true,
                                  iconSize: 30.0,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Month: '),
                            DropdownButton<int>(
                              value: selectedMonth,
                              onChanged: (int? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedMonth = newValue;
                                  });
                                }
                              },
                              items: List.generate(months.length, (index) {
                                return DropdownMenuItem<int>(
                                  value: index,
                                  child: Text(months[index]),
                                );
                              }),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Year: '),
                            DropdownButton<int>(
                              value: selectedYear,
                              onChanged: (int? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedYear = newValue;
                                  });
                                }
                              },
                              items: List.generate(10, (index) {
                                return DropdownMenuItem<int>(
                                  value: 2022 +
                                      index, // Generate years from 2022 to 2031
                                  child: Text('${2022 + index}'),
                                );
                              }),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final requests = await fetchApprovedRequests(
                                selectedYear, selectedMonth);
                            if (requests.isNotEmpty) {
                              final pdf = await generatePdf(requests);

                              await Printing.layoutPdf(
                                onLayout: (format) => pdf.save(),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'No approved requests found for the selected period.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: Text('Generate PDF'),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 400,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Icon(Icons.calendar_month),
                    //           Text(
                    //             'Upcoming Events',
                    //             style: GoogleFonts.inter(
                    //                 textStyle: TextStyle(
                    //                     fontSize: 24,
                    //                     fontWeight: FontWeight.w400)),
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         height: 16,
                    //       ),
                    //       Expanded(
                    //         child: ListView.builder(
                    //           itemCount: 3,
                    //           itemBuilder: (BuildContext ctx, i) {
                    //             return Container(
                    //               padding: EdgeInsets.symmetric(vertical: 8),
                    //               decoration: BoxDecoration(
                    //                 border: Border(
                    //                   bottom: BorderSide(
                    //                     color: Colors.grey[
                    //                         300]!, // Customize the color as needed
                    //                     width:
                    //                         1.0, // Customize the thickness as needed
                    //                   ),
                    //                 ),
                    //               ),
                    //               child: SizedBox(
                    //                 height: 50,
                    //                 child: Row(
                    //                   children: [
                    //                     Flexible(
                    //                       flex: 2,
                    //                       child: Padding(
                    //                         padding: const EdgeInsets.symmetric(
                    //                             horizontal: 16),
                    //                         child: Column(
                    //                           crossAxisAlignment:
                    //                               CrossAxisAlignment.start,
                    //                           children: [
                    //                             Text('May 6, 2024'),
                    //                             Text('8:00am - 3:00pm')
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     Flexible(
                    //                       flex: 3,
                    //                       child: Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: [
                    //                           Text(
                    //                             'Title',
                    //                             style: TextStyle(
                    //                                 fontWeight: FontWeight.bold,
                    //                                 fontSize: 14),
                    //                           ),
                    //                           Text('Description')
                    //                         ],
                    //                       ),
                    //                     ),
                    //                     SizedBox()
                    //                   ],
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       )
                    //     ],
                    //   ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
