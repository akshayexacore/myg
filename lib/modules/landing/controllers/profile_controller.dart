import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_claim/models/user.dart';
import 'package:travel_claim/modules/login/login_page.dart';
import 'package:travel_claim/resources/auth_repository.dart';
import 'package:travel_claim/resources/user_profile_repository.dart';
import 'package:travel_claim/utils/local_storage_data_provider.dart';
import 'package:travel_claim/utils/shared_preferences_data_provider.dart';
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
  var appVersion = "".obs;
  @override
  void onInit() {
    getUser();
    saveFcm();
    getPackageInfo();
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

  void logout()async{
    try {
      await AuthRepository().logoutUser();
    }catch(_){}
    finally {
      Get.offAllNamed(LoginPage.routeName);
      SharedPreferencesDataProvider().clear();
      //LocalStorageDataProvider().clear();
    }
  }

  void saveFcm()async{
    try{
      var body = {
        "fcm_token": await FirebaseMessaging.instance.getToken(),
        "type": Platform.isAndroid ? "android" : "ios"
      };
      print('fcm');
      print(body);
      final response = await _userProfileRepository.saveFcmToken(body: body);
    }catch(_){
    }
  }

  void getPackageInfo()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    appVersion("Version $version($buildNumber)");
  }
}
