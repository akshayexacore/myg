import 'package:bounce/bounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/landing/controllers/landing_controller.dart';
import 'package:travel_claim/modules/landing/controllers/profile_controller.dart';
import 'package:travel_claim/modules/notification/notification_screen.dart';
import 'package:travel_claim/modules/profile/profile_page.dart';
import 'package:travel_claim/views/components/alertDialog.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:badges/badges.dart' as badges;

import '../const/appassets.dart';
import '../style/colors.dart';
Widget backgroundImg(context,bottomContainerXaxis,upperContainerXaxis){
  return Stack(
    children: [
      Container(
        width: 58.5,
        color: primaryColorLight,
        height: MediaQuery.of(context).size.height,
        alignment:
        new Alignment(0, 0),
        transform:
        new Matrix4.translationValues(MediaQuery.of(context).size.width *upperContainerXaxis, -29.6, 0.0)
          ..rotateZ(-27 * 3.1415927 / 180),
      ),
      Center(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  AppAssets.splash_appIcon,width: MediaQuery.sizeOf(context).width*0.5,
              ),
            // tcustomhight("Travel Claim", Colors.white, 20.0, FontWeight.w500,

            //   )
            ],
          )
      ),
      Container(
        width: 58.5,
        color: primaryColorLight,
        height: MediaQuery.of(context).size.height,
        alignment:
        new Alignment(0, 0),
        transform:
        new Matrix4.translationValues(MediaQuery.of(context).size.width * bottomContainerXaxis, 139.6, 0.0)
          ..rotateZ(-27 * 3.1415927 / 180),
      ),



    ],

  );
}
Widget backgroundwithouAppicon(context,bottomContainerXaxis,upperContainerXaxis,child){
  return Stack(
    children: [
      Stack(
        children: [
          Container(
            width: 58.5,
            color: primaryColorLight,
            height: MediaQuery.of(context).size.height,
            alignment:
            new Alignment(0, 0),
            transform:
            new Matrix4.translationValues(MediaQuery.of(context).size.width *upperContainerXaxis, -29.6, 0.0)
              ..rotateZ(-27 * 3.1415927 / 180),
          ),
          Container(
            width: 58.5,
            color: primaryColorLight,
            height: MediaQuery.of(context).size.height,
            alignment:
            new Alignment(0, 0),
            transform:
            new Matrix4.translationValues(MediaQuery.of(context).size.width * bottomContainerXaxis, 12.6, 0.0)
              ..rotateZ(-27 * 3.1415927 / 180),
          ),

        ],

      ),
      child,
    ],
  );
}
// Widget profileBackgroundImg(context){
//   return    Stack(
//     children: [
//
//
//
//       Container(
//         width: 58.5,
//         color:primaryColorLight,
//         height: MediaQuery.of(context).size.height,
//         alignment:
//         new Alignment(0, 0),
//         transform:
//         new Matrix4.translationValues(MediaQuery.of(context).size.width * 0.1, 259.6, 0.0)
//           ..rotateZ(-27 * 3.1415927 / 180),
//       ),
//
//       Container(
//         width: 58.5,
//         color: primaryColorLight,
//         height: MediaQuery.of(context).size.height,
//         alignment:
//         new Alignment(0, 0),
//         transform:
//         new Matrix4.translationValues(MediaQuery.of(context).size.width * -0.74, 139.6, 0.0)
//           ..rotateZ(-27 * 3.1415927 / 180),
//       ),
//
//
//
//     ],
//   );
// }
Widget bgDashBoard(context,name){
  Size size = MediaQuery.of(context).size;
  return  Container(
    height: size.height,
    width: size.width,
    child: Column(
      children: [
        Container(
          decoration: boxImageDecoration(AppAssets.backimg, 0),
          width: size.width,
          height: size.height*0.35,
          child:Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 50, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Bounce(
                      duration: const Duration(milliseconds: 110),
                      onTap: (){
                        Get.toNamed(ProfilePage.routeName);
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: name.toString().isNotEmpty? thbAppbar(name[0], primaryColor):const SizedBox(),
                      ),
                    ),
                    Row(
                      children: [
                        /*Bounce(
                          duration: const Duration(milliseconds: 110),
                          onTap: (){
                            endBottomSheetDialog(
                                "Are you sure you want to Logout",
                                "",
                                "Logout",
                                "Cancel",
                                    (){
                                      Get.find<ProfileController>().logout();
                                }

                            );

                          },
                          child: SvgPicture.asset(AppAssets.logout,height: 20,)
                        ),
                        gapWC(20),*/
                        Bounce(
                          duration: const Duration(milliseconds: 110),
                          onTap: (){
                            Get.toNamed(NotificationScreen.routeName);
                          },
                          child: badges.Badge(
                              badgeContent: Obx(() {
                                return ts(Get.find<LandingController>().notifications.value.toString(), Colors.white);
                              },),
                              position: badges.BadgePosition.topEnd(
                                  top: -11, end: -2),
                              showBadge: Get.find<LandingController>().notifications.value>0  ? true : false,
                              badgeStyle: const badges.BadgeStyle(
                                shape: badges.BadgeShape.circle,
                                badgeColor: Colors.red,
                              ),
                              child: SvgPicture.asset(AppAssets.notification,height: 19,)),
                        ),
                      ],
                    )
                  ],
                ),
                // gapHC(26),
                // tchead("Welcome to your dashboard,", Colors.white, 20.0,
                //     FontWeight.w500),
                // gapHC(1),
                // tchead("Basil - MY GX-0000", Colors.white, 20.0,
                //     FontWeight.w500),
              ],
            ),
          ) ,
        ),
        Container(
          decoration: boxDecorationC(greyLight, 30, 30, 0, 0),
          width: size.width,

          height: size.height*0.65,

        )
      ],
    ),
  );
}
PreferredSizeWidget customAppBar(title){
  return AppBar(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    centerTitle: true,
    title:  thb(title,Colors.white),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.backimg),
          fit: BoxFit.cover,
        ),
      ),
    ),




  );
}
