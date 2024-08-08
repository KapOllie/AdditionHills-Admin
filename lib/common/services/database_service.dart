import 'package:barangay_adittion_hills_app/models/document/document.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String DOC_COLLECTION_REF = "documents";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _docsRef;

  DatabaseService() {
    _docsRef = _firestore
        .collection(DOC_COLLECTION_REF)
        .withConverter<Document>(
            fromFirestore: (snapshots, _) =>
                Document.fromJson(snapshots.data()!),
            toFirestore: (document, _) => document.toJson());
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
}
