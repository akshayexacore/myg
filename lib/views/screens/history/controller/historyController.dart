import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/state_manager.dart';

class Historycontroller extends GetxController{
  RxInt selectedPage = 0.obs;
  late PageController pageController;
  RxString lstrSelectedPage = "Al".obs;
  final RxList<Map<String, dynamic>> submittedCategory = [
    {"image":"assets/icons/flight.png",'label': 'Air', 'value': false,"expand":false},
    {"image":"assets/icons/train.png",'label': 'Train', 'value': false,"expand":false},
    {"image":"assets/icons/bedrom.png",'label': 'Lodging', 'value': false,"expand":false},
    {"image":"assets/icons/fastfood.png",'label': 'Food', 'value': false,"expand":false},
    {"image":"assets/icons/bus.png",'label': 'Bus', 'value': false,"expand":false},
    {"image":"assets/icons/fuel.png",'label': 'Fuel', 'value': false,"expand":false},
    {"image":"assets/icons/entertain.png",'label': 'Entertainment', 'value': false,"expand":false},
  ].obs;

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


}