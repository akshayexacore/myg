import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/modules/claim_approval/controllers/claim_detail_approval_controller.dart';
import 'package:travel_claim/modules/history/widgets/attached_file_widget.dart';
import 'package:travel_claim/utils/app_formatter.dart';
import 'package:travel_claim/views/components/alertDialog.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/components/textInputField.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class ClaimDetailApprovalPage extends StatelessWidget {
  ClaimDetailApprovalPage({Key? key}) : super(key: key);

  static const routeName = '/claim_detail_approval';

  final _controller = Get.find<ClaimDetailApprovalController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Claim confirmation"),
      body: SingleChildScrollView(
        child: Column(
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
                  headTitle("Amount", "${_controller.claim.value!.totalAmount.toStringAsFixed(2)} INR", colors: primaryColor),
                ],
              ),
            ),
            gapHC(10),
            ExpandedTileList.separated(
              key: ValueKey(_controller.claim.value!.categories!
                  .map(
                    (element) => "${element.id}-${element.name}",
                  )
                  .toList()
                  .join("")),
              itemCount: _controller.claim.value!.categories!.length,
              maxOpened: 2,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              ),
              initiallyOpenedControllersIndexes: [0],
              itemBuilder: (context, index, con) {
                return ExpandedTile(
                  theme: ExpandedTileThemeData(
                    headerColor: greyLight,
                    headerPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                    headerSplashColor: greyLight,
                    contentSeparatorColor: Colors.white,
                    contentBackgroundColor: Colors.white,
                    headerBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: greyLight)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  controller: con,
                  title: tss(_controller.claim.value!.categories![index].name,
                      Colors.black, 15.0),
                  leading: CachedNetworkImage(
                   imageUrl:  _controller.claim.value!.categories![index].imageUrl,
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
                        return ListView.separated(
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
                                                  .tripFrom),
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
                                                  .tripTo),
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
                                              Flexible(
                                                  flex: 5,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      ts(
                                                          "Odometer reading before",
                                                          const Color(0xff333333)
                                                              .withOpacity(0.8)),
                                                      Text(
                                                          _controller
                                                                  .claim
                                                                  .value!
                                                                  .categories![
                                                                      index]
                                                                  .items[formIndex]
                                                                  .odoMeterStart ??
                                                              'NA',
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
                                                        "Odometer reading after",
                                                        const Color(0xff333333)
                                                            .withOpacity(0.8)),
                                                    Text(
                                                        _controller
                                                                .claim
                                                                .value!
                                                                .categories![index]
                                                                .items[formIndex]
                                                                .odoMeterEnd ??
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
                                                  ],
                                                ),
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
                                                      return Container(
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
                                                  ?.name),
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
                                        headTitle("Amount",
                                            "${_controller.claim.value!.categories![index].items[formIndex].amount!.toStringAsFixed(2)} INR"),
                                      ],
                                    ),
                                  ),
                                  gapHC(10),
                                  Row(
                                    children: [
                                      Expanded(
                                          child:Custombutton(onTap: (){
                                            claimConfirmationbutton(context,onTap: (){
                                              Get.back();

                                              /*fToast.showToast(
                                                    child: Center(
                                                      child: showToastMessage(msg: "Claim has been Rejected",
                                                          iconColor: Colors.red,icon: Icons.close_rounded),
                                                    ));*/
                                            },status: 'reject');

                                          }
                                              , buttonName: "Reject",
                                              buttonColor: Colors.white,
                                              buttonBorderColor:Colors.grey.shade400,
                                              buttonTextColor:primaryColor)),
                                      gapWC(10),
                                      Expanded(
                                          child:Custombutton(
                                              onTap:(){
                                                approvalRequest(context,_controller.claim.value!.categories![index],_controller.claim.value!.categories![index].items[formIndex]);
                                              },
                                              buttonName: "Send Approval",
                                              buttonColor: primaryColor,
                                              buttonTextColor: Colors.white)
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(
                                  height: 20,
                                ),
                            itemCount: _controller
                                .claim.value!.categories![index].items.length);
                      }),
                      gapHC(10)
                    ],
                  ),
                  onTap: () {

                  },
                  onLongTap: () {

                  },
                );
              },
            ),
            gapHC(20),
            const Divider(),
            gapHC(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                      child: Custombutton(
                          onTap: () {
                            claimConfirmationbutton(context, onTap: () {
                              Get.back();

                              /*fToast.showToast(
                              child: Center(
                                child: showToastMessage(msg: "All Claim has Rejected",
                                    iconColor: Colors.red,icon: Icons.close_rounded),
                              ));*/
                            }, status: 'rejectall');
                          },
                          buttonName: "Reject all",
                          buttonColor: Colors.white,
                          buttonBorderColor: Colors.grey.shade400,
                          buttonTextColor: primaryColor)),
                  gapWC(20),
                  Expanded(
                      child: Custombutton(
                          onTap: () {
                            claimConfirmationbutton(context, onTap: () {
                              Get.back();
                              /*fToast.showToast(
                                  child: Center(
                                    child: showToastMessage(msg: "All Claim has Approved",
                                        iconColor: Colors.green,icon: Icons.check_circle_rounded),
                                  ));*/
                            }, status: 'approveall');
                          },
                          buttonName: "Approve all",
                          buttonColor: primaryColor,
                          buttonTextColor: Colors.white)),
                ],
              ),
            ),
            gapHC(30)
          ],
        ),
      ),
    ));
  }

  approvalRequest(BuildContext context,Category category,ClaimFormData form) {
    return show(
        context,
         contHeight: MediaQuery.sizeOf(context).height*0.8,
        autoDismiss: false,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      tssb('Approval request for ${category.name}', Colors.black,
                          FontWeight.bold),
                      gapHC(10),
                      const Divider(),
                      gapHC(10),
                      if (category.hasTripFrom)
                        headTitle(
                            "From",
                            form
                                .tripFrom),
                      if (category.hasTripFrom)
                        gapHC(10),
                      if (category.hasTripTo)
                        headTitle(
                            "To",
                            form
                                .tripTo),
                      if (category.hasTripTo)
                        gapHC(10),
                      if (category.hasToDate)
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
                                            form.fromDate!),
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
                                          form.toDate!),
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
                      if (category.hasToDate)
                        gapHC(10),
                      if (category.hasStartMeter)
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
                                        "Odometer reading before",
                                        const Color(0xff333333)
                                            .withOpacity(0.8)),
                                    Text(
                                        form.odoMeterStart ??
                                            'NA',
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
                                      "Odometer reading after",
                                      const Color(0xff333333)
                                          .withOpacity(0.8)),
                                  Text(
                                      form.odoMeterEnd ??
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      if (category.hasStartMeter)
                        gapHC(10),
                      if (!category.hasToDate)
                        headTitle(
                            "Document date",
                            AppFormatter.formatDDMMMYYYY(
                                form.fromDate!)),
                      if (!category.hasToDate)
                        gapHC(10),
                      headTitle(
                          "Number of employees",
                          form.noOfEmployees
                              .toString()),
                      if (form.noOfEmployees >
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
                                children: form.employees
                                    .map(
                                      (e) {
                                    return Container(
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
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        ),
                      gapHC(10),
                      if (form.selectedClass !=
                          null)
                        headTitle(
                            "Class",
                            form
                                .selectedClass
                                ?.name),
                      if (form.selectedClass !=
                          null)
                        gapHC(10),
                      headTitle(
                          "Remark",
                          form.remarks
                              .isEmpty
                              ? 'Nil'
                              : form.remarks),
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
                            child: form
                                .files
                                .isNotEmpty
                                ? AttachedFileWidget(
                              file: form.files
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
                      headTitle("Amount",
                          "${form.amount!.toStringAsFixed(2)} INR"),
                      gapHC(10),
                      Obx(() => Container(
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: boxOutlineCustom(
                                Colors.white, 10, Colors.grey.shade400),
                            child: DropdownButton(
                              focusColor: Colors.white,
                              dropdownColor: Colors.white,
                              underline: const SizedBox(),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              // Initial Value
                              value:
                                  _controller.selectedApprover.value.toString(),
                              isExpanded: true,
                              // Down Arrow Icon
                              icon: const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 13),

                              // Array list of items
                              items:
                                  _controller.approverList.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: ts(
                                    items,
                                    Colors.black,
                                  ),
                                );
                              }).toList(),
                              onChanged: (dynamic value) {
                                _controller.onSelectApprover(value);
                              },
                            ),
                          )),
                      gapHC(10),
                      TextinputfieldContainer(
                          showIcon: false,
                          verticalPadding: 6,
                          maxline: 3,
                          hintText: "Enter your remarks",
                          textInputAction: TextInputAction.done,
                          onSubmitted: () {},
                          isEnable: true,
                          isObscure: false),
                      gapHC(20)
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Custombutton(
                          onTap: () {
                            Get.back();
                          },
                          buttonName: "Close",
                          buttonColor: Colors.white,
                          buttonBorderColor: Colors.grey.shade400,
                          buttonTextColor: Colors.black)),
                  gapWC(20),
                  Expanded(
                      child: Custombutton(
                          onTap: () {
                            claimConfirmationbutton(context, onTap: () {
                              Get.back();
                              Get.back();
                              /*fToast.showToast(
                              child: Center(
                                child: showToastMessage(msg: "Claim has been Approved",
                                    iconColor: Colors.green,icon: Icons.check_circle_rounded),
                              ));*/
                            }, status: 'approve');
                          },
                          buttonName: "Send",
                          buttonColor: primaryColor,
                          buttonTextColor: Colors.white)),
                ],
              ),
            ],
          ),
        ));
  }

  claimConfirmationbutton(BuildContext context, {status, onTap}) {
    var buttontxtst = status == "approve"
        ? 'Approve'
        : status == "reject"
            ? 'Reject'
            : status == "rejectall"
                ? 'Reject all'
                : status == "approveall"
                    ? 'Approve all'
                    : '';
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
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
                                  status == "approve" || status == "approveall"
                                      ? AppAssets.sentpng
                                      : AppAssets.reject),
                              gapHC(20),
                              tcCustomhead(
                                  "Are you sure you want to \n"
                                  "submit the claim?",
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
                                  child: Custombutton(
                                      onTap: (onTap),
                                      buttonName: buttontxtst,
                                      buttonColor: primaryColor,
                                      buttonTextColor: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            ));
      },
    );
  }
}
