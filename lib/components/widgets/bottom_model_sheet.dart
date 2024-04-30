import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:spend_sense/components/widgets/small_button.dart';
import 'package:spend_sense/components/widgets/text_input_field.dart';
import 'package:spend_sense/model/transaction_model.dart';

import 'package:spend_sense/view_model/transaction_services.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime selectedDate =
      DateTime.now(); // Initialize with the current date and time

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  double parseDouble(String input) {
    try {
      return double.parse(input);
    } catch (e) {
      print('Error parsing double: $e');
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    double amount = parseDouble(amountController.text);
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height * 0.75,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Transaction',
                style: GoogleFonts.getFont(
                  'Lato',
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 126, 95, 239),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              TextInputField(
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  hintText: 'amount'),
              SizedBox(
                height: size.height * 0.015,
              ),
              TextInputField(
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  hintText: 'title'),
              SizedBox(
                height: size.height * 0.015,
              ),
              TextInputField(
                  keyboardType: TextInputType.text,
                  controller: descriptionController,
                  hintText: 'description'),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate.toLocal().toString().split(' ')[0],
                    style: const TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 153, 125, 251),
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 153, 125, 251),
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              SmallButton(
                ontap: () {
                  TransactionServices().addNewTransaction(TransactionModel(
                      userId: userId,
                      title: titleController.text,
                      shortDescription: descriptionController.text,
                      amount: amount,
                      date: selectedDate.toString()));
                  Navigator.of(context).pop();
                },
                height: size.height * 0.06,
                width: size.width * 0.40,
                text: 'Add Transaction',
              )
            ],
          ),
        ),
      ),
    );
  }
}
