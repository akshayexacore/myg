import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/models/claim_history.dart';
import 'package:travel_claim/modules/claim/claim_page.dart';
import 'package:travel_claim/resources/myg_repository.dart';


class HistoryController extends GetxController with GetSingleTickerProviderStateMixin{
  var isBusy = false.obs;

  var allItems = <ClaimHistory>[].obs;
  var pendingItems = <ClaimHistory>[].obs;
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
      lstrSelectedPage.value = "Pd";
    }
    if (pageNum == 3) {
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
      var response = await _repository.getClaimHistory();
        allItems(response.claims);
    } catch (_) {
      print('history claims get error: ${_.toString()}');
    } finally {
      if(!isSilent) {
        isBusy(false);
      }
    }
  }
}
