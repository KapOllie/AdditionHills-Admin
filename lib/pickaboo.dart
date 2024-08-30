import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

class MonthlyReportPage extends StatefulWidget {
  @override
  _MonthlyReportPageState createState() => _MonthlyReportPageState();
}

class _MonthlyReportPageState extends State<MonthlyReportPage> {
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DropdownButton<int>(
            value: selectedYear,
            items: List.generate(
                5,
                (index) => DropdownMenuItem(
                      value: DateTime.now().year - index,
                      child: Text('${DateTime.now().year - index}'),
                    )),
            onChanged: (value) {
              setState(() {
                selectedYear = value!;
              });
            },
          ),
          DropdownButton<int>(
            value: selectedMonth,
            items: List.generate(
                12,
                (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    )),
            onChanged: (value) {
              setState(() {
                selectedMonth = value!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                double totalFee =
                    await calculateTotalFee(selectedYear, selectedMonth);
                await generatePdfReport(selectedYear, selectedMonth, totalFee);
              } catch (e) {
                print('Error: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to generate report: $e')),
                );
              }
            },
            child: Text('Generate Report'),
          ),
        ],
      ),
    );
  }
}

Future<double> calculateTotalFee(int year, int month) async {
  final startDate = Timestamp.fromDate(DateTime(year, month, 1));
  final endDate = Timestamp.fromDate(DateTime(year, month + 1, 1));

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('reports')
      .where('request_status', isEqualTo: 'Approved')
      .where('date_selected', isGreaterThanOrEqualTo: startDate)
      .where('date_selected', isLessThan: endDate)
      .get();

  double totalFee = 0;
  querySnapshot.docs.forEach((doc) {
    totalFee += doc['fee'];
  });

  return totalFee;
}

Future<void> generatePdfReport(int year, int month, double totalFee) async {
  final pdf = pw.Document();

  // PDF generation code remains the same

  final bytes = await pdf.save();

  // Save the file to the documents directory
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/report_$month-$year.pdf');
  await file.writeAsBytes(bytes);

  // Share the file
  await Share.shareFiles([file.path], text: 'Monthly Financial Report');
}
