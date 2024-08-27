import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/common/widgets/textfield_validator/textfield_validators.dart';
import 'package:barangay_adittion_hills_app/models/document/document.dart';
import 'package:barangay_adittion_hills_app/presentation/documents/widgets/required_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DialogBox {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService();
  final DateFormat monthYearFormat =
      DateFormat('EEEE, MMMM d, yyyy \'at\' h:mm a');
  final List noRequirement = ["None"];

  void showAddNewDialogBox(BuildContext context) {
    bool _hasReq = false;
    String? _addReq;
    TextEditingController _updatedPriceController = TextEditingController();
    List<TextEditingController> listDocumentRequirements = [
      TextEditingController()
    ];
    // Ensure these are instance variables in your stateful widget class
    String? _priceChoice = 'Free';
    TextEditingController _priceController = TextEditingController();
    TextEditingController addTitle = TextEditingController();
    TextEditingController addDesc = TextEditingController();
    TextEditingController addPrice = TextEditingController(text: 'Free');
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
        print('No file selected.');
      }
      setState(() {}); // Update the UI after file selection and upload
    }

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
                color: const Color(0xfff0ebf8),
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
                                textStyle: TextStyle(
                                    color: Color(0xffDD3409), fontSize: 14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'Document Title',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: Color(0xff1B2533), fontSize: 14),
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
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(42)
                            ],
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
                                textStyle: TextStyle(
                                    color: Color(0xffDD3409), fontSize: 14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'Description',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: Color(0xff1B2533), fontSize: 14),
                                  fontWeight: FontWeight.w600),
                            ),
                          ])),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(bottom: 24, right: 16),
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
                              text: 'Fee',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: Color(0xff1B2533), fontSize: 14),
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: ' (optional)',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: Color(0xff1B2533), fontSize: 14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ])),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(right: 16, bottom: 24),
                            child: RequiredTextField(
                              helperText:
                                  'Empty field indicates that the document fee is free',
                              isRequired: true,
                              textController: addPrice,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'))
                              ],
                              textInputType: TextInputType.multiline,
                              maxLines: null,
                              inputValidator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    addPrice.text = 'Free';
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Transform.scale(
                                scale: 0.75,
                                child: Switch(
                                    activeTrackColor: Color(0xff189877),
                                    activeColor: Colors.white,
                                    value: _hasReq,
                                    onChanged: (value) {
                                      setState(() {
                                        _hasReq = value;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                        if (_hasReq)
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Container(
                              height: 350,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0XFF8E99AA))),
                              child: Column(
                                children: [
                                  ListView.builder(
                                      itemCount:
                                          listDocumentRequirements.length,
                                      shrinkWrap:
                                          true, // Added to avoid layout issues
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: 16, right: 16, top: 8),
                                          child: TextFormField(
                                            controller:
                                                listDocumentRequirements[index],
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff1B2533),
                                            )),
                                            decoration: InputDecoration(
                                              prefixText: '${index + 1}. ',
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  borderSide: BorderSide(
                                                      color: Color(0XFF8E99AA),
                                                      width: 1)),
                                              hoverColor: Colors.transparent,
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  borderSide: BorderSide(
                                                      color: Color(0XFF8E99AA),
                                                      width: 1.75)),
                                              suffixIcon: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 16),
                                                child: IconButton(
                                                    onPressed: () {
                                                      if (index == 0) {
                                                        debugPrint(
                                                            'index is less than 0');
                                                        setState(() {
                                                          _hasReq = false;
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
                        SizedBox(
                          height: 24,
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
                                          Center(
                                              child: Text('No Image Selected')),
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
                                // Create new document object
                                String selectedPrice = _priceChoice == 'Free'
                                    ? 'Free'
                                    : _priceController.text;
                                List noRequirements = ["None"];
                                List<String> requirementsValues =
                                    listDocumentRequirements
                                        .map((controller) => controller.text)
                                        .toList();
                                Document newDocument = Document(
                                    title: addTitle.text,
                                    description: addDesc.text,
                                    createdOn: Timestamp.now(),
                                    lastModifiedOn: Timestamp.now(),
                                    price: addPrice.text,
                                    imageUrl: _uploadedImageUrl!,
                                    docRequirements: _hasReq == false
                                        ? noRequirements
                                        : requirementsValues);

                                // Call addDoc and await the result
                                bool success = await _databaseService.addDoc(
                                  newDocument,
                                  Timestamp.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
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
          },
        );
      },
    );
  }

  showViewDialogBox(BuildContext context, Document viewDocument) {
    List<dynamic> viewDocRequirements = List.generate(
        viewDocument.docRequirements.length,
        (index) => "${viewDocument.docRequirements[index]}");
    TextEditingController viewDesc =
        TextEditingController(text: viewDocument.description);
    TextEditingController viewPrice =
        TextEditingController(text: viewDocument.price);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Container(
                color: const Color(0xfff0ebf8),
                height: double.infinity,
                width: MediaQuery.of(context).size.width / 2,
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              viewDocument.title,
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                  color: Color(0xff202124),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: Text(
                          'Created on: ${monthYearFormat.format(viewDocument.createdOn.toDate())}\nLast modified on: ${monthYearFormat.format(viewDocument.lastModifiedOn.toDate())}',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: const Color(0xffdadce0)),
                        ),
                        child: viewDocument.imageUrl != null &&
                                viewDocument.imageUrl!.isNotEmpty
                            ? Image.network(
                                viewDocument.imageUrl!,
                                fit: BoxFit.contain,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) {
                                    return child;
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(child: Icon(Icons.image));
                                },
                              )
                            : const Center(
                                child: Text(
                                  'No image available',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                      ),
                      Text(
                        'Description: ',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                      ),
                      Text(
                        viewDocument.description,
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: 'Fee: ',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
                        TextSpan(
                          text: viewDocument.price,
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal)),
                        )
                      ])),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Requirements:',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: viewDocRequirements.length,
                          itemBuilder: (BuildContext context, index) {
                            return ListTile(
                              title: viewDocument.docRequirements[index] ==
                                      'None'
                                  ? Text(
                                      'None',
                                      style: GoogleFonts.inter(
                                          textStyle: TextStyle(fontSize: 12)),
                                    )
                                  : Text(
                                      '${index + 1}. ${viewDocRequirements[index]}',
                                      style: GoogleFonts.inter(
                                          textStyle: TextStyle(fontSize: 14)),
                                    ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  showUpdateDialogBox(
      BuildContext context, Document updateDocument, String documentId) {
    List<TextEditingController> updateDocReq = List.generate(
        updateDocument.docRequirements.length,
        (index) =>
            TextEditingController(text: updateDocument.docRequirements[index]));

    bool hasReq = updateDocument.docRequirements[0] == 'None' ? false : true;

    String? _priceChoice = updateDocument.price == 'Free' ? 'Free' : 'Custom';
    TextEditingController _priceController = TextEditingController(
        text: updateDocument.price == 'Free' ? '' : updateDocument.price);
    TextEditingController updateTitle =
        TextEditingController(text: updateDocument.title);
    TextEditingController updateDesc =
        TextEditingController(text: updateDocument.description);
    TextEditingController updatePrice =
        TextEditingController(text: updateDocument.price);

    bool isPriceRequired = false;

    Uint8List? _newSelectedFile;
    String? _newUploadedImageUrl = updateDocument.imageUrl;
    void _removeImage(StateSetter setState) {
      _newUploadedImageUrl = null;
      _newSelectedFile = null;
      setState(() {});
    }

    Future<void> _pickAndUploadFile(StateSetter setState) async {
      // Pick a file using file_picker
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        _newSelectedFile = result.files.first.bytes;

        if (_newSelectedFile != null) {
          // Upload the file to Firebase Storage
          try {
            String fileName =
                'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
            final storageRef =
                FirebaseStorage.instance.ref().child('documents/$fileName');
            final uploadTask = storageRef.putData(
                _newSelectedFile!, SettableMetadata(contentType: 'image/jpeg'));
            final snapshot = await uploadTask.whenComplete(() => {});
            _newUploadedImageUrl = await snapshot.ref.getDownloadURL();
            print('Uploaded Image URL: $_newUploadedImageUrl');
          } catch (e) {
            print('Error during file upload: $e');
          }
        }
      } else {
        print('No file selected.');
      }
      setState(() {}); // Update the UI after file selection and upload
    }

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
                color: const Color(0xfff0ebf8),
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
                                'Update Document',
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  color: Color(0xff202124),
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
                        const SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => Dialog(
                                insetPadding: EdgeInsets.all(
                                    10), // Adjust padding as needed
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.8, // 80% of screen height
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent,
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            _newUploadedImageUrl!,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: const Color(0xffdadce0)),
                            ),
                            child: Stack(
                              children: [
                                _newUploadedImageUrl != null &&
                                        _newUploadedImageUrl!.isNotEmpty
                                    ? Image.network(
                                        _newUploadedImageUrl!,
                                        fit: BoxFit.contain,
                                        width: double.infinity,
                                        height: double.infinity,
                                        loadingBuilder:
                                            (context, child, progress) {
                                          if (progress == null) {
                                            return child;
                                          } else {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Center(
                                              child: Icon(Icons.image));
                                        },
                                      )
                                    : InkWell(
                                        onTap: () =>
                                            _pickAndUploadFile(setState),
                                        child: const Center(
                                          child: Icon(
                                            Icons.add_a_photo,
                                            size: 24,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                if (_newUploadedImageUrl != null &&
                                    _newUploadedImageUrl!.isNotEmpty)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: InkWell(
                                      onTap: () => _removeImage(setState),
                                      child: const Icon(
                                        Icons.remove_circle,
                                        color: Color(0XFFDD3409),
                                        size: 24,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'All fields marked with an asterisk (*) are required',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0XFF8E99AA),
                                    fontStyle: FontStyle.italic)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                              text: '*',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: Color(0xffDD3409), fontSize: 14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'Document Title',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: Color(0xff1B2533), fontSize: 14),
                                  fontWeight: FontWeight.w600),
                            ),
                          ])),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16, bottom: 24),
                          child: RequiredTextField(
                            isRequired: true,
                            textController: updateTitle,
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(42)
                            ],
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
                                textStyle: TextStyle(
                                    color: Color(0xffDD3409), fontSize: 14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'Description',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: Color(0xff1B2533), fontSize: 14),
                                  fontWeight: FontWeight.w600),
                            ),
                          ])),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(right: 16, bottom: 24),
                            child: RequiredTextField(
                              isRequired: true,
                              textController: updateDesc,
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
                              text: 'Fee',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: Color(0xff1B2533), fontSize: 14),
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: ' (optional)',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: Color(0xff1B2533), fontSize: 14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ])),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(right: 16, bottom: 24),
                            child: RequiredTextField(
                              helperText:
                                  'Empty field indicates that the document fee is free',
                              isRequired: true,
                              textController: updatePrice,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'))
                              ],
                              textInputType: TextInputType.multiline,
                              maxLines: null,
                              inputValidator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    updatePrice.text = 'Free';
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
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
                                      itemCount: updateDocReq.length,
                                      shrinkWrap:
                                          true, // Added to avoid layout issues
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: 16, right: 16, top: 8),
                                          child: TextFormField(
                                            controller: updateDocReq[index],
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff1B2533),
                                            )),
                                            decoration: InputDecoration(
                                              prefixText: '${index + 1}. ',
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  borderSide: BorderSide(
                                                      color: Color(0XFF8E99AA),
                                                      width: 1)),
                                              hoverColor: Colors.transparent,
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  borderSide: BorderSide(
                                                      color: Color(0XFF8E99AA),
                                                      width: 1.75)),
                                              suffixIcon: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 16),
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
                                                          updateDocReq[index]
                                                              .clear(); // Clear first
                                                          updateDocReq
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
                                              updateDocReq
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
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: InkWell(
                                child: Container(
                                  width: 120,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff017EF3),
                                      borderRadius: BorderRadius.zero),
                                  child: Center(
                                      child: Text('Update',
                                          style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.w600)))),
                                ),
                                onTap: () async {
                                  debugPrint(updateDocReq[0].toString());
                                  List<String> updatedDocReqValue =
                                      List.generate(updateDocReq.length,
                                          (index) => updateDocReq[index].text);
                                  if (_formKey.currentState!.validate()) {
                                    // Create updated document object
                                    Document updatedDocument = Document(
                                        title: updateTitle.text,
                                        description: updateDesc.text,
                                        createdOn: updateDocument.createdOn,
                                        lastModifiedOn: Timestamp.now(),
                                        price: _priceChoice == 'Custom'
                                            ? "₱${_priceController.text}"
                                            : 'Free',
                                        imageUrl: _newUploadedImageUrl ?? "",
                                        docRequirements: hasReq
                                            ? updatedDocReqValue
                                            : noRequirement);

                                    // Call updateDoc and await the result
                                    bool success = await _databaseService
                                        .updateDoc(documentId, updatedDocument);

                                    // Display success or error message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(success
                                            ? 'Document updated successfully!'
                                            : 'Failed to update document.'),
                                        backgroundColor:
                                            success ? Colors.green : Colors.red,
                                      ),
                                    );

                                    // Close the dialog if the update was successful
                                    if (success) {
                                      Navigator.pop(context);
                                      updateTitle.clear();
                                      updateDesc.clear();
                                      _priceController.clear();
                                    }
                                  }
                                },
                              ),
                            )
                          ],
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

  void confirmToDeleteDialogBox(BuildContext context, String selectedId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning_rounded,
            color: Color(0XFFDD3409),
            size: 48,
          ),
          title: Text(
            'Are you sure?',
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    color: Color(0xff0a0a0a), fontWeight: FontWeight.w600),
                fontSize: 20),
          ),
          content: Text(
            'Do you really want to delete this document?\nThis process cannot be undone.',
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
              child: const Text('Abort'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Close the dialog first

                // Show snackbar with CircularProgressIndicator
                final snackBar = const SnackBar(
                  duration: Duration(
                      days: 365), // Keeps the SnackBar open indefinitely
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 20),
                      Text('Deleting...'),
                    ],
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                try {
                  // Assuming _databaseService.deleteDoc() is a Future method
                  _databaseService.deleteDoc(selectedId);

                  // Deletion successful
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Document deleted successfully'),
                      backgroundColor: Color(0xff189877),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } catch (e) {
                  // Handle deletion error
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error deleting document'),
                      backgroundColor: Color(0XFFDD3409),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }
}
