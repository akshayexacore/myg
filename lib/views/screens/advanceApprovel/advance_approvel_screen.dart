import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/screens/advanceApprovel/advance%20approvel%20inner.dart';
import 'package:travel_claim/views/style/colors.dart';

class AdvanceApprovelScreen extends StatefulWidget {
  const AdvanceApprovelScreen({super.key});

  @override
  State<AdvanceApprovelScreen> createState() => _AdvanceApprovelScreenState();
}

class _AdvanceApprovelScreenState extends State<AdvanceApprovelScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Advance Approvals"),
          body: Padding(
            padding: const EdgeInsets.only(top: 14),
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context,index){
              return Bounce(
              duration: Duration(milliseconds: 110),
              onTap: (){
                Get.to(()=>AdvanceApprovelInner());

              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                decoration: boxOutlineShadowCustom(Colors.white, 10, Colors.grey.shade400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ts("Employee ID", Colors.black),
                            gapHC(2),
                            tssb("Basil(MYGX-2222)", Colors.black,FontWeight.w500),



                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ts("Date", Colors.black),
                            gapHC(2),
                            tssb("22/04/2024", Colors.black,FontWeight.w500),


                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    tcustom("\u{20B9}15,23.00", primaryColor, 18.0, FontWeight.w500),

                  ],
                ),
              ),
              );
            }),
          )
    ));
  }
}
