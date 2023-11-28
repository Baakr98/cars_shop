import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  // const CustomText({super.key});
  final String text;
  final double fontSize;
  final Color color;

  // ignore: use_key_in_widget_constructors
  CustomText({
    this.text = '',
    this.fontSize = 16,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          // fontFamily: 'Gothic',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w800,
          fontSize: fontSize,
          color: color,
        ));
  }
}
