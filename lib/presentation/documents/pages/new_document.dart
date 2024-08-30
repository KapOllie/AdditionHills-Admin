import 'dart:typed_data';

import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/models/document/document.dart';
import 'package:barangay_adittion_hills_app/presentation/documents/widgets/required_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final _formKey = GlobalKey<FormState>();

class NewDocument extends StatefulWidget {
  const NewDocument({super.key});

  @override
  State<NewDocument> createState() => _NewDocumentState();
}

class _NewDocumentState extends State<NewDocument> {
  bool hasReq = false;
  List<String> getDocRequirements = [];
  Map<String, bool> selectedOptions = {};
  Future<void> fetchHobbies() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('requirements')
          .doc('document_requirements')
          .get();

      if (snapshot.exists) {
        List<dynamic> requirementsFromFS = snapshot['requirements_list'];
        setState(() {
          getDocRequirements = List<String>.from(requirementsFromFS);
        });
      }
    } catch (e) {
      debugPrint("Error fetching hobbies: $e");
    }
  }

  final DatabaseService _databaseService = DatabaseService();
  final DateFormat monthYearFormat =
      DateFormat('EEEE, MMMM d, yyyy \'at\' h:mm a');
  final List noRequirement = ["None"];

  bool _hasReq = false;
  TextEditingController _updatedPriceController = TextEditingController();
  List<TextEditingController> listDocumentRequirements = [
    TextEditingController()
  ];

  String? _priceChoice = 'Free';
  TextEditingController _priceController = TextEditingController();
  TextEditingController addTitle = TextEditingController();
  TextEditingController addDesc = TextEditingController();
  TextEditingController addFee = TextEditingController(text: 'Free');
  Uint8List? _selectedFile;
  String? _uploadedImageUrl;

  Future<void> _pickAndUploadFile(StateSetter setState) async {
    // Pick a file using file_picker
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      _selectedFile = result.files.first.bytes;

      if (_selectedFile != null) {
        // Upload the file to Firebase Storage
        try {
          String fileName =
              'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
          final storageRef =
              FirebaseStorage.instance.ref().child('documents/$fileName');
          final uploadTask = storageRef.putData(
              _selectedFile!, SettableMetadata(contentType: 'image/jpeg'));
          final snapshot = await uploadTask.whenComplete(() => {});
          _uploadedImageUrl = await snapshot.ref.getDownloadURL();
          print('Uploaded Image URL: $_uploadedImageUrl');
        } catch (e) {
          print('Error during file upload: $e');
        }
      }
    } else {
      debugPrint('No file selected.');
    }
    setState(() {}); // Update the UI after file selection and upload
  }

  TextEditingController customOptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchHobbies().then((_) {
      // Ensure the selectedOptions map is initialized after fetching hobbies
      setState(() {
        for (var option in getDocRequirements) {
          selectedOptions[option] = selectedOptions[option] ?? false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Container(
        color: const Color(0xfff0ebf8),
        height: double.infinity,
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          color: Color(0xff1B2533),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close_sharp,
                            color: Color(0xff5f6368),
                          )),
                    ))
                  ],
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () async {
                    await _pickAndUploadFile(setState);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: const Color(0XFF8E99AA)),
                        image: _selectedFile != null
                            ? DecorationImage(
                                image: MemoryImage(_selectedFile!),
                                fit: BoxFit.contain,
                              )
                            : null,
                      ),
                      child: _selectedFile == null
                          ? const Center(
                              child: Icon(
                                Icons.add_a_photo_sharp,
                                color: Color(0XFF8E99AA),
                              ),
                            )
                          : Stack(
                              children: [
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedFile = null;
                                        _uploadedImageUrl = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Note: All fields marked with an asterisk (*) are required',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0XFF8E99AA),
                    )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: '*',
                      style: GoogleFonts.inter(
                        textStyle:
                            TextStyle(color: Color(0xffDD3409), fontSize: 14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'Document Title',
                      style: GoogleFonts.inter(
                          textStyle:
                              TextStyle(color: Color(0xff1B2533), fontSize: 14),
                          fontWeight: FontWeight.w600),
                    ),
                  ])),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 24),
                  child: RequiredTextField(
                    hintText: 'Enter document title',
                    isRequired: true,
                    textController: addTitle,
                    inputFormatter: [LengthLimitingTextInputFormatter(42)],
                    inputValidator: (value) {
                      if (value!.isEmpty) {
                        return "Title is required";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: '*',
                      style: GoogleFonts.inter(
                        textStyle:
                            TextStyle(color: Color(0xffDD3409), fontSize: 14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'Description',
                      style: GoogleFonts.inter(
                          textStyle:
                              TextStyle(color: Color(0xff1B2533), fontSize: 14),
                          fontWeight: FontWeight.w600),
                    ),
                  ])),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 24, right: 16),
                    child: RequiredTextField(
                      hintText: 'Add a description',
                      isRequired: true,
                      textController: addDesc,
                      textInputType: TextInputType.multiline,
                      maxLines: null,
                      inputValidator: (value) {
                        if (value!.isEmpty) {
                          return "Description is required";
                        }
                        return null;
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: '*',
                      style: GoogleFonts.inter(
                          textStyle:
                              TextStyle(color: Color(0XFFDD3409), fontSize: 14),
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: 'Fee',
                      style: GoogleFonts.inter(
                        textStyle:
                            TextStyle(color: Color(0xff1B2533), fontSize: 14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ])),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 16, bottom: 24),
                    child: RequiredTextField(
                      isRequired: true,
                      textController: addFee,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      textInputType: TextInputType.multiline,
                      maxLines: null,
                      inputValidator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            addFee.text = 'Free';
                          });
                        }
                        return null;
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Requirement',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Transform.scale(
                        scale: 0.75,
                        child: Switch(
                            activeTrackColor: Color(0xff189877),
                            activeColor: Colors.white,
                            value: hasReq,
                            onChanged: (value) {
                              setState(() {
                                hasReq = value;
                              });
                            }),
                      ),
                    ),
                  ],
                ),
                if (hasReq)
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Container(
                      height: 350,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0XFF8E99AA))),
                      child: Column(
                        children: [
                          ListView.builder(
                              itemCount: listDocumentRequirements.length,
                              shrinkWrap: true, // Added to avoid layout issues
                              itemBuilder: (BuildContext context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 8),
                                  child: TextFormField(
                                    controller: listDocumentRequirements[index],
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff1B2533),
                                    )),
                                    decoration: InputDecoration(
                                      prefixText: '${index + 1}. ',
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.zero,
                                          borderSide: BorderSide(
                                              color: Color(0XFF8E99AA),
                                              width: 1)),
                                      hoverColor: Colors.transparent,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.zero,
                                          borderSide: BorderSide(
                                              color: Color(0XFF8E99AA),
                                              width: 1.75)),
                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: IconButton(
                                            onPressed: () {
                                              if (index == 0) {
                                                debugPrint(
                                                    'index is less than 0');
                                                setState(() {
                                                  hasReq = false;
                                                });
                                              } else if (index > 0) {
                                                setState(() {
                                                  listDocumentRequirements[
                                                          index]
                                                      .clear(); // Clear first
                                                  listDocumentRequirements
                                                      .removeAt(index);
                                                }); //
                                              }
                                            },
                                            icon: Icon(
                                              Icons
                                                  .remove_circle_outline_rounded,
                                              size: 18,
                                              color: Color(0XFFDD3409),
                                            )),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      listDocumentRequirements
                                          .add(TextEditingController());
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add_circle_rounded,
                                    size: 18,
                                  )),
                              Text(
                                'Add More',
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(fontSize: 12)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                Center(
                  child: InkWell(
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: Color(0xff017EF3),
                          borderRadius: BorderRadius.zero),
                      child: Center(
                          child: Text('Add',
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)))),
                    ),
                    onTap: () async {
                      if (_uploadedImageUrl == null) {
                        // Show alert dialog if no image is selected
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Column(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    color: Colors.yellow,
                                    size: 32,
                                  ),
                                  Center(child: Text('No Image Selected')),
                                ],
                              ),
                              content: const Text(
                                  'Please select an image before adding the document.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else if (_formKey.currentState!.validate()) {
                        List<String> requirementsValues =
                            listDocumentRequirements
                                .map((controller) => controller.text)
                                .toList();
                        Document newDocument = Document(
                            title: addTitle.text,
                            description: addDesc.text,
                            createdOn: Timestamp.now(),
                            lastModifiedOn: Timestamp.now(),
                            fee: double.parse(addFee.text),
                            imageUrl: _uploadedImageUrl!,
                            docRequirements:
                                _hasReq == true ? requirementsValues : []);

                        // Call addDoc and await the result
                        bool success = await _databaseService.addDoc(
                          newDocument,
                          Timestamp.now().millisecondsSinceEpoch.toString(),
                        );

                        // Show Snackbar with success or error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(success
                                ? 'Document added successfully!'
                                : 'Failed to add document.'),
                            backgroundColor:
                                success ? Colors.green : Colors.red,
                          ),
                        );

                        // Close the dialog and clear fields only if the addition was successful
                        if (success) {
                          Navigator.pop(context);
                          addTitle.clear();
                          addDesc.clear();
                          _priceController.clear();
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
