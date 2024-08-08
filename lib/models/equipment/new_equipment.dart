import 'package:cloud_firestore/cloud_firestore.dart';

class NewEquipment {
  String itemName;
  String itemDescription;
  List<String> listRequirements;
  Timestamp createdOn;
  Timestamp lastUpdatedOn;
  NewEquipment({
    required this.itemName,
    required this.itemDescription,
    required this.listRequirements,
    required this.createdOn,
    required this.lastUpdatedOn,
  });

  NewEquipment.formJson(Map<String, Object?> json)
      : this(
          itemName: json['itemName'] as String,
          itemDescription: json['itemDescription'] as String,
          listRequirements: json['listRequirements'] as List<String>,
          createdOn: json['createdOn'] as Timestamp,
          lastUpdatedOn: json['lastUpdateOn'] as Timestamp,
        );
  NewEquipment copyWith(
      {String? itemName,
      String? itemDescription,
      List<String>? listRequirements,
      Timestamp? createdOn,
      Timestamp? lastUpdatedOn}) {
    return NewEquipment(
      itemName: itemName ?? this.itemName,
      itemDescription: itemDescription ?? this.itemDescription,
      listRequirements: listRequirements ?? this.listRequirements,
      createdOn: createdOn ?? this.createdOn,
      lastUpdatedOn: lastUpdatedOn ?? this.lastUpdatedOn,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'itemName': itemName,
      'itemDescription': itemDescription,
      'listRequirements': listRequirements,
      'createdOn': createdOn,
      'lastUpdatedOn': lastUpdatedOn,
    };
  }
}
