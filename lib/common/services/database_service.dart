import 'package:barangay_adittion_hills_app/models/document/document.dart';
import 'package:barangay_adittion_hills_app/models/equipment/new_equipment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String DOC_COLLECTION_REF = "documents";

const String ITEM_COLLECTION_REF = "event_equipment";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _docsRef;
  late final CollectionReference _itemRef;
  DatabaseService() {
    _docsRef = _firestore
        .collection(DOC_COLLECTION_REF)
        .withConverter<Document>(
            fromFirestore: (snapshots, _) =>
                Document.fromJson(snapshots.data()!),
            toFirestore: (document, _) => document.toJson());

    _itemRef = _firestore
        .collection(ITEM_COLLECTION_REF)
        .withConverter<NewEquipment>(
            fromFirestore: (snapshots, _) =>
                NewEquipment.fromJson(snapshots.data()!),
            toFirestore: (newEquipment, _) => newEquipment.toJson());
  }

  Stream<QuerySnapshot> getDocuments() {
    return _docsRef.snapshots();
  }

  void addDoc(Document doc) async {
    _docsRef.add(doc);
  }

  void updateDoc(String docsId, Document doc) {
    _docsRef.doc(docsId).update(doc.toJson());
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
    _itemRef.add(newEquip);
  }

  void deleteItem(String itemId) {
    _itemRef.doc(itemId).delete();
  }
}
