import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/claim/claim_page.dart';
import 'package:travel_claim/modules/claim_approval/claim_approval_list_page.dart';
import 'package:travel_claim/modules/drafts/draft_page.dart';
import 'package:travel_claim/modules/history/history_page.dart';
import 'package:travel_claim/modules/landing/controllers/landing_controller.dart';
import 'package:travel_claim/modules/landing/controllers/profile_controller.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/screens/advanceApprovel/advance_approvel_screen.dart';
import 'package:travel_claim/views/screens/claimApprovel/claim_Approvel_screen.dart';
import 'package:travel_claim/views/screens/cmdApproels/cmdapprovel_screen.dart';
import 'package:travel_claim/views/screens/draftScreen/draftscreen.dart';
import 'package:travel_claim/views/screens/history/historyscreen.dart';
import 'package:travel_claim/views/screens/newClaim/add_expense_screen.dart';
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
              padding: const EdgeInsets.only(top: 123, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    gapHC(26),
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
                    gapHC(13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Bounce(
                              duration: const Duration(milliseconds: 110),
                              onTap: () {
                                dprint("NewCliam");
                                Get.toNamed(ClaimPage.routeName);
                              },
                              child: menuCard(30.0, 0.0, 0.0, 0.0,
                                  AppAssets.newClaim_img, "New Claim")),
                        ),
                        gapWC(10),
                        Expanded(
                            child: Bounce(
                                duration: const Duration(milliseconds: 110),
                                onTap: () {
                                  dprint("Request");
                                  Get.to(() => ReqadvanceScreen());
                                },
                                child: menuCard(0.0, 30.0, 0.0, 0.0,
                                    AppAssets.reqAdv_img, "Request\nAdvance"))),
                      ],
                    ),
                    gapHC(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Bounce(
                              duration: const Duration(milliseconds: 110),
                              onTap: () {
                                Get.toNamed(DraftPage.routeName);
                              },
                              child: menuCard(0.0, 0.0, 0.0, 0.0,
                                  AppAssets.draft_img, "Draft")),
                        ),
                        gapWC(10),
                        Expanded(
                          child: Bounce(
                              duration: const Duration(milliseconds: 110),
                              onTap: () {
                                Get.toNamed(HistoryPage.routeName);
                              },
                              child: menuCard(0.0, 0.0, 0.0, 0.0,
                                  AppAssets.history_img, "History")),
                        ),
                      ],
                    ),
                    gapHC(20),
                    if(_profileController.user.value.grade==1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Bounce(
                                duration: const Duration(milliseconds: 110),
                                onTap: () {
                                  Get.toNamed(ClaimApprovalListPage.routeName);
                                },
                                child: menuCard(
                                    0.0,
                                    0.0,
                                    0.0,
                                    0.0,
                                    AppAssets.claimApprv_img,
                                    "Claim\nApprovals")),
                          ),
                          gapWC(10),
                          Expanded(
                            child: Bounce(
                                duration: const Duration(milliseconds: 110),
                                onTap: () {
                                  dprint("advv");
                                  Get.to(() => AdvanceApprovelScreen());
                                },
                                child: menuCard(
                                    0.0,
                                    0.0,
                                    0.0,
                                    0.0,
                                    AppAssets.advApprvl_img,
                                    "Advance\nApprovals")),
                          ),
                        ],
                      ),
                    if(_profileController.user.value.grade==1)
                      gapHC(20),
                    if(_profileController.user.value.grade==1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Bounce(
                                duration: const Duration(milliseconds: 110),
                                onTap: () {
                                  dprint("sped");
                                  Get.to(() => SpecialapprovelScreen());
                                },
                                child: menuCard(
                                    0.0,
                                    0.0,
                                    30.0,
                                    0.0,
                                    AppAssets.speciaslApprvl_img,
                                    "Special\nApprovals")),
                          ),
                          gapWC(10),
                          Expanded(
                            child: Bounce(
                                duration: const Duration(milliseconds: 110),
                                onTap: () {
                                  dprint("CM");
                                  Get.to(() => CmdapprovelScreen());
                                },
                                child: menuCard(0.0, 0.0, 0.0, 30.0,
                                    AppAssets.cmdApprvl_img, "CMD\nApprovals")),
                          ),
                        ],
                      ),
                    if(_profileController.user.value.grade==1)
                      gapHC(20),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
