import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboard();
}

class _AdminDashboard extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Row(
            children: [
              Flexible(
                  flex: 3,
                  child: Container(
                    // color: Colors.blue,
                    height: double.infinity,
                  )),
              Flexible(
                  child: SingleChildScrollView(
                child: Container(
                  height: 900,
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              width: 1, color: Colors.grey.shade400))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                    child: SingleChildScrollView(
                      child: Container(
                        height: 900,
                        width: double.infinity,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ))
        ],
      )),
    );
  }
}
