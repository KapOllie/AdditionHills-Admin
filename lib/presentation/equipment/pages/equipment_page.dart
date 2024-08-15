import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/common/widgets/column_field_text.dart';
import 'package:barangay_adittion_hills_app/common/widgets/common_widgets.dart';
import 'package:barangay_adittion_hills_app/common/widgets/textfield_validator/textfield_validators.dart';
import 'package:barangay_adittion_hills_app/models/equipment/new_equipment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Color reqBorder = Color(0xfffffff);
  final DatabaseService _databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6E6E6),

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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 400,
                      width: double.infinity,
                      child: StreamBuilder(
                          stream: _databaseService.getItems(),
                          builder: (context, snapshot) {
                            List equipment = snapshot.data?.docs ?? [];
                            debugPrint(_databaseService.getItems().toString());

                            if (equipment.isEmpty) {
                              return const Center(
                                child: Text('Empty'),
                              );
                            }
                            debugPrint(
                                "item count: ${equipment.length.toString()}");
                            return ListView.builder(
                                itemCount: equipment.length,
                                itemBuilder: (BuildContext context, int index) {
                                  NewEquipment newEquipment =
                                      equipment[index].data();
                                  String equipmentId = equipment[index].id;
                                  debugPrint(equipmentId);

                                  return Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 0.5,
                                              color: Color(0xffE6E6E6))),
                                    ),
                                    child: ListTile(
                                      titleAlignment:
                                          ListTileTitleAlignment.center,
                                      title: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Item
                                          Expanded(
                                            child: Text(
                                              newEquipment.itemName,
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

                                          // Quantity
                                          Expanded(
                                            child: Text(
                                              newEquipment.itemQuantity
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

                                          // Available
                                          Expanded(
                                            child: Text(
                                              '0',
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

                                          // In Use
                                          Expanded(
                                            child: Text(
                                              '0',
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
                                                // VIEW BUTTON

                                                viewItem(context, newEquipment);
                                              }, const Color(0xffd1a6ff),
                                                  'View'),
                                              actionButton(
                                                  const Icon(
                                                      Icons.edit_rounded), () {
                                                // EDIT BUTTON

                                                editItem(context, equipmentId,
                                                    newEquipment);
                                              }, const Color(0xffa5de97),
                                                  'Edit'),
                                              actionButton(
                                                  const Icon(
                                                      Icons.delete_rounded),
                                                  () {
                                                // DELETE BUTTON

                                                deleteItem(
                                                    context, equipmentId);
                                              }, const Color(0xfffc9583),
                                                  'Delete')
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }),
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
    TextEditingController addItemName = TextEditingController();
    TextEditingController addItemDescription = TextEditingController();
    TextEditingController addQuantity = TextEditingController();
    List<TextEditingController> addItemRequirements = [TextEditingController()];

    Color reqBorder = Colors.transparent;
    showDialog(
        barrierDismissible: false,
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
                return Container(
                  width: 600,
                  height: 500,
                  decoration: const BoxDecoration(
                    color: Color(0xffE8E8EA),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Add New Item',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xff1E1A2A),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                  padding: const EdgeInsets.only(
                                      top: 4, left: 8, right: 8, bottom: 24),
                                  child: TextFormField(
                                    controller: addItemName,
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
                                        color: Color(0xff1E1A2A),
                                      ),
                                    ),
                                    decoration: const InputDecoration(
                                      fillColor: Color(0xfFFFFFFF),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffE8E8EA)),
                                      ),
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  child: textFieldLabel('Description', 12),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: TextFormField(
                                    controller: addItemDescription,
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
                                        borderSide: BorderSide(
                                            color: Color(0xffE8E8EA)),
                                      ),
                                      focusedBorder: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Description cannot be empty.";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: textFieldLabel('Quantity', 12),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: TextFormField(
                                    controller: addQuantity,
                                    inputFormatters: onlyUnsignedNumbers(6),
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
                                        borderSide: BorderSide(
                                            color: Color(0xffE8E8EA)),
                                      ),
                                      focusedBorder: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Quantity field cannot be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: textFieldLabel('Requirements', 12),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 4),
                                  child: Container(
                                    padding: const EdgeInsetsDirectional.only(
                                        top: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: reqBorder),
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                    ),
                                    height: 150,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: addItemRequirements.length,
                                      itemBuilder: (context, index) {
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xfffafafa),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                  ),
                                                  child: Center(
                                                    child: TextFormField(
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Add at least 1 requirement.";
                                                        }
                                                        return null;
                                                      },
                                                      controller:
                                                          addItemRequirements[
                                                              index],
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
                                                              addItemRequirements[
                                                                      index]
                                                                  .clear();
                                                              addItemRequirements[
                                                                      index]
                                                                  .dispose();
                                                              addItemRequirements
                                                                  .removeAt(
                                                                      index);
                                                              // Update border color based on listControllers length
                                                              reqBorder =
                                                                  addItemRequirements
                                                                          .isEmpty
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .grey;
                                                            });
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .delete_rounded,
                                                            color: Color(
                                                                0xff8C8B92),
                                                            size: 18,
                                                          ),
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
                                          addItemRequirements
                                              .add(TextEditingController());
                                          debugPrint(addItemRequirements.length
                                              .toString());
                                          // Update border color based on listControllers length
                                          reqBorder =
                                              addItemRequirements.isEmpty
                                                  ? Colors.red
                                                  : Colors.grey;
                                        });
                                      },
                                      child:
                                          const Text('Add more requirements'),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            addItemRequirements.clear();
                                            Navigator.pop(context);
                                            addItemRequirements
                                                .add(TextEditingController());
                                            // Update border color after clearing list
                                            reqBorder =
                                                addItemRequirements.isEmpty
                                                    ? Colors.red
                                                    : Colors.grey;
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: Color(0xfffb9481),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                            ),
                                            child: Text(
                                              'CANCEL',
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: InkWell(
                                          child: Container(
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: Color(0xff73dae3),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'ADD',
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            List listControllerValue =
                                                List.generate(
                                                    addItemRequirements.length,
                                                    (index) => "");
                                            for (var i = 0;
                                                i < addItemRequirements.length;
                                                i++) {
                                              listControllerValue[i] =
                                                  addItemRequirements[i].text;
                                            }

                                            if (_formKey.currentState!
                                                    .validate() &&
                                                listControllerValue.first !=
                                                    "") {
                                              NewEquipment addNewEquipment =
                                                  NewEquipment(
                                                      itemName:
                                                          addItemName.text,
                                                      itemDescription:
                                                          addItemDescription
                                                              .text,
                                                      itemQuantity: int.parse(
                                                          addQuantity.text),
                                                      itemRequirements:
                                                          listControllerValue,
                                                      createdOn:
                                                          Timestamp.now(),
                                                      lastUpdatedOn:
                                                          Timestamp.now());
                                              _databaseService
                                                  .addItem(addNewEquipment);

                                              addItemName.clear();
                                              addItemDescription.clear();
                                              addQuantity.clear();
                                              addItemRequirements.clear();
                                              Navigator.pop(context);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  void deleteItem(BuildContext context, String itemId) {
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
                    _databaseService.deleteItem(itemId);
                    Navigator.pop(context);
                  },
                  child: const Text('Delete')),
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        });
  }

  void viewItem(BuildContext context, NewEquipment newEquipment) {
    List viewRequirements = newEquipment.itemRequirements;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.all(16.0), // Add padding for better UI
                constraints: const BoxConstraints(
                    maxHeight: 500,
                    maxWidth: 600), // Constraints instead of fixed size
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Item Name:'),
                    Text(newEquipment.itemName),
                    const SizedBox(height: 8), // Add spacing between sections
                    const Text('Description:'),
                    Text(newEquipment.itemDescription),
                    const SizedBox(height: 8),
                    const Text('Quantity: '),
                    Text(newEquipment.itemQuantity.toString()),
                    const SizedBox(height: 8),
                    const Text('Requirements:'),
                    Container(
                      height: 150, // Define a height for ListView
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(viewRequirements[index]),
                          );
                        },
                        itemCount: viewRequirements.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void editItem(
      BuildContext context, String equipmentId, NewEquipment newEquip) {
    List sample = newEquip.itemRequirements;
    List<TextEditingController> sample2 =
        List.generate(sample.length, (index) => TextEditingController());
    // debugPrint(sample2.length.toString());
    setState(() {
      for (var i = 0; i < sample.length; i++) {
        sample2[i].text = newEquip.itemRequirements[i];
      }
    });
    TextEditingController editItemName =
        TextEditingController(text: newEquip.itemName);
    TextEditingController editDescription =
        TextEditingController(text: newEquip.itemDescription);
    TextEditingController editQuantity =
        TextEditingController(text: newEquip.itemQuantity.toString());
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
                width: 600,
                decoration: BoxDecoration(
                    color: Color(0xffE8E8EA),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Edit',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color(0xff1E1A2A),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Form(
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
                              padding: const EdgeInsets.only(
                                  top: 4, left: 8, right: 8, bottom: 24),
                              child: TextFormField(
                                controller: editItemName,
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: textFieldLabel('Description', 12),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: TextFormField(
                                controller: editDescription,
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
                                    return "Description cannot be empty.";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: textFieldLabel('Quantity', 12),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: TextFormField(
                                controller: editQuantity,
                                inputFormatters: onlyUnsignedNumbers(6),
                                keyboardType: TextInputType.number,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Quantity field cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: textFieldLabel('Requirements', 12),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4),
                              child: Container(
                                padding: EdgeInsetsDirectional.only(top: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: reqBorder),
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                height: 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: sample2.length,
                                  itemBuilder: (context, index) {
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
                                              decoration: const BoxDecoration(
                                                color: Color(0xfffafafa),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4)),
                                              ),
                                              child: Center(
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Minimun of 1 requirement is required.";
                                                    }
                                                    return null;
                                                  },
                                                  controller: sample2[index],
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
                                                          sample2[index]
                                                              .clear();
                                                          sample2[index]
                                                              .dispose();
                                                          sample2
                                                              .removeAt(index);
                                                          // Update border color based on listControllers length
                                                          reqBorder =
                                                              sample2.isEmpty
                                                                  ? Colors.red
                                                                  : Colors.grey;
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete_rounded,
                                                        color:
                                                            Color(0xff8C8B92),
                                                        size: 18,
                                                      ),
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
                                        sample2.add(TextEditingController());
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
                                        sample2.clear();
                                        Navigator.pop(context);
                                        sample2.add(TextEditingController());
                                        setState(() {
                                          reqBorder = Colors.transparent;
                                        });
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
                                        child: Text('EDIT',
                                            style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                      ),
                                      onTap: () {
                                        _formKey.currentState!.validate();
                                        List sample3 = List.generate(
                                            sample2.length, (index) => "");

                                        for (var i = 0;
                                            i < sample2.length;
                                            i++) {
                                          sample3[i] = sample2[i].text;
                                        }

                                        if (_formKey.currentState!.validate()) {
                                          NewEquipment updatedEquipment =
                                              newEquip.copyWith(
                                                  itemName: editItemName.text,
                                                  itemDescription:
                                                      editDescription.text,
                                                  itemQuantity: int.parse(
                                                      editQuantity.text),
                                                  itemRequirements: sample3,
                                                  lastUpdatedOn:
                                                      Timestamp.now(),
                                                  createdOn:
                                                      newEquip.createdOn);

                                          _databaseService.updateItem(
                                              equipmentId, updatedEquipment);
                                        }
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
