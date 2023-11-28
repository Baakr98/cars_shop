import 'package:flutter/material.dart';
import '../core/constance.dart';
import 'normalText.dart';

class CustomBotton extends StatelessWidget {
  // const CustomBotton({super.key});

  final String text;
  final double width;
  final IconData? icon;
  final dynamic onPressed;
  final Color? iconColor;

  const CustomBotton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.width = 200,
      this.icon,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: EdgeInsets.all(10),
        color: primaryColor,
        focusColor: secondaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
            // const SizedBox(width: 5,),
            NormalText(
              text: text,
              color: black,
              fontSize: 18,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
