import 'package:bounce/bounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/branch.dart';
import 'package:travel_claim/models/trip_type.dart';
import 'package:travel_claim/modules/claim/controller/claim_controller.dart';
import 'package:travel_claim/modules/claim/widgets/form_item.dart';
import 'package:travel_claim/modules/landing/controllers/landing_controller.dart';
import 'package:travel_claim/modules/landing/controllers/profile_controller.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/components/textInputField.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'dart:math' as math;

import 'package:travel_claim/views/widgets.dart';

class ClaimPage extends StatelessWidget {
  ClaimPage({Key? key}) : super(key: key);

  static const routeName = '/claim';

  final profileController = Get.find<ProfileController>();
  final claimController = Get.find<ClaimController>();
  final landingController = Get.find<LandingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar("Add Expense"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: claimController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapHC(28),
                  Container(
                    decoration: boxDecoration(primaryColor, 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ts("Employee ID", Colors.white,
                                weight: FontWeight.w400),
                            gapHC(3),
                            tssb(
                              '${profileController.user.value.name}(${profileController.user.value.employeeId})',
                              Colors.white,
                              FontWeight.w600,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ts("Base Location", Colors.white,
                                weight: FontWeight.w400),
                            gapHC(3),
                            tssb(
                              profileController.user.value.baseLocation?.name,
                              Colors.white,
                              FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  gapHC(24),
                  tssb("Claim Form", Colors.black, FontWeight.bold),
                  gapHC(8),
                  const Divider(),
                  gapHC(5),
                  ts("Type of trip", Colors.black),
                  gapHC(3),
                  Obx(() => DropdownButtonFormField<TripType>(
                        focusColor: Colors.white,
                        dropdownColor: Colors.white,
                        decoration: dropdownDecoration,
                        hint: ts("Type of trip", Colors.grey.shade400),
                        validator: (value) {
                          if (value == null) {
                            return 'This is a mandatory field';
                          }
                          return null; // Valid input
                        },
                        //underline: const SizedBox(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        // Initial Value
                        value: claimController.selectedTripType.value,
                        isExpanded: true,
                        // Down Arrow Icon
                        icon: const Icon(Icons.arrow_forward_ios_rounded,
                            size: 13),

                        // Array list of items
                        items: landingController.tripTypes.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: ts(
                              e.name,
                              Colors.black,
                            ),
                          );
                        }).toList(),
                        onChanged: (TripType? value) {
                          claimController.selectedTripType(value);
                        },
                      )),
                  gapHC(15),
                  ts("Branch name", Colors.black),
                  gapHC(3),
                  Obx(() => DropdownButtonFormField<Branch>(
                        focusColor: Colors.white,
                        dropdownColor: Colors.white,
                        decoration: dropdownDecoration,
                        validator: (value) {
                          if (value == null) {
                            return 'This is a mandatory field';
                          }
                          return null; // Valid input
                        },
                        hint: ts("Branch", Colors.grey.shade400),
                        value: claimController.selectedBranch.value,
                        isExpanded: true,
                        // Down Arrow Icon
                        icon: const Icon(Icons.arrow_forward_ios_rounded,
                            size: 13),

                        // Array list of items
                        items: landingController.branches.map((b) {
                          return DropdownMenuItem(
                            value: b,
                            child: ts(
                              b.name,
                              Colors.black,
                            ),
                          );
                        }).toList(),
                        onChanged: (Branch? value) {
                          claimController.selectedBranch(value);
                        },
                      )),
                  gapHC(15),
                  ts("Purpose of trip", Colors.black),
                  gapHC(3),
                  TextinputfieldContainer(
                      showIcon: false,
                      onSubmitted: () {},
                      verticalPadding: 6,
                      validate: (value) {
                        if (value == null|| value.isEmpty) {
                          return 'This is a mandatory field';
                        }
                        return null; // Valid input
                      },
                      textInputAction: TextInputAction.done,
                      controller: claimController.textEditingControllerPurpose,
                      maxline: 3,
                      hintText: "Enter your purpose",
                      isEnable: true,
                      isObscure: false),
                  gapHC(20),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: boxBaseDecoration(greyLight, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tssb("Categories", Colors.black, FontWeight.bold),
                        gapHC(12),
                        Obx(
                          () {
                            return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // 2 columns
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 7.7 / 2,
                                ),
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: claimController.categories.length,
                                itemBuilder: (context, index) {
                                  return Obx(() {
                                    return GestureDetector(
                                      onTap: () {
                                        claimController.addOrRemoveCategory(
                                            claimController.categories[index]);
                                      },
                                      child: Container(
                                        height: 44,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 4),
                                        decoration:
                                            boxBaseDecoration(Colors.white, 6),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: 24.0,
                                              width: 24.0,
                                              child: Checkbox(
                                                activeColor: Colors.green,
                                                value: claimController
                                                    .isCategorySelected(
                                                        claimController
                                                            .categories[index]),
                                                hoverColor: Colors.black,
                                                focusColor: Colors.black,
                                                onChanged: (bool? value) {
                                                  claimController
                                                      .addOrRemoveCategory(
                                                          claimController
                                                                  .categories[
                                                              index]);
                                                },
                                              ),
                                            ),
                                            gapWC(4),
                                            Image.network(
                                              claimController
                                                  .categories[index].imageUrl,
                                              height: 18,
                                              width: 18,
                                            ),
                                            gapWC(4),
                                            Expanded(
                                                child: tchcus(
                                                    claimController
                                                        .categories[index].name,
                                                    Colors.black,
                                                    12.0,
                                                    height: 0.99)),
                                            gapWC(4),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                });
                          },
                        )
                      ],
                    ),
                  ),
                  gapHC(10),
                  Obx(() {
                    if (claimController.selectedCategories.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return ExpandedTileList.separated(
                      key: ValueKey(claimController.selectedCategories
                          .map(
                            (element) => "${element.id}-${element.name}",
                          )
                          .toList()
                          .join("")),
                      itemCount: claimController.selectedCategories.length,
                      maxOpened: 2,
                      padding: EdgeInsets.zero,
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
                                borderSide: const BorderSide(color: greyLight)),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12),
                          ),
                          controller: con,
                          title: tss(
                              claimController.selectedCategories[index].name,
                              Colors.black,
                              15.0),
                          leading: Image.network(
                            claimController.selectedCategories[index].imageUrl,
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
                                      return FormItem(
                                        category: claimController
                                            .selectedCategories[index],
                                        formData: claimController
                                            .selectedCategories[index]
                                            .items[formIndex],
                                        index: formIndex + 1,
                                        onDelete: formIndex > 0
                                            ? () {
                                                claimController
                                                    .selectedCategories[index]
                                                    .items
                                                    .removeAt(formIndex);
                                                claimController
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
                                    itemCount: claimController
                                        .selectedCategories[index]
                                        .items
                                        .length);
                              }),
                              gapHC(20),
                              Bounce(
                                onTap: () {
                                  claimController.addNewFormItem(claimController
                                      .selectedCategories[index]);
                                },
                                child: Container(
                                  decoration: boxOutlineCustom(
                                      Colors.white, 10.0, primaryColor),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 9, horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      tssb("Add more", Colors.black,
                                          FontWeight.w500),
                                      gapWC(2),
                                      const Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              ),
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
                    );
                  }),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 12, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 6,
                    blurRadius: 6,
                    offset: const Offset(5, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(child: Obx(() {
                    if (claimController.isDraftBusy.isTrue) {
                      return const SpinKitThreeBounce(
                        color: primaryColor,
                        size: 20,
                      );
                    }
                    return Custombutton(
                        onTap: claimController.saveToDrafts,
                        buttonName: "Save draft",
                        buttonColor: Colors.white,
                        buttonBorderColor: Colors.grey.shade400,
                        buttonTextColor: primaryColor);
                  })),
                  gapWC(20),
                  Expanded(child: Obx(() {
                    if (claimController.isBusy.isTrue) {
                      return const SpinKitThreeBounce(
                        color: primaryColor,
                        size: 20,
                      );
                    }
                    return Custombutton(
                        onTap: claimController.continueToPreview,
                        buttonName: "Continue",
                        buttonColor: primaryColor,
                        buttonTextColor: Colors.white);
                  })),
                ],
              ),
            ),
          ],
        ));
  }
}
