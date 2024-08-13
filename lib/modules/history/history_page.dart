
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/drafts/controllers/draft_controller.dart';
import 'package:travel_claim/modules/history/controllers/history_controller.dart';
import 'package:travel_claim/modules/history/history_detail_page.dart';
import 'package:travel_claim/utils/app_formatter.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/tabButton.dart';
import 'package:travel_claim/views/screens/history/viewd_Innerscreen.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  static const routeName = '/history';

  final _controller = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar("History"),
        body: Obx(()=>Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                //decoration: boxDecoration(Colors.white, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TabButton(
                          width: 0.3,
                          text: " All",
                          isShowIcon: false,
                          isWhite: true,
                          tabcolor: primaryColor,
                          pageNumber: 0,
                          selectedPage:
                          _controller.selectedPage.value,
                          onPressed: () {
                            _controller.lstrSelectedPage.value = "Al";
                            _controller.fnChangePage(0);
                          },
                          icon: Icons.person_2_outlined),
                    ),

                    Flexible(
                      child: TabButton(
                          width: 0.3,
                          isShowIcon: false,
                          isWhite: true,
                          text: "Pending",
                          pageNumber: 1,
                          tabcolor: primaryColor,
                          selectedPage:
                          _controller.selectedPage.value,
                          onPressed: () {
                            _controller. lstrSelectedPage.value = "Pe";
                            _controller.fnChangePage(1);
                          },
                          icon: Icons.shopping_cart_outlined),
                    ),

                    Flexible(
                      child: TabButton(
                          width: 0.3,
                          text: "Paid",
                          pageNumber: 2,
                          tabcolor: primaryColor,
                          isShowIcon: false,
                          isWhite: true,
                          selectedPage:
                          _controller.selectedPage.value,
                          onPressed: () {
                            _controller.lstrSelectedPage.value = "Pd";
                            _controller.fnChangePage(2);
                          },
                          icon: Icons.more_horiz),
                    ),
                    Flexible(
                      child: TabButton(
                          width: 0.3,
                          text: "Rejected",
                          pageNumber: 3,
                          tabcolor: primaryColor,
                          isShowIcon: false,
                          isWhite: true,
                          selectedPage:
                          _controller.selectedPage.value,
                          onPressed: () {
                            _controller.lstrSelectedPage.value = "Rj";
                            _controller.fnChangePage(3);
                          },
                          icon: Icons.more_horiz),
                    ),
                  ],
                ),
              ),
            ),


            Expanded(
              child: PageView(
                onPageChanged: (int page) {
                   _controller.selectedPage.value = page;
                },
                controller: _controller.pageController,
                children: [
                  wAllHistoryScreen(),
                  wPendingHistoryScreen(),
                  wPaidHistoryScreen( ),
                  wRejectedHistoryScreen( )
                ],
              ),
            ),
          ],
        ),)
    ));
  }

  wPendingHistoryScreen() {
    return Obx((){
      if(_controller.isBusy.isTrue){
        return const Center(child: SpinKitDoubleBounce(color: primaryColor,));
      }

      if(_controller.pendingItems.isEmpty){
        return Center(child: ts("No pending claims", Colors.black54));
      }

      return ListView.builder(
          itemCount: _controller.pendingItems.length,
          itemBuilder: (context,index){
            return Bounce(
              duration: const Duration(milliseconds: 110),
              onTap: (){
                Get.toNamed(HistoryDetailPage.routeName,arguments: _controller.pendingItems[index]);
              },
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
                        tssb("#${_controller.pendingItems[index].tripClaimId}", Colors.black,FontWeight.w500),
                        gapHC(5),
                        Container(
                          height: 26,
                          width: 90,
                          //     padding: EdgeInsets.symmetric(vertical: 2,horizontal: 20),
                          decoration: boxDecoration(yellowpending, 20),
                          child: Center(child: tssb("Pending", Colors.white, FontWeight.w500)),
                        )

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ts("Date", Colors.black),
                        gapHC(2),
                        tssb("22/04/2024", Colors.black,FontWeight.w500),
                        gapHC(5),
                        tcustom("\u{20B9}15,23.00", primaryColor, 18.0, FontWeight.w500),

                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    });

  }

  wPaidHistoryScreen() {
    return Obx((){
      if(_controller.isBusy.isTrue){
        return const Center(child: SpinKitDoubleBounce(color: primaryColor,));
      }

      if(_controller.paidItems.isEmpty){
        return Center(child: ts("No paid claims", Colors.black54));
      }

      return ListView.builder(
          itemCount: _controller.paidItems.length,
          itemBuilder: (context,index){
            return Bounce(
              duration: const Duration(milliseconds: 110),
              onTap: (){
                Get.toNamed(HistoryDetailPage.routeName,arguments: _controller.paidItems[index]);
              },
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
                        tssb("#${_controller.paidItems[index].tripClaimId}", Colors.black,FontWeight.w500),
                        gapHC(5),
                        Container(
                          height: 26,
                          width: 90,
                          //   padding: EdgeInsets.symmetric(vertical: 2,horizontal: 20),
                          decoration: boxDecoration(Colors.green, 20),
                          child: Center(child: tssb("Paid", Colors.white, FontWeight.w500)),
                        )

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ts("Date", Colors.black),
                        gapHC(2),
                        tssb("22/04/2024", Colors.black,FontWeight.w500),
                        gapHC(5),
                        tcustom("\u{20B9}15,23.00", primaryColor, 18.0, FontWeight.w500),

                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    });

  }

  wRejectedHistoryScreen() {
    return Obx((){
      if(_controller.isBusy.isTrue){
        return const Center(child: SpinKitDoubleBounce(color: primaryColor,));
      }

      if(_controller.rejectedItems.isEmpty){
        return Center(child: ts("No rejected claims", Colors.black54));
      }
      return ListView.builder(
          itemCount: _controller.rejectedItems.length,
          itemBuilder: (context,index){
            return Bounce(
              duration: const Duration(milliseconds: 110),
              onTap: (){
                Get.toNamed(HistoryDetailPage.routeName,arguments: _controller.rejectedItems[index]);
              },


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
                        tssb("#${_controller.paidItems[index].tripClaimId}", Colors.black,FontWeight.w500),
                        gapHC(5),
                        Container(
                          height: 26,
                          width: 90,
                          //  padding: EdgeInsets.symmetric(vertical: 2,horizontal: 20),
                          decoration: boxDecoration(pinkreject, 20),
                          child: Center(child: tssb("Rejected", Colors.white, FontWeight.w500)),
                        )

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ts("Date", Colors.black),
                        gapHC(2),
                        tssb("22/04/2024", Colors.black,FontWeight.w500),
                        gapHC(5),
                        tcustom("\u{20B9}15,23.00", primaryColor, 18.0, FontWeight.w500),

                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }

  wAllHistoryScreen() {
    return Obx((){
      if(_controller.isBusy.isTrue){
        return const Center(child: SpinKitDoubleBounce(color: primaryColor,));
      }

      if(_controller.allItems.isEmpty){
        return Center(child: ts("No items in history", Colors.black54));
      }
      return ListView.builder(
          itemCount: _controller.allItems.length,
          itemBuilder: (context,index){
            return Bounce(
              onTap: (){
                Get.toNamed(HistoryDetailPage.routeName,arguments: _controller.allItems[index]);
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
                        tssb("#${_controller.allItems[index].tripClaimId}", Colors.black,FontWeight.w500),
                        gapHC(5),
                        Container(     height: 26,
                          width: 90,

                          //   padding: EdgeInsets.symmetric(vertical: 2,horizontal: 20),
                          decoration: boxDecoration(index==0?yellowpending:index.isEven?Colors.green:pinkreject, 20),
                          child: Center(child: tssb(index==0?"Pending":index.isEven?"Paid":"Rejected", Colors.white, FontWeight.w500)),
                        )

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ts("Date", Colors.black),
                        gapHC(2),
                        tssb("22/04/2024", Colors.black,FontWeight.w500),
                        gapHC(5),
                        tcustom("\u{20B9}15,23.00", primaryColor, 18.0, FontWeight.w500),

                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }
}
