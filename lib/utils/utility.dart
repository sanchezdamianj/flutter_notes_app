import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final List<Color> predefinedColors = [
  const Color(0xffFD99FF),
  const Color(0xffFF9E9E),
  const Color(0xfffedc56),
  const Color(0xfffca3b7),
  const Color(0xff91F48F),
  const Color(0xffB69CFF),
  const Color(0xff9EFFFF),
];

void toast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0);
}
