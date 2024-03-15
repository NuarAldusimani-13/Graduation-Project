import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';

class Helper {
  static Future<bool?> showToast(String msg) {
    if (Platform.isWindows) return Future.value();
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        // gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  static bool isValidEmail(String email) {
    // Regular expression to validate email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
