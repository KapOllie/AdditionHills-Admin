import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/common/widgets/column_field_text.dart';
import 'package:barangay_adittion_hills_app/models/document_requests/document_request.dart';
import 'package:barangay_adittion_hills_app/presentation/equipment/pages/equipment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

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
                            Expanded(child: ColumnFieldText(fieldText: 'User')),
                            Expanded(
                                child: ColumnFieldText(
                                    fieldText: 'Date Requested')),
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
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  viewDocRequest(
                                                      documentRequest,
                                                      index,
                                                      docReqId);
                                                },
                                                child: Text(
                                                  documentRequest.user_email,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        color:
                                                            Color(0xff0a0a0a),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                documentRequest.date_requested
                                                    .toDate()
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      color: Color(0xff0a0a0a),
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
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      color: Color(0xff0a0a0a),
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
                                                        .request_status ==
                                                    "pending")
                                                  Icon(
                                                    Icons.warning_amber_rounded,
                                                    color:
                                                        Colors.yellow.shade400,
                                                  )
                                                else if (documentRequest
                                                        .request_status ==
                                                    "Denied")
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
                                                  )
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

  viewDocRequest(DocumentRequest docRequests, int index, String docReqId) {
    var viewDocRequestDialog = StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Align(
          alignment: Alignment.center,
          child: Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Document Request',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Request ID: ${docReqId}\n'),
                            TextSpan(
                                text:
                                    'Document Title: ${docRequests.document_title}\n'),
                            TextSpan(
                                text:
                                    'Requested by: ${docRequests.requester_name} (${docRequests.user_email})\n'),
                            TextSpan(
                                text:
                                    'Submitted on: ${docRequests.date_requested.toDate()}\n'),
                            TextSpan(
                                text:
                                    'Pickup date: ${docRequests.pickup_date.toDate()}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (docRequests.request_status == "pending")
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              DocumentRequest updatedStatus =
                                  docRequests.copyWith(
                                      document_title:
                                          docRequests.document_title,
                                      user_email: docRequests.user_email,
                                      requester_name:
                                          docRequests.requester_name,
                                      address: docRequests.address,
                                      birthday: docRequests.birthday,
                                      date_requested:
                                          docRequests.date_requested,
                                      pickup_date: docRequests.pickup_date,
                                      request_status: "Denied");
                              _databaseService.updateDocumentRequest(
                                  docReqId, updatedStatus);
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
                          ),
                          const SizedBox(
                              width: 16), // Add spacing between buttons
                          InkWell(
                            onTap: () {
                              DocumentRequest updatedStatus =
                                  docRequests.copyWith(
                                      document_title:
                                          docRequests.document_title,
                                      user_email: docRequests.user_email,
                                      requester_name:
                                          docRequests.requester_name,
                                      address: docRequests.address,
                                      birthday: docRequests.birthday,
                                      date_requested:
                                          docRequests.date_requested,
                                      pickup_date: docRequests.pickup_date,
                                      request_status: "Approved");
                              _databaseService.updateDocumentRequest(
                                  docReqId, updatedStatus);
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
                          ),
                        ],
                      ),
                    )
                  else
                    Text(docRequests.request_status)
                ],
              ),
            ),
          ),
        );
      },
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return viewDocRequestDialog;
      },
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
