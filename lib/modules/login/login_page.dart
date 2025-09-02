import 'package:bounce/bounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/textInputField.dart';
import 'package:travel_claim/views/style/colors.dart';

import 'controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static const routeName = '/login';

  final loginController = Get.find<LoginController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      extendBody: true,


      backgroundColor: primaryColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.7,
            child: backgroundImg(context,-0.27, 0.51),

          ),
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.48,
            child: Container(
              decoration:boxBaseDecorationC(Colors.white,
                  30, 30, 0, 0),
              padding: const EdgeInsets.symmetric(horizontal:16, ),

              child: Obx(()=>Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  gapHC(20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: loginController.formKey,
                        child: Column(
                          // / mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            gapHC(10),
                            Text(
                              "Lets sign you in",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  color: textColor),
                            ),
                            gapHC(13),
                            ts("Employee ID", Colors.black),
                            gapHC(3),
                            TextinputfieldContainer(
                                showIcon: false,
                                isEnable: true,
                                isObscure: false,
                                textCapitalization: TextCapitalization.characters,
                                hintText: "Enter your employee ID",
                                controller: loginController.textControllerUsername,
                                validate:(value){
                                  dprint("VVVV  >>>  > >${value}");
                                  if(value.isEmpty ||value==null){

                                    return "Please Enter a Value";
                                  }else{
                                    return null;
                                  }
                                },
                                keybordType: TextInputType.text),
                            gapHC(15),
                            ts("Password", Colors.black),
                            gapHC(5),
                            TextinputfieldContainer(
                                showIcon: true,
                                maxline: 1,
                                textCapitalization: TextCapitalization.none,
                                suffixIcon:loginController.showPassword.isTrue? Icons.visibility_off_outlined:Icons.visibility_outlined,
                                suffixIconOnclick: (){
                                  loginController.showPassword.toggle();
                                },
                                validate:(value){
                                  dprint("VVVsssssV  >>>  > >${value}");
                                  if(value.isEmpty ||value==null){
                                    return "Please Enter a Value";
                                  }else{
                                    return null;
                                  }
                                },
                                isObscure: !loginController.showPassword.value,
                                isEnable: true,
                                hintText: "Enter your password",
                                controller: loginController.textControllerPassword,
                                keybordType: TextInputType.text),
                            gapHC(30),
                            loginController.busy.isFalse?    Bounce(
                              duration: const Duration(seconds: 110),
                              onTap: (){
                                FocusScope.of(context).unfocus();
                                loginController.login();

                              },
                              child: Container(
                                height: 46,
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 12),

                                decoration: boxBaseDecoration(primaryColor, 10),
                                child: Center(child: tc("LOGIN", Colors.white,16)),

                              ),
                            ):
                            const SpinKitThreeBounce(color:primaryColor,size: 20,),


                          ],
                        ),
                      ),
                    ),
                  ),
                  if(MediaQuery.of(context).viewInsets.bottom==0)
                  gapHC(10),
                   if(MediaQuery.of(context).viewInsets.bottom==0)
                   tss("copyright@2024myClaim", Colors.black, 13.0),
                  if(MediaQuery.of(context).viewInsets.bottom==0)
                  gapHC(10),
                ],
              )),
            ),

          ),

        ],
      ),
    );
  }

  Widget loginTextfield(controller,isObscure,textInputAction,focusNode,showIcon,suffixIconOnclick,suffixIcon,hintText,keybordType,inputFormattor){
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      textInputAction:textInputAction ,
      focusNode: focusNode,

      style: const TextStyle(color: Colors.black),
      maxLines: 1,
      decoration: InputDecoration(

        contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 0.0
        ),
        suffixIcon:showIcon? Bounce(
          onTap: suffixIconOnclick,

          child: Icon(
            suffixIcon,
            color: Colors.grey.shade600,

          ),
        ):SizedBox(),
        hintText: hintText,
        hintStyle: hintTextStyle(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:  BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:  BorderSide(color: Colors.grey.shade500),
        ),
      ),
      keyboardType: keybordType,
      inputFormatters: inputFormattor,
      //   onSubmitted: (v){
      //     onSubmitted;
      //
      // },




    );
  }

}