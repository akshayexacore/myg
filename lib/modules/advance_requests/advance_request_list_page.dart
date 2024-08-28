import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/advance/advance_request_page.dart';
import 'package:travel_claim/modules/advance_requests/advance_detail_page.dart';
import 'package:travel_claim/modules/advance_requests/controllers/advance_request_list_controller.dart';
import 'package:travel_claim/utils/app_enums.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/style/colors.dart';

class AdvanceRequestListPage extends StatelessWidget {
  AdvanceRequestListPage({Key? key}) : super(key: key);

  static const routeName = '/advance_requests_list';

  final _controller = Get.find<AdvanceRequestListController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: customAppBar("Advance Requests"),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Get.toNamed(AdvanceRequestPage.routeName);
              },
              label: Text('Request Advance',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),),
              icon: SvgPicture.asset(AppAssets.reqAdv_img,fit: BoxFit.fill,color: Colors.white,height: 20,),
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), // Customize the radius for rounded corners
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                    return Center(child: ts("No requests", Colors.black54));
                  }

                  return RefreshIndicator(
                    onRefresh: ()async{
                      _controller.getAdvanceList();
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(15,10,15,70),
                        itemCount: _controller.items.length,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              Get.toNamed(AdvanceDetailPage.routeName,arguments: _controller.items[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: boxOutlineCustom(Colors.white, 10.0, Colors.grey.shade400),
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ts("Date", Colors.black),
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 30),
                                        decoration: boxDecoration(_controller.items[index].status.color, 20),
                                        child: tssb(_controller.items[index].status.title, Colors.white, FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  tssb(_controller.items[index].date, textColor, FontWeight.w500,height: 0.9),
                                  gapHC(8),
                                  const Divider(),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ts("Type of Trip", Colors.black),
                                            Text(
                                              _controller.items[index].tripTypeDetails?.name ?? '',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  color: textColor,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 6,),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ts("Branch", Colors.black),
                                            Text(
                                              _controller.items[index].visitBranchDetail?.name ?? '',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  color: textColor,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 6,),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ts("Amount", Colors.black),
                                            Text(
                                              "\u{20B9} ${_controller.items[index].totalAmount.toStringAsFixed(2)}",
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                })
            )
        ));
  }

}
