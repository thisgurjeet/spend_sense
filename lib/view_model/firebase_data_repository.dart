import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<double> getTotalAmount(String userId) async {
    double totalAmount = 0.0;

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('transactions')
          .where('userId', isEqualTo: userId)
          .get();

      List<DocumentSnapshot<Map<String, dynamic>>> documents =
          querySnapshot.docs;

      for (var doc in documents) {
        totalAmount += doc['amount'] as double;
      }
    } catch (e) {
      print('Error getting total amount: $e');
    }

    return totalAmount;
  }
}
