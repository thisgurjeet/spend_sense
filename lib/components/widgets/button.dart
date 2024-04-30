import 'package:flutter/material.dart';

import 'package:spend_sense/components/app_colors.dart';

class Button extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const Button({Key? key, required this.onTap, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.backgroundColor,
                    Color.fromARGB(255, 174, 148, 248),
                  ])),
          child: Center(
            child: child,
          )),
    );
  }
}
