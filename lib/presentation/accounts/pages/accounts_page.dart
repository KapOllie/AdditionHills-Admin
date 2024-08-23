import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/common/widgets/common_widgets.dart';
import 'package:barangay_adittion_hills_app/models/user/user_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barangay_adittion_hills_app/common/widgets/column_field_text.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPage();
}

class _AccountsPage extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0ebf8),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Text(
                          'Accounts',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  color: Color(0xff202124),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        height: 56,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: Text(
                                'Clients (1)',
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        color: Color(0xff202124),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: TextField(
                                        // controller: searchDoc,
                                        style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                            color: Color(0xff202124),
                                            fontSize: 12,
                                          ),
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8),
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          hintText: 'Search user by email',
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
                                        left: BorderSide(
                                            color: Color(0xffdadce0)),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: const Color(0xffdadce0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 44,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xffdadce0),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  leading: const Text(''),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'User',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: Color(0xff202124),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Name',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: Color(0xff202124),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Date Created',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: Color(0xff202124),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Phone Number',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: Color(0xff202124),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('users')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }

                                        if (!snapshot.hasData ||
                                            snapshot.data!.docs.isEmpty) {
                                          return Center(
                                              child: Text('No data found.'));
                                        }
                                        // Get the list of documents
                                        List<QueryDocumentSnapshot>
                                            numberOfUsers = snapshot.data!.docs;

                                        return ListView.builder(
                                          itemCount: numberOfUsers.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            Map<String, dynamic> data =
                                                numberOfUsers[index].data()
                                                    as Map<String, dynamic>;
                                            return Container(
                                              color: index.isEven
                                                  ? Colors.white
                                                  : const Color(0xffFAFAFA),
                                              child: ListTile(
                                                leading: Text(
                                                  '${index + 1}.',
                                                  style: GoogleFonts.inter(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 8)),
                                                ),
                                                title: Row(
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child: Text(
                                                          numberOfUsers[index]
                                                              .id,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              GoogleFonts.inter(
                                                                  textStyle:
                                                                      const TextStyle(
                                                            fontSize: 12,
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child: Text(
                                                          data['name'],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              GoogleFonts.inter(
                                                                  textStyle:
                                                                      const TextStyle(
                                                            fontSize: 12,
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${data['createdOn'].toDate()}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.inter(
                                                                textStyle:
                                                                    const TextStyle(
                                                          fontSize: 12,
                                                        )),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        data['contact'],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.inter(
                                                                textStyle:
                                                                    const TextStyle(
                                                          fontSize: 12,
                                                        )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      })),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 32),
                        child: Divider(),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        height: 56,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: Text(
                                'Admin (2)',
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        color: Color(0xff202124),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: TextField(
                                        // controller: searchDoc,
                                        style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                            color: Color(0xff202124),
                                            fontSize: 12,
                                          ),
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8),
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          hintText: 'Search user by email',
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
                                        left: BorderSide(
                                            color: Color(0xffdadce0)),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: const Color(0xffdadce0),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 44,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xffdadce0),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  leading: const Text(''),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'User',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: Color(0xff202124),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Date Created',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: Color(0xff202124),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Account Status',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: Color(0xff202124),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (BuildContext context, index) {
                                    return Container(
                                      color: index.isEven
                                          ? Colors.white
                                          : const Color(0xffFAFAFA),
                                      child: ListTile(
                                        leading: Text(
                                          '${index + 1}.',
                                          style: GoogleFonts.inter(
                                              textStyle:
                                                  const TextStyle(fontSize: 8)),
                                        ),
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '@username',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                    textStyle: const TextStyle(
                                                  fontSize: 12,
                                                )),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                DateTime.now().toString(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                    textStyle: const TextStyle(
                                                  fontSize: 12,
                                                )),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Active',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                    textStyle: const TextStyle(
                                                  fontSize: 12,
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            //   Expanded(
            //     child: Container(
            //       padding:
            //           const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            //       decoration: const BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.all(Radius.circular(4))),
            //       child: Column(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 24.0),
            //             child: Align(
            //               alignment: Alignment.center,
            //               child: Transform.scale(
            //                 scale: 3.0,
            //                 child: const Icon(
            //                   Icons.account_circle_rounded,
            //                   size: 48,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(top: 24, bottom: 8),
            //             child: Text(
            //               'John Doe Jr.',
            //               style: GoogleFonts.inter(
            //                   textStyle: const TextStyle(fontSize: 24)),
            //             ),
            //           ),
            //           Text(
            //             '@username',
            //             style: GoogleFonts.inter(
            //                 textStyle: const TextStyle(
            //               fontSize: 12,
            //             )),
            //             textAlign: TextAlign.center,
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 16),
            //             child: Align(
            //               alignment: Alignment.centerLeft,
            //               child: Text(
            //                 'UID: ',
            //                 style: GoogleFonts.inter(
            //                     textStyle: const TextStyle(fontSize: 14)),
            //                 textAlign: TextAlign.left,
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 16),
            //             child: Align(
            //               alignment: Alignment.centerLeft,
            //               child: Text(
            //                 'Address: ',
            //                 style: GoogleFonts.inter(
            //                     textStyle: const TextStyle(fontSize: 14)),
            //                 textAlign: TextAlign.left,
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 16),
            //             child: Align(
            //               alignment: Alignment.centerLeft,
            //               child: Text(
            //                 'Birthday: ',
            //                 style: GoogleFonts.inter(
            //                     textStyle: const TextStyle(fontSize: 14)),
            //                 textAlign: TextAlign.left,
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 16),
            //             child: Align(
            //               alignment: Alignment.centerLeft,
            //               child: Text(
            //                 'Contact: ',
            //                 style: GoogleFonts.inter(
            //                     textStyle: const TextStyle(fontSize: 14)),
            //                 textAlign: TextAlign.left,
            //               ),
            //             ),
            //           ),
            //           Expanded(
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Expanded(
            //                   child: GestureDetector(
            //                     onTap: () {
            //                       //TODO: Deactivate account function
            //                     },
            //                     child: Container(
            //                       height: 40,
            //                       decoration: BoxDecoration(
            //                           color: Color(0xfffafafa),
            //                           border: Border.all(
            //                               width: 1,
            //                               color: const Color(0xffdadce0))),
            //                       child: const Center(
            //                         child: const Text('Deactivate'),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 const SizedBox(
            //                   width: 16,
            //                 ),
            //                 Expanded(
            //                   child: GestureDetector(
            //                     onTap: () {
            //                       //TODO: Delete account function
            //                     },
            //                     child: Container(
            //                       height: 40,
            //                       decoration: BoxDecoration(
            //                           color: Color(0xfffafafa),
            //                           border: Border.all(
            //                               width: 1,
            //                               color: const Color(0xffdadce0))),
            //                       child: const Center(
            //                         child: Text('Delete'),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
