import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_claim/views/components/alertDialog.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/components/textInputField.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class AdvanceApprovelInner extends StatefulWidget {
  const AdvanceApprovelInner({super.key});

  @override
  State<AdvanceApprovelInner> createState() => _AdvanceApprovelInnerState();
}

class _AdvanceApprovelInnerState extends State<AdvanceApprovelInner> {
  final FocusNode remark_focusNode = FocusNode();
  @override
  void dispose() {
    // Clean up the focus node when the widget is disposed
    remark_focusNode.dispose();

    super.dispose();
  }
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: customAppBar("Advance Approvals"),
      body: Padding(
        padding:   EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                
                      decoration: boxDecoration(primaryColor, 10),
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ts("Employee ID", Colors.white),
                              gapHC(2),
                              tssb("Basil(MYGX-111)", Colors.white,FontWeight.w500),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ts("Date", Colors.white),
                              gapHC(2),
                              tssb("22/02/2024", Colors.white,FontWeight.w500),
                            ],
                          ),
                        ],
                      ),
                    ),
                    gapHC(15),
                
                
                    Container(
                     // margin:  EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: boxBaseDecoration(greyLight, 10),
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          headTitle("Type of trip", "Inauguration"),
                          gapHC(5),
                          headTitle("Branch name", "Thrissure"),
                          gapHC(5),
                          headTitle("Purpose of trip", "Inauguration at Thrissure"),
                          gapHC(5),
                          headTitle("Remarks", "Requesting for an advance amount of 8000 for the inauguration at Thrissur",
                              txtalign: TextAlign.start),
                          gapHC(5),
                          headTitle("Amount", "\u{20B9} 15,23.00",colors: primaryColor,fonsize: 16.0),
                
                        ],
                      ),),
                    gapHC(10),
                    Divider(),
                    ts("Remarks", Colors.black),
                    gapHC(3),
                    Container(
                      child:  TextinputfieldContainer(
                          showIcon: false,
                          verticalPadding: 6,
                          maxline: 4,
                          textInputAction: TextInputAction.done,
                
                          focusNode: remark_focusNode,
                          onSubmitted:  (){
                            remark_focusNode.unfocus();
                          } ,
                          hintText: "Enter your remarks",
                          isEnable: true,
                          isObscure: false),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child:Custombutton(onTap: (){

                      bottomsheet(context,"reject","Adv",ontap: (){
                        Get.back();
                        fToast.showToast(
                            child: Center(
                              child: showToastMessage(msg: "Advance has been Rejected",
                                  iconColor: Colors.red,icon: Icons.close_rounded),
                            ));
                      });
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                        , buttonName: "Reject",
                        buttonColor: Colors.white,
                        buttonBorderColor:Colors.grey.shade400,
                        buttonTextColor: Colors.black)
                ),
                gapWC(20),
                Expanded(
                    child:Custombutton(onTap: (){

                      bottomsheet(context,"approve","Adv",ontap: (){
                        Get.back();
                        fToast.showToast(
                            child: Center(
                              child: showToastMessage(msg: "Advance has been Approved",
                                  iconColor: Colors.green,icon: Icons.check_circle_rounded),
                            ));
                      });
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                        , buttonName: "Approve",
                        buttonColor: primaryColor,
                        buttonTextColor: Colors.white)
                ),
              ],
            ),
            gapHC(20)
          ],
        ),
      ),
    ));
  }
}
