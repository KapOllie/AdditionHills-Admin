import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/widgets/textfield_validator/textfield_validators.dart';

newVenueDialogBox(BuildContext context, GlobalKey<FormState> formKey) {
  final List<TextEditingController> listControllers = [TextEditingController()];
  List<String> days = [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
  ];
  String selectedDay = 'Sunday';
  final List<TextEditingController> availableDays = [TextEditingController()];

  TimeOfDay timeAvailableFrom = TimeOfDay.now();
  TimeOfDay timeUntil = TimeOfDay.now();
  final List<TextEditingController> timeFromList = [TextEditingController()];
  final List<TextEditingController> timeUntilList = [TextEditingController()];
  final List<String> selectedDaysHourList = [];
  TextEditingController newPriceCtrl = TextEditingController();
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
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'New Venue',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Venue Name',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1E1A2A))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 16,
                      ),
                      child: TextFormField(
                        // controller: addItemName,
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
                    Text(
                      'Venue Address',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1E1A2A))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 16,
                      ),
                      child: TextFormField(
                        // controller: addItemName,
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
                    Text(
                      'Description',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1E1A2A))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 16,
                      ),
                      child: TextFormField(
                        // controller: addItemDescription,
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
                    Text(
                      'Contact Number',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1E1A2A))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 16,
                      ),
                      child: TextFormField(
                        // controller: addItemName,
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
                      'Requirements',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1E1A2A))),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 4,
                      ),
                      height: 156,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffE8E8EA)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: ListView.builder(
                            itemCount: listControllers.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                margin: const EdgeInsets.only(bottom: 4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: const Color(0xffE8E8EA),
                                        width: 0.75),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4))),
                                child: ListTile(
                                  leading: Text("${index + 1}."),
                                  title: TextFormField(
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff0a0a0a),
                                            fontWeight: FontWeight.normal)),
                                    decoration: const InputDecoration(
                                        hintText: 'Enter a requirement',
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 2)),
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
                                      setState(() {
                                        listControllers[index].clear();
                                        listControllers[index].dispose();
                                        listControllers.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              );
                            }),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4))),
                            child: Text(
                              'Add Requirement',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 12, color: Colors.white)),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              listControllers.add(TextEditingController());
                            });
                          },
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff1E1A2A))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 4,
                                  bottom: 16,
                                ),
                                child: TextFormField(
                                  controller: newPriceCtrl,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Item name cannot be empty!";
                                    }
                                    return null;
                                  },
                                  inputFormatters: onlyUnsignedNumbers(6),
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
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffE8E8EA)),
                                      ),
                                      hoverColor: Color(0xffffffff)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: SizedBox(
                              width: 14,
                            ))
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      width: double.infinity,
                      height: 210,
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
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                            fontSize: 12,
                                          )),
                                        ))),
                                    Expanded(
                                        flex: 2,
                                        child: Center(
                                            child: Text(
                                          'Time',
                                          style: GoogleFonts.poppins(
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
                                                    fillColor:
                                                        const Color(0xfFFFFFFF),
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
                                                          readOnly: false,
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
                                                          style:
                                                              GoogleFonts.inter(
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
                                                                            debugPrint(newPriceCtrl.text);
                                                                            final TimeOfDay?
                                                                                timeOfDay =
                                                                                await showTimePicker(context: context, initialTime: timeAvailableFrom);
                                                                            if (timeOfDay !=
                                                                                null) {
                                                                              setState(() {
                                                                                timeAvailableFrom = timeOfDay;
                                                                                timeFromList[index].text = "${timeAvailableFrom.format(context)} ";
                                                                              });
                                                                            }
                                                                          },
                                                                          icon: const Icon(Icons
                                                                              .av_timer_rounded)),
                                                                  fillColor:
                                                                      const Color(
                                                                          0xfFFFFFFF),
                                                                  filled: true,
                                                                  border:
                                                                      const OutlineInputBorder(),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Color(0xffE8E8EA)),
                                                                  ),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Color(0xffE8E8EA)),
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
                                                          style:
                                                              GoogleFonts.inter(
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
                                                                            final TimeOfDay?
                                                                                timeUntilDay =
                                                                                await showTimePicker(context: context, initialTime: timeAvailableFrom);
                                                                            if (timeUntilDay !=
                                                                                null) {
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
                                                                  filled: true,
                                                                  border:
                                                                      const OutlineInputBorder(),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Color(0xffE8E8EA)),
                                                                  ),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Color(0xffE8E8EA)),
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
                                            setState(() {
                                              availableDays[index].clear;
                                              availableDays[index].dispose();
                                              availableDays.removeAt(index);
                                              timeFromList[index].clear;
                                              timeFromList[index].dispose();
                                              timeFromList.removeAt(index);
                                              timeUntilList[index].clear;
                                              timeUntilList[index].dispose();
                                              timeUntilList.removeAt(index);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.remove_circle_rounded,
                                            size: 18,
                                          )),
                                    );
                                  }),
                            ),
                          ],
                        ),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4))),
                            child: Text(
                              'Add more',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 12, color: Colors.white)),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              availableDays.add(TextEditingController());
                              timeFromList.add(TextEditingController());
                              timeUntilList.add(TextEditingController());

                              debugPrint(availableDays.length.toString());
                            });
                          },
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {},
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
                          onTap: () {
                            formKey.currentState!.validate();
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
