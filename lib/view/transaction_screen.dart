import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spend_sense/components/widgets/bottom_model_sheet.dart';
import 'package:spend_sense/components/widgets/transaction_card.dart';
import 'package:spend_sense/view_model/transaction_services.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 125, 131, 246),
        title: Text(
          'Your Transactions',
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 18.5,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 251, 251),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 12),
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('transactions')
                  .where('userId', isEqualTo: userId?.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Column(children: [
                    SizedBox(
                      height: size * 0.03,
                    ),
                    Text(
                      'No Transaction added yet',
                      style: GoogleFonts.lato(
                          color: const Color.fromARGB(255, 111, 117, 235),
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: size * 0.04,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, bottom: size * 0.3),
                      child: const Image(
                        image: AssetImage('assets/images/waiting.png'),
                      ),
                    ),
                  ]);
                }
                if (snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var title = snapshot.data!.docs[index]['title'];
                        var description =
                            snapshot.data!.docs[index]['shortDescription'];
                        var amount = snapshot.data!.docs[index]['amount'];
                        var docId = snapshot.data!.docs[index].id;
                        return TransactionCard(
                          title: title,
                          description: description,
                          amount: amount,
                          onDelete: () {
                            TransactionServices().deleteTransaction(docId);
                          },
                        );
                      });
                }
                return Container();
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          elevation: 4,
          backgroundColor: const Color.fromARGB(255, 126, 111, 230),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              isScrollControlled: true, // to allow the changes in height
              builder: (BuildContext context) {
                return const CustomBottomSheet();
              },
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          )),
    );
  }
}
