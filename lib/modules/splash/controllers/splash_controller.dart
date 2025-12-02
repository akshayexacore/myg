
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/login/controllers/auth_controller.dart';
import 'package:travel_claim/modules/splash/controllers/update_controller.dart';
import 'package:travel_claim/utils/app_exception.dart';
import 'package:travel_claim/views/components/app_dialog.dart';


class SplashController extends GetxController {
 
  var isBusy = false.obs;
  late final noNetwork = false.obs;
  @override
  void onInit() {
    gotoHomePage();
    super.onInit();
  }

  void gotoHomePage() async {
    await Future.delayed(const Duration(milliseconds: 2000)).then((value) async {
    
      try{

        Get.find<AuthController>().gotoLandingPage();
      }on FetchDataException catch(e){
        print('splash error');
        print(e.toString());
        noNetwork(true);
        gotoHomePage();
      }catch(_){
        if(_ is UnauthorisedException){
          Get.find<AuthController>().logout();
          AppDialog.showToast("Session expired! Login Again.");
        }
        print('splash error');
        print(_.toString());
      }
    });
  }
}
