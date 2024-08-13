import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/screens/cmdApproels/cmdApprovelinnner.dart';
import 'package:travel_claim/views/style/colors.dart';

class CmdapprovelScreen extends StatefulWidget {
  const CmdapprovelScreen({super.key});

  @override
  State<CmdapprovelScreen> createState() => _CmdapprovelScreenState();
}

class _CmdapprovelScreenState extends State<CmdapprovelScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar("CMD Approvals"),
          body: Padding(
            padding: const EdgeInsets.only(top: 14),
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context,index){
                  return Bounce(
                    duration: Duration(milliseconds: 110),
                    onTap: (){
                     Get.to(()=>Cmdapprovelinnner());

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
                                  ts("Trip ID", Colors.black),
                                  gapHC(2),
                                  tssb("#TMG1234", Colors.black,FontWeight.w500),



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
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                                       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ts("Employee ID", Colors.black),
                                  ts("Amount", Colors.black),
                                ],
                              ),
                              gapWC(20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  tssb("Basil(MYGX-123)", Colors.black,FontWeight.w500),

                                  tssb("\u{20B9}15,23.00", Colors.black,FontWeight.w500),

                                ],
                              ),
                            ],
                          ),
                      //    tcustom("\u{20B9}15,23.00", primaryColor, 18.0, FontWeight.w500),

                        ],
                      ),
                    ),
                  );
                }),
          )
      ),
    );
  }
}
