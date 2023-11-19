import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tenantyia/models/datatenant.dart';

CollectionReference tbltenant =
    FirebaseFirestore.instance.collection("dataTenant");

class Database {
  static Stream<QuerySnapshot> getData() {
    return tbltenant.orderBy('LastUpdated', descending: true).snapshots();
  }

  static Future<void> tambahData({required dataTenant item}) async {
    DocumentReference docRef = tbltenant.doc();
    await docRef
        .set(item.toJson())
        .whenComplete(() => print("Data Berhasil ditambah"))
        .catchError((e) => print("Error: " + e));
  }

  static Future<void> hapusData(String documentId) async {
    try {
      await tbltenant.doc(documentId).delete();
      print("Data berhasil dihapus");
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future<void> editData(String documentId,
      {required dataTenant updatedData}) async {
    try {
      await tbltenant.doc(documentId).update(updatedData.toJson());
      print("Data berhasil diperbarui");
    } catch (e) {
      print("Error: $e");
    }
  }

  static Stream<QuerySnapshot> searchData(String query) {
    String queryUpperCase =
        query.toUpperCase(); // Mengonversi query ke huruf kecil
    return tbltenant
        .where('NamaPT', isGreaterThanOrEqualTo: queryUpperCase)
        .where('NamaPT', isLessThan: queryUpperCase + '\uf8ff')
        .orderBy('NamaPT', descending: true)
        .snapshots();
  }
}
