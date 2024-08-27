import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_claim/main.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class AppDialog {
  static   showDialog({
    String? title,
    String? content,
    String? positiveText,
    String? negativeText,
    VoidCallback? positiveOnPressed,
    VoidCallback? negativeOnPressed,
    bool dismissible = false,
  }) {
  return  Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: 320.0,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff120D26),
                    ),
                    textAlign: TextAlign.center,
                  ),
                if (content != null)
                  Column(
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF2D2D2D),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                if (negativeText != null || positiveText != null)
                  Column(
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          if (negativeText != null)
                            Expanded(
                              child: Bounce(
                                duration: const Duration(seconds: 110),
                                onTap: negativeOnPressed,
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 12),

                                  decoration: boxBaseDecoration(Colors.grey, 10),
                                  child: Center(child: tc(negativeText, Colors.white,14)),

                                ),
                              ),
                            ),
                          if (positiveText != null && negativeText != null)
                            const SizedBox(
                              width: 8.0,
                            ),
                          if (positiveText != null)
                            Expanded(
                              child: Bounce(
                                duration: const Duration(seconds: 110),
                                onTap: positiveOnPressed,
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 12),

                                  decoration: boxBaseDecoration(primaryColor, 10),
                                  child: Center(child: tc(positiveText, Colors.white,14)),

                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        barrierDismissible: dismissible);
  }

  static showSnackBar(String title, String message) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      margin: const EdgeInsets.all(0),
      colorText: Colors.white,
      borderRadius: 0.0,
    );
  }

  static showToast(String message,{bool isError = false}) {
    late FToast fToast;
    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
    fToast.showToast(
      child: showToastMessage(msg: message,
          iconColor: isError ? Colors.red : Colors.green,icon: isError ? Icons.error_rounded : Icons.check_circle_rounded),
    );
    /*Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: primaryColor,
        textColor: Colors.white,
        fontSize: 14.0
    );*/
  }
}
