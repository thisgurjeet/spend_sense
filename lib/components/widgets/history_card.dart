import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryCard extends StatelessWidget {
  final String title;
  final double amount;
  const HistoryCard({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.075,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 139, 133, 253),
                Color(0xFFAEAAFF)
              ], // Adjust the colors as needed
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 143, 149, 253),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 113, 119, 241).withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(4, 4),
              ),
            ]),
        child: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 21),
            ),
            Expanded(child: Container()),
            Text(
              '-\$$amount',
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 23),
            )
          ],
        ));
  }
}
