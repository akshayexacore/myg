import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/notification/controllers/notification_controller.dart';

import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  static const routeName = '/notifications';

  final NotificationController notificationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Notifications"),
      body:ListView.builder(
          itemCount: notificationController.notificationList.length ,
          itemBuilder: (context,index){
            String text = notificationController.notificationList[index]["text"].toString();
            List<TextSpan> spans = parseText(text);
        return  Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          child:       Container(
            decoration: boxOutlineShadowCustom(Colors.white, 10, Colors.grey.shade400),

            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                 Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10,
                        horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("6:22 AM", style: TextStyle(color: Colors.black,
                                fontSize: 12),),
                          ],
                        ),
                       RichText(text: TextSpan(
                         children: spans
                       ))

                      ],
                    ),
                  ),
                ),
                Container(
                  height: 4,
                  decoration: boxDecorationC(primaryColor, 0.0, 0.0, 52, 52),
                ),
              ],
            ) , ),
        );
      })
    )

    );

  }

  List<TextSpan> parseText(String text) {
    List<TextSpan> spans = [];
    RegExp regExp = RegExp(r'\[([a-z]+)\](.*?)\[\/\1\]');
    int start = 0;

    for (Match match in regExp.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(
          text: text.substring(start, match.start),
          style: TextStyle(color: Colors.black),
        ));
      }

      String colorName = match.group(1)!;
      String content = match.group(2)!;

      Color color;
      switch (colorName) {
        case 'red':
          color = Colors.red;
          break;
        case 'green':
          color = Colors.green;
          break;
      // Add more colors if needed
        default:
          color = Colors.black;
          break;
      }

      spans.add(TextSpan(
        text: content,
        style: TextStyle(color: color),
      ));

      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: TextStyle(color: Colors.black),
      ));
    }

    return spans;
  }
}
