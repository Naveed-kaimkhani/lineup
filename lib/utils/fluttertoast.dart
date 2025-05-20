import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterToastUtil {
  static void showToast({required String text}) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT, // You can change this to LENGTH_LONG if needed
      gravity: ToastGravity.BOTTOM, // Adjust position (e.g., BOTTOM, CENTER, TOP)
      timeInSecForIosWeb: 1, // Duration for iOS/Web
      backgroundColor: Colors.black.withOpacity(0.8), // Customize toast background color
      textColor: Colors.white, // Customize text color
      fontSize: 16.0, // Adjust font size
    );
  }
}
