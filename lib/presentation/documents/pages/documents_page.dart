import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/common/widgets/common_widgets.dart';
import 'package:barangay_adittion_hills_app/common/widgets/textfield_validator/textfield_validators.dart';
import 'package:barangay_adittion_hills_app/models/document/document.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/column_field_text.dart';

final _formKey = GlobalKey<FormState>();

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

final _newDocument = TextEditingController();
final _newDescription = TextEditingController();
final DatabaseService _databaseService = DatabaseService();

void showUpdateDialogBox(String docsId, BuildContext context, Document doc,
    DatabaseService databaseService) {
  final newTitle = TextEditingController(text: doc.title);
  final newDescription = TextEditingController(text: doc.description);

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                        color: Color(0xff0a0a0a),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Title',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Color(0xff2294F2),
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 24),
                      child: TextFormField(
                        controller: newTitle,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Item Title cannot be empty!";
                          }
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(42),
                        ],
                        cursorColor: const Color(0xff1D1929),
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff1E1A2A),
                          ),
                        ),
                        decoration: const InputDecoration(
                          fillColor: Color(0xfFFFFFFF),
                          filled: true,
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffE8E8EA)),
                          ),
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Description',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Color(0xff2294F2),
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: TextFormField(
                        controller: newDescription,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff1E1A2A),
                          ),
                        ),
                        decoration: const InputDecoration(
                          fillColor: Color(0xffffffff),
                          filled: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 30, horizontal: 8),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffE8E8EA)),
                          ),
                          focusedBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Document description cannot be empty!";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: Color(0xffFF7F50),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Center(
                                  child: Text('Cancel',
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)))),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: Color(0xff2294F2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Center(
                                  child: Text('Save',
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)))),
                            ),
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Document updatedDocument = doc.copyWith(
                                    title: newTitle.text,
                                    description: newDescription.text,
                                    lastModifiedOn: Timestamp.now());
                                databaseService.updateDoc(
                                    docsId, updatedDocument);
                                Navigator.pop(context);
                              }
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

class _DocumentsPageState extends State<DocumentsPage> {
  PlatformFile? _imageFile;

  Future<void> _showPicker() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result == null) {
        return;
      }
      setState(() {
        _imageFile = result.files.first;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint(_imageFile.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6E6E6),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 8),
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white),
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
                    headText('Documents'),
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
                      width: 260,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xffE3F2FC),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 4),
                            width: 200,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            child: TextField(
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color:
                                      const Color(0xff818A91).withOpacity(0.5),
                                  fontSize: 12,
                                ),
                              ),
                              decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: 'Search document by Title',
                                hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: const Color(0xff818A91)
                                        .withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              cursorColor: const Color(0xff2294F2),
                              onChanged: (value) {
                                debugPrint(value);
                              },
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                debugPrint('Tapped!');
                              },
                              child: Container(
                                height: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color(0xff2294F2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                child: const Icon(
                                  Icons.search_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 60,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xffE5E8FC),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Center(
                        child: ColumnFieldText(
                          fieldText: 'ID',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ColumnFieldText(
                          fieldText: 'Title',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ColumnFieldText(
                          fieldText: 'Last Modified',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ColumnFieldText(
                          fieldText: 'Actions',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                  height: 300,
                  child: StreamBuilder(
                      stream: _databaseService.getDocuments(),
                      builder: (context, snapshot) {
                        List documents = snapshot.data?.docs ?? [];
                        debugPrint(_databaseService.getDocuments().toString());
                        if (documents.isEmpty) {
                          return const Center(
                            child: Text('Empty'),
                          );
                        }
                        return ListView.separated(
                          itemCount: documents.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            Document document = documents[index].data();
                            String docsId = documents[index].id;
                            debugPrint(docsId);
                            return ListTile(
                                contentPadding: const EdgeInsets.all(4),
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Color(0xff2294F2),
                                      width: 1,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                leading: Text("${index + 1}"),
                                title: Row(
                                  children: [
                                    // column 1
                                    Expanded(
                                        child: Center(child: Text(docsId))),
                                    // Column 2
                                    Expanded(
                                        child: Center(
                                            child: Text(document.title))),
                                    Expanded(
                                        child: Center(
                                            child: Text(DateFormat.yMMMd()
                                                .add_jm()
                                                .format(document.lastModifiedOn
                                                    .toDate())))),
                                    Expanded(
                                        child: Container(
                                      // color: Colors.pinkAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              tooltip: 'View',
                                              onPressed: () {
                                                viewDoc(context, document);
                                              },
                                              icon: const Icon(
                                                Icons.remove_red_eye_rounded,
                                                color: Color(0xff007bff),
                                              )),
                                          IconButton(
                                              tooltip: 'Edit',
                                              onPressed: () {
                                                showUpdateDialogBox(
                                                  docsId,
                                                  context,
                                                  Document(
                                                      title: document.title,
                                                      description:
                                                          document.description,
                                                      createdOn:
                                                          document.createdOn,
                                                      lastModifiedOn: document
                                                          .lastModifiedOn),
                                                  _databaseService,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.edit_rounded,
                                                color: Color(0xffFFD700),
                                              )),
                                          IconButton(
                                              tooltip: 'Delete',
                                              onPressed: () {
                                                confirmToDeleteDialogBox(
                                                    context, docsId);
                                              },
                                              icon: const Icon(
                                                Icons.delete_rounded,
                                                color: Color(0xffdc3545),
                                              )),
                                        ],
                                      ),
                                    )),
                                  ],
                                ));
                          },
                        );
                      })),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff2294F2),
        onPressed: () {
          showAddNewDialogBox(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        label: Row(
          children: [
            const Icon(
              Icons.add_rounded,
              color: Colors.white,
            ),
            Text(
              'New Document',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(color: Colors.white)),
            )
          ],
        ),
        elevation: 5,
      ),
    );
  }

  void viewDoc(
    BuildContext context,
    Document doc,
  ) async {
    TextEditingController _viewTitleController =
        TextEditingController(text: doc.title);
    TextEditingController _viewDescController =
        TextEditingController(text: doc.description);

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'View',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          color: Color(0xff0a0a0a),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Title',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color(0xff2294F2),
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 24),
                        child: TextFormField(
                          readOnly: true,
                          controller: _viewTitleController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Item Title cannot be empty!";
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(42),
                          ],
                          cursorColor: const Color(0xff1D1929),
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Color(0xff1E1A2A),
                            ),
                          ),
                          decoration: const InputDecoration(
                            fillColor: Color(0xfFFFFFFF),
                            filled: true,
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE8E8EA)),
                            ),
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      if (_imageFile != null)
                        Image.memory(
                          Uint8List.fromList(_imageFile!.bytes!),
                          width: 400,
                          height: 600,
                        ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text:
                                "Created on: ${DateFormat.yMMMd().add_jm().format(doc.createdOn.toDate())}\n",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 10))),
                        TextSpan(
                            text:
                                "Last modified on: ${DateFormat.yMMMd().add_jm().format(doc.lastModifiedOn.toDate())}",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 10))),
                      ])),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Description',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color(0xff2294F2),
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: TextFormField(
                          readOnly: true,
                          controller: _viewDescController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Color(0xff1E1A2A),
                            ),
                          ),
                          decoration: const InputDecoration(
                            fillColor: Color(0xffffffff),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 30, horizontal: 8),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE8E8EA)),
                            ),
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: Container(
                                width: 120,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Color(0xffFF7F50),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Center(
                                    child: Text('Close',
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                color: Color(0xffFFFFFF),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)))),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  showAddNewDialogBox(BuildContext context) {
    TextEditingController addTitle = TextEditingController();
    TextEditingController addDesc = TextEditingController();
    TextEditingController addPrice = TextEditingController();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width / 2,
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Add New Document',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                  color: Color(0xff0a0a0a),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: 24,
                                  child: IconButton(
                                      onPressed: () {
                                        _showPicker();
                                      },
                                      icon: Icon(Icons.add_a_photo_rounded)),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Title',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Color(0xff2294F2),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 24),
                          child: TextFormField(
                            controller: addTitle,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Item Title cannot be empty!";
                              }
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(42),
                            ],
                            cursorColor: const Color(0xff1D1929),
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff1E1A2A),
                              ),
                            ),
                            decoration: const InputDecoration(
                              fillColor: Color(0xfFFFFFFF),
                              filled: true,
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffE8E8EA)),
                              ),
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Description',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Color(0xff2294F2),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: TextFormField(
                            controller: addDesc,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff1E1A2A),
                              ),
                            ),
                            decoration: const InputDecoration(
                              fillColor: Color(0xffffffff),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 8),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffE8E8EA)),
                              ),
                              focusedBorder: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Document description cannot be empty!";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Price',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Color(0xff2294F2),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 24),
                          child: TextFormField(
                            controller: addPrice,
                            validator: (value) {
                              if (value!.isEmpty) {
                                setState(() {
                                  addPrice.text = 'Free';
                                });
                              }
                              return null;
                            },
                            inputFormatters: onlyUnsignedNumbers(4),
                            cursorColor: const Color(0xff1D1929),
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff1E1A2A),
                              ),
                            ),
                            decoration: const InputDecoration(
                              fillColor: Color(0xfFFFFFFF),
                              filled: true,
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffE8E8EA)),
                              ),
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.black,
                        ),
                        if (_imageFile != null)
                          Image.memory(
                            Uint8List.fromList(_imageFile!.bytes!),
                            width: 400,
                            height: 600,
                          ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                child: Container(
                                  width: 120,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffFF7F50),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Center(
                                      child: Text('Cancel',
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  color: Color(0xffFFFFFF),
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w400)))),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                child: Container(
                                  width: 120,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff2294F2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Center(
                                      child: Text('Add',
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  color: Color(0xffFFFFFF),
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w400)))),
                                ),
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    Document document = Document(
                                        title: addTitle.text,
                                        description: addDesc.text,
                                        createdOn: Timestamp.now(),
                                        lastModifiedOn: Timestamp.now());
                                    _databaseService.addDoc(document);
                                    Navigator.pop(context);
                                    _newDocument.clear();
                                    _newDescription.clear();
                                  }
                                  return;
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }
}

void confirmToDeleteDialogBox(BuildContext context, String docsId) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning_rounded,
            color: Color(0xffDC143C),
            size: 48,
          ),
          title: Text(
            'Are your sure?',
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: Color(0xff0a0a0a), fontWeight: FontWeight.w600),
                fontSize: 20),
          ),
          content: Text(
            'Do you really want to delete this document?\nThis process cannot be undone.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
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
                  _databaseService.deleteDoc(docsId);
                  Navigator.pop(context);
                },
                child: const Text('Delete')),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      });
}
