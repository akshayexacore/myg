import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/claim_history.dart';
import 'package:travel_claim/resources/myg_repository.dart';
import 'package:travel_claim/utils/app_enums.dart';

class ClaimApprovalListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var isBusy = false.obs;
   late PageController pageController;

  var allItems = <ClaimHistory>[].obs;
  var approvedItems = <ClaimHistory>[].obs;
  var pendingItems = <ClaimHistory>[].obs;
  var paidItems = <ClaimHistory>[].obs;
  var rejectedItems = <ClaimHistory>[].obs;
  final _repository = MygRepository();
  RxInt selectedPage = 0.obs;
  RxString lstrSelectedPage = "Al".obs;
  @override
  void onInit() {
    pageController = PageController();
    getApprovalList();
    super.onInit();
  }

  getApprovalList({bool isSilent = false}) async {
    try {
      if (!isSilent) {
        isBusy(true);
      }
      allItems.clear();
      paidItems.clear();
      pendingItems.clear();
      rejectedItems.clear();
      paidItems.clear();

      var response = await _repository.getClaimsForApproval();
              allItems(response.claims);
            for (var item in response.claims) {
        switch (item.status) {
          case ClaimStatus.pending:
            pendingItems.add(item);
            break;
          case ClaimStatus.approved:
            approvedItems.add(item);
            break;
          case ClaimStatus.rejected:
            rejectedItems.add(item);
            break;
          case ClaimStatus.none:
            break;
          case ClaimStatus.resubmitted:
            break;
          case ClaimStatus.settled:
          paidItems.add(item);
          break;
            // TODO: Handle this case.
        } 
      }
      // allItems(response.claims);
    } catch (_) {
      print('approval claims get error: ${_.toString()}');
    } finally {
      if (!isSilent) {
        isBusy(false);
      }
    }
  }
    fnChangePage(int pageNum) {
    selectedPage.value = pageNum;
    pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );

    if (pageNum == 0) {
      lstrSelectedPage.value = "Al";
    }

    if (pageNum == 1) {
      lstrSelectedPage.value = "Pe";
    }
    if (pageNum == 2) {
      lstrSelectedPage.value = "Ap";
    }
    if (pageNum == 3) {
      lstrSelectedPage.value = "Pd";
    }
    if (pageNum == 4) {
      lstrSelectedPage.value = "Rj";
    }
  }
}
