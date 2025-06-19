
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/claim/widgets/form_item.dart';
import 'package:travel_claim/modules/history/controllers/history_detail_controller.dart';
import 'package:travel_claim/modules/history/widgets/attached_file_widget.dart';
import 'package:travel_claim/utils/app_enums.dart';
import 'package:travel_claim/utils/app_formatter.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:path/path.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class ClaimResubmitPage extends StatelessWidget {
  ClaimResubmitPage({Key? key}) : super(key: key);

  static const routeName = '/claim_resubmit';

  final _controller = Get.find<HistoryDetailController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Claim Resubmit"),
      body: Obx((){
        if(_controller.isBusy.isTrue){
          return const Center(child: SpinKitDoubleBounce(color: primaryColor,));
        }

        return SingleChildScrollView(
          child: Form(
            key: _controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gapHC(10),
                Container(
                  margin:  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: boxDecoration(primaryColor, 10),
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ts("Trip ID", Colors.white),
                          gapHC(2),
                          tssb("#${_controller.claim.value!.tmgId}", Colors.white,FontWeight.w500),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ts("Date", Colors.white),
                          gapHC(2),
                          tssb(_controller.claim.value!.date, Colors.white,FontWeight.w500),
                        ],
                      ),
                    ],
                  ),
                ),


                Container(
                  margin:  const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  decoration: boxBaseDecoration(greyLight, 10),
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  child: Column(
                    children: [
                      headTitle("Type of trip", _controller.claim.value!.tripTypeDetails?.name ?? ''),
                      gapHC(3),
                      headTitle("Branch name", _controller.claim.value!.visitBranchDetail?.map((e)=>e.name).join(',') ?? ''),
                      gapHC(3),
                      headTitle("Purpose of trip", _controller.claim.value!.tripPurpose),
                    ],
                  ),),


                Container(
                  margin:  const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                  decoration: boxBaseDecoration(greyLight, 10),
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ts("Reporting person approval", Colors.black),
                          tssb(_controller.claim.value!.approverStatus.title,_controller.claim.value!.approverStatus.color,FontWeight.w700)

                        ],
                      ),

                      gapHC(2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ts("Finance approval", Colors.black),
                          tssb(_controller.claim.value!.financeStatus.title,
                              _controller.claim.value!.financeStatus.color,
                              FontWeight.w700)

                        ],
                      ),

                      gapHC(10),

                      _controller.claim.value!.status==ClaimStatus.pending?const SizedBox(): Column(
                        children: [
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ts("${_controller.claim.value!.status.title} Date", Colors.black),
                              tssb(_controller.claim.value!.status==ClaimStatus.approved ? _controller.claim.value!.tripApprovedDate : _controller.claim.value!.status==ClaimStatus.rejected ? _controller.claim.value!.tripRejectedDate : _controller.claim.value!.financeApprovedDate ,
                                  Colors.black,
                                  FontWeight.w500)

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ts(_controller.claim.value!.status== ClaimStatus.rejected ?"Rejected person": _controller.claim.value!.status== ClaimStatus.approved ? "Approved Reporting person" :"Approved Finance person", Colors.black),
                              Expanded(
                                child: Text(
                                  _controller.claim.value!.status== ClaimStatus.rejected||_controller.claim.value!.status== ClaimStatus.approved ? "${_controller.claim.value!.approverDetails?.name} (${_controller.claim.value!.approverDetails?.employeeId})" : "${_controller.claim.value!.financeApproverDetails?.name} (${_controller.claim.value!.financeApproverDetails?.employeeId})",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              )

                            ],
                          ),
                        ],
                      ),

                      gapHC(10),





                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 26,
                            width: 90,
                            //  padding: EdgeInsets.symmetric(vertical: 2,horizontal: 30),
                            decoration: boxBaseDecoration(  _controller.claim.value!.status.color, 20),
                            child: Center(child: tssb(_controller.claim.value!.status.title, Colors.white, FontWeight.w500)),
                          ),
                          tcustom("\u{20B9}${_controller.claim.value!.totalAmount.toStringAsFixed(2)}", primaryColor, 18.0, FontWeight.w500),

                        ],
                      ),


                    ],
                  ),),

                const Padding(
                  padding:   EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: Divider(),
                ),
                _controller.claim.value!.status==ClaimStatus.rejected  ? Padding(
                  padding:   const EdgeInsets.symmetric(horizontal: 15,vertical: 5),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tssb("Reason for rejection", Colors.black, FontWeight.w400),
                      gapHC(5),
                      ts('NA', Colors.black.withOpacity(0.6))

                    ],
                  ),
                ):const SizedBox(),





                Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: tssb("Categories", Colors.black, FontWeight.w600),
                ),
                const SizedBox(height: 15,),
                ExpandedTileList.separated(
                  key: ValueKey(_controller.reSubmittedCategories!
                      .map(
                        (element) => "${element.id}-${element.name}",
                  )
                      .toList()
                      .join("")),
                  itemCount: _controller.reSubmittedCategories!.length,
                  maxOpened: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 12,
                  ),
                  initiallyOpenedControllersIndexes: [0],
                  itemBuilder: (context, index, con) {
                   bool hasRejected =  _controller.reSubmittedCategories![index].items.map((e) => e.status == ClaimStatus.rejected,).toList().isNotEmpty;
                    return ExpandedTile(
                      theme: ExpandedTileThemeData(
                        headerColor: greyLight,
                        headerPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 9),
                        headerSplashColor: greyLight,
                        contentSeparatorColor: Colors.white,
                        contentBackgroundColor: Colors.white,
                        headerBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:  BorderSide(color: hasRejected ? Colors.red : greyLight)),
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 8),
                      ),
                      controller: con,
                      title: tss(_controller.reSubmittedCategories[index].name,
                          Colors.black,
                          15.0),
                      leading: Image.network(
                        _controller.reSubmittedCategories[index].imageUrl,
                        height: 25,
                        width: 25,
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_down,
                        color: primaryColor.withOpacity(0.8),
                        size: 24,
                      ),
                      trailingRotation: 180,
                      contentseparator: 8,
                      content: Column(
                        children: [
                          Obx(() {
                            debugPrint(_controller.isFormAddBusy.isTrue.toString());
                            if (_controller.isFormAddBusy.isTrue) {
                              // do nothing
                            }
                            return ListView.separated(
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, formIndex) {
                                  return FormItem(
                                    category: _controller
                                        .reSubmittedCategories[index],
                                    formData: _controller
                                        .reSubmittedCategories[index]
                                        .items[formIndex],
                                    index: formIndex + 1,
                                    onDelete: formIndex > 0
                                        ? () {
                                      _controller
                                          .reSubmittedCategories[index]
                                          .items
                                          .removeAt(formIndex);
                                      _controller
                                          .emitFormChange();
                                    }
                                        : null,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                const Divider(
                                  color: greyLight,
                                  height: 30,
                                ),
                                itemCount: _controller
                                    .reSubmittedCategories[index]
                                    .items
                                    .length);
                          }),
                          gapHC(10)
                        ],
                      ),
                      onTap: () {
                        debugPrint("tapped!!");
                      },
                      onLongTap: () {
                        debugPrint("looooooooooong tapped!!");
                      },
                    );
                  },
                ),
                gapHC(15),
                if(showBottomActions())
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    child: Text("You can edit and resubmit the claim only once. If you resubmit this claim, you cannot resubmit it again.",style: TextStyle(color: Color(0xff333333).withOpacity(0.8),fontSize: 14),),
                  ),
                if(showBottomActions())
                  gapHC(15),
                if(showBottomActions())
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                            child: Custombutton(
                                onTap: () {
                                  Get.back();
                                },
                                buttonName: "Cancel",
                                buttonColor: Colors.white,
                                buttonBorderColor: Colors.grey.shade400,
                                buttonTextColor: Colors.black)),
                        gapWC(20),
                        Expanded(
                            child: Obx((){
                              if (_controller.isReSubmitBusy.isTrue) {
                                return const SpinKitThreeBounce(
                                  color: primaryColor,
                                  size: 20,
                                );
                              }
                              return Custombutton(
                                  onTap: _controller.gotoResubmitPreview,
                                  buttonName: "Re - submit",
                                  buttonColor: primaryColor,
                                  buttonTextColor: Colors.white);
                            })),
                      ],
                    ),
                  ),
                if(showBottomActions())
                gapHC(25),
              ],
            ),
          ),
        );
      }),
    ));
  }

  bool showBottomActions(){
    return _controller.claim.value!.tripHistoryStatus == ClaimStatus.rejected || _controller.claim.value!.status == ClaimStatus.rejected;
  }
}
