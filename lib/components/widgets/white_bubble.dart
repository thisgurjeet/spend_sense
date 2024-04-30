import 'package:flutter/material.dart';

class WhiteBubble extends StatelessWidget {
  const WhiteBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: const Opacity(
        opacity: 0.20,
        child: Image(
          image: AssetImage(
            'assets/images/rename.png',
          ),
        ),
      ),
    );
  }
}
