import 'package:cloud_firestore/cloud_firestore.dart';

class EventVenue {
  String venueName;
  String venueAddress;
  String venueDescription;
  String venueContact;
  List<dynamic> venueRequirements; // Specify type if known (e.g., List<String>)
  String venuePrice;
  List<dynamic> venueAvailable; // Specify type if known (e.g., List<DateTime>)
  Timestamp createdOn;
  Timestamp lastUpdatedOn;

  EventVenue({
    required this.venueName,
    required this.venueAddress,
    required this.venueDescription,
    required this.venueContact,
    required this.venueRequirements,
    required this.venuePrice,
    required this.venueAvailable,
    required this.createdOn,
    required this.lastUpdatedOn,
  });

  EventVenue.fromJson(Map<String, Object?> json)
      : this(
          venueName: json['venueName'] as String,
          venueAddress: json['venueAddress'] as String,
          venueDescription: json['venueDescription'] as String,
          venueContact: json['venueContact'] as String,
          venueRequirements: json['venueRequirements'] as List<dynamic>,
          venuePrice: json['venuePrice'] as String,
          venueAvailable:
              json['venueAvailable'] as List<dynamic>, // Specify type if known
          createdOn: json['createdOn'] as Timestamp,
          lastUpdatedOn: json['lastUpdatedOn'] as Timestamp,
        );

  EventVenue copyWith({
    String? venueName,
    String? venueAddress,
    String? venueDescription,
    String? venueContact,
    List<dynamic>? venueRequirements,
    String? venuePrice,
    List<dynamic>? venueAvailable,
    Timestamp? createdOn,
    Timestamp? lastUpdatedOn,
  }) {
    return EventVenue(
      venueName: venueName ?? this.venueName,
      venueAddress: venueAddress ?? this.venueAddress,
      venueDescription: venueDescription ?? this.venueDescription,
      venueContact: venueContact ?? this.venueContact,
      venueRequirements: venueRequirements ?? this.venueRequirements,
      venuePrice: venuePrice ?? this.venuePrice,
      venueAvailable: venueAvailable ?? this.venueAvailable,
      createdOn: createdOn ?? this.createdOn,
      lastUpdatedOn: lastUpdatedOn ?? this.lastUpdatedOn,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'venueName': venueName,
      'venueAddress': venueAddress,
      'venueDescription': venueDescription,
      'venueContact': venueContact,
      'venueRequirements': venueRequirements,
      'venuePrice': venuePrice,
      'venueAvailable': venueAvailable,
      'createdOn': createdOn,
      'lastUpdatedOn': lastUpdatedOn,
    };
  }
}
