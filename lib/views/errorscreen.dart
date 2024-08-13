


import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';


class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            children: [],
          ),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              Image.asset("assets/gifs/nointernet.gif",width: 200,),
              tss('Connection Lost', Colors.black, 15.0),
              tcn('Server connection lost, try again', Colors.black, 10.0),
              gapHC(10),
              Bounce(
                duration: const Duration(milliseconds: 110),
                onTap: (){
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 8),
                  decoration: boxBaseDecoration(primaryColor.withOpacity(0.2), 30),
                  child: tcn('Close', Colors.black, 12.0),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
