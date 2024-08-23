// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:barangay_adittion_hills_app/common/widgets/common_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/models/document_requests/document_request.dart';

class AdminProfilePage extends StatefulWidget {
  final String email;
  const AdminProfilePage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0ebf8),
      body: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headText('Profile'),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('email', isEqualTo: widget.email)
                  .where('userType', isEqualTo: 'client')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No documents found.'));
                }

                // Process the documents
                final documents = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final document =
                        documents[index].data() as Map<String, dynamic>;
                    // Display your document data here
                    return ListTile(
                      title: Text(document['name']),
                      subtitle:
                          Text(document['requester_name'] ?? 'No description'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
