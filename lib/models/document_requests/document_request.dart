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
  String contact_number;
  String residence_since;
  double fee;

  DocumentRequest({
    required this.fee,
    required this.document_title,
    required this.user_email,
    required this.requester_name,
    required this.address,
    required this.birthday,
    required this.date_requested,
    required this.pickup_date,
    required this.request_status,
    required this.contact_number,
    required this.residence_since,
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
          contact_number: json['contact_number'] as String,
          residence_since: json['years_of_residence'] as String,
          fee: json['fee'] as double,
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
    String? contact_number,
    String? residence_since,
    double? fee,
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
        contact_number: contact_number ?? this.contact_number,
        residence_since: residence_since ?? this.residence_since,
        fee: fee ?? this.fee);
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
      'contact_number': contact_number,
      'years_of_residence': residence_since,
      'fee': fee,
    };
  }
}
