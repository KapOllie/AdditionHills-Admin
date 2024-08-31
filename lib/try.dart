import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(ResidenceCalculatorApp());
}

class ResidenceCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Residence Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResidenceCalculator(),
    );
  }
}

class ResidenceCalculator extends StatefulWidget {
  @override
  _ResidenceCalculatorState createState() => _ResidenceCalculatorState();
}

class _ResidenceCalculatorState extends State<ResidenceCalculator> {
  DateTime? _selectedDate;
  String _result = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _calculateResidence();
      });
    }
  }

  void _calculateResidence() {
    if (_selectedDate == null) return;

    final now = DateTime.now();
    final difference = now.difference(_selectedDate!);
    final years = difference.inDays ~/ 365;
    final months = (difference.inDays % 365) ~/ 30;

    setState(() {
      _result = '$years year(s) and $months month(s)';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Residence Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date of Residence'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
