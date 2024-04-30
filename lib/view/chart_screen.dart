import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:spend_sense/components/widgets/bar_chart.dart';

import 'package:spend_sense/components/widgets/history_card.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 125, 131, 246),
        title: Text(
          'Weekly Chart',
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 18.5,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 10,
              ),
              child: Text(
                'History',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 117, 123, 245),
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.75,
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 5,
                bottom: 10,
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('transactions')
                    .where('userId', isEqualTo: userId?.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No History',
                        style: GoogleFonts.lato(
                          color: const Color.fromARGB(255, 106, 112, 235),
                          fontSize: 25,
                        ),
                      ),
                    );
                  }
                  if (snapshot.data!.docs.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var title = snapshot.data!.docs[index]['title'];
                              var amount = snapshot.data!.docs[index]['amount'];
                              return Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: HistoryCard(
                                  title: title,
                                  amount: amount,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Expense by Day',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 117, 123, 245),
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
                height: 300,
                padding: const EdgeInsets.all(8.0),
                child: TransactionChart()),
          ],
        ),
      ),
    );
  }
}
