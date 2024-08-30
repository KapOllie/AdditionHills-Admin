import 'package:cloud_firestore/cloud_firestore.dart';

class EquipmentRequestsModel {
  String requesterName;
  String requesterContact;
  String requesterAddress;
  String requesterBirthday;
  String requesterPurpose;
  String requesterAge;
  String requesterEmail;
  List<dynamic> requestEquipment;
  Timestamp requestDate;
  String requestSelectedDate;
  String requestSelectedTime;

  EquipmentRequestsModel({
    required this.requesterName,
    required this.requesterContact,
    required this.requesterAddress,
    required this.requesterBirthday,
    required this.requesterPurpose,
    required this.requesterAge,
    required this.requesterEmail,
    required this.requestEquipment,
    required this.requestDate,
    required this.requestSelectedDate,
    required this.requestSelectedTime,
  });

  EquipmentRequestsModel.fromJson(Map<String, Object?> json)
      : this(
          requesterName: json['requester_name'] as String,
          requesterContact: json['contact_number'] as String,
          requesterAddress: json['address'] as String,
          requesterBirthday: json['birthday'] as String,
          requesterPurpose: json['purpose'] as String,
          requesterAge: json['user_age'] as String,
          requesterEmail: json['user_email'] as String,
          requestEquipment: json['request_equipment'] as List<dynamic>,
          requestDate: json['date_requested'] as Timestamp,
          requestSelectedDate: json['selected_date'] as String,
          requestSelectedTime: json['selected_time'] as String,
        );

  EquipmentRequestsModel copyWith({
    String? requesterName,
    String? requesterContact,
    String? requesterAddress,
    String? requesterBirthday,
    String? requesterPurpose,
    String? requesterAge,
    String? requesterEmail,
    List<dynamic>? requestEquipment,
    Timestamp? requestDate,
    String? requestSelectedDate,
    String? requestSelectedTime,
  }) {
    return EquipmentRequestsModel(
      requesterName: requesterName ?? this.requesterName,
      requesterContact: requesterContact ?? this.requesterContact,
      requesterAddress: requesterAddress ?? this.requesterAddress,
      requesterBirthday: requesterBirthday ?? this.requesterBirthday,
      requesterPurpose: requesterPurpose ?? this.requesterPurpose,
      requesterAge: requesterAge ?? this.requesterAge,
      requesterEmail: requesterEmail ?? this.requesterEmail,
      requestEquipment: requestEquipment ?? this.requestEquipment,
      requestDate: requestDate ?? this.requestDate,
      requestSelectedDate: requestSelectedDate ?? this.requestSelectedDate,
      requestSelectedTime: requestSelectedTime ?? this.requestSelectedTime,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'requester_name': requesterName,
      'contact_number': requesterContact,
      'address': requesterAddress,
      'birthday': requesterBirthday,
      'purpose': requesterPurpose,
      'user_age': requesterAge,
      'user_email': requesterEmail,
      'request_equipment': requestEquipment,
      'date_requested': requestDate,
      'selected_date': requestSelectedDate,
      'selected_time': requestSelectedTime,
    };
  }
}
