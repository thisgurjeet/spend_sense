import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final VoidCallback ontap;

  const SmallButton({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: const Color.fromARGB(255, 117, 85, 234)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
