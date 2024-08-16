import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/claim_history.dart';
import 'package:travel_claim/modules/claim_approval/claim_detail_approval_page.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/screens/claimApprovel/claim_confirmation_screen.dart';
import 'package:travel_claim/views/style/colors.dart';

class ClaimApprovalCard extends StatelessWidget {
  final ClaimHistory claim;
  const ClaimApprovalCard({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: 110),
      onTap: (){
         Get.toNamed(ClaimDetailApprovalPage.routeName,arguments: claim);
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
                    tssb("#${claim.tmgId}", Colors.black,FontWeight.w500),



                  ],
                ),
                gapWC(5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ts("Date", Colors.black),
                    gapHC(2),
                    tssb(claim.date, Colors.black,FontWeight.w500),


                  ],
                ),
              ],
            ),
            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ts("Employee ID", Colors.black),
                      gapHC(2),
                      Text(
                        "${claim.userDetails?.name} (${claim.userDetails?.employeeId})",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                gapWC(5),
                tcustom("\u{20B9}${claim.totalAmount.toStringAsFixed(0)}", primaryColor, 18.0, FontWeight.w500),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
