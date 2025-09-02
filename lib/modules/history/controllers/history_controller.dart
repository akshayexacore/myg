import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/models/claim_history.dart';
import 'package:travel_claim/modules/claim/claim_page.dart';
import 'package:travel_claim/resources/myg_repository.dart';
import 'package:travel_claim/utils/app_enums.dart';


class HistoryController extends GetxController with GetSingleTickerProviderStateMixin{
  var isBusy = false.obs;

  var allItems = <ClaimHistory>[].obs;
  var pendingItems = <ClaimHistory>[].obs;
  var approvedItems = <ClaimHistory>[].obs;
  var paidItems = <ClaimHistory>[].obs;
  var rejectedItems = <ClaimHistory>[].obs;

  RxInt selectedPage = 0.obs;
  late PageController pageController;
  RxString lstrSelectedPage = "Al".obs;
  final _repository = MygRepository();

  @override
  void onInit() {
    getHistory();
    pageController = PageController();
    super.onInit();
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

  void gotoClaimForm(ClaimForm claim){
    Get.toNamed(ClaimPage.routeName,arguments: claim);
  }

  getHistory({bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isBusy(true);
      }
      pendingItems.clear();
      allItems.clear();
      approvedItems.clear();
      paidItems.clear();
      rejectedItems.clear();


      var response = await _repository.getClaimHistory();
        allItems(response.claims);

      for (var item in response.claims) {
        switch (item.status) {
          case ClaimStatus.pending:
            pendingItems.add(item);
            break;
          case ClaimStatus.approved:
            approvedItems.add(item);
            break;
          case ClaimStatus.settled:
            paidItems.add(item);
          case ClaimStatus.rejected:
            rejectedItems.add(item);
            break;
          case ClaimStatus.none:
            break;
          case ClaimStatus.resubmitted:
            break;
        } 
      }

    } catch (_) {
      print('history claims get error: ${_.toString()}');
    } finally {
      if(!isSilent) {
        isBusy(false);
      }
    }
  }
}
