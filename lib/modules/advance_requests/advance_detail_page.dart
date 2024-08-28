import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/advance_requests/controllers/advance_detail_controller.dart';
import 'package:travel_claim/utils/app_enums.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class AdvanceDetailPage extends StatelessWidget {
  AdvanceDetailPage({Key? key}) : super(key: key);

  static const routeName = '/advance_detail';

  final _controller = Get.find<AdvanceDetailController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: customAppBar("Advance Request"),
          body: Padding(
            padding:   EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(

                          decoration: boxDecoration(primaryColor, 10),
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ts("Request ID", Colors.white),
                                  gapHC(2),
                                  tssb(_controller.advance.value!.id, Colors.white,FontWeight.w500),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ts("Date", Colors.white),
                                  gapHC(2),
                                  tssb(_controller.advance.value!.date, Colors.white,FontWeight.w500),
                                ],
                              ),
                            ],
                          ),
                        ),
                        gapHC(15),


                        Container(
                          // margin:  EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                          decoration: boxBaseDecoration(greyLight, 10),
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              headTitle("Type of trip", _controller.advance.value!.tripTypeDetails?.name),
                              gapHC(5),
                              headTitle("Branch name", _controller.advance.value!.visitBranchDetail?.name),
                              gapHC(5),
                              headTitle("Purpose of trip", _controller.advance.value!.tripPurpose),
                              gapHC(5),
                              headTitle("Remarks", _controller.advance.value!.remarks,
                                  txtalign: TextAlign.start),
                              gapHC(5),
                              headTitle("Amount", "\u{20B9} ${_controller.advance.value!.totalAmount.toStringAsFixed(2)}",colors: primaryColor,fonsize: 18.0),
                              gapHC(5),
                              headTitle("Status", "${_controller.advance.value!.status.title}",colors: _controller.advance.value!.status.color,fonsize: 18.0),

                            ],
                          ),),
                        gapHC(10),
                      ],
                    ),
                  ),
                ),
                gapHC(20)
              ],
            ),
          ),
        ));
  }

}
