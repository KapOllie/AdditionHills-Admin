import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/common/widgets/column_field_text.dart';
import 'package:barangay_adittion_hills_app/common/widgets/field_label/text_field.dart';
import 'package:barangay_adittion_hills_app/models/announcements/announcement.dart';
import 'package:barangay_adittion_hills_app/presentation/documents/widgets/required_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AnnouncementsPage extends StatefulWidget {
  final String email;
  const AnnouncementsPage({super.key, required this.email});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  final _formKey = GlobalKey<FormState>();
  String updatedId = '';
  late AnnouncementModel updatedModel;
  DatabaseService _databaseService = DatabaseService();
  TextEditingController newTitle = TextEditingController();
  TextEditingController newContent = TextEditingController();
  bool toEdit = false;
  FieldLabel announcementText = FieldLabel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                color: Colors.grey.shade300, width: 1))),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              announcementText.headText(!toEdit
                                  ? 'New Announcement'
                                  : 'Edit Announcement'),
                              if (toEdit)
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        newTitle.clear();
                                        newContent.clear();
                                        toEdit = !toEdit;
                                      });
                                    },
                                    icon: Icon(Icons.cancel))
                            ],
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Note: All fields marked with an asterisk (*) are required',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                              fontSize: 12,
                              color: Color(0XFF8E99AA),
                            )),
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: '*',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: Color(0xffDD3409), fontSize: 14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'Announcement Title',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: Color(0xff1B2533), fontSize: 14),
                                  fontWeight: FontWeight.w600),
                            ),
                          ])),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: RequiredTextField(
                              hintText: 'Enter an announcement title',
                              isRequired: true,
                              textController: newTitle,
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
                          SizedBox(
                            height: 32,
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: '*',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: Color(0xffDD3409), fontSize: 14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'Content',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: Color(0xff1B2533), fontSize: 14),
                                  fontWeight: FontWeight.w600),
                            ),
                          ])),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: RequiredTextField(
                              hintText: 'Describe your announcement',
                              isRequired: true,
                              textController: newContent,
                              textInputType: TextInputType.multiline,
                              maxLines: null,
                              inputValidator: (value) {
                                if (value!.isEmpty) {
                                  return "Content is required";
                                }
                                return null;
                              },
                            ),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: TextButton(
                                        onPressed: !toEdit
                                            ? () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  AnnouncementModel model =
                                                      AnnouncementModel(
                                                    title: newTitle.text,
                                                    content: newContent.text,
                                                    publishedDate:
                                                        Timestamp.now(),
                                                    publishedBy: widget.email,
                                                    lastModifiedDate:
                                                        Timestamp.now(),
                                                    lastModifiedBy:
                                                        widget.email,
                                                  );

                                                  bool success =
                                                      await _databaseService
                                                          .addAnnouncement(
                                                              model);

                                                  if (success) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              'Announcement added successfully!')),
                                                    );
                                                    newTitle.clear();
                                                    newContent.clear();
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              'Failed to add announcement.')),
                                                    );
                                                  }
                                                }
                                              }
                                            : () async {
                                                updatedModel.title =
                                                    newTitle.text;
                                                updatedModel.content =
                                                    newContent.text;
                                                updatedModel.lastModifiedDate =
                                                    Timestamp.now();
                                                updatedModel.lastModifiedBy =
                                                    widget.email;
                                                updateAnnouncement(
                                                    updatedModel, updatedId);
                                              },
                                        child: Center(
                                          child: Text(
                                            !toEdit ? 'Post' : 'Update',
                                            style: GoogleFonts.inter(
                                                textStyle: TextStyle()),
                                          ),
                                        ),
                                      ))
                                ],
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  child: Column(
                children: [
                  Text(
                    'Announcements',
                    style:
                        GoogleFonts.inter(textStyle: TextStyle(fontSize: 24)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Color(0xffdadce0), width: 1),
                              right: BorderSide(
                                  color: Color(0xffdadce0), width: 1),
                              bottom: BorderSide(
                                  color: Color(0xffdadce0), width: 1),
                              top: BorderSide(
                                  color: Color(0xffdadce0), width: 1)),
                          borderRadius: BorderRadius.zero,
                          color: Colors.white,
                        ),
                        child: const ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                  child: ColumnFieldText(fieldText: 'Title')),
                              Expanded(
                                  child: ColumnFieldText(fieldText: 'Actions')),
                            ],
                          ),
                        )),
                  ),
                  Container(
                    height: 500,
                    child: StreamBuilder(
                        stream: _databaseService.getAnnouncements(),
                        builder: (context, snapshot) {
                          List allAnnouncements = snapshot.data?.docs ?? [];

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData ||
                              snapshot.data?.docs.isEmpty == true) {
                            return const Center(
                                child: Text('No Document available'));
                          }

                          if (allAnnouncements.isEmpty) {
                            return Center(
                              child: Text('Empty'),
                            );
                          }

                          return ListView.builder(
                              itemCount: allAnnouncements.length,
                              itemBuilder: (BuildContext context, int index) {
                                AnnouncementModel data =
                                    allAnnouncements[index].data();
                                String id = allAnnouncements[index].id;
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                width: 1,
                                                color: Color(0xffE6E6E6)),
                                            left: BorderSide(
                                                width: 1,
                                                color: Color(0xffE6E6E6)),
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Color(0xffE6E6E6)))),
                                    child: ListTile(
                                      // onTap: () => _dialogBox.showViewDialogBox(
                                      //     context, document),
                                      shape: const Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Color(0xffE6E6E6))),
                                      title: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: GestureDetector(
                                              // onTap: () => _dialogBox.showViewDialogBox,
                                              child: Center(
                                                  child: Text(
                                                textAlign: TextAlign.center,
                                                data.title,
                                                style: GoogleFonts.inter(
                                                    textStyle: const TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff202124))),
                                              )),
                                            )),
                                            Expanded(
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      tooltip: 'Update',
                                                      onPressed: () {
                                                        try {
                                                          setState(() {
                                                            updatedModel = data;
                                                            updatedId = id;
                                                            newTitle.text =
                                                                data.title;
                                                            newContent.text =
                                                                data.content;
                                                            toEdit = true;
                                                          });
                                                        } catch (e) {}
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .mode_edit_outline_rounded,
                                                        color:
                                                            Color(0xffFFC550),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10),
                                                      child: VerticalDivider(
                                                        thickness: 0.5,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      tooltip: 'Delete',
                                                      onPressed: () async {
                                                        confirmDeleteAnnouncement(
                                                            id);
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color:
                                                            Color(0xffDD3409),
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
                                  ),
                                );
                              });
                        }),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void updateAnnouncement(AnnouncementModel model, String id) async {
    try {
      bool success = await _databaseService.updateAnnouncement(id, model);
      if (success) {
        // Show success Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Announcement updated successfully!')),
        );
        setState(() {
          newTitle.clear();
          newContent.clear();
          toEdit = false;
        });
      } else {
        // Show error Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update announcement.')),
        );
      }
    } catch (e) {
      // Handle exception if needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('An error occurred while updating the announcement.')),
      );
    }
  }

  void confirmDeleteAnnouncement(String id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this announcement?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Abort'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                // Close the dialog
                bool success = await _databaseService.deleteAnnouncement(id);
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Announcement deleted successfully!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete announcement.')),
                  );
                }
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
