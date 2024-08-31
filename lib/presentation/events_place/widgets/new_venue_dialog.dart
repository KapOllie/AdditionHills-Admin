import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/common/widgets/field_label/text_field.dart';
import 'package:barangay_adittion_hills_app/models/venue/event_venue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/widgets/textfield_validator/textfield_validators.dart';

final _formKey = GlobalKey<FormState>();

newVenueDialogBox(BuildContext context, DatabaseService _databaseService) {
  bool hasFee = false;
  bool hasRequirements = false;
  bool hasScheduleTable = false;
  FieldLabel venueFieldLabel = FieldLabel();
  List<dynamic> hasNoScheduleTable = ['none'];
  final List<TextEditingController> listControllers = [TextEditingController()];
  List<String> days = [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'SUNDAY',
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
  ];
  String selectedDay = 'Sunday';
  final List<TextEditingController> availableDays = [TextEditingController()];

  TimeOfDay timeAvailableFrom = TimeOfDay.now();
  TimeOfDay timeUntil = TimeOfDay.now();
  final List<TextEditingController> timeFromList = [TextEditingController()];
  final List<TextEditingController> timeUntilList = [TextEditingController()];
  final List<String> selectedDaysHourList = [];
  TextEditingController addFeeController = TextEditingController();
  TextEditingController newEventName = TextEditingController();
  TextEditingController newEventAddress = TextEditingController();
  TextEditingController newEventDesc = TextEditingController();
  TextEditingController newEventContact = TextEditingController();

  var numberDialog =
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return Align(
      alignment: Alignment.centerRight,
      child: SafeArea(
        child: Material(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
          child: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width / 2,
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'New Venue',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: venueFieldLabel.noteRequired(),
                    ),
                    venueFieldLabel.requiredFieldLabel('Venue Name'),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 16,
                      ),
                      child: TextFormField(
                        controller: newEventName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Venue name cannot be empty!";
                          }
                          return null;
                        },
                        inputFormatters: [
                          // LengthLimitingTextInputFormatter(42),
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
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE8E8EA)),
                            ),
                            hoverColor: Color(0xffffffff)),
                      ),
                    ),
                    venueFieldLabel.requiredFieldLabel('Venue Address'),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 16,
                      ),
                      child: TextFormField(
                        controller: newEventAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Venue address cannot be empty!";
                          }
                          return null;
                        },
                        inputFormatters: [
                          // LengthLimitingTextInputFormatter(42),
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
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE8E8EA)),
                            ),
                            hoverColor: Color(0xffffffff)),
                      ),
                    ),
                    venueFieldLabel.requiredFieldLabel('Description'),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 16,
                      ),
                      child: TextFormField(
                        controller: newEventDesc,
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
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffE8E8EA)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffE8E8EA)),
                          ),
                          hoverColor: Color(0xffffffff),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Description cannot be empty!";
                          }
                          return null;
                        },
                      ),
                    ),
                    venueFieldLabel.requiredFieldLabel('Contact Number'),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 16,
                      ),
                      child: TextFormField(
                        controller: newEventContact,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          if (!RegExp(r'^\+639\d{9}$|^09\d{9}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid Philippine phone number';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'(\+639[0-9]*|09[0-9]*|\d)'),
                          ),
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
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE8E8EA)),
                            ),
                            hoverColor: Color(0xffffffff)),
                      ),
                    ),
                    Text(
                      'Note: Leaving the switches below turned off will set the value to (None)',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Requirements',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1E1A2A))),
                        ),
                        Transform.scale(
                          scale: 0.75,
                          child: Switch(
                              activeTrackColor: Colors.green,
                              activeColor: Colors.white,
                              value: hasRequirements,
                              onChanged: (value) {
                                setState(() {
                                  hasRequirements = value;
                                });
                              }),
                        ),
                      ],
                    ),
                    if (hasRequirements)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 240,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffE8E8EA)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: listControllers.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: const Color(0xffE8E8EA),
                                            width: 0.75),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4)),
                                      ),
                                      child: ListTile(
                                        leading: Text("${index + 1}."),
                                        title: TextFormField(
                                          controller: listControllers[index],
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff1B2533),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          decoration: const InputDecoration(
                                            hintText: 'Enter a requirement',
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 2),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Empty";
                                            }
                                            return null;
                                          },
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.remove_circle_rounded,
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            if (index == 0) {
                                              setState(() {
                                                hasRequirements = false;
                                              });
                                            } else if (index > 0) {
                                              setState(() {
                                                listControllers[index]
                                                    .dispose();
                                                listControllers.removeAt(index);
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Center(
                                child: InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade600,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                    ),
                                    child: Text(
                                      'Add Requirement',
                                      style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      listControllers
                                          .add(TextEditingController());
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fee',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1E1A2A))),
                        ),
                        Transform.scale(
                          scale: 0.75,
                          child: Switch(
                              activeTrackColor: Colors.green,
                              activeColor: Colors.white,
                              value: hasFee,
                              onChanged: (value) {
                                setState(() {
                                  hasFee = value;
                                });
                              }),
                        ),
                      ],
                    ),
                    if (hasFee)
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 4,
                                bottom: 16,
                              ),
                              child: TextFormField(
                                controller: addFeeController,
                                inputFormatters: onlyUnsignedNumbers(6),
                                cursorColor: const Color(0xff1D1929),
                                style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff1E1A2A),
                                  ),
                                ),
                                decoration: InputDecoration(
                                    hintText: '0.00',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff1E1A2A),
                                    ),
                                    prefixStyle: GoogleFonts.inter(
                                        textStyle: TextStyle(fontSize: 14)),
                                    prefixText: '₱ ',
                                    fillColor: Color(0xfFFFFFFF),
                                    filled: true,
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xffE8E8EA)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xffE8E8EA)),
                                    ),
                                    hoverColor: Color(0xffffffff)),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: SizedBox(
                                width: 14,
                              ))
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Schedule Table',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1E1A2A))),
                        ),
                        Transform.scale(
                          scale: 0.75,
                          child: Switch(
                              activeTrackColor: Colors.green,
                              activeColor: Colors.white,
                              value: hasScheduleTable,
                              onChanged: (value) {
                                setState(() {
                                  hasScheduleTable = value;
                                });
                              }),
                        ),
                      ],
                    ),
                    if (hasScheduleTable)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        width: double.infinity,
                        height: 240,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black12),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(color: Colors.black12),
                                )),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Text(
                                            'Day',
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                              fontSize: 12,
                                            )),
                                          ))),
                                      Expanded(
                                          flex: 2,
                                          child: Center(
                                              child: Text(
                                            'Time',
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                              fontSize: 12,
                                            )),
                                          ))),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: availableDays.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: Text("${index + 1}."),
                                        title: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 4,
                                                  bottom: 16,
                                                ),
                                                child: TextFormField(
                                                  controller:
                                                      availableDays[index],
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Empty";
                                                    } else if (!(days
                                                        .contains(value))) {
                                                      return "Invalid Input";
                                                    }
                                                    return null;
                                                  },
                                                  inputFormatters: [
                                                    // LengthLimitingTextInputFormatter(42),
                                                  ],
                                                  cursorColor:
                                                      const Color(0xff1D1929),
                                                  style: GoogleFonts.inter(
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Color(0xff1E1A2A),
                                                    ),
                                                  ),
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 16),
                                                      fillColor: const Color(
                                                          0xfFFFFFFF),
                                                      filled: true,
                                                      border:
                                                          const OutlineInputBorder(),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xffE8E8EA)),
                                                      ),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xffE8E8EA)),
                                                      ),
                                                      hoverColor: const Color(
                                                          0xffffffff)),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 4,
                                                            bottom: 16,
                                                          ),
                                                          child: TextFormField(
                                                            readOnly: true,
                                                            controller:
                                                                timeFromList[
                                                                    index],
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "Item name cannot be empty!";
                                                              }
                                                              return null;
                                                            },
                                                            cursorColor:
                                                                const Color(
                                                                    0xff1D1929),
                                                            style: GoogleFonts
                                                                .inter(
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Color(
                                                                    0xff1E1A2A),
                                                              ),
                                                            ),
                                                            decoration:
                                                                InputDecoration(
                                                                    contentPadding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            16),
                                                                    suffixIcon:
                                                                        IconButton(
                                                                            onPressed:
                                                                                () async {
                                                                              debugPrint(addFeeController.text);
                                                                              final TimeOfDay? timeOfDay = await showTimePicker(context: context, initialTime: timeAvailableFrom);
                                                                              if (timeOfDay != null) {
                                                                                setState(() {
                                                                                  timeAvailableFrom = timeOfDay;
                                                                                  timeFromList[index].text = "${timeAvailableFrom.format(context)} ";
                                                                                });
                                                                              }
                                                                            },
                                                                            icon: const Icon(Icons
                                                                                .av_timer_rounded)),
                                                                    fillColor: const Color(
                                                                        0xfFFFFFFF),
                                                                    filled:
                                                                        true,
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: Color(0xffE8E8EA)),
                                                                    ),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: Color(0xffE8E8EA)),
                                                                    ),
                                                                    hoverColor:
                                                                        const Color(
                                                                            0xffffffff)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 4,
                                                            bottom: 16,
                                                          ),
                                                          child: TextFormField(
                                                            readOnly: true,
                                                            controller:
                                                                timeUntilList[
                                                                    index],
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "Empty!";
                                                              }
                                                              return null;
                                                            },
                                                            cursorColor:
                                                                const Color(
                                                                    0xff1D1929),
                                                            style: GoogleFonts
                                                                .inter(
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Color(
                                                                    0xff1E1A2A),
                                                              ),
                                                            ),
                                                            decoration:
                                                                InputDecoration(
                                                                    suffixIcon:
                                                                        IconButton(
                                                                            onPressed:
                                                                                () async {
                                                                              final TimeOfDay? timeUntilDay = await showTimePicker(context: context, initialTime: timeAvailableFrom);
                                                                              if (timeUntilDay != null) {
                                                                                setState(() {
                                                                                  timeUntil = timeUntilDay;
                                                                                  timeUntilList[index].text = "${timeUntilDay.format(context)} ";
                                                                                });
                                                                              }
                                                                            },
                                                                            icon: const Icon(Icons
                                                                                .av_timer_rounded)),
                                                                    fillColor:
                                                                        const Color(
                                                                            0xfFFFFFFF),
                                                                    filled:
                                                                        true,
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: Color(0xffE8E8EA)),
                                                                    ),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: Color(0xffE8E8EA)),
                                                                    ),
                                                                    hoverColor:
                                                                        const Color(
                                                                            0xffffffff)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: IconButton(
                                            onPressed: () {
                                              if (index == 0) {
                                                setState(() {
                                                  hasScheduleTable = false;
                                                });
                                              } else if (index > 0) {
                                                setState(() {
                                                  availableDays[index].clear;
                                                  availableDays[index]
                                                      .dispose();
                                                  availableDays.removeAt(index);
                                                  timeFromList[index].clear;
                                                  timeFromList[index].dispose();
                                                  timeFromList.removeAt(index);
                                                  timeUntilList[index].clear;
                                                  timeUntilList[index]
                                                      .dispose();
                                                  timeUntilList.removeAt(index);
                                                });
                                              }
                                            },
                                            icon: Icon(
                                              Icons.remove_circle_rounded,
                                              size: 18,
                                            )),
                                      );
                                    }),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                child: Center(
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade600,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(4))),
                                      child: Text(
                                        'Add more',
                                        style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white)),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        availableDays
                                            .add(TextEditingController());
                                        timeFromList
                                            .add(TextEditingController());
                                        timeUntilList
                                            .add(TextEditingController());

                                        debugPrint(
                                            availableDays.length.toString());
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(color: Colors.red),
                            child: Center(child: Text('Cancel')),
                          ),
                        )),
                        SizedBox(
                          width: 24,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () async {
                            List<String> allEventRequirements = List.generate(
                                listControllers.length,
                                (index) => listControllers[index].text);

                            List<String> allAvailableDays = hasScheduleTable &&
                                    availableDays.isNotEmpty &&
                                    timeFromList.isNotEmpty &&
                                    timeUntilList.isNotEmpty
                                ? List.generate(
                                    availableDays.length,
                                    (index) =>
                                        "${availableDays[index].text.toUpperCase()}: ${timeFromList[index].text} - ${timeUntilList[index].text}")
                                : [];

                            if (_formKey.currentState!.validate()) {
                              EventVenue newEventVenue = EventVenue(
                                venueName: newEventName.text,
                                venueAddress: newEventAddress.text,
                                venueDescription: newEventDesc.text,
                                venueContact: newEventContact.text,
                                venueRequirements: allEventRequirements,
                                venuePrice: addFeeController.text.isEmpty
                                    ? 'Free'
                                    : "₱${addFeeController.text}",
                                venueAvailable: allAvailableDays,
                                createdOn: Timestamp.now(),
                                lastUpdatedOn: Timestamp.now(),
                              );

                              bool success = await _databaseService
                                  .addVenue(newEventVenue);

                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Venue successfully added!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                // Clear the form fields
                                newEventName.clear();
                                newEventAddress.clear();
                                newEventDesc.clear();
                                newEventContact.clear();
                                addFeeController.clear();
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Failed to add venue. Please try again.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please fill in all required fields.'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(color: Colors.blue),
                            child: Center(child: Text('Add')),
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  });

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return numberDialog;
    },
  );
}
