import 'package:cloud_firestore/cloud_firestore.dart';

class Document {
  String title;
  String description;
  Timestamp createdOn;
  Timestamp lastModifiedOn;
  double fee;
  String imageUrl;
  List<dynamic> docRequirements;

  Document(
      {required this.title,
      required this.description,
      required this.createdOn,
      required this.lastModifiedOn,
      required this.fee,
      required this.imageUrl,
      required this.docRequirements});

  Document.fromJson(Map<String, Object?> json)
      : this(
            title: json['title'] as String,
            description: json['description'] as String,
            createdOn: json['createdOn']! as Timestamp,
            lastModifiedOn: json['lastModifiedOn']! as Timestamp,
            fee: json['fee'] as double,
            imageUrl: json['imageUrl'] as String,
            docRequirements: json['docRequirements'] as List<dynamic>);

  Document copyWith(
      {String? title,
      String? description,
      Timestamp? createdOn,
      Timestamp? lastModifiedOn,
      double? fee,
      String? imageUrl,
      List<dynamic>? docRequirements}) {
    return Document(
        title: title ?? this.title,
        description: description ?? this.description,
        createdOn: createdOn ?? this.createdOn,
        lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
        fee: fee ?? this.fee,
        imageUrl: imageUrl ?? this.imageUrl,
        docRequirements: docRequirements ?? this.docRequirements);
  }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'description': description,
      'createdOn': createdOn,
      'lastModifiedOn': lastModifiedOn,
      'fee': fee,
      'imageUrl': imageUrl,
      'docRequirements': docRequirements
    };
  }
}
