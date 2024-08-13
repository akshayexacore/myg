import 'package:bounce/bounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/landing/controllers/profile_controller.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/textInputField.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'dart:math' as math;

import 'package:travel_claim/views/widgets.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  static const routeName = '/profile';

  final profileController = Get.find<ProfileController>();


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Obx(()=>Scaffold(
          backgroundColor: Colors.white,
          appBar: customAppBar("Profile"),
          body:profileController.isBusy.isFalse ? Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  gapHC(25),
                  Obx(()=>  CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    radius: 45.0,
                    //       name.toString().isNotEmpty? thbAppbar(name[0], primaryColor)
                    child:
                    profileController.user.value.name.isNotEmpty?
                    tcustom(profileController.user.value.name[0],primaryColor,30.0,FontWeight.bold):SizedBox(),
                  ),),
                  gapHC(15),

                  Divider(color: Colors.grey.shade300,),
                  gapHC(10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20
                    ),
                    decoration: boxBaseDecoration(greyLight, 8),
                    child: Obx(()=>Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        headTitle("Employee ID", profileController.user.value.employeeId),
                        gapHC(10),
                        headTitle("Employee name",profileController.user.value.name),
                        gapHC(10),
                        headTitle("Department", profileController.user.value.department),
                        gapHC(10),
                        headTitle("Branch", "${profileController.user.value.branch?.name} (${profileController.user.value.branch?.code})"),
                        gapHC(10),
                        headTitle("Base location", "${profileController.user.value.baseLocation?.name} (${profileController.user.value.baseLocation?.code})"),
                        gapHC(10),
                        headTitle("Designation",profileController.user.value.designation),
                        gapHC(10),
                        headTitle("Grade", 'Grade ${profileController.user.value.grade}'),
                        gapHC(10),
                        headTitle("Reporting Person", profileController.user.value.reportingPerson),
                        gapHC(10),
                        headTitle("Email", profileController.user.value.email),
                        gapHC(10),
                        headTitle("Mobile Number", profileController.user.value.phoneNumber),


                      ],

                    )),
                  )
                ],
              ),
            ),
          ):const Center(
            child:    SpinKitThreeBounce(color:primaryColor,size: 20,),
          ),

        ),)
    );
  }

}