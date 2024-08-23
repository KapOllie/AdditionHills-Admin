import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientDataStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Data'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data found.'));
          }

          // Get the list of documents
          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents
                .length, // Set the item count to the number of documents
            itemBuilder: (context, index) {
              // Access the document data
              Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(documents[index].id), // Document ID as title
                subtitle: Text(data['contact']), // Document data as subtitle
              );
            },
          );
        },
      ),
    );
  }
}
