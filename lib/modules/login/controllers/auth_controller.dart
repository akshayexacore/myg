import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/landing/landing_page.dart';
import 'package:travel_claim/modules/login/login_page.dart';
import 'package:travel_claim/resources/auth_repository.dart';
import 'package:travel_claim/resources/user_profile_repository.dart';
import 'package:travel_claim/utils/app_exception.dart';
import 'package:travel_claim/utils/shared_preferences_data_provider.dart';
import 'package:travel_claim/views/components/app_dialog.dart';


class AuthController extends GetxController {
  late final busy = false.obs;

  late final _authRepository = AuthRepository();
  late final _userProfileRepository = UserProfileRepository();


  void gotoLandingPage() async {
    busy(true);
    try {

      String token = await _authRepository.getAccessToken();
      if (token.isNotEmpty) {
        // if (user.name.isNotEmpty) {
        final user = await _userProfileRepository.getUserOffline();
        if (user.id!=0) {
            _gotoLandingPage();
        } else {
          gotoLoginPage();
        }
        /* } else {
        _gotoProfileUpdate();
      }*/
      } else {
        gotoLoginPage();
      }
      busy(false);

      if (Platform.isAndroid) {
        SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      }
    }catch(_){
      print('landing:${_.toString()}');
      if(_ is UnauthorisedException){
        logout();
      }else{
        AppDialog.showToast(_.toString());
      }
    }
  }

  void _gotoLandingPage() {
    Get.offAllNamed(LandingPage.routeName);
  }

  void gotoLoginPage() async {
      Get.offAllNamed(LoginPage.routeName);
  }


  void logout() async{
    try {
      await _authRepository.logoutUser();
    }catch(_){}
    finally {
      SharedPreferencesDataProvider().clear();
      Get.offAllNamed(LoginPage.routeName);
    }
  }

  Future<bool> isLoggedIn()async{
    String token = await _authRepository.getAccessToken();
    if (token.isNotEmpty) {
      return true;
    }else{
      return false;
    }
  }

}
