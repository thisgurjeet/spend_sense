import 'package:flutter/material.dart';

import '../app_colors.dart';

class BlueBubble extends StatelessWidget {
  const BlueBubble({super.key});

  @override
  Widget build(BuildContext context) {
    ColorFilter colorFilter =
        const ColorFilter.mode(AppColors.backgroundColor, BlendMode.srcIn);

    return Container(
        height: MediaQuery.of(context).size.height * 0.22,
        child: ColorFiltered(
          colorFilter: colorFilter,
          child: const Opacity(
            opacity: 0.35,
            child: Image(
              image: AssetImage(
                'assets/images/rename.png',
              ),
            ),
          ),
        ));
  }
}
