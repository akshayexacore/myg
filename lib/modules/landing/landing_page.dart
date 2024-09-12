import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/advance/advance_request_page.dart';
import 'package:travel_claim/modules/advance_requests/advance_request_list_page.dart';
import 'package:travel_claim/modules/claim/claim_page.dart';
import 'package:travel_claim/modules/claim_approval/claim_approval_list_page.dart';
import 'package:travel_claim/modules/drafts/draft_page.dart';
import 'package:travel_claim/modules/history/history_page.dart';
import 'package:travel_claim/modules/landing/controllers/landing_controller.dart';
import 'package:travel_claim/modules/landing/controllers/profile_controller.dart';
import 'package:travel_claim/modules/special_approval/special_approval_list_page.dart';
import 'package:travel_claim/utils/app_enums.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/screens/advanceApprovel/advance_approvel_screen.dart';
import 'package:travel_claim/views/screens/cmdApproels/cmdapprovel_screen.dart';
import 'package:travel_claim/views/screens/reqAdvance/reqadvance_screen.dart';
import 'package:travel_claim/views/screens/specialApprovel/specialapprovel_screen.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class LandingPage extends StatelessWidget {
  static const routeName = '/landing';

  LandingPage({Key? key}) : super(key: key);

  final LandingController _controller = Get.find();
  final ProfileController _profileController = Get.find();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Obx(() {
            return bgDashBoard(context, _profileController.user.value.name);
          }),
          Obx((){
            return Padding(
              padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    gapHC(31),
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tchead("Welcome to your dashboard,", Colors.white,
                              20.0, FontWeight.w500),
                          gapHC(1),
                          Obx(() {
                            return tchead(
                                "${_profileController.user.value.name} - ${_profileController.user.value.employeeId}",
                                Colors.white,
                                20.0,
                                FontWeight.w500);
                          }),
                        ],
                      ),
                    ),
                    gapHC(31),
                    if(_profileController.user.value.grade.hasPermission(Permission.newClaim) || _profileController.user.value.grade.hasPermission(Permission.requestAdvance))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Expanded(
                          child: _profileController.user.value.grade.hasPermission(Permission.newClaim) ? Bounce(
                              duration: const Duration(milliseconds: 110),
                              onTap: () {
                                Get.toNamed(ClaimPage.routeName);
                              },
                              child: menuCard(30.0, 0.0, 0.0, 0.0,
                                  AppAssets.newClaim_img, "New Claim")) : const SizedBox(),
                        ),
                        gapWC(10),
                        Expanded(
                            child: _profileController.user.value.grade.hasPermission(Permission.requestAdvance) ? Bounce(
                                duration: const Duration(milliseconds: 110),
                                onTap: () {
                                  Get.toNamed(AdvanceRequestListPage.routeName);
                                },
                                child: menuCard(0.0, 30.0, 0.0, 0.0,
                                    AppAssets.reqAdv_img, "Request\nAdvance")) : const SizedBox()),
                      ],
                    ),
                    if(_profileController.user.value.grade.hasPermission(Permission.newClaim) || _profileController.user.value.grade.hasPermission(Permission.requestAdvance))
                    gapHC(20),
                    if(_profileController.user.value.grade.hasPermission(Permission.drafts) || _profileController.user.value.grade.hasPermission(Permission.history))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: _profileController.user.value.grade.hasPermission(Permission.drafts) ? Bounce(
                              duration: const Duration(milliseconds: 110),
                              onTap: () {
                                Get.toNamed(DraftPage.routeName);
                              },
                              child: menuCard(0.0, 0.0, _profileController.user.value.grade.hasPermission(Permission.claimApprovals) ? 0.0 : 30.0, 0.0,
                                  AppAssets.draft_img, "Draft")) : const SizedBox(),
                        ),
                        gapWC(10),
                        Expanded(
                          child: _profileController.user.value.grade.hasPermission(Permission.history) ? Bounce(
                              duration: const Duration(milliseconds: 110),
                              onTap: () {
                                Get.toNamed(HistoryPage.routeName);
                              },
                              child: menuCard(0.0, 0.0, 0.0, _profileController.user.value.grade.hasPermission(Permission.claimApprovals) ? 0.0 : 30.0,
                                  AppAssets.history_img, "History")): const SizedBox(),
                        ),
                      ],
                    ),
                    if(_profileController.user.value.grade.hasPermission(Permission.claimApprovals) || _profileController.user.value.grade.hasPermission(Permission.advanceApprovals))
                    gapHC(20),
                    if(_profileController.user.value.grade.hasPermission(Permission.claimApprovals) || _profileController.user.value.grade.hasPermission(Permission.advanceApprovals))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: _profileController.user.value.grade.hasPermission(Permission.claimApprovals) ? Bounce(
                                duration: const Duration(milliseconds: 110),
                                onTap: () {
                                  Get.toNamed(ClaimApprovalListPage.routeName);
                                },
                                child: menuCard(
                                    _profileController.user.value.grade.hasPermission(Permission.drafts) ? 0.0 : 30.0,
                                    0.0,
                                    _profileController.user.value.grade.hasPermission(Permission.cmdApprovals) ? 0.0 : 30.0,
                                    0.0,
                                    AppAssets.claimApprv_img,
                                    "Claim\nApprovals")) : const SizedBox(),
                          ),
                          gapWC(10),
                          Expanded(
                            child: _profileController.user.value.grade.hasPermission(Permission.specialApprovals) ? Bounce(
                                duration: const Duration(milliseconds: 110),
                                onTap: () {
                                  Get.toNamed(SpecialApprovalListPage.routeName);
                                },
                                child: menuCard(
                                    0.0,
                                    _profileController.user.value.grade.hasPermission(Permission.history) ? 0.0 : 30.0,
                                    0.0,
                                    30.0,
                                    AppAssets.speciaslApprvl_img,
                                    "Special\nApprovals")) : const SizedBox(),
                          ),
                          /*Expanded(
                            child: _profileController.user.value.grade.hasPermission(Permission.advanceApprovals) ? Bounce(
                                duration: const Duration(milliseconds: 110),
                                onTap: () {
                                  dprint("advv");
                                  Get.to(() => const AdvanceApprovelScreen());
                                },
                                child: menuCard(
                                    0.0,
                                    _profileController.user.value.grade.hasPermission(Permission.history) ? 0.0 : 30.0,
                                    0.0,
                                    _profileController.user.value.grade.hasPermission(Permission.cmdApprovals) || _profileController.user.value.grade.hasPermission(Permission.specialApprovals) ? 0.0 : 30.0,
                                    AppAssets.advApprvl_img,
                                    "Advance\nApprovals")) : const SizedBox(),
                          ),*/
                        ],
                      ),
                      if(_profileController.user.value.grade.hasPermission(Permission.specialApprovals) || _profileController.user.value.grade.hasPermission(Permission.cmdApprovals))
                      gapHC(20),
                    if(_profileController.user.value.grade.hasPermission(Permission.specialApprovals) || _profileController.user.value.grade.hasPermission(Permission.cmdApprovals))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                         /* Expanded(
                            child: _profileController.user.value.grade.hasPermission(Permission.specialApprovals) ? Bounce(
                                duration: const Duration(milliseconds: 110),
                                onTap: () {
                                  Get.toNamed(SpecialApprovalListPage.routeName);
                                },
                                child: menuCard(
                                    0.0,
                                    0.0,
                                    30.0,
                                    0.0,
                                    AppAssets.speciaslApprvl_img,
                                    "Special\nApprovals")) : const SizedBox(),
                          ),
                          gapWC(10),*/
                          Expanded(
                            child: _profileController.user.value.grade.hasPermission(Permission.cmdApprovals) ? Bounce(
                                duration: const Duration(milliseconds: 110),
                                onTap: () {
                                  dprint("CM");
                                  Get.to(() => const CmdapprovelScreen());
                                },
                                child: menuCard(0.0, 0.0, 0.0, 30.0,
                                    AppAssets.cmdApprvl_img, "CMD\nApprovals")) : const SizedBox(),
                          ),
                        ],
                      ),
                      gapHC(20),
                  ],
                ),
              ),
            );
          }),
          Align(alignment: Alignment.bottomCenter,child: Obx(() => Text(_profileController.appVersion.value,style: TextStyle(fontSize: 11,color: Colors.black87,fontWeight: FontWeight.w400),),))
        ],
      ),
    );
  }
}
