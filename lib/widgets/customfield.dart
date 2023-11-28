import 'package:flutter/material.dart';

import '../core/constance.dart';

class CutomField extends StatelessWidget {
  // const CutomField({super.key});
  final String? hint;
  final bool isPassword;
  final dynamic onSaved;
  final dynamic validator;
  final TextEditingController? controller ;

  const CutomField({super.key, this.hint, this.onSaved, this.validator, this.controller,this.isPassword=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: isPassword,
        controller: controller,
        onChanged: onSaved,
        validator: validator,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(40.0))),
            focusColor: secondaryColor,
            hintText: hint,
            fillColor: secondaryColor,
            hoverColor: secondaryColor),
      ),
    );
  }
}
