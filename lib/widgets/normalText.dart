import 'package:flutter/material.dart';

import '../core/constance.dart';


class NormalText extends StatelessWidget {
  // const NormalText({super.key});
  final String text;
  final double fontSize;
  final Color color;
  final Alignment alignment;

  const NormalText(
      {this.text = '',
      this.fontSize = 16,
      this.color = primaryColor,
      this.alignment = Alignment.topLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: alignment,
        child: Text(
          text,
          style: TextStyle(
            // fontFamily: 'Gothic',
            fontStyle: FontStyle.normal,
            // fontWeight: FontWeight.w800,
            fontSize: fontSize,
            color: color,
          ),
        ));
  }
}
