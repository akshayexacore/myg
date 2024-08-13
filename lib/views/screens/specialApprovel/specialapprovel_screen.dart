import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/screens/specialApprovel/specialApprovelinner.dart';

class SpecialapprovelScreen extends StatefulWidget {
  const SpecialapprovelScreen({super.key});

  @override
  State<SpecialapprovelScreen> createState() => _SpecialapprovelScreenState();
}

class _SpecialapprovelScreenState extends State<SpecialapprovelScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: customAppBar("Special Approvals"),
          body: Padding(
            padding: const EdgeInsets.only(top: 14),
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context,index){
                  return Bounce(
                    duration: const Duration(milliseconds: 110),
                    onTap: (){
                    Get.to(()=>Specialapprovelinner());

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
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
                          gapHC(5),
                          tssb('Special approval for Lodging', Colors.black,FontWeight.w500)

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
