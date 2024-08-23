// ignore_for_file: sized_box_for_whitespace

import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/common/widgets/column_field_text.dart';
import 'package:barangay_adittion_hills_app/common/widgets/common_widgets.dart';
import 'package:barangay_adittion_hills_app/common/widgets/textfield_validator/textfield_validators.dart';
import 'package:barangay_adittion_hills_app/models/equipment/new_equipment.dart';
import 'package:barangay_adittion_hills_app/presentation/documents/widgets/required_textfield.dart';
import 'package:barangay_adittion_hills_app/presentation/equipment/pages/pricing_table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final _formKey = GlobalKey<FormState>();

class EventEquipmentPage extends StatefulWidget {
  const EventEquipmentPage({super.key});

  @override
  State<EventEquipmentPage> createState() => _EventEquipmentPageState();
}

class _EventEquipmentPageState extends State<EventEquipmentPage> {
  TextEditingController searchEquipment = TextEditingController();
  String searchQuery = '';
  final List<TextEditingController> listControllers = [TextEditingController()];
  final List<String> listRequirements = <String>[""];
  Color reqBorder = Color(0xfffffff);
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    searchEquipment.addListener(() {
      setState(() {
        searchQuery = searchEquipment.text.toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0ebf8),

      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 8),
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                    headText('Event Equipment'),
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
                                controller: searchEquipment,
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
                                  hintText:
                                      'Search event equipment by item name',
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
                        Expanded(
                            child: ColumnFieldText(fieldText: 'Item Name')),
                        Expanded(child: ColumnFieldText(fieldText: 'Quantity')),
                        Expanded(
                            child: ColumnFieldText(fieldText: 'Available')),
                        Expanded(child: ColumnFieldText(fieldText: 'In Use')),
                        Expanded(child: ColumnFieldText(fieldText: 'Actions')),
                      ],
                    ),
                  )),
              SizedBox(
                  height: 300,
                  child: StreamBuilder(
                      stream: _databaseService.getItems(),
                      builder: (context, snapshot) {
                        List equipment = snapshot.data?.docs ?? [];

                        // Filter the documents by the search query
                        List filteredEquipments = equipment.where((doc) {
                          String title = doc.data().itemName.toLowerCase();
                          return title.contains(searchQuery);
                        }).toList();

                        if (equipment.isEmpty) {
                          return const Center(
                            child: Text('Empty'),
                          );
                        }
                        if (filteredEquipments.isEmpty) {
                          return const Center(
                            child: Text('No documents found'),
                          );
                        }

                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: equipment.length,
                            itemBuilder: (BuildContext context, int index) {
                              NewEquipment newEquipment =
                                  equipment[index].data();
                              String equipmentId = equipment[index].id;

                              return Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 1, color: Color(0xffE6E6E6)),
                                        left: BorderSide(
                                            width: 1, color: Color(0xffE6E6E6)),
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Color(0xffE6E6E6)))),
                                child: ListTile(
                                  onTap: () => viewItem(context, newEquipment),
                                  titleAlignment: ListTileTitleAlignment.center,
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Item
                                      Expanded(
                                        child: Text(
                                          newEquipment.itemName,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
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
                                          newEquipment.itemQuantity.toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
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
                                          '0',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
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
                                          '0',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
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
                                              const Icon(Icons.edit_rounded),
                                              () {
                                            // EDIT BUTTON

                                            editItem(context, equipmentId,
                                                newEquipment);
                                          }, const Color(0xff189877), 'Edit'),
                                          actionButton(
                                              const Icon(Icons.delete_rounded),
                                              () {
                                            // DELETE BUTTON

                                            deleteItem(context, equipmentId);
                                          }, const Color(0XFFDD3409), 'Delete')
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            });
                      })),
            ],
          ),
        ),
      ),

      // Floating Action Button

      floatingActionButton: Container(
        padding: const EdgeInsets.only(right: 32, bottom: 32),
        child: FloatingActionButton(
          onPressed: () {
            addNewItem(context);
          },
          backgroundColor: const Color(0xff6B3CEB),
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
    final List hasNoRequirements = ["None"];
    final Map<String, dynamic> hasNoPricingTable = {};

    Map<String, List<TextEditingController>> inputControllers = {
      'listSetName': [TextEditingController()],
      'listSetQuantity': [TextEditingController()],
      'listSetPrice': [TextEditingController()],
      'listRules': [TextEditingController()],
    };

    List<TextEditingController> listSetName = [TextEditingController()];
    List<TextEditingController> listSetQuantity = [TextEditingController()];
    List<TextEditingController> listSetPrice = [TextEditingController()];
    List<TextEditingController> listRules = [TextEditingController()];
    TextEditingController addItemName = TextEditingController();
    TextEditingController addItemDescription = TextEditingController();
    TextEditingController addQuantity = TextEditingController();
    List<TextEditingController> addItemRequirements = [TextEditingController()];

    bool hasPricingTable = false;
    bool hasReq = false;
    bool hasRules = false;

    void disposeControllers() {
      addItemName.dispose();
      addItemDescription.dispose();
      addQuantity.dispose();
      for (var controller in addItemRequirements) {
        controller.dispose();
      }
      for (var controller in listSetName) {
        controller.dispose();
      }
      for (var controller in listSetQuantity) {
        controller.dispose();
      }
      for (var controller in listSetPrice) {
        controller.dispose();
      }
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
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
                            horizontal: 16, vertical: 24),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Add New Item',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                color: Color(0xff1B2533),
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, bottom: 16, left: 16),
                                child: Text(
                                  'Note: All fields marked with an asterisk (*) are required',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8, left: 16),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: '*',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: Color(0xffDD3409),
                                          fontSize: 14),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Item Name',
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            color: Color(0xff1B2533),
                                            fontSize: 14),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ])),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 24),
                                child: RequiredTextField(
                                  hintText: 'Enter item name',
                                  textController: addItemName,
                                  maxLines: null,
                                  isRequired: true,
                                  inputFormatter: [
                                    LengthLimitingTextInputFormatter(42)
                                  ],
                                  inputValidator: (value) {
                                    if (value!.isEmpty) {
                                      return "Item name is required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8, left: 16),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: '*',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: Color(0xffDD3409),
                                          fontSize: 14),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Item Description',
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            color: Color(0xff1B2533),
                                            fontSize: 14),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ])),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 24),
                                child: RequiredTextField(
                                  textController: addItemDescription,
                                  maxLines: null,
                                  isRequired: true,
                                  inputValidator: (value) {
                                    if (value!.isEmpty) {
                                      return "Item description is required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8, left: 16),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: '*',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: Color(0xffDD3409),
                                          fontSize: 14),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Item Quantity',
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            color: Color(0xff1B2533),
                                            fontSize: 14),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ])),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 16, left: 16, bottom: 16),
                                child: RequiredTextField(
                                  textController: addQuantity,
                                  isRequired: true,
                                  inputFormatter: onlyUnsignedNumbers(4),
                                  inputValidator: (value) {
                                    if (value!.isEmpty) {
                                      return "Item quantity is required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, bottom: 16, left: 16),
                                child: Text(
                                  'Note: Leaving the switches below turned off will set the value to (None)',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  'Pricing Table',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                trailing: Transform.scale(
                                  scale: 0.75,
                                  child: Switch(
                                      activeTrackColor: Colors.green,
                                      activeColor: Colors.white,
                                      value: hasPricingTable,
                                      onChanged: (value) {
                                        setState(() {
                                          hasPricingTable = value;
                                        });
                                      }),
                                ),
                              ),
                              if (hasPricingTable)
                                Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                width: 100,
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  'Set',
                                                  style: GoogleFonts.inter(
                                                      textStyle: TextStyle(
                                                          fontSize: 14)),
                                                )),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                                width: 100,
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  'Quantity',
                                                  style: GoogleFonts.inter(
                                                      textStyle: TextStyle(
                                                          fontSize: 14)),
                                                )),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                                width: 100,
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  'Price',
                                                  style: GoogleFonts.inter(
                                                      textStyle: TextStyle(
                                                          fontSize: 14)),
                                                )),
                                            Container(
                                              width: 100,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'Action',
                                                style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                        fontSize: 14)),
                                              ),
                                            )
                                          ],
                                        )),
                                    SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                        itemCount: listSetPrice.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                    width: 100,
                                                    child: TextFormField(
                                                      style: GoogleFonts.inter(
                                                          textStyle: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                      controller:
                                                          listSetName[index],
                                                      decoration:
                                                          InputDecoration(
                                                              fillColor:
                                                                  Colors.white,
                                                              filled: true,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none),
                                                    )),
                                                SizedBox(width: 8),
                                                Container(
                                                    width: 100,
                                                    child: TextFormField(
                                                      style: GoogleFonts.inter(
                                                          textStyle: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                      inputFormatters:
                                                          onlyUnsignedNumbers(
                                                              4),
                                                      controller:
                                                          listSetQuantity[
                                                              index],
                                                      decoration:
                                                          InputDecoration(
                                                              fillColor:
                                                                  Colors.white,
                                                              filled: true,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none),
                                                    )),
                                                SizedBox(width: 8),
                                                Container(
                                                    width: 100,
                                                    child: TextFormField(
                                                      inputFormatters:
                                                          onlyUnsignedNumbers(
                                                              4),
                                                      style: GoogleFonts.inter(
                                                          textStyle: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                      controller:
                                                          listSetPrice[index],
                                                      decoration: InputDecoration(
                                                          prefixText: '₱ ',
                                                          prefixStyle: GoogleFonts.inter(
                                                              textStyle: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
                                                          fillColor:
                                                              Colors.white,
                                                          filled: true,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none),
                                                    )),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Container(
                                                  width: 100,
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              inputControllers[
                                                                      'listSetName']
                                                                  ?.add(
                                                                      TextEditingController());
                                                              listSetName.add(
                                                                  TextEditingController());
                                                              listSetQuantity.add(
                                                                  TextEditingController());
                                                              listSetPrice.add(
                                                                  TextEditingController());
                                                            });
                                                          },
                                                          icon: Icon(Icons
                                                              .add_circle)),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            if (index == 0) {
                                                              setState(() {
                                                                hasPricingTable =
                                                                    false;
                                                              });
                                                            } else if (index >
                                                                0) {
                                                              setState(() {
                                                                listSetName[
                                                                        index]
                                                                    .clear();
                                                                listSetName[
                                                                        index]
                                                                    .dispose();
                                                                listSetQuantity[
                                                                        index]
                                                                    .clear();
                                                                listSetQuantity[
                                                                        index]
                                                                    .dispose();
                                                                listSetPrice[
                                                                        index]
                                                                    .clear();

                                                                listSetPrice[
                                                                        index]
                                                                    .dispose();
                                                                listSetName
                                                                    .removeAt(
                                                                        index);
                                                                listSetQuantity
                                                                    .removeAt(
                                                                        index);
                                                                listSetPrice
                                                                    .removeAt(
                                                                        index);
                                                              });
                                                            }
                                                          },
                                                          icon: Icon(Icons
                                                              .remove_circle)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ListTile(
                                trailing: Transform.scale(
                                  scale: 0.75,
                                  child: Switch(
                                    activeTrackColor: Colors.green,
                                    activeColor: Colors.white,
                                    value: hasReq,
                                    onChanged: (value) {
                                      setState(() {
                                        hasReq = value;
                                      });
                                    },
                                  ),
                                ),
                                title: Text(
                                  'Requirements',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              if (hasReq)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 4),
                                  child: Container(
                                    padding: const EdgeInsetsDirectional.only(
                                        top: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Color(0XFF8E99AA)),
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    height: 200,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                addItemRequirements.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0xfffafafa),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                        ),
                                                        child: Center(
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "Empty";
                                                              }
                                                              return null;
                                                            },
                                                            controller:
                                                                addItemRequirements[
                                                                    index],
                                                            style: GoogleFonts
                                                                .inter(
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Color(
                                                                    0xff1B2533),
                                                              ),
                                                            ),
                                                            decoration:
                                                                InputDecoration(
                                                              prefixStyle: GoogleFonts.inter(
                                                                  textStyle:
                                                                      TextStyle(
                                                                          fontSize:
                                                                              10)),
                                                              prefixText:
                                                                  '${index + 1}. ',
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .zero,
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0XFF8E99AA),
                                                                      width:
                                                                          1)),
                                                              errorBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .zero,
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0xffE45D3A),
                                                                      width:
                                                                          1)),
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .zero,
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0XFF8E99AA),
                                                                      width:
                                                                          1.75)),
                                                              suffixIcon:
                                                                  IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if (index ==
                                                                        0) {
                                                                      setState(
                                                                          () {
                                                                        hasReq =
                                                                            false;
                                                                      });
                                                                    } else if (index >
                                                                        0) {
                                                                      addItemRequirements[
                                                                              index]
                                                                          .clear();
                                                                      addItemRequirements[
                                                                              index]
                                                                          .dispose();
                                                                      addItemRequirements
                                                                          .removeAt(
                                                                              index);
                                                                    }
                                                                  });
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .delete_rounded,
                                                                  color: Color(
                                                                      0xffE45D3A),
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
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 16),
                                            child: Container(
                                              width: double.infinity,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          Color(0XFF8E99AA))),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    addItemRequirements.add(
                                                        TextEditingController());
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.add_circle_rounded,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      'Add more requirement',
                                                      style: GoogleFonts.inter(
                                                          textStyle: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ListTile(
                                trailing: Transform.scale(
                                  scale: 0.75,
                                  child: Switch(
                                    activeTrackColor: Colors.green,
                                    activeColor: Colors.white,
                                    value: hasRules,
                                    onChanged: (value) {
                                      setState(() {
                                        hasRules = value;
                                      });
                                    },
                                  ),
                                ),
                                title: Text(
                                  'Rules',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              if (hasRules)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 4),
                                  child: Container(
                                    padding: const EdgeInsetsDirectional.only(
                                        top: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Color(0XFF8E99AA)),
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    height: 200,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: listRules.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                        ),
                                                        child: Center(
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return ".";
                                                              }
                                                              return null;
                                                            },
                                                            controller:
                                                                listRules[
                                                                    index],
                                                            style: GoogleFonts
                                                                .inter(
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Color(
                                                                    0xff1B2533),
                                                              ),
                                                            ),
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      left: 16),
                                                              prefixStyle: GoogleFonts.inter(
                                                                  textStyle:
                                                                      TextStyle(
                                                                          fontSize:
                                                                              10)),
                                                              prefixText:
                                                                  '${index + 1}. ',
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .zero,
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0XFF8E99AA),
                                                                      width:
                                                                          1)),
                                                              errorBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .zero,
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0xffE45D3A),
                                                                      width:
                                                                          1)),
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .zero,
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0XFF8E99AA),
                                                                      width:
                                                                          1.75)),
                                                              suffixIcon:
                                                                  IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if (index ==
                                                                        0) {
                                                                      setState(
                                                                          () {
                                                                        hasRules =
                                                                            false;
                                                                      });
                                                                    } else if (index >
                                                                        0) {
                                                                      listRules[
                                                                              index]
                                                                          .clear();
                                                                      listRules[
                                                                              index]
                                                                          .dispose();
                                                                      listRules
                                                                          .removeAt(
                                                                              index);
                                                                    }
                                                                  });
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .delete_rounded,
                                                                  color: Color(
                                                                      0xffE45D3A),
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
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 16),
                                            child: Container(
                                              width: double.infinity,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          Color(0XFF8E99AA))),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    listRules.add(
                                                        TextEditingController());
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.add_circle_rounded,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      'Add more rules',
                                                      style: GoogleFonts.inter(
                                                          textStyle: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                  ],
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          disposeControllers();
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                            color: Color(0xffDD3409),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                          ),
                                          child: Text(
                                            'CANCEL',
                                            style: GoogleFonts.inter(
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
                                            color: Color(0xff017EF3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'ADD',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Map<String, dynamic>
                                              generatePricingTable(
                                                  List<TextEditingController>
                                                      listSetName,
                                                  List<TextEditingController>
                                                      listSetQuantity,
                                                  List<TextEditingController>
                                                      listSetPrice) {
                                            Map<String, dynamic> pricingTable =
                                                {};
                                            for (int i = 0;
                                                i < listSetName.length;
                                                i++) {
                                              if (i < listSetQuantity.length &&
                                                  i < listSetPrice.length) {
                                                String name =
                                                    listSetName[i].text;
                                                String quantity =
                                                    listSetQuantity[i].text;
                                                String price =
                                                    listSetPrice[i].text;

                                                int quantityInt =
                                                    int.tryParse(quantity) ?? 0;
                                                double priceDouble =
                                                    double.tryParse(price) ??
                                                        0.0;

                                                // Populate the map
                                                pricingTable[name] = {
                                                  'quantity': quantityInt,
                                                  'price': priceDouble,
                                                };
                                              }
                                            }

                                            return pricingTable;
                                          }

                                          Map<String, dynamic> pricingTable =
                                              generatePricingTable(
                                                  listSetName,
                                                  listSetQuantity,
                                                  listSetPrice);

                                          if (_formKey.currentState!
                                              .validate()) {
                                            List<String> listControllerValue =
                                                addItemRequirements
                                                    .map((controller) =>
                                                        controller.text)
                                                    .toList();

                                            NewEquipment addNewEquipment =
                                                NewEquipment(
                                              itemName: addItemName.text,
                                              itemDescription:
                                                  addItemDescription.text,
                                              itemQuantity:
                                                  int.parse(addQuantity.text),
                                              itemRequirements: hasReq
                                                  ? listControllerValue
                                                  : hasNoRequirements,
                                              createdOn: Timestamp.now(),
                                              lastUpdatedOn: Timestamp.now(),
                                              pricingTable: hasPricingTable
                                                  ? pricingTable
                                                  : hasNoPricingTable,
                                            );

                                            _databaseService
                                                .addItem(addNewEquipment);

                                            // disposeControllers();
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
      },
    );
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
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      color: Color(0xff0a0a0a), fontWeight: FontWeight.w600),
                  fontSize: 20),
            ),
            content: Text(
              'Do you really want to delete this Item?\nThis process cannot be undone.',
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
    final DateFormat monthYearFormat =
        DateFormat('EEEE, MMMM d, yyyy \'at\' h:mm a');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Container(
              color: const Color(0xfff0ebf8),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              height: double.infinity,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          newEquipment.itemName,
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
                      'Created on: ${monthYearFormat.format(newEquipment.createdOn.toDate())}\nLast modified on: ${monthYearFormat.format(newEquipment.lastUpdatedOn.toDate())}',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 12,
                        ),
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
                    newEquipment.itemDescription,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Quantity: ',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                  Text(
                    newEquipment.itemQuantity.toString(),
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Requirements: ',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewRequirements.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: newEquipment.itemRequirements[index] == 'None'
                            ? Text(
                                'None',
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(fontSize: 12)),
                              )
                            : Text(
                                '${index + 1}. ${viewRequirements[index]}',
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(fontSize: 14)),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void editItem(
      BuildContext context, String equipmentId, NewEquipment newEquip) {
    bool hasPricingTable = newEquip.pricingTable.isEmpty ? false : true;
    List sample = newEquip.itemRequirements;

    List<TextEditingController> updateListSetPrice = newEquip
        .pricingTable.entries
        .map((entry) =>
            TextEditingController(text: entry.value['price']?.toString() ?? ''))
        .toList();

    List<TextEditingController> updateListSetQuantity = newEquip
        .pricingTable.entries
        .map((entry) => TextEditingController(
            text: entry.value['quantity']?.toString() ?? ''))
        .toList();
    List<TextEditingController> updateListSetName = newEquip
        .pricingTable.entries
        .map((entry) => TextEditingController(text: entry.key.toString()))
        .toList();

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
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                color: Color(0xff1B2533),
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
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
                                    color: Color(0xff1B2533),
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
                                    color: Color(0xff1B2533),
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
                                    color: Color(0xff1B2533),
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
                            ListTile(
                              title: Text(
                                'Pricing Table',
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              trailing: Transform.scale(
                                scale: 0.75,
                                child: Switch(
                                    activeTrackColor: Colors.green,
                                    activeColor: Colors.white,
                                    value: hasPricingTable,
                                    onChanged: (value) {
                                      setState(() {
                                        hasPricingTable = value;
                                        debugPrint(
                                            'Has Pricing Table: $hasPricingTable');
                                        if (!hasPricingTable) {
                                          updateListSetName.clear();
                                          updateListSetQuantity.clear();
                                          updateListSetPrice.clear();
                                        } else {
                                          updateListSetName
                                              .add(TextEditingController());
                                          updateListSetQuantity
                                              .add(TextEditingController());
                                          updateListSetPrice
                                              .add(TextEditingController());
                                        }
                                      });
                                    }),
                              ),
                            ),
                            if (hasPricingTable)
                              Column(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: 100,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'Set',
                                                style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                        fontSize: 14)),
                                              )),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                              width: 100,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'Quantity',
                                                style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                        fontSize: 14)),
                                              )),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                              width: 100,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'Price',
                                                style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                        fontSize: 14)),
                                              )),
                                          Container(
                                            width: 100,
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              'Action',
                                              style: GoogleFonts.inter(
                                                  textStyle:
                                                      TextStyle(fontSize: 14)),
                                            ),
                                          )
                                        ],
                                      )),
                                  SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount: updateListSetName.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  width: 100,
                                                  child: TextFormField(
                                                    controller:
                                                        updateListSetName[
                                                            index],
                                                    decoration: InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none),
                                                  )),
                                              SizedBox(width: 8),
                                              Container(
                                                  width: 100,
                                                  child: TextFormField(
                                                    controller:
                                                        updateListSetQuantity[
                                                            index],
                                                    decoration: InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none),
                                                  )),
                                              SizedBox(width: 8),
                                              Container(
                                                  width: 100,
                                                  child: TextFormField(
                                                    controller:
                                                        updateListSetPrice[
                                                            index],
                                                    decoration: InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none),
                                                  )),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                width: 100,
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          // setState(() {
                                                          //   listSetName.add(
                                                          //       TextEditingController());
                                                          //   listSetQuantity.add(
                                                          //       TextEditingController());
                                                          //   listSetPrice.add(
                                                          //       TextEditingController());
                                                          // });
                                                        },
                                                        icon: Icon(
                                                            Icons.add_circle)),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          if (index == 0) {
                                                            setState(() {
                                                              hasPricingTable =
                                                                  false;
                                                            });
                                                          } else if (index >
                                                              0) {
                                                            setState(() {
                                                              // listSetName[
                                                              //         index]
                                                              //     .clear();
                                                              // listSetQuantity[
                                                              //         index]
                                                              //     .clear();
                                                              // listSetPrice[
                                                              //         index]
                                                              //     .clear();
                                                              // listSetName[
                                                              //         index]
                                                              //     .dispose();
                                                              // listSetQuantity[
                                                              //         index]
                                                              //     .dispose();
                                                              // listSetPrice[
                                                              //         index]
                                                              //     .dispose();
                                                              // listSetName
                                                              //     .removeAt(
                                                              //         index);
                                                              // listSetQuantity
                                                              //     .removeAt(
                                                              //         index);
                                                              // listSetPrice
                                                              //     .removeAt(
                                                              //         index);
                                                            });
                                                          }
                                                        },
                                                        icon: Icon(Icons
                                                            .remove_circle)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
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
                                                      color: Color(0xff1B2533),
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
                                          style: GoogleFonts.inter(
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
                                            style: GoogleFonts.inter(
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
    style: GoogleFonts.inter(
        textStyle: TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.w600,
            color: const Color(0xff1B2533))),
  );
}
