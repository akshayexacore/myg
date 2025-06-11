import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/screens/claimApprovel/claim_confirmation_screen.dart';
import 'package:travel_claim/views/style/colors.dart';

class ClaimApprovelScreen extends StatefulWidget {
  const ClaimApprovelScreen({super.key});

  @override
  State<ClaimApprovelScreen> createState() => _ClaimApprovelScreenState();
}

class _ClaimApprovelScreenState extends State<ClaimApprovelScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: customAppBar("Claim Approvalss"),
            body: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context,index){
                return Bounce(
                  duration: Duration(milliseconds: 110),
                  onTap: (){
          Get.to(()=>ClaimConfirmationScreen());

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    decoration: boxOutlineShadowCustom(Colors.white, 10, Colors.grey.shade400),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                ts("Trip ID", Colors.black),
                                gapHC(2),
                                tssb("#TMG1234", Colors.black,FontWeight.w500),



                              ],
                            ),
                            gapWC(5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ts("Employee ID", Colors.black),
                                gapHC(2),
                                tssb("Basil(MYGX-2222)", Colors.black,FontWeight.w500),



                              ],
                            ),
                            gapWC(5),
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

                        tcustom("\u{20B9}15,23.00", primaryColor, 18.0, FontWeight.w500),

                      ],
                    ),
                  ),
                );
              })
            )
        ));
  }
}
