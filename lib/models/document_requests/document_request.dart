import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentRequest {
  String document_title;
  String user_email;
  String requester_name;
  String address;
  String birthday;
  Timestamp date_requested;
  Timestamp pickup_date;
  String request_status;

  DocumentRequest({
    required this.document_title,
    required this.user_email,
    required this.requester_name,
    required this.address,
    required this.birthday,
    required this.date_requested,
    required this.pickup_date,
    required this.request_status,
  });

  DocumentRequest.fromJson(Map<String, Object?> json)
      : this(
          document_title: json['document_title'] as String,
          user_email: json['user_email'] as String,
          requester_name: json['requester_name'] as String,
          address: json['address'] as String,
          birthday: json['birthday'] as String,
          date_requested: json['date_requested']! as Timestamp,
          pickup_date: json['pickup_date']! as Timestamp,
          request_status: json['request_status'] as String,
        );

  DocumentRequest copyWith({
    String? document_title,
    String? user_email,
    String? requester_name,
    String? address,
    String? birthday,
    Timestamp? date_requested,
    Timestamp? pickup_date,
    String? request_status,
  }) {
    return DocumentRequest(
      document_title: document_title ?? this.document_title,
      user_email: user_email ?? this.user_email,
      requester_name: requester_name ?? this.requester_name,
      address: address ?? this.address,
      birthday: birthday ?? this.birthday,
      date_requested: date_requested ?? this.date_requested,
      pickup_date: pickup_date ?? this.pickup_date,
      request_status: request_status ?? this.request_status,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'document_title': document_title,
      'user_email': user_email,
      'requester_name': requester_name,
      'address': address,
      'birthday': birthday,
      'date_requested': date_requested,
      'pickup_date': pickup_date,
      'request_status': request_status,
    };
  }
}
