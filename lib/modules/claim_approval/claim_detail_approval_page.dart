import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/models/employee.dart';
import 'package:travel_claim/modules/claim_approval/controllers/claim_detail_approval_controller.dart';
import 'package:travel_claim/modules/history/widgets/attached_file_widget.dart';
import 'package:travel_claim/modules/landing/controllers/profile_controller.dart';
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
import 'package:collection/collection.dart';

class ClaimDetailApprovalPage extends StatelessWidget {
  ClaimDetailApprovalPage({Key? key}) : super(key: key);

  static const routeName = '/claim_detail_approval';

  final _controller = Get.find<ClaimDetailApprovalController>();
  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Claim approval"),
      body: Obx(() {
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: boxDecoration(primaryColor, 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ts("Trip ID", Colors.white),
                        gapHC(2),
                        tssb("#${_controller.claim.value!.tmgId}", Colors.white,
                            FontWeight.w500),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ts("Date", Colors.white),
                        gapHC(2),
                        tssb(_controller.claim.value!.date, Colors.white,
                            FontWeight.w500),
                      ],
                    ),
                  ],
                ),
              ),
              gapHC(5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: boxBaseDecoration(greyLight, 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    headTitle("Employee ID",
                        "${_controller.claim.value!.userDetails?.name} (${_controller.claim.value!.userDetails?.employeeId})"),
                    gapHC(5),
                    headTitle("Base Location",
                        "${_controller.claim.value!.userDetails?.empBaseLocation}"),
                  ],
                ),
              ),
              gapHC(5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: boxBaseDecoration(greyLight, 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _controller.claim.value!.status == ClaimStatus.pending
                        ? const SizedBox()
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ts("${_controller.claim.value!.status.title} Date",
                                      Colors.black),
                                  tssb(
                                      _controller.claim.value!.status ==
                                              ClaimStatus.approved
                                          ? _controller
                                              .claim.value!.tripApprovedDate
                                          : _controller.claim.value!.status ==
                                                  ClaimStatus.rejected
                                              ? _controller
                                                  .claim.value!.tripRejectedDate
                                              : _controller.claim.value!
                                                  .financeApprovedDate,
                                      Colors.black,
                                      FontWeight.w500)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ts(
                                      _controller.claim.value!.status ==
                                              ClaimStatus.rejected
                                          ? "Rejected person"
                                          : _controller.claim.value!.status ==
                                                  ClaimStatus.approved
                                              ? "Approved Reporting person"
                                              : "Approved Finance person",
                                      Colors.black),
                                  Expanded(
                                    child: Text(
                                      _controller.claim.value!.status ==
                                                  ClaimStatus.rejected ||
                                              _controller.claim.value!.status ==
                                                  ClaimStatus.approved
                                          ? "${_controller.claim.value!.approverDetails?.name} (${_controller.claim.value!.approverDetails?.employeeId})"
                                          : "${_controller.claim.value!.financeApproverDetails?.name} (${_controller.claim.value!.financeApproverDetails?.employeeId})",
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
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
                    if (_controller.claim.value!.status != ClaimStatus.pending)
                      gapHC(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 26,
                          width: 90,
                          //  padding: EdgeInsets.symmetric(vertical: 2,horizontal: 30),
                          decoration: boxBaseDecoration(
                              _controller.claim.value!.tripHistoryStatus.color,
                              20),
                          child: Center(
                              child: tssb(
                                  _controller
                                      .claim.value!.tripHistoryStatus.title,
                                  Colors.white,
                                  FontWeight.w500)),
                        ),
                        tcustom(
                            "\u{20B9}${_controller.claim.value!.totalAmount.toStringAsFixed(2)}",
                            primaryColor,
                            18.0,
                            FontWeight.w500),
                      ],
                    ),
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
                    headTitle("Type of trip",
                        _controller.claim.value!.tripTypeDetails?.name ?? ''),
                    gapHC(7),
                    headTitle("Branch name",
                        _controller.claim.value!.visitBranchDetail?.name ?? ''),
                    gapHC(7),
                    headTitle("Purpose of trip",
                        _controller.claim.value!.tripPurpose),
                    gapHC(7),
                    /* headTitle("Claim period", "21/02/2024-22/02/2024"),
                  gapHC(7),*/
                    headTitle("Amount",
                        "${_controller.claim.value!.totalAmount.toStringAsFixed(2)} INR",
                        colors: primaryColor),
                  ],
                ),
              ),
              gapHC(10),
              _controller.claim.value!.status != ClaimStatus.pending
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tssb(
                              _controller.claim.value!.status ==
                                      ClaimStatus.rejected
                                  ? "Reason for rejection"
                                  : "Remarks",
                              Colors.black,
                              FontWeight.w400),
                          if (_controller
                              .claim.value!.tripApproverRemarks.isNotEmpty)
                            gapHC(5),
                          if (_controller
                              .claim.value!.tripApproverRemarks.isNotEmpty)
                            ts(_controller.claim.value!.tripApproverRemarks,
                                Colors.black.withOpacity(0.6))
                        ],
                      ),
                    )
                  : const SizedBox(),
              Builder(
                builder: (context) {
                  List<Category> cats =
                      _controller.claim.value!.categories!.where(
                    (element) {
                      return element.items
                          .where((e) => e.status == ClaimStatus.rejected)
                          .isNotEmpty;
                    },
                  ).toList();

                  return ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: cats[index].items.map(
                          (e) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                tssb("${cats[index].name}:", Colors.black,
                                    FontWeight.w400),
                                gapHC(5),
                                ts('${e.approverRemarks}',
                                    Colors.black.withOpacity(0.6))
                              ],
                            );
                          },
                        ).toList(),
                      );
                    },
                    itemCount: cats.length,
                  );
                },
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
                maxOpened: 20,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                initiallyOpenedControllersIndexes:
                    _controller.claim.value!.categories!
                        .mapIndexed(
                          (index, element) => index,
                        )
                        .toList(),
                itemBuilder: (context, index, con) {
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
                          borderSide: const BorderSide(color: greyLight)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    controller: con,
                    title: tss(_controller.claim.value!.categories![index].name,
                        Colors.black, 15.0),
                    leading: CachedNetworkImage(
                      imageUrl:
                          _controller.claim.value!.categories![index].imageUrl,
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
                                      decoration:
                                          boxBaseDecoration(greyLight, 0),
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
                                                        .tripFrom ??
                                                    ''),
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
                                                        .tripTo ??
                                                    ''),
                                          if (_controller.claim.value!
                                              .categories![index].hasTripTo)
                                            gapHC(10),
                                          if (_controller.claim.value!
                                              .categories![index].hasToDate)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                    flex: 5,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ts(
                                                            "Checked In",
                                                            const Color(
                                                                    0xff333333)
                                                                .withOpacity(
                                                                    0.8)),
                                                        Text(
                                                            _controller
                                                                        .claim
                                                                        .value!
                                                                        .categories![
                                                                            index]
                                                                        .items[
                                                                            formIndex]
                                                                        .fromDate !=
                                                                    null
                                                                ? AppFormatter.formatDDMMMYYYY(_controller
                                                                    .claim
                                                                    .value!
                                                                    .categories![
                                                                        index]
                                                                    .items[
                                                                        formIndex]
                                                                    .fromDate!)
                                                                : "nill",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Color(
                                                                    0xff333333)))
                                                      ],
                                                    )),
                                                Expanded(
                                                  flex: 5,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ts(
                                                          "Checked Out",
                                                          const Color(
                                                                  0xff333333)
                                                              .withOpacity(
                                                                  0.8)),
                                                      Text(
                                                          _controller
                                                                      .claim
                                                                      .value!
                                                                      .categories![
                                                                          index]
                                                                      .items[
                                                                          formIndex]
                                                                      .toDate !=
                                                                  null
                                                              ? AppFormatter.formatDDMMMYYYY(
                                                                  _controller
                                                                      .claim
                                                                      .value!
                                                                      .categories![
                                                                          index]
                                                                      .items[
                                                                          formIndex]
                                                                      .toDate!)
                                                              : "",
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xff333333))),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Flexible(
                                                //     flex: 5,
                                                //     child: Column(
                                                //       crossAxisAlignment:
                                                //           CrossAxisAlignment
                                                //               .start,
                                                //       children: [
                                                //         ts(
                                                //             "Odometer reading before",
                                                //             const Color(
                                                //                     0xff333333)
                                                //                 .withOpacity(
                                                //                     0.8)),
                                                //         Text(
                                                //             _controller
                                                //                     .claim
                                                //                     .value!
                                                //                     .categories![
                                                //                         index]
                                                //                     .items[
                                                //                         formIndex]
                                                //                     .odoMeterStart ??
                                                //                 'NA',
                                                //             style: const TextStyle(
                                                //                 fontFamily:
                                                //                     'Roboto',
                                                //                 fontSize: 14,
                                                //                 fontWeight:
                                                //                     FontWeight
                                                //                         .w700,
                                                //                 color: Color(
                                                //                     0xff333333)))
                                                //       ],
                                                //     )),
                                                Expanded(
                                                  flex: 5,
                                                  child: ts(
                                                      "Odometer reading after",
                                                      const Color(0xff333333)
                                                          .withOpacity(0.8)),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                      "${_controller.claim.value!.categories![index].items[formIndex].odoMeterEnd} KM" ??
                                                          'NA',
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style: const TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xff333333))),
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
                                             _controller
                                                        .claim
                                                        .value!
                                                        .categories![index]
                                                        .items[formIndex]
                                                        .fromDate!=null?       AppFormatter.formatDDMMMYYYY(
                                                    _controller
                                                        .claim
                                                        .value!
                                                        .categories![index]
                                                        .items[formIndex]
                                                        .fromDate!):"Nill"),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Flexible(
                                                    flex: 5, child: SizedBox()),
                                                Expanded(
                                                  flex: 5,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: _controller
                                                        .claim
                                                        .value!
                                                        .categories![index]
                                                        .items[formIndex]
                                                        .employees
                                                        .map(
                                                      (e) {
                                                        return Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      6),
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 2),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14),
                                                              color:
                                                                  primaryColor),
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
                                                        ?.name ??
                                                    ''),
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
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Color(
                                                                0xff333333))),
                                              ),
                                            ],
                                          ),
                                          gapHC(10),
                                          headTitle("Amount",
                                              "${_controller.claim.value!.categories![index].items[formIndex].amount!.toStringAsFixed(2)} INR"),
                                          Obx(() {
                                            if (_controller
                                                        .claim
                                                        .value!
                                                        .categories![index]
                                                        .items[formIndex]
                                                        .selectedClass !=
                                                    null &&
                                                _controller
                                                        .claim
                                                        .value!
                                                        .categories![index]
                                                        .items[formIndex]
                                                        .selectedClass
                                                        ?.policy
                                                        ?.gradeAmount !=
                                                    null &&
                                                _controller
                                                        .claim
                                                        .value!
                                                        .categories![index]
                                                        .items[formIndex]
                                                        .amount !=
                                                    null) {
                                              double max = _controller
                                                      .claim
                                                      .value!
                                                      .categories![index]
                                                      .items[formIndex]
                                                      .eligibleAmount ??
                                                  _controller
                                                      .claim
                                                      .value!
                                                      .categories![index]
                                                      .items[formIndex]
                                                      .selectedClass!
                                                      .policy!
                                                      .gradeAmount!;
                                              double totalKms = 0;
                                              if (_controller
                                                  .claim
                                                  .value!
                                                  .categories![index]
                                                  .hasStartMeter) {
                                                double start = double.tryParse(
                                                        _controller
                                                                .claim
                                                                .value!
                                                                .categories![
                                                                    index]
                                                                .items[
                                                                    formIndex]
                                                                .odoMeterStart ??
                                                            '0') ??
                                                    0;
                                                double end = double.tryParse(
                                                        _controller
                                                                .claim
                                                                .value!
                                                                .categories![
                                                                    index]
                                                                .items[
                                                                    formIndex]
                                                                .odoMeterEnd ??
                                                            '0') ??
                                                    0;
                                                if (start == 0 && end == 0) {
                                                  return const SizedBox
                                                      .shrink();
                                                }

                                                totalKms = end - start;

                                                max = totalKms *
                                                    _controller
                                                        .claim
                                                        .value!
                                                        .categories![index]
                                                        .items[formIndex]
                                                        .selectedClass!
                                                        .policy!
                                                        .gradeAmount!;
                                              }

                                              if (_controller
                                                      .claim
                                                      .value!
                                                      .categories![index]
                                                      .items[formIndex]
                                                      .amount! >
                                                  max) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: headTitle(
                                                    "",
                                                    "(Eligible amount ${max.toStringAsFixed(2)} INR ${_controller.claim.value!.categories![index].hasStartMeter ? 'for $totalKms Kms @ ${_controller.claim.value!.categories![index].items[formIndex].selectedClass!.policy!.gradeAmount} INR/Km' : ''})",
                                                    colors: Colors.red,
                                                  ),
                                                );
                                              }
                                              return const SizedBox.shrink();
                                            }
                                            return const SizedBox.shrink();
                                          }),
                                          gapHC(10),
                                          if (_controller
                                                  .claim
                                                  .value!
                                                  .categories![index]
                                                  .items[formIndex]
                                                  .status !=
                                              ClaimStatus.pending)
                                            headTitle("Status",
                                                "${_controller.claim.value!.categories![index].items[formIndex].status.title}",
                                                colors: _controller
                                                    .claim
                                                    .value!
                                                    .categories![index]
                                                    .items[formIndex]
                                                    .status
                                                    .color),
                                        ],
                                      ),
                                    ),
                                    gapHC(10),
                                    if (_controller
                                                .claim
                                                .value!
                                                .categories![index]
                                                .items[formIndex]
                                                .status ==
                                            ClaimStatus.resubmitted ||
                                        _controller
                                                .claim
                                                .value!
                                                .categories![index]
                                                .items[formIndex]
                                                .status ==
                                            ClaimStatus.pending)
                                      Row(
                                        children: [
                                          Expanded(child: Obx(() {
                                            if (_controller
                                                .isUpdateBusy.isTrue) {
                                              return const SpinKitThreeBounce(
                                                color: primaryColor,
                                                size: 20,
                                              );
                                            }
                                            return Custombutton(
                                                onTap: () {
                                                  claimConfirmationButton(
                                                      context, onTap: () {
                                                    _controller.rejectSingle(
                                                        _controller
                                                            .claim
                                                            .value!
                                                            .categories![index]
                                                            .items[formIndex]);
                                                  }, status: 'reject');
                                                },
                                                buttonName: "Reject",
                                                buttonColor: Colors.white,
                                                buttonBorderColor:
                                                    Colors.grey.shade400,
                                                buttonTextColor: primaryColor);
                                          })),
                                          gapWC(10),
                                          Expanded(
                                              child: AbsorbPointer(
                                            absorbing: !_controller
                                                .claim
                                                .value!
                                                .categories![index]
                                                .items[formIndex]
                                                .sentForApproval,
                                            child: Custombutton(
                                                onTap: () {
                                                  approvalRequest(
                                                      context,
                                                      _controller.claim.value!
                                                          .categories![index],
                                                      _controller
                                                          .claim
                                                          .value!
                                                          .categories![index]
                                                          .items[formIndex]);
                                                },
                                                buttonName: "Send Approval",
                                                buttonColor: _controller
                                                        .claim
                                                        .value!
                                                        .categories![index]
                                                        .items[formIndex]
                                                        .sentForApproval
                                                    ? primaryColor
                                                    : primaryColor
                                                        .withOpacity(0.6),
                                                buttonTextColor: Colors.white),
                                          )),
                                        ],
                                      ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    height: 20,
                                  ),
                              itemCount: _controller.claim.value!
                                  .categories![index].items.length);
                        }),
                        gapHC(10)
                      ],
                    ),
                    onTap: () {},
                    onLongTap: () {},
                  );
                },
              ),
              gapHC(20),
              if (showBottomActions()) const Divider(),
              if (showBottomActions()) gapHC(20),
              if (showBottomActions())
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                          child: Custombutton(
                              onTap: () {
                                claimConfirmationButton(context, onTap: () {
                                  _controller.approveOrRejectAll(
                                      isReject: true);
                                }, status: 'reject_all');
                              },
                              buttonName: "Reject all",
                              buttonColor: Colors.white,
                              buttonBorderColor: Colors.grey.shade400,
                              buttonTextColor: primaryColor)),
                      gapWC(20),
                      Expanded(
                          child: Custombutton(
                              onTap: () {
                                claimConfirmationButton(context, onTap: () {
                                  _controller.approveOrRejectAll(
                                      isReject: false);
                                }, status: 'approve_all');
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
        );
      }),
    ));
  }

  approvalRequest(BuildContext context, Category category, ClaimFormData form) {
    return show(
        context,
        contHeight: MediaQuery.sizeOf(context).height * 0.8,
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
                      tssb('Approval request for ${category.name}',
                          Colors.black, FontWeight.bold),
                      gapHC(10),
                      const Divider(),
                      gapHC(10),
                      if (category.hasTripFrom)
                        headTitle("From", form.tripFrom),
                      if (category.hasTripFrom) gapHC(10),
                      if (category.hasTripTo) headTitle("To", form.tripTo),
                      if (category.hasTripTo) gapHC(10),
                      if (category.hasToDate)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ts(
                                        "Checked In",
                                        const Color(0xff333333)
                                            .withOpacity(0.8)),
                                    Text(
                                        AppFormatter.formatDDMMMYYYY(
                                            form.fromDate!),
                                        style: const TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff333333)))
                                  ],
                                )),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ts("Checked Out",
                                      const Color(0xff333333).withOpacity(0.8)),
                                  Text(
                                      AppFormatter.formatDDMMMYYYY(
                                          form.toDate!),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff333333))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      if (category.hasToDate) gapHC(10),
                      if (category.hasStartMeter)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ts(
                                        "Odometer reading before",
                                        const Color(0xff333333)
                                            .withOpacity(0.8)),
                                    Text(form.odoMeterStart ?? 'NA',
                                        style: const TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff333333)))
                                  ],
                                )),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ts("Odometer reading after",
                                      const Color(0xff333333).withOpacity(0.8)),
                                  Text(form.odoMeterEnd ?? 'NA',
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff333333))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      if (category.hasStartMeter) gapHC(10),
                      if (!category.hasToDate)
                        headTitle("Document date",
                            AppFormatter.formatDDMMMYYYY(form.fromDate!)),
                      if (!category.hasToDate) gapHC(10),
                      headTitle(
                          "Number of employees", form.noOfEmployees.toString()),
                      if (form.noOfEmployees > 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Flexible(flex: 5, child: SizedBox()),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: form.employees.map(
                                  (e) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 6),
                                      margin: const EdgeInsets.only(bottom: 2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: primaryColor),
                                      child: ts('${e.name}(${e.employeeId})',
                                          Colors.white),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        ),
                      gapHC(10),
                      if (form.selectedClass != null)
                        headTitle("Class", form.selectedClass?.name ?? ''),
                      if (form.selectedClass != null) gapHC(10),
                      headTitle("Remark",
                          form.remarks.isEmpty ? 'Nil' : form.remarks),
                      gapHC(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                              flex: 5,
                              child: ts("Attached files",
                                  const Color(0xff333333).withOpacity(0.8))),
                          Expanded(
                            flex: 5,
                            child: form.files.isNotEmpty
                                ? AttachedFileWidget(
                                    file: form.files.first,
                                  )
                                : const Text("Nil",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff333333))),
                          ),
                        ],
                      ),
                      gapHC(10),
                      headTitle(
                          "Amount", "${form.amount!.toStringAsFixed(2)} INR"),
                      Builder(builder: (context) {
                        if (form.selectedClass != null &&
                            form.selectedClass?.policy?.gradeAmount != null &&
                            form.amount != null) {
                          double max = form.selectedClass!.policy!.gradeAmount!;
                          double totalKms = 0;
                          if (category.hasStartMeter) {
                            double start =
                                double.tryParse(form.odoMeterStart ?? '0') ?? 0;
                            double end =
                                double.tryParse(form.odoMeterEnd ?? '0') ?? 0;
                            if (start == 0 && end == 0) {
                              return const SizedBox.shrink();
                            }

                            totalKms = end - start;

                            max = totalKms *
                                form.selectedClass!.policy!.gradeAmount!;
                          }

                          if (form.amount! > max) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: headTitle(
                                "",
                                "(Eligible amount ${max.toStringAsFixed(2)} INR ${category.hasStartMeter ? 'for $totalKms Kms @ ${form.selectedClass!.policy!.gradeAmount!} INR/Km' : ''})",
                                colors: Colors.red,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }
                        return const SizedBox.shrink();
                      }),
                      gapHC(10),
                      Obx(() => Container(
                            height: 45,
                            child: DropdownButtonFormField2<Employee?>(
                              decoration: dropdownDecoration.copyWith(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                focusColor: Colors.white,
                                prefixIconConstraints:
                                    BoxConstraints.tight(const Size(2, 0)),
                                prefixIcon: Container(
                                  width: 0,
                                ),
                              ),
                              hint: ts("Select approver", Colors.grey.shade400),
                              buttonStyleData: const ButtonStyleData(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white),
                                  padding: EdgeInsets.symmetric(horizontal: 0),
                                  elevation: 0,
                                  overlayColor:
                                      WidgetStatePropertyAll(Colors.white)),
                              dropdownStyleData: const DropdownStyleData(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white),
                              ),
                              value: _controller.selectedApprover.value,
                              isExpanded: false,
                              iconStyleData: IconStyleData(
                                  icon: Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 13,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                  iconSize: 13),
                              items:
                                  _controller.approverList.map((Employee item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: ts(
                                    item.name,
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
                          controller:
                              _controller.textEditingControllerConfirmRemarks,
                          verticalPadding: 6,
                          maxline: 3,
                          hintText: "Enter your remarks",
                          textInputAction: TextInputAction.done,
                          onSubmitted: () {},
                          isEnable: true,
                          isObscure: false),
                      gapHC(40),
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
                          Expanded(child: Obx(() {
                            if (_controller.isUpdateBusy.isTrue) {
                              return const SpinKitDoubleBounce(
                                color: primaryColor,
                              );
                            }
                            return Custombutton(
                                onTap: () {
                                  _controller.sentForApproval(form);
                                },
                                buttonName: "Send",
                                buttonColor: primaryColor,
                                buttonTextColor: Colors.white);
                          })),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  claimConfirmationButton(BuildContext context,
      {status, required VoidCallback onTap}) {
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
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            content: SingleChildScrollView(
              //mainAxisAlignment: MainAxisAlignment.center,
              child: Container(
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
                            if (status == "approve_all")
                              Obx(
                                () {
                                  var widgets = [];
                                  for (var element
                                      in _controller.claim.value!.categories!) {
                                    for (var item in element.items) {
                                      if (item.sentForApproval == true &&
                                          item.amount! >
                                              (item.eligibleAmount ?? 0)) {
                                        widgets.add(Text.rich(
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: textColor),
                                            TextSpan(
                                                text: 'Submitted ',
                                                children: [
                                                  TextSpan(
                                                      text: element.name,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: primaryColor)),
                                                  TextSpan(
                                                      text:
                                                          ' amount is ₹${item.amount!.toStringAsFixed(2)}, but only ₹${item.eligibleAmount!.toStringAsFixed(2)} is eligible as per policy. It will be adjusted to ₹${item.eligibleAmount!.toStringAsFixed(2)}',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: textColor))
                                                ])));
                                      }
                                    }
                                  }

                                  return ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          widgets[index],
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                            height: 10,
                                          ),
                                      itemCount: widgets.length);
                                },
                              ),
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
                                controller: _controller
                                    .textEditingControllerConfirmRemarks,
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
                            Expanded(child: Obx(() {
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
            ));
      },
    );
  }

  bool showBottomActions() {
    bool canResubmit = _controller.claim.value!.categories!
        .expand((category) => category.items)
        .toList()
        .where((e) {
          return e.status == ClaimStatus.pending &&
              e.approverId == _profileController.user.value.employeeId;
        })
        .toList()
        .isNotEmpty;

    return canResubmit; //_controller.claim.value!.tripHistoryStatus != ClaimStatus.approved && _controller.claim.value!.tripHistoryStatus != ClaimStatus.settled;
  }
}
