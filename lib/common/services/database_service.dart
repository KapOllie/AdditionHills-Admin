import 'package:barangay_adittion_hills_app/models/document/document.dart';
import 'package:barangay_adittion_hills_app/models/document_requests/document_request.dart';
import 'package:barangay_adittion_hills_app/models/equipment/new_equipment.dart';
import 'package:barangay_adittion_hills_app/models/user/user_web.dart';
import 'package:barangay_adittion_hills_app/models/venue/event_venue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String DOC_COLLECTION_REF = "documents";

const String ITEM_COLLECTION_REF = "event_equipment";

const String DOCREQ_COLLECTION_REF = "document_requests";

const String VENUE_COLLECTION_REF = "event_venue";

const String REGISTERED_CLIENT_COLLECTION_REF = "registered_client";

const String APP_USERS_COLLECTION_REF = 'users';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _docsRef;
  late final CollectionReference _itemRef;
  late final CollectionReference _venueRef;
  late final CollectionReference _docReqRef;
  late final CollectionReference _registeredClient;
  late final CollectionReference _appUser;
  late final CollectionReference appUsersRef = FirebaseFirestore.instance
      .collection('users')
      .doc('app_users')
      .collection('app_users');
  DatabaseService() {
    _appUser = _firestore
        .collection(APP_USERS_COLLECTION_REF)
        .withConverter<UserWeb>(
            fromFirestore: (snapshots, _) =>
                UserWeb.fromJson(snapshots.data()!),
            toFirestore: (userWeb, _) => userWeb.toJson());

    _registeredClient = _firestore
        .collection(REGISTERED_CLIENT_COLLECTION_REF)
        .withConverter<UserWeb>(
            fromFirestore: (snapshots, _) =>
                UserWeb.fromJson(snapshots.data()!),
            toFirestore: (userWeb, _) => userWeb.toJson());

    _docsRef = _firestore
        .collection(DOC_COLLECTION_REF)
        .withConverter<Document>(
            fromFirestore: (snapshots, _) =>
                Document.fromJson(snapshots.data()!),
            toFirestore: (document, _) => document.toJson());

    _venueRef = _firestore
        .collection(VENUE_COLLECTION_REF)
        .withConverter<EventVenue>(
            fromFirestore: (snapshots, _) =>
                EventVenue.fromJson(snapshots.data()!),
            toFirestore: (eventVenue, _) => eventVenue.toJson());

    _itemRef = _firestore
        .collection(ITEM_COLLECTION_REF)
        .withConverter<NewEquipment>(
            fromFirestore: (snapshots, _) =>
                NewEquipment.fromJson(snapshots.data()!),
            toFirestore: (newEquipment, _) => newEquipment.toJson());

    _docReqRef = _firestore
        .collection(DOCREQ_COLLECTION_REF)
        .withConverter<DocumentRequest>(
            fromFirestore: (snapshots, _) =>
                DocumentRequest.fromJson(snapshots.data()!),
            toFirestore: (documentRequest, _) => documentRequest.toJson());
  }

  Future<bool> addUsers(UserWeb userWeb, String email) async {
    try {
      await _firestore
          .collection('users')
          .doc(userWeb.email)
          .set(userWeb.toJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Stream<QuerySnapshot> getDocuments() {
    return _docsRef.snapshots();
  }

  Future<bool> addDoc(Document doc, String docId) async {
    try {
      await _firestore
          .collection(DOC_COLLECTION_REF)
          .doc(docId)
          .set(doc.toJson());
      print("Document added successfully");
      return true;
    } catch (e) {
      print("Failed to add document: $e");
      return false;
    }
  }

  Future<bool> updateDoc(String docsId, Document doc) async {
    try {
      await _docsRef.doc(docsId).update(doc.toJson());
      print("Document updated successfully");
      return true;
    } catch (e) {
      print("Failed to update the document");
      return false;
    }
  }

  void deleteDoc(String docsId) {
    _docsRef.doc(docsId).delete();
  }

  Stream<QuerySnapshot> getItems() {
    return _itemRef.snapshots();
  }

  void updateItem(String itemId, NewEquipment newEquip) {
    _itemRef.doc(itemId).update(newEquip.toJson());
  }

  void addItem(NewEquipment newEquip) async {
    try {
      await _itemRef.add(newEquip);
      // Optionally, you can add a success message or perform additional actions here
      print('Item added successfully');
    } catch (e) {
      // Handle any errors here
      print('Failed to add item: $e');
      // Optionally, you can show an error message to the user or log the error
    }
  }

  void deleteItem(String itemId) {
    _itemRef.doc(itemId).delete();
  }

  Stream<QuerySnapshot> getDocumentRequests() {
    return _docReqRef.snapshots();
  }

  void updateDocumentRequest(String docReqId, DocumentRequest docReq) {
    _docReqRef.doc(docReqId).update(docReq.toJson());
  }

  Stream<QuerySnapshot> getVenues() {
    return _venueRef.snapshots();
  }

  void addVenue(EventVenue eventVenue) async {
    _venueRef.add(eventVenue);
  }

  void deleteVenue(String venueId) {
    _venueRef.doc(venueId).delete();
  }

  void updateVenue(String venueId, EventVenue eventVenue) {
    _venueRef.doc(venueId).update(eventVenue.toJson());
  }

  Future<List<DocumentSnapshot>>
      getAllDocumentsIncludingSubcollections() async {
    try {
      // Get the main document
      DocumentSnapshot clientDoc = await FirebaseFirestore.instance
          .collection('apptest')
          .doc('client')
          .get();

      // Assuming the document contains a list of subcollection names
      List<dynamic> subcollectionNames = clientDoc.get('');

      List<DocumentSnapshot> resultDocs = [];

      for (String subcollectionName in subcollectionNames) {
        // Fetch all documents from each subcollection
        QuerySnapshot subCollectionSnapshot =
            await clientDoc.reference.collection(subcollectionName).get();
        resultDocs.addAll(subCollectionSnapshot.docs);
      }

      return resultDocs;
    } catch (e) {
      print("Failed to get all documents including subcollections: $e");
      return [];
    }
  }
}
