import 'package:bounce/bounce.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/claim/controller/claim_controller.dart';
import 'package:travel_claim/modules/history/widgets/attached_file_widget.dart';
import 'package:travel_claim/modules/landing/controllers/landing_controller.dart';
import 'package:travel_claim/modules/landing/controllers/profile_controller.dart';
import 'package:travel_claim/utils/app_formatter.dart';
import 'package:travel_claim/views/components/alertDialog.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';

class ClaimConfirmationPage extends StatelessWidget {
  ClaimConfirmationPage({super.key});
  static const routeName = '/claim_confirmation';
  final profileController = Get.find<ProfileController>();
  final claimController = Get.find<ClaimController>();
  final landingController = Get.find<LandingController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar("Claim confirmations"),
        body: Column(
          children: [
            Expanded(
              child: Obx(() => SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: boxBaseDecoration(greyLight, 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headTitle("Employee ID",
                                    '${profileController.user.value.name}(${profileController.user.value.employeeId})'),
                                gapHC(10),
                                headTitle(
                                    "Base Location",
                                    profileController
                                        .user.value.baseLocation?.name),
                                gapHC(10),
                                headTitle(
                                    "Date",
                                    AppFormatter.formatDDMMMYYYY(claimController
                                            .claimFrom.value?.createdAt ??
                                        DateTime.now())),
                                gapHC(10),
                                headTitle(
                                    "Type of trip",
                                    claimController
                                        .selectedTripType.value?.name),
                                gapHC(10),
                                headTitle("Branch name",
                                    claimController.selectedBranch.value?.name),
                                gapHC(10),
                                headTitle(
                                    "Purpose of trip",
                                    claimController
                                        .textEditingControllerPurpose.text),
                              ],
                            ),
                          ),
                        ),
                        ExpandedTileList.separated(
                          key: ValueKey(claimController.selectedCategories
                              .map(
                                (element) => "${element.id}-${element.name}",
                              )
                              .toList()
                              .join("")),
                          itemCount: claimController.selectedCategories.length,
                          maxOpened: 20,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                          initiallyOpenedControllersIndexes: [0],
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
                                    borderSide:
                                        const BorderSide(color: greyLight)),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              controller: con,
                              title: tss(
                                  claimController
                                      .selectedCategories[index].name,
                                  Colors.black,
                                  15.0),
                              leading: CachedNetworkImage(
                                imageUrl: claimController
                                    .selectedCategories[index].imageUrl,
                                height: 25,
                                width: 25,
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_down,
                                color: primaryColor.withOpacity(0.8),
                                size: 24,
                              ),
                              trailingRotation: 180,
                              contentseparator: 12,
                              content: Column(
                                children: [
                                  Obx(() {
                                    if (claimController.isFormAddBusy.isTrue) {
                                      // do nothing
                                    }
                                    return ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, formIndex) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            decoration:
                                                boxBaseDecoration(greyLight, 0),
                                            child: Column(
                                              children: [
                                                if (claimController
                                                    .selectedCategories[index]
                                                    .hasTripFrom)
                                                  headTitle(
                                                      "From",
                                                      claimController
                                                          .selectedCategories[
                                                              index]
                                                          .items[formIndex]
                                                          .tripFrom),
                                                if (claimController
                                                    .selectedCategories[index]
                                                    .hasTripFrom)
                                                  gapHC(10),
                                                if (claimController
                                                    .selectedCategories[index]
                                                    .hasTripTo)
                                                  headTitle(
                                                      "To",
                                                      claimController
                                                          .selectedCategories[
                                                              index]
                                                          .items[formIndex]
                                                          .tripTo),
                                                if (claimController
                                                    .selectedCategories[index]
                                                    .hasTripTo)
                                                  gapHC(10),
                                                if (claimController
                                                    .selectedCategories[index]
                                                    .hasToDate)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                  Color(0xff333333)
                                                                      .withOpacity(
                                                                          0.8)),
                                                              Text(
                                                                  AppFormatter.formatDDMMMYYYY(claimController
                                                                      .selectedCategories[
                                                                          index]
                                                                      .items[
                                                                          formIndex]
                                                                      .fromDate!),
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontSize:
                                                                          14,
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
                                                                Color(0xff333333)
                                                                    .withOpacity(
                                                                        0.8)),
                                                            Text(
                                                                AppFormatter.formatDDMMMYYYY(claimController
                                                                    .selectedCategories[
                                                                        index]
                                                                    .items[
                                                                        formIndex]
                                                                    .toDate!),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        14,
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
                                                if (claimController
                                                    .selectedCategories[index]
                                                    .hasToDate)
                                                  gapHC(10),
                                                if (claimController
                                                    .selectedCategories[index]
                                                    .hasStartMeter)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Flexible(
                                                          flex: 5,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ts(
                                                                  "Odometer reading before",
                                                                  Color(0xff333333)
                                                                      .withOpacity(
                                                                          0.8)),
                                                              Text(
                                                                  claimController
                                                                          .selectedCategories[
                                                                              index]
                                                                          .items[
                                                                              formIndex]
                                                                          .odoMeterStart ??
                                                                      'NA',
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontSize:
                                                                          14,
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
                                                                "Odometer reading after",
                                                                Color(0xff333333)
                                                                    .withOpacity(
                                                                        0.8)),
                                                            Text(
                                                                claimController
                                                                        .selectedCategories[
                                                                            index]
                                                                        .items[
                                                                            formIndex]
                                                                        .odoMeterEnd ??
                                                                    'NA',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        14,
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
                                                if (claimController
                                                    .selectedCategories[index]
                                                    .hasStartMeter)
                                                  gapHC(10),
                                                if (!claimController
                                                    .selectedCategories[index]
                                                    .hasToDate)
                                                  headTitle(
                                                      "Document date",
                                                      AppFormatter.formatDDMMMYYYY(
                                                          claimController
                                                              .selectedCategories[
                                                                  index]
                                                              .items[formIndex]
                                                              .fromDate!)),
                                                if (!claimController
                                                    .selectedCategories[index]
                                                    .hasToDate)
                                                  gapHC(10),
                                                headTitle(
                                                    "Number of employees",
                                                    claimController
                                                        .selectedCategories[
                                                            index]
                                                        .items[formIndex]
                                                        .noOfEmployees
                                                        .toString()),
                                                if (claimController
                                                        .selectedCategories[
                                                            index]
                                                        .items[formIndex]
                                                        .noOfEmployees >
                                                    1)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Flexible(
                                                          flex: 5,
                                                          child: SizedBox()),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: claimController
                                                              .selectedCategories[
                                                                  index]
                                                              .items[formIndex]
                                                              .employees
                                                              .map(
                                                            (e) {
                                                              return Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            5,
                                                                        horizontal:
                                                                            6),
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            2),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            14),
                                                                    color:
                                                                        primaryColor),
                                                                child: ts(
                                                                    '${e.name}(${e.employeeId})',
                                                                    Colors
                                                                        .white),
                                                              );
                                                            },
                                                          ).toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                gapHC(10),
                                                if (claimController
                                                            .selectedCategories[
                                                                index]
                                                            .classes !=
                                                        null &&
                                                    claimController
                                                        .selectedCategories[
                                                            index]
                                                        .classes!
                                                        .isNotEmpty &&
                                                    claimController
                                                        .selectedCategories[
                                                            index]
                                                        .hasClass)
                                                  headTitle(
                                                      "Class",
                                                      claimController
                                                              .selectedCategories[
                                                                  index]
                                                              .items[formIndex]
                                                              .selectedClass
                                                              ?.name ??
                                                          ''),
                                                if (claimController
                                                            .selectedCategories[
                                                                index]
                                                            .classes !=
                                                        null &&
                                                    claimController
                                                        .selectedCategories[
                                                            index]
                                                        .classes!
                                                        .isNotEmpty)
                                                  gapHC(10),
                                                headTitle(
                                                    "Remark",
                                                    claimController
                                                            .selectedCategories[
                                                                index]
                                                            .items[formIndex]
                                                            .remarks
                                                            .isEmpty
                                                        ? 'Nil'
                                                        : claimController
                                                            .selectedCategories[
                                                                index]
                                                            .items[formIndex]
                                                            .remarks),
                                                gapHC(10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                        flex: 5,
                                                        child: ts(
                                                            "Attached files",
                                                            Color(0xff333333)
                                                                .withOpacity(
                                                                    0.8))),
                                                    Expanded(
                                                      flex: 5,
                                                      child: claimController
                                                              .selectedCategories[
                                                                  index]
                                                              .items[formIndex]
                                                              .files
                                                              .isNotEmpty
                                                          ? AttachedFileWidget(
                                                              file: claimController
                                                                  .selectedCategories[
                                                                      index]
                                                                  .items[
                                                                      formIndex]
                                                                  .files
                                                                  .first,
                                                            )
                                                          : const Text("Nil",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Color(
                                                                      0xff333333))),
                                                    ),
                                                  ],
                                                ),
                                                gapHC(10),
                                                headTitle("Amount",
                                                    "${claimController.selectedCategories[index].items[formIndex].amount!.toStringAsFixed(2)} INR"),
                                                Obx(() {
                                                  if (claimController
                                                              .selectedCategories[
                                                                  index]
                                                              .items[formIndex]
                                                              .selectedClass !=
                                                          null &&
                                                      claimController
                                                              .selectedCategories[
                                                                  index]
                                                              .items[formIndex]
                                                              .selectedClass
                                                              ?.policy
                                                              ?.gradeAmount !=
                                                          null &&
                                                      claimController
                                                              .selectedCategories[
                                                                  index]
                                                              .items[formIndex]
                                                              .amount !=
                                                          null) {
                                                    double max = claimController
                                                            .selectedCategories[
                                                                index]
                                                            .items[formIndex]
                                                            .eligibleAmount ??
                                                        claimController
                                                            .selectedCategories[
                                                                index]
                                                            .items[formIndex]
                                                            .selectedClass!
                                                            .policy!
                                                            .gradeAmount!;
                                                    double totalKms = 0;
                                                    if (claimController
                                                            .selectedCategories[
                                                                index]
                                                            .id ==
                                                        4) {
                                                      int totaldays = getNumberOfDays(
                                                          claimController
                                                              .selectedCategories[
                                                                  index]
                                                              .items[formIndex]
                                                              .fromDate,
                                                          claimController
                                                              .selectedCategories[
                                                                  index]
                                                              .items[formIndex]
                                                              .toDate);
                                                      if (totaldays != 0) {
                                                        double? totalAmount = totaldays *
                                                            (claimController
                                                                    .selectedCategories[
                                                                        index]
                                                                    .items[
                                                                        formIndex]
                                                                    .eligibleAmount ??
                                                                0);
                                                        max = totalAmount;
                                                        // if (mounted) {
                                                        //   // textEditingControllerAmount.text =
                                                        //   //     totalAmount.toStringAsFixed(2);
                                                        // }
                                                        // widget.formData.amount = totalAmount ?? 0;
                                                      }
                                                    } else {
                                                      if (claimController
                                                          .selectedCategories[
                                                              index]
                                                          .hasStartMeter) {
                                                        double start = double.tryParse(
                                                                claimController
                                                                        .selectedCategories[
                                                                            index]
                                                                        .items[
                                                                            formIndex]
                                                                        .odoMeterStart ??
                                                                    '0') ??
                                                            0;
                                                        double end = double.tryParse(
                                                                claimController
                                                                        .selectedCategories[
                                                                            index]
                                                                        .items[
                                                                            formIndex]
                                                                        .odoMeterEnd ??
                                                                    '0') ??
                                                            0;
                                                        if (start == 0 &&
                                                            end == 0) {
                                                          return const SizedBox
                                                              .shrink();
                                                        }
                                                        totalKms = end - start;
                                                        max = totalKms *
                                                            claimController
                                                                .selectedCategories[
                                                                    index]
                                                                .items[
                                                                    formIndex]
                                                                .selectedClass!
                                                                .policy!
                                                                .gradeAmount!;
                                                      }
                                                    }
                                                    if (claimController
                                                            .selectedCategories[
                                                                index]
                                                            .items[formIndex]
                                                            .amount! >
                                                        max) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: headTitle(
                                                          "",
                                                          "(Eligible amount ${max.toStringAsFixed(2)} INR ${claimController.selectedCategories[index].hasStartMeter ? 'for $totalKms Kms @ ${claimController.selectedCategories[index].items[formIndex].selectedClass!.policy!.gradeAmount!} INR/Km' : ''})",
                                                          colors: Colors.red,
                                                        ),
                                                      );
                                                    }
                                                    return const SizedBox
                                                        .shrink();
                                                  }
                                                  return const SizedBox
                                                      .shrink();
                                                }),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                              height: 15,
                                            ),
                                        itemCount: claimController
                                            .selectedCategories[index]
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
                        )
                      ],
                    ),
                  )),
            ),

            /*const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),

              child: Divider(),
            ),*/

            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5.0,
                  spreadRadius: 1,
                  offset: Offset(0, -3),
                ),
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 0.0,
                  spreadRadius: 0,
                  offset: Offset(0, 15),
                ),
              ]),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tcCustomhead(
                      "Total Amount", Colors.grey.shade600, FontWeight.w400),
                  tcCustomhead(
                      "\u{20B9}${claimController.selectedCategories.expand((category) => category.items).toList().map((v) => v).toList().map(
                            (e) => e.amount,
                          ).toList().fold(0.0, (sum, item) => sum + item!.toDouble()).toStringAsFixed(2)}",
                      primaryColor,
                      FontWeight.w700),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                      child: Custombutton(
                    onTap: () {
                      Get.back();
                    },
                    buttonName: "Cancel",
                    buttonColor: Colors.white,
                    buttonTextColor: Colors.black,
                    buttonBorderColor: Colors.grey.shade400,
                  )),
                  gapWC(20),
                  Expanded(
                      child: Custombutton(
                          onTap: () {
                            show(
                                context,
                                autoDismiss: false,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          gapHC(30),
                                          Image.asset(
                                            AppAssets.msgBox,
                                            fit: BoxFit.fill,
                                          ),
                                          gapHC(30),
                                          tssb(
                                              "Total Amount",
                                              Colors.grey.shade600,
                                              FontWeight.w500),
                                          tcustom(
                                              "\u{20B9}${claimController.selectedCategories.expand((category) => category.items).toList().map((v) => v).toList().map(
                                                    (e) => e.amount,
                                                  ).toList().fold(0.0, (sum, item) => sum + item!.toDouble()).toStringAsFixed(2)}",
                                              primaryColor,
                                              20.0,
                                              FontWeight.w500),
                                          gapHC(30),
                                          tcCustomhead(
                                              "Are you sure you want to \n"
                                              "submit the claim?",
                                              Colors.black87,
                                              size: 21.0,
                                              align: TextAlign.center,
                                              FontWeight.w500)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Custombutton(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  buttonName: "Cancel",
                                                  buttonColor: Colors.white,
                                                  buttonBorderColor:
                                                      Colors.grey.shade400,
                                                  buttonTextColor:
                                                      Colors.black)),
                                          gapWC(20),
                                          Expanded(child: Obx(() {
                                            if (claimController.isBusy.isTrue) {
                                              return const SpinKitThreeBounce(
                                                color: primaryColor,
                                                size: 20,
                                              );
                                            }
                                            return Custombutton(
                                                onTap: claimController.save,
                                                buttonName: "Submit",
                                                buttonColor: primaryColor,
                                                buttonTextColor: Colors.white);
                                          })),
                                        ],
                                      ),
                                    ),
                                    gapHC(20)
                                  ],
                                ));
                          },
                          buttonName: "Submit",
                          buttonColor: primaryColor,
                          buttonTextColor: Colors.white)),
                ],
              ),
            ),
            gapHC(20)
          ],
        ),
      ),
    );
  }

  int getNumberOfDays(DateTime? fromDate, DateTime? toDate) {
    if (fromDate == null || toDate == null) {
      return 0;
    }
    int days = toDate.difference(fromDate).inDays;
    print("the total days befor addition$days");
    return days == 0 ? 1 : days;
  }
}
