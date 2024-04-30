import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spend_sense/model/transaction_model.dart';

class TransactionServices {
  User? user = FirebaseAuth.instance.currentUser;
  final transactionCollection =
      FirebaseFirestore.instance.collection('transactions');

  // CREATE
  void addNewTransaction(TransactionModel model) {
    transactionCollection.add(model.toMap());
  }

  // DELETE
  void deleteTransaction(String docId) {
    transactionCollection.doc(docId).delete();
  }
}
