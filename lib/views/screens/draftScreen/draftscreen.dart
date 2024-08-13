import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/screens/draftScreen/draftInner.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class DraftScreen extends StatefulWidget {
  const DraftScreen({super.key});

  @override
  State<DraftScreen> createState() => _DraftScreenState();
}

class _DraftScreenState extends State<DraftScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
         backgroundColor: Colors.white,
         appBar: customAppBar("Draft"),
          body: ListView.builder(
              itemCount: 4,
              itemBuilder: (context,index){
            return Bounce(
              onTap: (){
                Get.to(()=>DraftinnerScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 15,right: 15),
                child: Stack(
                  children: [
                    Container(

                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                      decoration: boxOutlineShadowCustom(Colors.white, 10, Colors.grey.shade400),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          headTitle("Date", "22/02/2024"),
                          headTitle("Type of trip", "Inaugurations"),
                          headTitle("Branch name", "Thrissure"),
                        ],
                      ),

                    ),
                    Positioned.fill(

                      child: Align(    alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: boxDecoration(primaryColor, 50),
                          child: Icon(Icons.arrow_forward_ios,
                            color: Colors.white,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          })

    ));
  }
}
