import 'package:flutter/material.dart' show StatelessWidget;
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;

import '../constants/colors.dart' show ksecondaryBackgroundColor, ktextColor;

class Leading extends StatelessWidget {
  final bool isDark;
  const Leading({super.key, required this.number, required this.isDark});

  final String number;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45, // or whatever size your SVG is
      height: 45,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'Assets/images/muslim (1) 1.svg',
            height: 45,
            width: 45,
            fit: BoxFit.contain,
          ),
          Text(
            '$number',
            style: TextStyle(
              fontSize: 15, // Adjust as needed
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: isDark ? ksecondaryBackgroundColor : ktextColor,
            ),
          ),
        ],
      ),
    );
  }
}
