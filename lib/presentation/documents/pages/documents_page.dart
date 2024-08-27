import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/common/widgets/common_widgets.dart';
import 'package:barangay_adittion_hills_app/common/widgets/field_label/text_field.dart';
import 'package:barangay_adittion_hills_app/common/widgets/textfield_validator/textfield_validators.dart';
import 'package:barangay_adittion_hills_app/models/document/document.dart';
import 'package:barangay_adittion_hills_app/presentation/documents/widgets/dialog_box.dart';
import 'package:barangay_adittion_hills_app/presentation/documents/widgets/required_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/column_field_text.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

DialogBox _dialogBox = DialogBox();

final DatabaseService _databaseService = DatabaseService();

class _DocumentsPageState extends State<DocumentsPage> {
  FieldLabel documentsText = FieldLabel();
  TextEditingController searchDoc = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    searchDoc.addListener(() {
      setState(() {
        searchQuery = searchDoc.text.toLowerCase();
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
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.zero, color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    documentsText.headText('Documents'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                height: 56,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 280,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          left: BorderSide(color: Color(0xffdadce0)),
                          top: BorderSide(color: Color(0xffdadce0)),
                          bottom: BorderSide(color: Color(0xffdadce0)),
                          right: BorderSide(color: Color(0xffdadce0)),
                        ),
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: TextField(
                                controller: searchDoc,
                                style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                    color: Color(0xff202124),
                                    fontSize: 12,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText: 'Search document by Title',
                                  hintStyle: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                      color: Color(0xff202124),
                                      fontSize: 12,
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
                  ],
                ),
              ),
              SizedBox(
                height: 24,
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
                        Expanded(child: ColumnFieldText(fieldText: 'ID')),
                        Expanded(child: ColumnFieldText(fieldText: 'Title')),
                        Expanded(child: ColumnFieldText(fieldText: 'Fee')),
                        Expanded(
                            child: ColumnFieldText(fieldText: 'Last Modified')),
                        Expanded(child: ColumnFieldText(fieldText: 'Actions')),
                      ],
                    ),
                  )),
              SizedBox(
                  height: 300,
                  child: StreamBuilder(
                    stream: _databaseService.getDocuments(),
                    builder: (context, snapshot) {
                      // Fetch documents from snapshot
                      List documents = snapshot.data?.docs ?? [];

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData ||
                          snapshot.data?.docs.isEmpty == true) {
                        return const Center(
                            child: Text('No Document available'));
                      }

                      if (documents.isEmpty) {
                        return Center(
                          child: Text('Empty'),
                        );
                      }

                      // Filter the documents by the search query
                      List filteredDocuments = documents.where((doc) {
                        String title = doc.data().title.toLowerCase();
                        return title.contains(searchQuery);
                      }).toList();

                      // Sort the documents by 'lastModifiedOn' date
                      filteredDocuments.sort((a, b) {
                        DateTime dateA = a.data().lastModifiedOn.toDate();
                        DateTime dateB = b.data().lastModifiedOn.toDate();
                        return dateB.compareTo(dateA); // Descending order
                      });

                      if (filteredDocuments.isEmpty) {
                        return const Center(
                          child: Text('No documents found'),
                        );
                      }

                      return ListView.builder(
                        itemCount: filteredDocuments.length,
                        itemBuilder: (BuildContext context, int index) {
                          Document document = filteredDocuments[index].data();
                          String docsId = filteredDocuments[index].id;
                          return Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1, color: Color(0xffE6E6E6)),
                                    left: BorderSide(
                                        width: 1, color: Color(0xffE6E6E6)),
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xffE6E6E6)))),
                            child: ListTile(
                              onTap: () => _dialogBox.showViewDialogBox(
                                  context, document),
                              shape: const Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xff202124))),
                              title: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    // column 1
                                    Expanded(
                                        child: Center(
                                            child: Text(
                                      docsId,
                                      style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff202124))),
                                    ))),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: VerticalDivider(
                                        thickness: 0.5,
                                      ),
                                    ),

                                    Expanded(
                                        child: GestureDetector(
                                      onTap: () => _dialogBox.showViewDialogBox,
                                      child: Center(
                                          child: Text(
                                        textAlign: TextAlign.center,
                                        document.title,
                                        style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff202124))),
                                      )),
                                    )),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: VerticalDivider(
                                        thickness: 0.5,
                                      ),
                                    ),
                                    Expanded(
                                        child: Center(
                                            child: Text(
                                      document.price,
                                      style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff202124))),
                                    ))),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: VerticalDivider(
                                        thickness: 0.5,
                                      ),
                                    ),
                                    Expanded(
                                        child: Center(
                                            child: Text(
                                      DateFormat.yMMMd().add_jm().format(
                                            document.lastModifiedOn.toDate(),
                                          ),
                                      style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff202124))),
                                    ))),
                                    Expanded(
                                      child: IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              tooltip: 'Edit',
                                              onPressed: () {
                                                _dialogBox.showUpdateDialogBox(
                                                    context, document, docsId);
                                              },
                                              icon: const Icon(
                                                Icons.mode_edit_outline_rounded,
                                                color: Color(0xffFFC550),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: VerticalDivider(
                                                thickness: 0.5,
                                              ),
                                            ),
                                            IconButton(
                                              tooltip: 'Delete',
                                              onPressed: () {
                                                _dialogBox
                                                    .confirmToDeleteDialogBox(
                                                        context, docsId);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Color(0xffDD3409),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )),
            ],
          ),
        ),
        floatingActionButton: Container(
          padding: const EdgeInsets.only(right: 32, bottom: 32),
          child: FloatingActionButton(
            onPressed: () {
              _dialogBox.showAddNewDialogBox(context);
            },
            backgroundColor: const Color(0xff6B3CEB),
            shape: const CircleBorder(),
            tooltip: 'Add New Document',
            child: const Icon(
              Icons.add_rounded,
              size: 24,
              color: Colors.white,
            ),
          ),
        ));
  }
}
