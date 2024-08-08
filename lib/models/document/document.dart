import 'package:cloud_firestore/cloud_firestore.dart';

class Document {
  String title;
  String description;
  Timestamp createdOn;
  Timestamp lastModifiedOn;

  Document({
    required this.title,
    required this.description,
    required this.createdOn,
    required this.lastModifiedOn,
  });

  Document.fromJson(Map<String, Object?> json)
      : this(
          title: json['title'] as String,
          description: json['description'] as String,
          createdOn: json['createdOn']! as Timestamp,
          lastModifiedOn: json['lastModifiedOn']! as Timestamp,
        );

  Document copyWith(
      {String? title,
      String? description,
      Timestamp? createdOn,
      Timestamp? lastModifiedOn}) {
    return Document(
      title: title ?? this.title,
      description: description ?? this.description,
      createdOn: createdOn ?? this.createdOn,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'description': description,
      'createdOn': createdOn,
      'lastModifiedOn': lastModifiedOn,
    };
  }
}
