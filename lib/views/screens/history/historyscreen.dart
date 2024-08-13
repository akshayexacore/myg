import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/tabButton.dart';
import 'package:travel_claim/views/screens/history/controller/historyController.dart';
import 'package:travel_claim/views/screens/history/viewd_Innerscreen.dart';
import 'package:travel_claim/views/style/colors.dart';

class Historyscreen extends StatefulWidget {
  const Historyscreen({super.key});

  @override
  State<Historyscreen> createState() => _HistoryscreenState();
}

class _HistoryscreenState extends State<Historyscreen> {
  final Historycontroller historycontroller =
  Get.put(Historycontroller());
  @override
  void initState() {

    historycontroller.pageController = PageController();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                        historycontroller.selectedPage.value,
                        onPressed: () {
                          historycontroller.lstrSelectedPage.value = "Al";
                          historycontroller.fnChangePage(0);
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
                        historycontroller.selectedPage.value,
                        onPressed: () {
                          historycontroller. lstrSelectedPage.value = "Pe";
                          historycontroller.fnChangePage(1);
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
                        historycontroller.selectedPage.value,
                        onPressed: () {
                          historycontroller.lstrSelectedPage.value = "Pd";
                          historycontroller.fnChangePage(2);
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
                        historycontroller.selectedPage.value,
                        onPressed: () {
                          historycontroller.lstrSelectedPage.value = "Rj";
                          historycontroller.fnChangePage(3);
                        },
                        icon: Icons.more_horiz),
                  ),
                ],
              ),
            ),
          ),


          Expanded(
            child: SizedBox(
              width: size.width,
              // decoration: boxDecoration(white, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: PageView(
                      onPageChanged: (int page) {
                        if(mounted){

                          historycontroller.selectedPage.value = page;

                        }
                      },
                      controller: historycontroller.pageController,
                      children: [
                        // 1st page design ------ Choose Item
                        wAllHistoryScreen(MediaQuery.of(context).size),

                        //2nd Page  design -----------------------------------
                        wPendingHistoryScreen(MediaQuery.of(context).size),
                        wPaidHistoryScreen( MediaQuery.of(context).size),
                        wRejectedHistoryScreen( MediaQuery.of(context).size)

                        // 3rd Page for Delivery Details
                        // Container for  1st page   design -----------------------------------
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),)
    ));
  }
}

wPendingHistoryScreen(Size size) {
     return ListView.builder(
      itemCount: 12,
      itemBuilder: (context,index){
        return Bounce(
          duration: Duration(milliseconds: 110),
          onTap: (){
            Get.to(()=>ViewdInnerscreen(status: "Pending",
              statusCouses: "Your claim for the train has been rejected because the bill date and submitted date are different. Additionally, the submitted travel location does not match the location on the train.",
              statusDate: "25/03/2024",
              statusPerson: "Adham(MYG-AAAW)",)
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
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
                    tssb("#TMG1234", Colors.black,FontWeight.w500),
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
}

wPaidHistoryScreen(Size size) {
  return ListView.builder(
      itemCount: 12,
      itemBuilder: (context,index){
        return Bounce(
          duration: Duration(milliseconds: 110),
          onTap: (){
            Get.to(()=>ViewdInnerscreen(status: "Paid",
              statusCouses: "Your claim for the train has been rejected because the bill date and submitted date are different. Additionally, the submitted travel location does not match the location on the train.",
              statusDate: "25/03/2024",
              statusPerson: "Adham(MYG-AAAW)",)
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
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
                    tssb("#TMG1234", Colors.black,FontWeight.w500),
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
}

wRejectedHistoryScreen(Size size) {
  return ListView.builder(
      itemCount: 12,
      itemBuilder: (context,index){
        return Bounce(
          duration: Duration(milliseconds: 110),
          onTap: (){
            Get.to(()=>ViewdInnerscreen(status: "Rejected",
              statusCouses: "Your claim for the train has been rejected because the bill date and submitted date are different. Additionally, the submitted travel location does not match the location on the train.",
              statusDate: "25/03/2024",
              statusPerson: "Adham(MYG-AAAW)",)
            );
            },


          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
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
                    tssb("#TMG1234", Colors.black,FontWeight.w500),
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
}

wAllHistoryScreen(Size size) {
  return ListView.builder(
      itemCount: 12,
      itemBuilder: (context,index){
    return Bounce(
      onTap: (){
        Get.to(()=>ViewdInnerscreen(status: index==0?"Pending":index.isEven?"Paid":"Rejected",
        statusCouses: "Your claim for the train has been rejected because the bill date and submitted date are different. Additionally, the submitted travel location does not match the location on the train.",
       statusDate: "25/03/2024",
        statusPerson: "Adham(MYG-AAAW)",));
      },
      duration: Duration(milliseconds: 110),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
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
                tssb("#TMG1234", Colors.black,FontWeight.w500),
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
}
