import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/common/widgets/column_field_text.dart';
import 'package:barangay_adittion_hills_app/models/document_requests/document_request.dart';
import 'package:barangay_adittion_hills_app/presentation/equipment/pages/equipment_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DocumentRequestPage extends StatefulWidget {
  const DocumentRequestPage({super.key});

  @override
  State<DocumentRequestPage> createState() => _DocumentRequestPageState();
}

class _DocumentRequestPageState extends State<DocumentRequestPage> {
  final DatabaseService _databaseService = DatabaseService();
  Icon status = Icon(Icons.check_circle_outline_rounded);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6E6E6),
      body: Padding(
        padding: EdgeInsets.all(8),
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
                    'Document Requests',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            color: Color(0xff1B2533),
                            fontSize: 24,
                            fontWeight: FontWeight.w600)),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: InkWell(
                  //     onTap: () {},
                  //     child: Container(
                  //       width: 200,
                  //       height: 40,
                  //       decoration: BoxDecoration(
                  //         color: Color(0xff017EF3),
                  //       ),
                  //       child: Center(
                  //         child: Text(
                  //           '+ New Document Request',
                  //           style: GoogleFonts.inter(
                  //               textStyle: TextStyle(
                  //                   color: Colors.white, fontSize: 14)),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
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
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                                child: ColumnFieldText(fieldText: 'Sender')),
                            Expanded(
                                child: ColumnFieldText(
                                    fieldText: 'Date Requested')),
                            Expanded(
                                child:
                                    ColumnFieldText(fieldText: 'Pickup Date')),
                            Expanded(
                                child: ColumnFieldText(
                                    fieldText: 'Document Title')),
                            Expanded(
                                child: ColumnFieldText(fieldText: 'Status')),
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: double.infinity,
                        height: 500,
                        child: StreamBuilder(
                            stream: _databaseService.getDocumentRequests(),
                            builder: (context, snapshot) {
                              List docReq = snapshot.data?.docs ?? [];
                              if (docReq.isEmpty) {
                                return const Center(
                                  child: Text('Empty'),
                                );
                              }
                              return ListView.builder(
                                  itemCount: docReq.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    DocumentRequest documentRequest =
                                        docReq[index].data();
                                    String docReqId = docReq[index].id;
                                    return Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 0.5,
                                                  color: Color(0xffE6E6E6)))),
                                      child: ListTile(
                                        onTap: () => viewDocRequest(
                                            documentRequest, index, docReqId),
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                documentRequest.user_email,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                  textStyle: const TextStyle(
                                                      color: Color(0xff1B2533),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${DateFormat('MMMM d, yyyy h:mm a').format(documentRequest.date_requested.toDate())}',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                  textStyle: const TextStyle(
                                                      color: Color(0xff1B2533),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${DateFormat('MMMM d, yyyy h:mm a').format(documentRequest.pickup_date.toDate())}',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                  textStyle: const TextStyle(
                                                      color: Color(0xff1B2533),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                documentRequest.document_title,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                  textStyle: const TextStyle(
                                                      color: Color(0xff1B2533),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if (documentRequest
                                                    .request_status
                                                    .contains('Pending'))
                                                  Icon(
                                                    Icons.warning_amber_rounded,
                                                    color:
                                                        Colors.yellow.shade400,
                                                  )
                                                else if (documentRequest
                                                    .request_status
                                                    .contains('Denied'))
                                                  Icon(
                                                    Icons
                                                        .remove_circle_outline_rounded,
                                                    color: Colors.red.shade400,
                                                  )
                                                else
                                                  Icon(
                                                    Icons
                                                        .check_circle_outline_rounded,
                                                    color:
                                                        Colors.green.shade400,
                                                  ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      if (documentRequest
                                                          .request_status
                                                          .contains(
                                                              'Pending')) {
                                                        // Show a Snackbar if the document status is pending
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                'Document status is still pending and needs action before deletion.'),
                                                            duration: Duration(
                                                                seconds: 3),
                                                          ),
                                                        );
                                                      } else {
                                                        // Show the confirmation dialog if the status is not pending
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Confirm Deletion'),
                                                              content: Text(
                                                                  'Are you sure you want to delete this request permanently?'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(); // Close the dialog without deleting
                                                                  },
                                                                  child: Text(
                                                                      'Abort'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    // Close the confirmation dialog before deletion
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();

                                                                    try {
                                                                      // Proceed with the deletion
                                                                      await _databaseService.deleteDocReq(
                                                                          docReqId,
                                                                          documentRequest);

                                                                      // Show success dialog
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('Success'),
                                                                            content:
                                                                                Text('The document request was successfully deleted.'),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop(); // Close the dialog
                                                                                },
                                                                                child: Text('OK'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    } catch (e) {
                                                                      // Show error dialog if something goes wrong
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('Error'),
                                                                            content:
                                                                                Text('An error occurred while deleting the document request: $e'),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop(); // Close the dialog
                                                                                },
                                                                                child: Text('OK'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                      'Delete'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                    icon: Icon(Icons.delete))
                                              ],
                                            )),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  int calculateAge(String birthDateString) {
    // Parse the string into a DateTime object
    DateTime birthDate = DateTime.parse(birthDateString);
    DateTime currentDate = DateTime.now(); // Get the current date

    int age = currentDate.year - birthDate.year;

    // Check if the birthday has occurred yet this year
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--; // Subtract 1 if the birthday hasn't occurred yet this year
    }

    return age;
  }

  void viewDocRequest(DocumentRequest docRequest, int index, String docReqId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: Material(
            child: Container(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDocumentRequestHeader(docRequest),
                  const SizedBox(height: 16),
                  _buildSenderInformation(docRequest, docReqId),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildDocumentRequestActions(docRequest, docReqId),
                      ],
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

  Widget _buildDocumentRequestHeader(DocumentRequest docRequest) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        'Document Request',
        style: GoogleFonts.inter(
          textStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSenderInformation(
      DocumentRequest docRequest, String docIdString) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About the Request',
          style: GoogleFonts.inter(
              textStyle:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 8),
        Text(
          'Document Id: $docIdString',
          style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 14)),
        ),
        Text(
          'Document Title: ${docRequest.document_title}',
          style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 14)),
        ),
        Text(
          'Fee: ${docRequest.fee == 0 ? 'Free' : docRequest.fee.toString()}',
          style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 14)),
        ),
        Text(
          'Submitted on: ${DateFormat('MMMM d, yyyy h:mm a').format(docRequest.date_requested.toDate())}',
          style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 14)),
        ),
        Text(
          'Pickup Date: ${DateFormat('MMMM d, yyyy h:mm a').format(docRequest.pickup_date.toDate())}',
          style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 14)),
        ),
        const SizedBox(height: 16),
        Text(
          'Sender Information',
          style: GoogleFonts.inter(
              textStyle:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 8),
        Text(
          'Name: ${docRequest.requester_name}',
          style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 14)),
        ),
        Text(
          'Birthday: ${docRequest.birthday}',
          style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 14)),
        ),
        Text(
          'Age: ${calculateAge(docRequest.birthday).toString()}',
          style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 14)),
        ),
        Text(
          'Contact: ${docRequest.contact_number}',
          style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 14)),
        ),
        Text(
          'Email: ${docRequest.user_email}',
          style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 14)),
        ),
        Text(
          'Years of Residence: ${docRequest.residence_since}',
          style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 14)),
        ),
      ],
    );
  }

  Widget _buildDocumentRequestActions(
      DocumentRequest docRequest, String docReqId) {
    if (docRequest.request_status == "Pending") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDeclineButton(docRequest, docReqId),
          const SizedBox(width: 16),
          _buildApproveButton(docRequest, docReqId),
        ],
      );
    } else {
      return Text(
        'Status: ${docRequest.request_status}',
        style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 14)),
      );
    }
  }

  Widget _buildDeclineButton(DocumentRequest docRequest, String docReqId) {
    return InkWell(
      onTap: () {
        final updatedStatus = docRequest.copyWith(
            request_status:
                "Denied on ${DateFormat('MMMM d, yyyy h:mm a').format(Timestamp.now().toDate())}");
        _databaseService.updateDocumentRequest(docReqId, updatedStatus);
        Navigator.pop(context);
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 150,
        color: Colors.red.shade700,
        child: const Text(
          'Decline',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildApproveButton(DocumentRequest docRequest, String docReqId) {
    return InkWell(
      onTap: () {
        final updatedStatus = docRequest.copyWith(request_status: "Approved");
        _databaseService.updateDocumentRequest(docReqId, updatedStatus);
        Navigator.pop(context);
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 150,
        color: Colors.green.shade700,
        child: const Text(
          'Approve',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

Widget actionButton(Icon buttonIcon, void Function()? onPressed,
    Color iconColor, String toolTip) {
  return IconButton(
    tooltip: toolTip,
    icon: buttonIcon,
    iconSize: 24,
    color: iconColor,
    onPressed: onPressed,
  );
}
