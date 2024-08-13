import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/splash/controllers/splash_controller.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/style/colors.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  static const routeName = '/';

  final SplashController splashController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Container(
            width: 58,
            color: primaryColorLight,
            height: MediaQuery.of(context).size.height,
            alignment:
            new Alignment(0, 0),
            transform:
            new Matrix4.translationValues(MediaQuery.of(context).size.width * 0.59, -29.6, 0.0)
              ..rotateZ(-27 * 3.1415927 / 180),
          ),
          Center(
              child:  Image.asset(
                AppAssets.appIcon,

              )
          ),
          Container(
            width: 58,
            color: primaryColorLight,
            height: MediaQuery.of(context).size.height,
            alignment:
            new Alignment(0, 0),
            transform:
            new Matrix4.translationValues(MediaQuery.of(context).size.width * -0.68, 139.6, 0.0)
              ..rotateZ(-27 * 3.1415927 / 180),
          ),



        ],

      ),
    );
  }
}
