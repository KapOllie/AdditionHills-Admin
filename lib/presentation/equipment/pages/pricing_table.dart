import 'package:flutter/material.dart';

class PricingTable {
  String setName;
  int quantity;
  double price;

  PricingTable({
    required this.setName,
    required this.quantity,
    required this.price,
  });
}

class PricingTableController {
  TextEditingController setName;
  TextEditingController quantity;
  TextEditingController price;

  PricingTableController({
    required this.setName,
    required this.quantity,
    required this.price,
  });
}
