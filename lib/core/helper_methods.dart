import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'constance.dart';
Future  navigateTo(context,{required Widget page,bool withHistory =true}){
  return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => page,), (route) => withHistory);
}
Future  toast({required String msg}){
  return Fluttertoast.showToast(msg: msg,
  backgroundColor: primaryColor, textColor: Colors.white,
  );
}
Future  navigateAndReplace(context,{required Widget page}){
  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page,));
}
