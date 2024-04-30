import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final String description;
  final double amount;
  final VoidCallback onDelete;

  const TransactionCard({
    Key? key,
    required this.title,
    required this.description,
    required this.amount,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: Stack(children: [
        Container(
          height: size.height * 0.185,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 132, 126, 254),
                Color(0xFFAEAAFF)
              ], // Adjust the colors as needed
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 35, 14, 110)
                    .withOpacity(0.1), // Shadow color
                spreadRadius: 1, // Spread radius
                blurRadius: 2, // Blur radius
                offset: const Offset(4, 4), // Offset of the shadow
              ),
            ],
          ),
          child: Row(children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.095,
                    ),
                    Text(
                      title,
                      style: GoogleFonts.lato(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Text(
                      description,
                      style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ))
          ]),
        ),
        Positioned(
            child: Container(
                height: size.height * 0.04,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 182, 179, 252),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ))),
        Positioned(
          left: 20,
          top: 20,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: Container(
              height: size.height * 0.065,
              width: size.width * 0.80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 112, 104, 248),
                    Color.fromARGB(255, 140, 135, 234)
                  ])),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Row(children: [
                  Text(
                    '\$ $amount',
                    style: GoogleFonts.lato(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18.7,
                      )),
                  IconButton(
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 18.7,
                      ))
                ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
