import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/landing/landing_page.dart';
import 'package:travel_claim/modules/login/controllers/auth_controller.dart';
import 'package:travel_claim/modules/login/login_page.dart';
import 'package:travel_claim/resources/auth_repository.dart';
import 'package:travel_claim/resources/user_profile_repository.dart';
import 'package:travel_claim/utils/app_exception.dart';
import 'package:travel_claim/views/components/app_dialog.dart';


class LoginController extends GetxController {
  late var busy = false.obs;
  late var showPassword = false.obs;


  late final textControllerUsername = TextEditingController();
  late final textControllerPassword = TextEditingController();

  late final _authRepository = AuthRepository();
  late final _userProfileRepository = UserProfileRepository();

  late final _authController = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    busy = _authController.busy;
    super.onInit();
  }

  void login() async {
    busy(true);
    try {
      if (formKey.currentState!.validate()) {
        final response = await _authRepository.login(
            textControllerUsername.text, textControllerPassword.text);

        if (response.success) {
          busy(false);
         await _userProfileRepository.saveUser(response.user!);
         await _authRepository.saveAccessToken(response.accessToken);
         await _authRepository.saveRefreshToken(response.refreshToken);

          gotoLandingPage();
        } else {
          busy(false);
          AppDialog.showToast(response.message ?? 'Something went wrong! Try again.',isError: true);
        }
      } else {
        busy(false);
      }
    } on UnauthorisedException {
      busy(false);
      AppDialog.showToast('Invalid credentials',isError: true);
    } catch (_) {
      print(_.toString());
      busy(false);
      AppDialog.showToast('Something went wrong! Try again.',isError: true);
    } finally {}
  }

  bool _validate(){
    if(!textControllerUsername.text.isEmail){
      AppDialog.showToast('Enter valid email address',isError: true);
      return false;
    }
    if(textControllerPassword.text.isEmpty || textControllerPassword.text.length <3){
      AppDialog.showToast('Password must have at least 3 characters.',isError: true);
      return false;
    }
    return true;
  }


  void gotoLoginPage() {
    Get.offAllNamed(LoginPage.routeName);
  }

  void gotoLandingPage() async{
    Get.offAllNamed(LandingPage.routeName);
  }

}
