import 'package:barangay_adittion_hills_app/common/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barangay_adittion_hills_app/common/widgets/column_field_text.dart'; // Fixed the typo

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPage();
}

class _AccountsPage extends State<AccountsPage> {
  var myList = [
    'a',
    'a',
    'a',
    'a',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              height: 60,
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [headText('Accounts')],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              height: 60,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 260,
                    decoration: const BoxDecoration(
                      color: Color(0xffE3F2FC),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 4),
                          width: 200,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: TextField(
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: const Color(0xff818A91).withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: 'Search documents Title',
                              hintStyle: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color:
                                      const Color(0xff818A91).withOpacity(0.5),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            cursorColor: const Color(0xff2294F2),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Implement search functionality
                            },
                            child: Container(
                              height: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color(0xff2294F2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              child: const Icon(
                                Icons.search_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 60,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffE5E8FC),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Expanded(
                    child: Center(
                      child: ColumnFieldText(
                        fieldText: 'ID',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ColumnFieldText(
                        fieldText: 'Name',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ColumnFieldText(
                        fieldText: 'Creation Date',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ColumnFieldText(
                        fieldText: 'Status',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
                height: 400, // Specify a height or wrap in Expanded
                child: ListView.separated(
                  itemCount: myList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final item = myList[index];
                    return ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color(0xffE5E8FC),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      title: Text(item),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
