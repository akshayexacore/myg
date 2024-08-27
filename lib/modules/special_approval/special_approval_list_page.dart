import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/claim_approval/controllers/claim_approval_list_controller.dart';
import 'package:travel_claim/modules/claim_approval/widgets/claim_approval_card.dart';
import 'package:travel_claim/modules/special_approval/controllers/special_approval_list_controller.dart';
import 'package:travel_claim/modules/special_approval/widgets/special_approval_card.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';

class SpecialApprovalListPage extends StatelessWidget {
  SpecialApprovalListPage({Key? key}) : super(key: key);

  static const routeName = '/special_approval_list';

  final _controller = Get.find<SpecialApprovalListController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: customAppBar("Special Approvals"),
            body: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Obx((){

                  if (_controller.isBusy.isTrue) {
                    return const Center(
                        child: SpinKitDoubleBounce(
                          color: primaryColor,
                        ));
                  }

                  if (_controller.items.isEmpty) {
                    return Center(child: ts("No claims for special approval", Colors.black54));
                  }

                  return RefreshIndicator(
                    onRefresh: ()async{
                      _controller.getApprovalList();
                    },
                    child: ListView.builder(
                        itemCount: _controller.items.length,
                        itemBuilder: (context,index){
                          return SpecialApprovalCard(claim: _controller.items[index],);
                        }),
                  );
                })
            )
        ));
  }

}
