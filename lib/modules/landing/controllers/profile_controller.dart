import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/user.dart';
import 'package:travel_claim/modules/login/login_page.dart';
import 'package:travel_claim/resources/auth_repository.dart';
import 'package:travel_claim/resources/user_profile_repository.dart';
import 'package:travel_claim/views/components/app_dialog.dart';

class ProfileController extends GetxController {
  var isBusy = false.obs;
  var isUpdateBusy = false.obs;

  var canEdit = false.obs;
  var hasNewNotification = false.obs;

  late final textControllerFirstName = TextEditingController();
  late final textControllerLastName = TextEditingController();
  late final textControllerEmail = TextEditingController();
  TextEditingController textEditingControllerDob = TextEditingController();
  var selectedDob = Rxn<DateTime>();

  var genders = ["Male","Female","Other"];
  var selectedGender = Rxn<String>();

  var profilePic = Rxn<String>();

  final _userProfileRepository = UserProfileRepository();
  var user = User().obs;
  var error = "".obs;
  @override
  void onInit() {
    getUser();
    saveFcm();
    super.onInit();
  }

  void getUser()async{
    try{
      error("");
      isBusy(true);
      var response = await _userProfileRepository.getUser();
      if(response.success) {
        user(response.user);
      }
    }catch(_){
    }finally{
      isBusy(false);
    }
  }

  void gotoLogout(){
    AppDialog.showDialog(title: "Logout?",content: "Are you sure you want to logout?",negativeText: "Cancel",positiveText: "Logout",positiveOnPressed: (){
      logout();
    },negativeOnPressed: Get.back);
  }

  void logout(){
    AuthRepository().logoutUser();
    Get.offAllNamed(LoginPage.routeName);
  }

  void saveFcm()async{
    try{
      var body = {
        "registration_id": await FirebaseMessaging.instance.getToken(),
        "type": Platform.isAndroid ? "android" : "ios"
      };
      print('fcm');
      print(body);
      final response = await _userProfileRepository.saveFcmToken(body: body);
    }catch(_){
    }
  }
}
