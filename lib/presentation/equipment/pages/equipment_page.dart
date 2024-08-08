import 'package:barangay_adittion_hills_app/common/widgets/column_field_text.dart';
import 'package:barangay_adittion_hills_app/common/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

final _formKey = GlobalKey<FormState>();

class EventEquipmentPage extends StatefulWidget {
  const EventEquipmentPage({super.key});

  @override
  State<EventEquipmentPage> createState() => _EventEquipmentPageState();
}

class _EventEquipmentPageState extends State<EventEquipmentPage> {
  final List<TextEditingController> listControllers = [TextEditingController()];
  final List<String> listRequirements = <String>[""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              height: 100,
              child: Align(
                alignment: Alignment.centerLeft,
                child: headText(
                  'Events Equipment',
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 14),
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      )
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffE6E6E6), width: 1.5))),
                        child: const ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: ColumnFieldText(
                                  fieldText: 'Item',
                                ),
                              ),
                              Expanded(
                                child: ColumnFieldText(
                                  fieldText: 'Quantity',
                                ),
                              ),
                              Expanded(
                                child: ColumnFieldText(
                                  fieldText: 'Available',
                                ),
                              ),
                              Expanded(
                                child: ColumnFieldText(
                                  fieldText: 'In Use',
                                ),
                              ),
                              Expanded(
                                child: ColumnFieldText(
                                  fieldText: 'Actions',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 200,
                        width: double.infinity,
                        decoration: const BoxDecoration(),
                        child: ListView.builder(
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.5,
                                          color: Color(0xffE6E6E6))),
                                  // color: (index.isEven)
                                  //     ? Colors.white
                                  //     : Color(0xffFAFAFA),
                                ),
                                child: ListTile(
                                  titleAlignment: ListTileTitleAlignment.center,
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Item
                                      Expanded(
                                        child: Text(
                                          'Chairs',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                color: Color(0xff0a0a0a),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),

                                      // Quantity
                                      Expanded(
                                        child: Text(
                                          'Chairs',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                color: Color(0xff0a0a0a),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),

                                      // Available
                                      Expanded(
                                        child: Text(
                                          'Chairs',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                color: Color(0xff0a0a0a),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),

                                      // In Use
                                      Expanded(
                                        child: Text(
                                          'Chairs',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                color: Color(0xff0a0a0a),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),

                                      // Actions
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          actionButton(
                                              const Icon(
                                                  Icons.visibility_rounded),
                                              () {
                                            viewItem(context);
                                          }, const Color(0xffd1a6ff), 'View'),
                                          actionButton(
                                              const Icon(Icons.edit_rounded),
                                              () {
                                            editItem(context);
                                          }, const Color(0xffa5de97), 'Edit'),
                                          actionButton(
                                              const Icon(Icons.delete_rounded),
                                              () {
                                            deleteItem(context);
                                          }, const Color(0xfffc9583), 'Delete')
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                )),
          ],
        ),
      )),

      // Floating Action Button

      floatingActionButton: Container(
        padding: const EdgeInsets.only(right: 30),
        child: FloatingActionButton(
          onPressed: () {
            addNewItem(context);
          },
          backgroundColor: const Color(0xff73dae3),
          shape: const CircleBorder(),
          tooltip: 'Add Item',
          child: const Icon(
            Icons.add_rounded,
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void addNewItem(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                width: 600,
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Add New Item',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Color(0xff1E1A2A),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500)),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  child: textFieldLabel('Item Name', 12),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Item name cannot be empty!";
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
                                            color: Color(0xff1E1A2A))),
                                    decoration: const InputDecoration(
                                        fillColor: Color(0xffE8E8EA),
                                        filled: true,
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffE8E8EA))),
                                        focusedBorder: InputBorder.none),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  child: textFieldLabel('Description', 12),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Container(
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                            horizontal: 8, vertical: 0),
                                    height: 100,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffE8E8EA),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    child: TextFormField(
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff1E1A2A))),
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none),
                                    ),
                                  ),
                                ),

                                // REQUIREMENTS SECTION

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: textFieldLabel('Requirements', 12),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      itemCount: listControllers.length,
                                      itemBuilder: (context, index) {
                                        if (listControllers.isEmpty) {
                                          return const Text('EMpty.');
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: textFieldLabel(
                                                    'Requirement #${index + 1}',
                                                    12),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xffE8E8EA),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(4),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    // Centering the TextFormField within the container
                                                    child: TextFormField(
                                                      style: GoogleFonts.inter(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color:
                                                              Color(0xff1E1A2A),
                                                        ),
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        suffixIcon: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              listControllers[
                                                                      index]
                                                                  .clear();
                                                              listControllers[
                                                                      index]
                                                                  .dispose();
                                                              listControllers
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                          },
                                                          icon: const Icon(Icons
                                                              .delete_rounded),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                // ADD MORE REQUIREMENT BUTTON

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: Container(
                                      width: double.infinity,
                                      height: 40,
                                      child: TextButton(
                                        style: const ButtonStyle(),
                                        onPressed: () {
                                          setState(() {
                                            listControllers
                                                .add(TextEditingController());
                                          });
                                        },
                                        child:
                                            const Text('Add more requirements'),
                                      )),
                                ),

                                // CANCEL BUTTON

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            listControllers.clear();
                                            Navigator.pop(context);
                                            listControllers
                                                .add(TextEditingController());
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                                color: Color(0xfffb9481),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4))),
                                            child: Text(
                                              'CANCEL',
                                              style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),

                                      // ADD BUTTON

                                      Expanded(
                                        child: InkWell(
                                          child: Container(
                                            height: 40,
                                            decoration: const BoxDecoration(
                                                color: Color(0xff73dae3),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4))),
                                            alignment: Alignment.center,
                                            child: Text('ADD',
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400))),
                                          ),
                                          onTap: () {
                                            _formKey.currentState!.validate();
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  void deleteItem(BuildContext context) {
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
              'Do you really want to delete this Item?\nThis process cannot be undone.',
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
                    // _databaseService.deleteDoc(docsId);
                    Navigator.pop(context);
                  },
                  child: const Text('Delete')),
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        });
  }

  void viewItem(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: SingleChildScrollView(
              child: Container(
                height: 500,
                width: 600,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Item Name:'),
                    Text('Title Name'),
                    Text('Description:'),
                    Text('Description....'),
                    Text('Requirements:')
                  ],
                ),
              ),
            ),
          );
        });
  }

  void editItem(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(4),
            )),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.all(16),
                width: 600,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff0a0a0a))),
                      ),
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textFieldLabel('Item Name', 12),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: const BoxDecoration(
                                  color: Color(0xffE8E8EA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: TextFormField(
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff1E1A2A))),
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: textFieldLabel('Description', 12),
                            ),
                            Container(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 8, vertical: 0),
                              height: 125,
                              decoration: const BoxDecoration(
                                  color: Color(0xffE8E8EA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: TextFormField(
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff1E1A2A))),
                                decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: textFieldLabel('Requirements', 12),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  itemCount: listControllers.length,
                                  itemBuilder: (context, index) {
                                    if (listControllers.isEmpty) {
                                      return const Text('EMpty.');
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: textFieldLabel(
                                                'Requirement #${index + 1}',
                                                12),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              decoration: const BoxDecoration(
                                                color: Color(0xffE8E8EA),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(4),
                                                ),
                                              ),
                                              child: Center(
                                                // Centering the TextFormField within the container
                                                child: TextFormField(
                                                  style: GoogleFonts.inter(
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Color(0xff1E1A2A),
                                                    ),
                                                  ),
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    suffixIcon: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          listControllers[index]
                                                              .clear();
                                                          listControllers[index]
                                                              .dispose();
                                                          listControllers
                                                              .removeAt(index);
                                                        });
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete_rounded),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            // ADD MORE REQUIREMENT BUTTON

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  child: TextButton(
                                    style: const ButtonStyle(),
                                    onPressed: () {
                                      setState(() {
                                        listControllers
                                            .add(TextEditingController());
                                      });
                                    },
                                    child: const Text('Add more requirements'),
                                  )),
                            ),

                            // CANCEL BUTTON

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        listControllers.clear();
                                        Navigator.pop(context);
                                        listControllers
                                            .add(TextEditingController());
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: Color(0xfffb9481),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        child: Text(
                                          'CANCEL',
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),

                                  // ADD BUTTON

                                  Expanded(
                                    child: InkWell(
                                      child: Container(
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: Color(0xff73dae3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        alignment: Alignment.center,
                                        child: Text('ADD',
                                            style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                      ),
                                      onTap: () {
                                        _formKey.currentState!.validate();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        });
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

List<TextInputFormatter> onlyUnsignedNumbers() {
  final disallowZero = FilteringTextInputFormatter.deny(
    RegExp(r'^0+'),
  );
  return [
    FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),
    TextInputFormatter.withFunction(
        (TextEditingValue oldValue, TextEditingValue newValue) {
      final newValueText = newValue.text;
      if (newValueText.length > 6) {
        return oldValue;
      }
      if (newValueText.length > 1 && newValueText[0].trim() == '0') {
        newValue = disallowZero.formatEditUpdate(oldValue, newValue);
        if (newValue.text.isEmpty) {
          return oldValue;
        }
      }
      if (newValueText.isNotEmpty) {
        return int.tryParse(newValueText) != null ? newValue : oldValue;
      }

      return newValue;
    })
  ];
}

Widget textFieldLabel(String fieldText, double textSize) {
  return Text(
    fieldText,
    style: GoogleFonts.poppins(
        textStyle: TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.w500,
            color: const Color(0xff1E1A2A))),
  );
}
