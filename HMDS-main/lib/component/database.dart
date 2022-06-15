import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference aptCollection =
      FirebaseFirestore.instance.collection('appointment');

  Future updateData(String title, String details) async {
    return await aptCollection.doc(uid).set({
      'title': title,
      'details': details,
    });
  }
}
