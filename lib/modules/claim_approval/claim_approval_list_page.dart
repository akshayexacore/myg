import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/claim_approval/controllers/claim_approval_list_controller.dart';
import 'package:travel_claim/modules/claim_approval/widgets/claim_approval_card.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/tabButton.dart';
import 'package:travel_claim/views/style/colors.dart';

class ClaimApprovalListPage extends StatelessWidget {
  ClaimApprovalListPage({Key? key}) : super(key: key);

  static const routeName = '/claim_approval_list';

  final _controller = Get.find<ClaimApprovalListController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: customAppBar("Claim Approvals"),
            body: Obx(
          () {
                return Column(
                  children: [
                        Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      //decoration: boxDecoration(Colors.white, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: TabButton(
                                width: 0.1,
                                text: " All",
                                isShowIcon: false,
                                isWhite: true,
                                tabcolor: primaryColor,
                                pageNumber: 0,
                                selectedPage: _controller.selectedPage.value,
                                onPressed: () {
                                  _controller.lstrSelectedPage.value = "Al";
                                  _controller.fnChangePage(0);
                                },
                                icon: Icons.person_2_outlined),
                          ),
                          Flexible(
                            flex: 2,
                            child: TabButton(
                                width: 0.2,
                                isShowIcon: false,
                                isWhite: true,
                                text: "Pending",
                                pageNumber: 1,
                                tabcolor: primaryColor,
                                selectedPage: _controller.selectedPage.value,
                                onPressed: () {
                                  _controller.lstrSelectedPage.value = "Pe";
                                  _controller.fnChangePage(1);
                                },
                                icon: Icons.shopping_cart_outlined),
                          ),
                          Flexible(
                            flex: 2,
                            child: TabButton(
                                width: 0.2,
                                isShowIcon: false,
                                isWhite: true,
                                text: "Approved",
                                pageNumber: 2,
                                tabcolor: primaryColor,
                                selectedPage: _controller.selectedPage.value,
                                onPressed: () {
                                  _controller.lstrSelectedPage.value = "Ap";
                                  _controller.fnChangePage(2);
                                },
                                icon: Icons.shopping_cart_outlined),
                          ),
                                 Flexible(
                            flex: 2,
                            child: TabButton(
                                width: 0.2,
                                text: "Paid",
                                pageNumber: 3,
                                tabcolor: primaryColor,
                                isShowIcon: false,
                                isWhite: true,
                                selectedPage: _controller.selectedPage.value,
                                onPressed: () {
                                  _controller.lstrSelectedPage.value = "Pd";
                                  _controller.fnChangePage(3);
                                },
                                icon: Icons.more_horiz),
                          ),
                  
                          Flexible(
                            flex: 2,
                            child: TabButton(
                                width: 0.2,
                                text: "Rejected",
                                pageNumber: 4,
                                tabcolor: primaryColor,
                                isShowIcon: false,
                                isWhite: true,
                                selectedPage: _controller.selectedPage.value,
                                onPressed: () {
                                  _controller.lstrSelectedPage.value = "Rj";
                                  _controller.fnChangePage(4);
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
                        wApprovedHistoryScreen(),
                        wPaidHistoryScreen(),
                       
                        wRejectedHistoryScreen()
                      ],
                    ),
                  ),
                  ],
                );
              }
            )
        ));
  }
  
  wPaidHistoryScreen() {
    return Obx(() {
      if (_controller.isBusy.isTrue) {
        return  Center(
            child: SpinKitDoubleBounce(
          color: primaryColor,
        ));
      }

      if (_controller.paidItems.isEmpty) {
        return Center(child: ts("No paid claims", Colors.black54));
      }

      return RefreshIndicator(
        onRefresh: () async {
          _controller.getApprovalList();
        },
        child: ListView.builder(
            itemCount: _controller.paidItems.length,
            itemBuilder: (context, index) {
              return ClaimApprovalCard(
                claim: _controller.paidItems[index],
              );
            }),
      );
    });
  }
  wPendingHistoryScreen() {
    return Obx(() {
      if (_controller.isBusy.isTrue) {
        return const Center(
            child: SpinKitDoubleBounce(
          color: primaryColor,
        ));
      }

      if (_controller.pendingItems.isEmpty) {
        return Center(child: ts("No pending claims", Colors.black54));
      }

      return RefreshIndicator(
        onRefresh: () async {
          _controller.getApprovalList();
        },
        child: ListView.builder(
            itemCount: _controller.pendingItems.length,
            itemBuilder: (context, index) {
              return ClaimApprovalCard(
                claim: _controller.pendingItems[index],
              );
            }),
      );
    });
  }

  wApprovedHistoryScreen() {
    return Obx(() {
      if (_controller.isBusy.isTrue) {
        return const Center(
            child: SpinKitDoubleBounce(
          color: primaryColor,
        ));
      }

      if (_controller.approvedItems.isEmpty) {
        return Center(child: ts("No approved claims", Colors.black54));
      }

      return RefreshIndicator(
        onRefresh: () async {
          _controller.getApprovalList();
        },
        child: ListView.builder(
            itemCount: _controller.approvedItems.length,
            itemBuilder: (context, index) {
              return ClaimApprovalCard(
                claim: _controller.approvedItems[index],
              );
            }),
      );
    });
  }



  wRejectedHistoryScreen() {
    return Obx(() {
      if (_controller.isBusy.isTrue) {
        return const Center(
            child: SpinKitDoubleBounce(
          color: primaryColor,
        ));
      }

      if (_controller.rejectedItems.isEmpty) {
        return Center(child: ts("No rejected claims", Colors.black54));
      }
      return RefreshIndicator(
        onRefresh: () async {
          _controller.getApprovalList();
        },
        child: ListView.builder(
            itemCount: _controller.rejectedItems.length,
            itemBuilder: (context, index) {
              return ClaimApprovalCard(
                claim: _controller.rejectedItems[index],
              );
            }),
      );
    });
  }

  wAllHistoryScreen() {
    return Obx(() {
      if (_controller.isBusy.isTrue) {
        return const Center(
            child: SpinKitDoubleBounce(
          color: primaryColor,
        ));
      }

      if (_controller.allItems.isEmpty) {
        return Center(child: ts("No items in history", Colors.black54));
      }
      return RefreshIndicator(
        onRefresh: () async {
          _controller.getApprovalList();
        },
        child: ListView.builder(
            itemCount: _controller.allItems.length,
            itemBuilder: (context, index) {
              return ClaimApprovalCard(
                claim: _controller.allItems[index],
              );
            }),
      );
    });
  }
}
