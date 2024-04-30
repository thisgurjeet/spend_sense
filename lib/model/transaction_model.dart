import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String userId;
  final String title;
  final String shortDescription;
  final double amount;
  final String date;

  TransactionModel(
      {required this.userId,
      required this.title,
      required this.shortDescription,
      required this.amount,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'shortDescription': shortDescription,
      'amount': amount,
      'date': date,
    };
  }

  factory TransactionModel.fromSnap(
      DocumentSnapshot<Map<String, dynamic>> user) {
    return TransactionModel(
      userId: user.id,
      title: user['title'],
      shortDescription: user['shortDescription'],
      amount: user['amount'],
      date: user['date'],
    );
  }
}
