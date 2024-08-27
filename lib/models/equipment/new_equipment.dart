import 'package:cloud_firestore/cloud_firestore.dart';

class NewEquipment {
  String itemName;
  String itemDescription;
  int itemQuantity;
  List<dynamic> itemRequirements;
  Timestamp createdOn;
  Timestamp lastUpdatedOn;
  Map<String, dynamic> pricingTable;
  List<dynamic> rules;

  NewEquipment({
    required this.itemName,
    required this.itemDescription,
    required this.itemQuantity,
    required this.itemRequirements,
    required this.createdOn,
    required this.lastUpdatedOn,
    required this.pricingTable,
    required this.rules,
  });

  NewEquipment.fromJson(Map<String, Object?> json)
      : this(
          itemName: json['itemName'] as String,
          itemDescription: json['itemDescription'] as String,
          itemQuantity: json['itemQuantity'] as int,
          itemRequirements: json['itemRequirements']
              as List<dynamic>, // Specify type if known
          createdOn: json['createdOn'] as Timestamp,
          lastUpdatedOn: json['lastUpdatedOn'] as Timestamp,
          pricingTable: json['pricingTable'] as Map<String, dynamic>,
          rules: json['rules'] as List<dynamic>,
        );

  NewEquipment copyWith({
    String? itemName,
    String? itemDescription,
    int? itemQuantity,
    List<dynamic>? itemRequirements,
    Timestamp? createdOn,
    Timestamp? lastUpdatedOn,
    Map<String, dynamic>? pricingTable,
    List<dynamic>? rules,
  }) {
    return NewEquipment(
      itemName: itemName ?? this.itemName,
      itemDescription: itemDescription ?? this.itemDescription,
      itemQuantity: itemQuantity ?? this.itemQuantity,
      itemRequirements: itemRequirements ?? this.itemRequirements,
      createdOn: createdOn ?? this.createdOn,
      lastUpdatedOn: lastUpdatedOn ?? this.lastUpdatedOn,
      pricingTable: pricingTable ?? this.pricingTable,
      rules: rules ?? this.rules,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'itemName': itemName,
      'itemDescription': itemDescription,
      'itemQuantity': itemQuantity,
      'itemRequirements': itemRequirements,
      'createdOn': createdOn,
      'lastUpdatedOn': lastUpdatedOn,
      'pricingTable': pricingTable,
      'rules': rules,
    };
  }
}
