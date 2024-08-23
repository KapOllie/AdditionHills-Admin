import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/models/venue/event_venue.dart';
import 'package:flutter/material.dart';

viewVenue(BuildContext context, EventVenue eventVenue, String venueId) {
  DatabaseService _databaseService = DatabaseService();
  debugPrint(eventVenue.venueRequirements.length.toString());
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Column(
              children: [
                Text('Venue Name: ${eventVenue.venueName}'),
                Text('Venue Address: ${eventVenue.venueAddress}'),
                Text('Description: ${eventVenue.venueDescription}'),
                Text('Contact: ${eventVenue.venueContact}'),
                Container(
                  height: 50,
                  child: ListView.builder(
                      itemCount: eventVenue.venueRequirements.length,
                      itemBuilder: (BuildContext context, index) {
                        return ListTile(
                          title: Text(eventVenue.venueRequirements[index]),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
