import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/models/employee.dart';
import 'package:travel_claim/modules/claim_approval/claim_detail_approval_page.dart';
import 'package:travel_claim/modules/claim_approval/controllers/claim_detail_approval_controller.dart';
import 'package:travel_claim/modules/history/widgets/attached_file_widget.dart';
import 'package:travel_claim/modules/special_approval/controllers/special_detail_approval_controller.dart';
import 'package:travel_claim/utils/app_enums.dart';
import 'package:travel_claim/utils/app_formatter.dart';
import 'package:travel_claim/views/components/alertDialog.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/components/textInputField.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class SpecialDetailApprovalPage extends StatelessWidget {
  SpecialDetailApprovalPage({Key? key}) : super(key: key);

  static const routeName = '/special_detail_approval';

  final _controller = Get.find<SpecialDetailApprovalController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Special Approvals"),
      body: Obx((){
        if (_controller.isBusy.isTrue) {
          return const Center(
              child: SpinKitDoubleBounce(
                color: primaryColor,
              ));
        }

        if (_controller.claim.value!.tmgId.isEmpty) {
          return Center(child: ts("Claim details not found!", Colors.black54));
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: boxDecoration(primaryColor, 10),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ts("Trip ID", Colors.white),
                        gapHC(2),
                        tssb("#${_controller.claim.value!.tmgId}", Colors.white, FontWeight.w500),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ts("Date", Colors.white),
                        gapHC(2),
                        tssb(_controller.claim.value!.date, Colors.white, FontWeight.w500),
                      ],
                    ),
                  ],
                ),
              ),
              gapHC(5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: boxBaseDecoration(greyLight, 10),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    headTitle("Employee ID", "${_controller.claim.value!.userDetails?.name} (${_controller.claim.value!.userDetails?.employeeId})"),
                    gapHC(5),
                    headTitle("Base Location", "${_controller.claim.value!.userDetails?.empBaseLocation}"),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    headTitle("Type of trip", _controller.claim.value!.tripTypeDetails?.name ?? ''),
                    gapHC(7),
                    headTitle("Branch name", _controller.claim.value!.visitBranchDetail?.name ?? ''),
                    gapHC(7),
                    headTitle("Purpose of trip", _controller.claim.value!.tripPurpose),
                    gapHC(7),
                    /* headTitle("Claim period", "21/02/2024-22/02/2024"),
                  gapHC(7),*/
                    headTitle("Amount", "${_controller.claim.value!.categories!
                        .expand((category) => category.items)
                        .toList().map((v) => v).toList().map((e) => e.amount,).toList().fold(0.0, (sum, item) => sum + item!.toDouble()).toStringAsFixed(2)} INR", colors: primaryColor),
                  ],
                ),
              ),
              gapHC(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: tssb(_controller.claim.value!.status==ClaimStatus.rejected ? "Reason for rejection" : "Remarks", Colors.black, FontWeight.w400),
              ),
              Builder(builder: (context) {
                List<Category> cats = _controller.claim.value!.categories!;

                return ListView.builder(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cats[index].items.map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tssb("${cats[index].name}:", Colors.black, FontWeight.w400),
                          gapHC(5),
                          Container(
                                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15,),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:Border.all(color:  Color(0xffFF2424)),
                            color: Color(0xffFFEDED)
                          ),
                            child: ts(e.approverRemarks.isNotEmpty ? e.approverRemarks : 'NA', Colors.black.withOpacity(0.6)))
                        ],
                      );
                    },).toList(),
                  );
                },itemCount: cats.length,);
              },),

              gapHC(10),

              ListView.separated(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemBuilder: (context, index) {
                 return Column(
                   children: [
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 12,vertical: 9),
                       margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                       decoration: BoxDecoration(
                         color: Color(0xffE2E2E2),
                         borderRadius: BorderRadius.circular(8)
                       ),
                       child: Row(
                         children: [
                           CachedNetworkImage(
                             imageUrl:  _controller.claim.value!.categories![index].imageUrl,
                             height: 25,
                             width: 25,
                           ),
                           SizedBox(width: 15,),
                           tss(_controller.claim.value!.categories![index].name,
                               Colors.black, 15.0)
                         ],
                       ),
                     ),
                     ListView.separated(
                         shrinkWrap: true,
                         physics: const NeverScrollableScrollPhysics(),
                         itemBuilder: (context, formIndex) {
                           return Column(
                             children: [
                               Container(
                                 padding: const EdgeInsets.symmetric(
                                     horizontal: 20, vertical: 20),
                                 decoration: boxBaseDecoration(greyLight, 0),
                                 child: Column(
                                   children: [
                                     if (_controller.claim.value!
                                         .categories![index].hasTripFrom)
                                       headTitle(
                                           "From",
                                           _controller
                                               .claim
                                               .value!
                                               .categories![index]
                                               .items[formIndex]
                                               .tripFrom ?? ''),
                                     if (_controller.claim.value!
                                         .categories![index].hasTripFrom)
                                       gapHC(10),
                                     if (_controller.claim.value!
                                         .categories![index].hasTripTo)
                                       headTitle(
                                           "To",
                                           _controller
                                               .claim
                                               .value!
                                               .categories![index]
                                               .items[formIndex]
                                               .tripTo ?? ''),
                                     if (_controller.claim.value!
                                         .categories![index].hasTripTo)
                                       gapHC(10),
                                     if (_controller.claim.value!
                                         .categories![index].hasToDate)
                                       Row(
                                         mainAxisAlignment:
                                         MainAxisAlignment.spaceBetween,
                                         crossAxisAlignment:
                                         CrossAxisAlignment.start,
                                         children: [
                                           Flexible(
                                               flex: 5,
                                               child: Column(
                                                 crossAxisAlignment:
                                                 CrossAxisAlignment.start,
                                                 children: [
                                                   ts(
                                                       "Checked In",
                                                       const Color(0xff333333)
                                                           .withOpacity(0.8)),
                                                   Text(
                                                       AppFormatter
                                                           .formatDDMMMYYYY(
                                                           _controller
                                                               .claim
                                                               .value!
                                                               .categories![
                                                           index]
                                                               .items[
                                                           formIndex]
                                                               .fromDate!),
                                                       style: const TextStyle(
                                                           fontFamily: 'Roboto',
                                                           fontSize: 14,
                                                           fontWeight:
                                                           FontWeight.w700,
                                                           color: Color(
                                                               0xff333333)))
                                                 ],
                                               )),
                                           Expanded(
                                             flex: 5,
                                             child: Column(
                                               crossAxisAlignment:
                                               CrossAxisAlignment.start,
                                               children: [
                                                 ts(
                                                     "Checked Out",
                                                     const Color(0xff333333)
                                                         .withOpacity(0.8)),
                                                 Text(
                                                     AppFormatter
                                                         .formatDDMMMYYYY(
                                                         _controller
                                                             .claim
                                                             .value!
                                                             .categories![
                                                         index]
                                                             .items[
                                                         formIndex]
                                                             .toDate!),
                                                     textAlign: TextAlign.left,
                                                     overflow: TextOverflow.fade,
                                                     style: const TextStyle(
                                                         fontFamily: 'Roboto',
                                                         fontSize: 14,
                                                         fontWeight:
                                                         FontWeight.bold,
                                                         color:
                                                         Color(0xff333333))),
                                               ],
                                             ),
                                           ),
                                         ],
                                       ),
                                     if (_controller.claim.value!
                                         .categories![index].hasToDate)
                                       gapHC(10),
                                     if (_controller.claim.value!
                                         .categories![index].hasStartMeter)
                                       Row(
                                         mainAxisAlignment:
                                         MainAxisAlignment.spaceBetween,
                                         crossAxisAlignment:
                                         CrossAxisAlignment.start,
                                         children: [
                                          //  Flexible(
                                          //      flex: 5,
                                          //      child: Column(
                                          //        crossAxisAlignment:
                                          //        CrossAxisAlignment.start,
                                          //        children: [
                                          //          ts(
                                          //              "Odometer reading before",
                                          //              const Color(0xff333333)
                                          //                  .withOpacity(0.8)),
                                          //          Text(
                                          //              _controller
                                          //                  .claim
                                          //                  .value!
                                          //                  .categories![
                                          //              index]
                                          //                  .items[formIndex]
                                          //                  .odoMeterStart ??
                                          //                  'NA',
                                          //              style: const TextStyle(
                                          //                  fontFamily: 'Roboto',
                                          //                  fontSize: 14,
                                          //                  fontWeight:
                                          //                  FontWeight.w700,
                                          //                  color: Color(
                                          //                      0xff333333)))
                                          //        ],
                                          //      )),
                                           Expanded(
                                             flex: 5,
                                             child: ts(
                                                 "Total dometer reading",
                                                 const Color(0xff333333)
                                                     .withOpacity(0.8)),
                                           ),
                                           Expanded(
                                             flex: 5,
                                             child: Text(
                                                    "${ _controller
                                                         .claim
                                                         .value!
                                                         .categories![index]
                                                         .items[formIndex]
                                                         .odoMeterEnd} KM "??
                                                         'NA',
                                                     textAlign: TextAlign.left,
                                                     overflow: TextOverflow.fade,
                                                     style: const TextStyle(
                                                         fontFamily: 'Roboto',
                                                         fontSize: 14,
                                                         fontWeight:
                                                         FontWeight.bold,
                                                         color:
                                                         Color(0xff333333))),
                                           ),
                                         ],
                                       ),
                                     if (_controller.claim.value!
                                         .categories![index].hasStartMeter)
                                       gapHC(10),
                                     if (!_controller.claim.value!
                                         .categories![index].hasToDate)
                                       headTitle(
                                           "Document date",
                                           AppFormatter.formatDDMMMYYYY(
                                               _controller
                                                   .claim
                                                   .value!
                                                   .categories![index]
                                                   .items[formIndex]
                                                   .fromDate!)),
                                     if (!_controller.claim.value!
                                         .categories![index].hasToDate)
                                       gapHC(10),
                                     headTitle(
                                         "Number of employees",
                                         _controller
                                             .claim
                                             .value!
                                             .categories![index]
                                             .items[formIndex]
                                             .noOfEmployees
                                             .toString()),
                                     if (_controller
                                         .claim
                                         .value!
                                         .categories![index]
                                         .items[formIndex]
                                         .noOfEmployees >
                                         1)
                                       Row(
                                         mainAxisAlignment:
                                         MainAxisAlignment.spaceBetween,
                                         crossAxisAlignment:
                                         CrossAxisAlignment.start,
                                         children: [
                                           const Flexible(
                                               flex: 5, child: SizedBox()),
                                           Expanded(
                                             flex: 5,
                                             child: Column(
                                               crossAxisAlignment:
                                               CrossAxisAlignment.start,
                                               children: _controller
                                                   .claim
                                                   .value!
                                                   .categories![index]
                                                   .items[formIndex]
                                                   .employees
                                                   .map(
                                                     (e) {
                                                   return Column(
                                                     children: [
                                                       Container(
                                                         padding: const EdgeInsets
                                                             .symmetric(
                                                             vertical: 5,
                                                             horizontal: 6),
                                                         margin:
                                                         const EdgeInsets.only(
                                                             bottom: 2),
                                                         decoration: BoxDecoration(
                                                             borderRadius:
                                                             BorderRadius
                                                                 .circular(14),
                                                             color: primaryColor),
                                                         child: ts(
                                                             '${e.name}(${e.employeeId})',
                                                             Colors.white),
                                                             
                                                       ),
                                                        if (e.isDuplication ==
                                                                true)
                                                              DuplicationText(
                                                                id: e
                                                                    .duplicationId
                                                                    .toString(),
                                                                remark: _controller
                                                                        .claim
                                                                        .value!
                                                                        .categories![
                                                                            index]
                                                                        .items[
                                                                            formIndex]
                                                                        .remarks
                                                                        .isEmpty
                                                                    ? 'Nil'
                                                                    : _controller
                                                                        .claim
                                                                        .value!
                                                                        .categories![
                                                                            index]
                                                                        .items[
                                                                            formIndex]
                                                                        .remarks,
                                                                perosns: _controller
                                                                    .claim
                                                                    .value!
                                                                    .categories![
                                                                        index]
                                                                    .items[
                                                                        formIndex]
                                                                    .employees
                                                                    .map((e) =>
                                                                        e.name)
                                                                    .join(","),
                                                              )
                                                     ],
                                                   );
                                                   
                                                 },
                                               ).toList(),
                                             ),
                                           ),
                                         ],
                                       ),
                                     gapHC(10),
                                     if (_controller
                                         .claim
                                         .value!
                                         .categories![index]
                                         .items[formIndex]
                                         .selectedClass !=
                                         null)
                                       headTitle(
                                           "Class",
                                           _controller
                                               .claim
                                               .value!
                                               .categories![index]
                                               .items[formIndex]
                                               .selectedClass
                                               ?.name ?? ''),
                                     if (_controller
                                         .claim
                                         .value!
                                         .categories![index]
                                         .items[formIndex]
                                         .selectedClass !=
                                         null)
                                       gapHC(10),
                                     headTitle(
                                         "Remark",
                                         _controller
                                             .claim
                                             .value!
                                             .categories![index]
                                             .items[formIndex]
                                             .remarks
                                             .isEmpty
                                             ? 'Nil'
                                             : _controller
                                             .claim
                                             .value!
                                             .categories![index]
                                             .items[formIndex]
                                             .remarks),
                                     gapHC(10),
                                     Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       crossAxisAlignment:
                                       CrossAxisAlignment.start,
                                       children: [
                                         Flexible(
                                             flex: 5,
                                             child: ts(
                                                 "Attached files",
                                                 const Color(0xff333333)
                                                     .withOpacity(0.8))),
                                         Expanded(
                                           flex: 5,
                                           child: _controller
                                               .claim
                                               .value!
                                               .categories![index]
                                               .items[formIndex]
                                               .files
                                               .isNotEmpty
                                               ? AttachedFileWidget(
                                             file: _controller
                                                 .claim
                                                 .value!
                                                 .categories![index]
                                                 .items[formIndex]
                                                 .files
                                                 .first,
                                           )
                                               : const Text("Nil",
                                               style: TextStyle(
                                                   fontFamily: 'Roboto',
                                                   fontSize: 14,
                                                   fontWeight:
                                                   FontWeight.w700,
                                                   color:
                                                   Color(0xff333333))),
                                         ),
                                       ],
                                     ),
                                     gapHC(10),
                                     headTitle("Amount", "${_controller.claim.value!.categories![index].items[formIndex].amount!.toStringAsFixed(2)} INR"),

                                     Obx(() {
                                       if (_controller.claim.value!.categories![index].items[formIndex].selectedClass != null &&
                                           _controller.claim.value!.categories![index].items[formIndex].selectedClass?.policy?.gradeAmount != null &&
                                           _controller.claim.value!.categories![index].items[formIndex].amount != null) {
                                         double max = _controller.claim.value!.categories![index].items[formIndex].eligibleAmount ?? _controller.claim.value!.categories![index].items[formIndex].selectedClass!.policy!.gradeAmount!;
                                         double totalKms = 0;
                                         if (_controller.claim.value!.categories![index].hasStartMeter) {
                                           double start =
                                               double.tryParse(_controller.claim.value!.categories![index].items[formIndex].odoMeterStart ?? '0') ?? 0;
                                           double end =
                                               double.tryParse(_controller.claim.value!.categories![index].items[formIndex].odoMeterEnd ?? '0') ?? 0;
                                           if (start == 0 && end == 0) {
                                             return const SizedBox.shrink();
                                           }

                                           totalKms = end - start;

                                           max = totalKms *
                                               _controller.claim.value!.categories![index].items[formIndex].selectedClass!.policy!.gradeAmount!;
                                         }

                                         if (_controller.claim.value!.categories![index].items[formIndex].amount! > max) {
                                           return Padding(
                                             padding: const EdgeInsets.only(top: 5),
                                             child: headTitle("",
                                               "(Eligible amount ${max.toStringAsFixed(2)} INR ${_controller.claim.value!.categories![index].hasStartMeter ? 'for $totalKms Kms @ ${_controller.claim.value!.categories![index].items[formIndex].selectedClass!.policy!.gradeAmount!} INR/Km' : ''})",
                                               colors: Colors.red,
                                             ),
                                           );
                                         }
                                         return const SizedBox.shrink();
                                       }
                                       return const SizedBox.shrink();
                                     }),
                                     gapHC(10),
                                     if(_controller.claim.value!.categories![index].items[formIndex].status != ClaimStatus.pending)
                                       headTitle("Status", "${_controller.claim.value!.categories![index].items[formIndex].status.title}",colors: _controller.claim.value!.categories![index].items[formIndex].status.color),
                                     if(_controller.claim.value!.categories!
                                         .expand((category) => category.items)
                                         .toList().where((e) => e.status == ClaimStatus.pending,).toList().length >1 && _controller.claim.value!.categories![index].items[formIndex].status == ClaimStatus.pending)
                                     gapHC(10),
                                     if(_controller.claim.value!.categories!
                                         .expand((category) => category.items)
                                         .toList().where((e) => e.status == ClaimStatus.pending,).toList().length >1 && _controller.claim.value!.categories![index].items[formIndex].status == ClaimStatus.pending)
                                       Row(
                                         children: [
                                           Expanded(
                                               child:Obx((){
                                                 if(_controller.isUpdateBusy.isTrue){
                                                   return const SpinKitThreeBounce(color:primaryColor,size: 20,);
                                                 }
                                                 return Custombutton(onTap: (){
                                                   claimConfirmationButton(context,status: "reject",onTap:  (){
                                                     _controller.rejectSingle(_controller.claim.value!.categories![index].items[formIndex]);
                                                   });

                                                 }
                                                     , buttonName: "Reject",
                                                     buttonColor: Colors.white,
                                                     buttonBorderColor:Colors.grey.shade400,
                                                     buttonTextColor:primaryColor);
                                               })),
                                         ],
                                       ),
                                   ],
                                 ),
                               ),
                               gapHC(10),
                               ],
                           );
                         },
                         separatorBuilder: (context, index) =>
                         const Divider(
                           height: 20,
                         ),
                         itemCount: _controller
                             .claim.value!.categories![index].items.length),
                   ],
                 );
              }, separatorBuilder: (context, index) => SizedBox(height: 15,), itemCount: _controller.claim.value!.categories!.length),
              if(showBottomActions())
              Divider(),
              gapHC(5),
              if(showBottomActions())
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ts("Remarks", Colors.black),
                  ],
                ),
              ),
              gapHC(3),
              if(showBottomActions())
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextinputfieldContainer(
                    showIcon: false,
                    controller: _controller.textEditingControllerConfirmRemarks,
                    verticalPadding: 6,
                    maxline: 3,
                    textInputAction: TextInputAction.done,
                    hintText: "Enter your remarks",
                    isEnable: showBottomActions(),
                    isObscure: false),
              ),
              gapHC(20),
              if(showBottomActions())
              const Divider(),
              if(showBottomActions())
              gapHC(20),
              if(showBottomActions())
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                        child: Obx((){
                          if (_controller.isUpdateBusy.isTrue) {
                            return const SpinKitDoubleBounce(
                              color: primaryColor,
                            );
                          }
                          return Custombutton(
                              onTap: () {
                                specialApprovals(context,"reject", (){

                                  _controller.approveOrRejectAll(isReject: true);
                                });
                              },
                              buttonName: "Reject All",
                              buttonColor: Colors.white,
                              buttonBorderColor: Colors.grey.shade400,
                              buttonTextColor: Colors.black);
                        })),
                    gapWC(20),
                    Expanded(
                        child: Obx((){
                          if (_controller.isUpdateBusy.isTrue) {
                            return const SpinKitDoubleBounce(
                              color: primaryColor,
                            );
                          }
                          return Custombutton(
                              onTap: () {
                                specialApprovals(context,"approve", (){
                                  _controller.approveOrRejectAll(isReject: false);
                                });
                              },
                              buttonName: "Approve All",
                              buttonColor: primaryColor,
                              buttonTextColor: Colors.white);
                        })),
                  ],
                ),
              ),
              gapHC(30)
            ],
          ),
        );
      }),
    ));
  }

  bool showBottomActions(){
    bool canResubmit = _controller.claim.value!.categories!
        .expand((category) => category.items)
        .toList().where((e) => e.status == ClaimStatus.pending).toList().isNotEmpty;
    return canResubmit;
  }

  specialApprovals(BuildContext context,status,ontap){
    String txtst = status=="approve"?"approve":status=="reject"?"reject":"";
    String buttontxtst = status=="approve"?"Approve":status=="reject"?"Reject":"";
    return Get.bottomSheet(

      Container(
          height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width,

          decoration: boxBaseDecorationC(Colors.white, 20, 20, 0, 0),
          child:  Padding(
            padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(status=="approve"? AppAssets.sentpng:AppAssets.reject),
                      gapHC(20),
                      tcCustomhead("Are you sure you want to \n"
                          "${txtst} the special approvals?", Colors.black87,
                          size: 21.0,
                          align: TextAlign.center, FontWeight.w500)
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child:Custombutton(onTap: (){
                          Get.back();
                        }
                            , buttonName: "Cancel",
                            buttonColor: Colors.white,
                            buttonBorderColor:Colors.grey.shade400,
                            buttonTextColor: Colors.black)),
                    gapWC(20),
                    Expanded(
                        child:Obx((){
                          if (_controller.isUpdateBusy.isTrue) {
                            return const SpinKitDoubleBounce(
                              color: primaryColor,
                            );
                          }
                          return Custombutton(onTap:ontap,
                              buttonName: buttontxtst,
                              buttonColor: primaryColor,
                              buttonTextColor: Colors.white);
                        })
                    ),
                  ],
                ),

              ],
            ),
          )
      ),


      isDismissible: false,


      enableDrag: false,

    );
  }

  claimConfirmationButton(BuildContext context, {status,required VoidCallback onTap}) {
    var buttonText = status == "approve"
        ? 'Approve'
        : status == "reject"
        ? 'Reject'
        : status == "reject_all"
        ? 'Reject all'
        : status == "approve_all"
        ? 'Approve all'
        : '';
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return PopScope(
          canPop: true,
          onPopInvoked: (val){
            _controller.textEditingControllerConfirmRemarks.clear();
          },
          child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: boxDecoration(Colors.white, 20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              //  mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    status == "approve" || status == "approve_all"
                                        ? AppAssets.sentpng
                                        : AppAssets.reject),
                                gapHC(20),
                                tcCustomhead(
                                    "Are you sure you want to \n"
                                        "${buttonText.toLowerCase()} the claim?",
                                    Colors.black87,
                                    size: 21.0,
                                    align: TextAlign.center,
                                    FontWeight.w500),
                                gapHC(30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ts("Remarks", Colors.black),
                                  ],
                                ),
                                gapHC(3),
                                TextinputfieldContainer(
                                    showIcon: false,
                                    verticalPadding: 6,
                                    maxline: 3,
                                    controller: _controller.textEditingControllerConfirmRemarks,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: () {},
                                    hintText: "Enter your remarks",
                                    isEnable: true,
                                    isObscure: false),
                              ],
                            ),
                            gapHC(30),
                            Row(
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
                                      if (_controller.isUpdateBusy.isTrue) {
                                        return const SpinKitDoubleBounce(
                                          color: primaryColor,
                                        );
                                      }
                                      return Custombutton(
                                          onTap: onTap,
                                          buttonName: buttonText,
                                          buttonColor: primaryColor,
                                          buttonTextColor: Colors.white);
                                    })),
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              )),
        );
      },
    );
  }
}
