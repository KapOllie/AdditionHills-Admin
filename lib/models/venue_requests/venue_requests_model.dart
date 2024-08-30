import 'package:cloud_firestore/cloud_firestore.dart';

class VenueRequestsModel {
  String venueName;
  Timestamp requestDate;
  String requestSelectedDate;
  String requestStatus;
  String requestPurpose;
  String requesterName;
  String requesterContact;
  String requesterAddress;
  String requesterEmail;
  String requesterAge;
  List<dynamic> additionalEquipments;
  String requesterBirthday;

  VenueRequestsModel({
    required this.venueName,
    required this.requestDate,
    required this.requestSelectedDate,
    required this.requestStatus,
    required this.requestPurpose,
    required this.requesterName,
    required this.requesterContact,
    required this.requesterAddress,
    required this.requesterEmail,
    required this.requesterAge,
    required this.additionalEquipments,
    required this.requesterBirthday,
  });

  VenueRequestsModel.fromJson(Map<String, Object?> json)
      : this(
          venueName: json['venue_name'] as String,
          requestDate: json['date_requested'] as Timestamp,
          requestSelectedDate: json['selected_date'] as String,
          requestStatus: json['request_status'] as String,
          requestPurpose: json['purpose'] as String,
          requesterName: json['requester_name'] as String,
          requesterContact: json['contact_number'] as String,
          requesterAddress: json['address'] as String,
          requesterEmail: json['user_email'] as String,
          requesterAge: json['user_age'] as String,
          additionalEquipments: json['additional_equipments'] as List<dynamic>,
          requesterBirthday: json['birthday'] as String,
        );

  VenueRequestsModel copyWith({
    String? venueName,
    Timestamp? requestDate,
    String? requestSelectedDate,
    String? requestStatus,
    String? requestPurpose,
    String? requesterName,
    String? requesterContact,
    String? requesterAddress,
    String? requesterEmail,
    String? requesterAge,
    List<dynamic>? additionalEquipments,
    String? requesterBirthday,
  }) {
    return VenueRequestsModel(
      venueName: venueName ?? this.venueName,
      requestDate: requestDate ?? this.requestDate,
      requestSelectedDate: requestSelectedDate ?? this.requestSelectedDate,
      requestStatus: requestStatus ?? this.requestStatus,
      requestPurpose: requestPurpose ?? this.requestPurpose,
      requesterName: requesterName ?? this.requesterName,
      requesterContact: requesterContact ?? this.requesterContact,
      requesterAddress: requesterAddress ?? this.requesterAddress,
      requesterEmail: requesterEmail ?? this.requesterEmail,
      requesterAge: requesterAge ?? this.requesterAge,
      additionalEquipments: additionalEquipments ?? this.additionalEquipments,
      requesterBirthday: requesterBirthday ?? this.requesterBirthday,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'venue_name': venueName,
      'date_requested': requestDate,
      'selected_date': requestSelectedDate,
      'request_status': requestStatus,
      'purpose': requestPurpose,
      'requester_name': requesterName,
      'contact_number': requesterContact,
      'address': requesterAddress,
      'user_email': requesterEmail,
      'user_age': requesterAge,
      'additional_equipments': additionalEquipments,
      'birthday': requesterBirthday,
    };
  }
}
