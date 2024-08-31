import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementModel {
  String title;
  String content;
  Timestamp publishedDate;
  String publishedBy;
  Timestamp lastModifiedDate;
  String lastModifiedBy;

  AnnouncementModel({
    required this.title,
    required this.content,
    required this.publishedDate,
    required this.publishedBy,
    required this.lastModifiedDate,
    required this.lastModifiedBy,
  });

  AnnouncementModel.fromJson(Map<String, Object?> json)
      : this(
          title: json['title'] as String,
          content: json['content'] as String,
          publishedDate: json['published_date']! as Timestamp,
          publishedBy: json['published_by'] as String,
          lastModifiedDate: json['last_modified_date']! as Timestamp,
          lastModifiedBy: json['last_modified_by'] as String,
        );

  AnnouncementModel copyWith({
    String? title,
    String? content,
    Timestamp? publishedDate,
    String? publishedBy,
    Timestamp? lastModifiedDate,
    String? lastModifiedBy,
  }) {
    return AnnouncementModel(
      title: title ?? this.title,
      content: content ?? this.content,
      publishedDate: publishedDate ?? this.publishedDate,
      publishedBy: publishedBy ?? this.publishedBy,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'content': content,
      'published_date': publishedDate,
      'published_by': publishedBy,
      'last_modified_date': lastModifiedDate,
      'last_modified_by': lastModifiedBy,
    };
  }
}
