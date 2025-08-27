import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/claim_history.dart';
import 'package:travel_claim/modules/history/history_detail_page.dart';
import 'package:travel_claim/utils/app_enums.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';

class ClaimHistoryCard extends StatelessWidget {
  final ClaimHistory claim;
  const ClaimHistoryCard({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: (){
        Get.toNamed(
  HistoryDetailPage.routeName,
  arguments: {
    'claim': claim,
    'id': claim.tripClaimId, // or any other ID you want
  },
);
      },
      duration: const Duration(milliseconds: 110),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        decoration: boxOutlineShadowCustom(Colors.white, 10, Colors.grey.shade400),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ts("Trip ID", Colors.black),
                gapHC(2),
                tssb("#${claim.tmgId}", Colors.black,FontWeight.w500),
                gapHC(5),
                Row(
                  children: [
                    Container(     height: 26,
                      width: 90,

                      //   padding: EdgeInsets.symmetric(vertical: 2,horizontal: 20),
                      decoration: boxDecoration(claim.status.color, 20),
                      child: Center(child: tssb(claim.status.title, Colors.white, FontWeight.w500)),
                    ),
                    if(claim.status == ClaimStatus.pending)
                      SizedBox(width: 7,),
                    if(claim.status == ClaimStatus.pending)
                      Text(claim.pendingFrom,style: TextStyle(color: const Color(0xff333333).withOpacity(0.8),fontSize: 12,fontWeight: FontWeight.w400),)
                  ],
                )

              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ts("Date", Colors.black),
                gapHC(2),
                tssb(claim.date, Colors.black,FontWeight.w500),
                gapHC(5),
                tcustom("\u{20B9}${claim.totalAmount}", primaryColor, 18.0, FontWeight.w500),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
