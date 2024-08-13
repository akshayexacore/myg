import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_claim/views/components/alertDialog.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/components/textInputField.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class Cmdapprovelinnner extends StatefulWidget {
  const Cmdapprovelinnner({super.key});

  @override
  State<Cmdapprovelinnner> createState() => _CmdapprovelinnnerState();
}

class _CmdapprovelinnnerState extends State<Cmdapprovelinnner> {
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
          appBar: customAppBar("CMD Approvals"),
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
                                  ts("Trip ID", Colors.white),
                                  gapHC(2),
                                  tssb("#TMG1234", Colors.white,FontWeight.w500),
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
                              headTitle("Employee ID", "Basil(MYGX=111)"),
                              gapHC(5),
                              headTitle("Number of employees", "01"),
                              gapHC(5),
                              headTitle("Category", "client entertainment"),
                              gapHC(5),
                              headTitle("Remarks", "Lunch with client",
                                  txtalign: TextAlign.start),
                              gapHC(5),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      flex: 5,
                                      child: ts("Attached files", Colors.black)),
                    
                    
                                  Expanded(
                                    flex: 5,
                                    child: Row(
                                      children: [
                                        Image.asset(AppAssets.file,height: 16,width: 14,fit: BoxFit.fill,),
                                        gapWC(7),
                                        Text("tickets.pdf",textAlign: TextAlign.left,overflow: TextOverflow.fade,style: const TextStyle(
                                            fontFamily: 'Roboto',fontSize: 14,
                                            fontWeight: FontWeight.bold,color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                    
                            ],
                          ),),
                        gapHC(15),
                    
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            tcCustomhead("Amount", Colors.grey.shade600, FontWeight.w400),
                            tcCustomhead("\u{20B9}18,140.00", primaryColor, FontWeight.w700),
                          ],
                        ),
                    
                        gapHC(15),
                    
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

                          bottomsheet(context,"reject","cmd",ontap:(){
                            Get.back();
                            fToast.showToast(
                                child: Center(
                                  child: showToastMessage(msg: "Claim has been Rejected",
                                  iconColor: Colors.red,icon: Icons.close_rounded),
                                ));
                          } );
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                            , buttonName: "Reject",
                            buttonColor: Colors.white,
                            buttonBorderColor:Colors.grey.shade400,
                            buttonTextColor: Colors.black)),
                    gapWC(20),
                    Expanded(
                        child:Custombutton(onTap: (){

                          bottomsheet(context,"approve","cmd",ontap: (){
                            Get.back();
                            fToast.showToast(
                                child: Center(
                                  child: showToastMessage(msg: "Claim has been Approved",
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
