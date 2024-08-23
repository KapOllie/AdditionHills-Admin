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
      backgroundColor: const Color(0xfff0ebf8),
      body: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 8),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white),
        ),
      ),
    );
  }
}
