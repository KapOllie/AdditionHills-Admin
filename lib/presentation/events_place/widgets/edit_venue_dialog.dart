import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/common/widgets/field_label/text_field.dart';
import 'package:barangay_adittion_hills_app/models/venue/event_venue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/widgets/textfield_validator/textfield_validators.dart';

final _formKey = GlobalKey<FormState>();
editVenueDialogBox(BuildContext context, DatabaseService databaseService,
    String venueId, EventVenue eventVenue) {
  List<String> daysList = [];
  List<String> timeFromList = [];

  List<String> timeUntilList = [];

  if (eventVenue.venueAvailable.isNotEmpty) {
    List<dynamic> scheduleTable = List.generate(
        eventVenue.venueAvailable.length,
        (index) => eventVenue.venueAvailable[index]);
    for (var i = 0; i < scheduleTable.length; i++) {
      String schedule = scheduleTable[i];

      // Step 1: Split the schedule by ": " to separate the day from the time range
      List<String> parts = schedule.split(': ');
      String day = parts[0];

      // Step 2: Split the time range by " - " to get the start and end times
      List<String> times = parts[1].split(' - ');
      String timeFrom = times[0];
      String timeUntil = times[1];

      // Add the extracted values to the respective lists
      daysList.add(day);
      timeFromList.add(timeFrom);
      timeUntilList.add(timeUntil);
    }
  }

  bool hasRequirements = false;
  bool hasFee = eventVenue.venuePrice.isNotEmpty ? true : false;
  bool hasScheduleTable = eventVenue.venueAvailable.isNotEmpty ? true : false;
  FieldLabel updateVenueText = FieldLabel();
  final List<TextEditingController> listControllers = [TextEditingController()];
  List<String> days = [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'SUNDAY',
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
  ];
  String selectedDay = 'Sunday';
  final List<TextEditingController> availableDays =
      eventVenue.venueAvailable.isNotEmpty
          ? List.generate(daysList.length,
              (index) => TextEditingController(text: daysList[index]))
          : [TextEditingController()];

  TimeOfDay timeAvailableFrom = TimeOfDay.now();
  TimeOfDay timeUntil = TimeOfDay.now();
  final List<TextEditingController> timeFromListControllers =
      eventVenue.venueAvailable.isNotEmpty
          ? List.generate(timeFromList.length,
              (index) => TextEditingController(text: timeFromList[index]))
          : [TextEditingController()];
  final List<TextEditingController> timeUntilListControllers =
      eventVenue.venueAvailable.isNotEmpty
          ? List.generate(timeUntilList.length,
              (index) => TextEditingController(text: timeUntilList[index]))
          : [TextEditingController()];

  final List<String> selectedDaysHourListControllers = [];

  TextEditingController updateFee =
      TextEditingController(text: eventVenue.venuePrice);
  TextEditingController updateName =
      TextEditingController(text: eventVenue.venueName);
  TextEditingController updateAddress =
      TextEditingController(text: eventVenue.venueAddress);
  TextEditingController updateDescription =
      TextEditingController(text: eventVenue.venueDescription);
  TextEditingController updateContact =
      TextEditingController(text: eventVenue.venueContact);

  var editDialog =
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
                        'Edit Venue',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: updateVenueText.noteRequired(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: updateVenueText.requiredFieldLabel('Venue Name'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 16,
                      ),
                      child: TextFormField(
                        controller: updateName,
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
                    Padding(
                      padding: EdgeInsets.only(),
                      child:
                          updateVenueText.requiredFieldLabel('Venue Address'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 16,
                      ),
                      child: TextFormField(
                        controller: updateAddress,
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
                    Padding(
                      padding: EdgeInsets.only(),
                      child: updateVenueText.requiredFieldLabel('Description'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 16,
                      ),
                      child: TextFormField(
                        controller: updateDescription,
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
                    Padding(
                      padding: EdgeInsets.only(),
                      child:
                          updateVenueText.requiredFieldLabel('Contact Number'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 16,
                      ),
                      child: TextFormField(
                        controller: updateContact,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Contact number cannot be empty!";
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
                        margin: const EdgeInsets.only(
                          top: 4,
                        ),
                        height: 240,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffE8E8EA)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
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
                                        margin:
                                            const EdgeInsets.only(bottom: 4),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: const Color(0xffE8E8EA),
                                                width: 0.75),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(4))),
                                        child: ListTile(
                                          leading: Text("${index + 1}."),
                                          title: TextFormField(
                                            controller: listControllers[index],
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff1B2533),
                                                    fontWeight:
                                                        FontWeight.normal)),
                                            decoration: const InputDecoration(
                                                hintText: 'Enter a requirement',
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 2)),
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
                                                  listControllers
                                                      .removeAt(index);
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
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
                                            Radius.circular(4))),
                                    child: Text(
                                      'Add Requirement',
                                      style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white)),
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
                                controller: updateFee,
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
                                                    } else if (!(days.contains(
                                                        value.toUpperCase()))) {
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
                                                                timeFromListControllers[
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
                                                                              debugPrint(updateFee.text);
                                                                              final TimeOfDay? timeOfDay = await showTimePicker(context: context, initialTime: timeAvailableFrom);
                                                                              if (timeOfDay != null) {
                                                                                setState(() {
                                                                                  timeAvailableFrom = timeOfDay;
                                                                                  timeFromListControllers[index].text = "${timeAvailableFrom.format(context)} ";
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
                                                                timeUntilListControllers[
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
                                                                                  timeUntilListControllers[index].text = "${timeUntilDay.format(context)} ";
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
                                                  timeFromListControllers[index]
                                                      .clear;
                                                  timeFromListControllers[index]
                                                      .dispose();
                                                  timeFromListControllers
                                                      .removeAt(index);
                                                  timeUntilListControllers[
                                                          index]
                                                      .clear;
                                                  timeUntilListControllers[
                                                          index]
                                                      .dispose();
                                                  timeUntilListControllers
                                                      .removeAt(index);
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
                                        'Add More',
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
                                        timeFromListControllers
                                            .add(TextEditingController());
                                        timeUntilListControllers
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
                            List<String> allAvailableDays = List.generate(
                                availableDays.length,
                                (index) =>
                                    "${availableDays[index].text}: ${timeFromListControllers[index].text} - ${timeUntilListControllers[index].text}");

                            if (_formKey.currentState!.validate()) {
                              EventVenue newEventVenue = EventVenue(
                                  venueName: updateName.text,
                                  venueAddress: updateAddress.text,
                                  venueDescription: updateDescription.text,
                                  venueContact: updateContact.text,
                                  venueRequirements: allEventRequirements,
                                  venuePrice: updateFee.text.isEmpty
                                      ? 'Free'
                                      : updateFee.text,
                                  venueAvailable: allAvailableDays,
                                  createdOn: Timestamp.now(),
                                  lastUpdatedOn: Timestamp.now());

                              try {
                                await databaseService.updateVenue(
                                    venueId, newEventVenue);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Venue updated successfully!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                updateName.clear();
                                updateAddress.clear();
                                updateDescription.clear();
                                updateContact.clear();
                                updateFee.clear();
                                Navigator.pop(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to update venue: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(color: Colors.blue),
                            child: Center(child: Text('Update')),
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
      return editDialog;
    },
  );
}
