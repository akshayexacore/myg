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

class Specialapprovelinner extends StatefulWidget {
  const Specialapprovelinner({super.key});

  @override
  State<Specialapprovelinner> createState() => _SpecialapprovelinnerState();
}

class _SpecialapprovelinnerState extends State<Specialapprovelinner> {
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
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Special Approvals"),
      body: Padding(
        padding:   EdgeInsets.symmetric(horizontal: 15, vertical: 10),

        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    gapHC(10),
                    tssb("Approval request for lodging", Colors.black, FontWeight.bold),
                    const Divider(),
                    gapHC(5),
                    Container(
                     // margin:   const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                
                
                      decoration: boxDecoration(primaryColor, 10),
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
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
                    //  margin:  const EdgeInsets.symmetric(horizontal: 15),
                      decoration: boxBaseDecoration(greyLight, 10),
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ts("Checked-In", Colors.black),
                              ts("22/03/2024",weight: FontWeight.w500, Colors.black),
                
                
                
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ts("Checked-Out", Colors.black),
                              ts("25/03/2024",weight: FontWeight.w500, Colors.black),
                
                
                
                            ],
                          ),
                        ],
                      ),),
                    gapHC(5),
                    Divider(),
                
                
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        headTitle("Number of employee", "01"),
                
                
                        gapHC(7),
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
                        gapHC(7),
                        headTitle("Claim period", "21/02/2024-22/02/2024"),
                        gapHC(7),
                        headTitle("Amount", "231.00 INR",),
                        gapHC(7),
                        headTitle("Remark", "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
                
                
                
                      ],
                    ),
                    gapHC(5),
                    Divider(),
                    gapHC(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ts("Remarks", Colors.black),
                      ],
                    ),
                    gapHC(3),
                    TextinputfieldContainer(
                        showIcon: false,
                        verticalPadding: 6,
                        maxline: 3,
                        textInputAction: TextInputAction.done,
                
                        focusNode: remark_focusNode,
                        onSubmitted:  (){
                          remark_focusNode.unfocus();
                        } ,
                        hintText: "Enter your remarks",
                        isEnable: true,
                        isObscure: false),
                
                
                
                    gapHC(30)
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child:Custombutton(onTap: (){

                      specialApprovals("reject", (){

                        Get.back();
                        fToast.showToast(
                            child: Center(
                              child: showToastMessage(msg: "Special Approval has been Rejected",
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

                      specialApprovals("approve", (){
                        Get.back();
                        fToast.showToast(
                            child: Center(
                              child: showToastMessage(msg: "Special Approval has been Approved",
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
          ],
        ),
      ),
    ));
  }
  specialApprovals(status,ontap){
    String txtst = status=="approve"?"approve":status=="reject"?"reject":"";
    String buttontxtst = status=="approve"?"Approve":status=="reject"?"Reject":"";
    return Get.bottomSheet(

      Container(
          height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width,

          decoration: boxBaseDecorationC(Colors.white, 20, 20, 0, 0),
          child:  Padding(
            padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(status=="approve"? AppAssets.sentpng:AppAssets.reject),
                      gapHC(20),
                      tcCustomhead("Are you sure you want to \n"
                          "${txtst} the special approvals?", Colors.black87,
                          size: 21.0,
                          align: TextAlign.center, FontWeight.w500)
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child:Custombutton(onTap: (){
                          // bottomsheet(context);
                          Get.back();
                        }
                            , buttonName: "Cancel",
                            buttonColor: Colors.white,
                            buttonBorderColor:Colors.grey.shade400,
                            buttonTextColor: Colors.black)),
                    gapWC(20),
                    Expanded(
                        child:Custombutton(onTap:ontap,
                            buttonName: buttontxtst,
                            buttonColor: primaryColor,
                            buttonTextColor: Colors.white)
                    ),
                  ],
                ),

              ],
            ),
          )
      ),


      isDismissible: false,


      enableDrag: false,

    );
  }
}
