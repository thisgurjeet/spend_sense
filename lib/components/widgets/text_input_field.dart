import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  final TextInputType keyboardType;
  const TextInputField(
      {Key? key,
      required this.keyboardType,
      required this.controller,
      required this.hintText,
      this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(143, 148, 251, 1),
                blurRadius: 8,
                offset: Offset(0, 2))
          ]),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.065,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
        child: TextField(
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey.shade400))),
      ),
    );
  }
}
