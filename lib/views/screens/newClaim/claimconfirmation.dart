import 'package:bounce/bounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_claim/views/components/alertDialog.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/screens/newClaim/newclaim_controller/claimconfirmationController.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class Claimconfirmation extends StatefulWidget {
  const Claimconfirmation({super.key});

  @override
  State<Claimconfirmation> createState() => _ClaimconfirmationState();
}

class _ClaimconfirmationState extends State<Claimconfirmation> {
  final Claimconfirmationcontroller claimconfirmationcontroller =
  Get.put(Claimconfirmationcontroller());
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
      child:  Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar("Claim confirmation"),
        body: Column(
          children: [
            Expanded(
              child: Obx(()=>
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: 20,
                              vertical: 16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20
                            ),
                            decoration: boxBaseDecoration(greyLight, 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                    
                              children: [
                    
                                headTitle("Employee ID", "Basil(MYGX-1234)"),
                                gapHC(10),
                                headTitle("Base Location", "Kozhikode"),
                                gapHC(10),
                                headTitle("Date", "22/02/2024"),
                                gapHC(10),
                                headTitle("Type of trip", "Inauguration"),
                                gapHC(10),
                                headTitle("Branch name", "Thrissure"),
                                gapHC(10),
                                headTitle("Purpose of trip", "Inauguration at Thrissure"),
                    
                              ],
                    
                            ),
                          ),
                        ),
                    
                    
                    
                    
                    
                    
                       ListView.builder(
                         shrinkWrap: true,
                           physics: ScrollPhysics(),
                           itemCount:  claimconfirmationcontroller.expenseCategory.value.length,
                           itemBuilder: (context,index){
                         return    Column(
                           children: [
                             Bounce(
                                 onTap: (){
                                   setState(() {
                                     claimconfirmationcontroller.expenseCategory.value[index]["expand"] =! claimconfirmationcontroller.expenseCategory.value[index]["expand"];

                                   });
                                   dprint("DDDD>> ${claimconfirmationcontroller.expenseCategory.value[index]["expand"]}");

                                 },
                                 child: Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                                   child: expansionTile(  claimconfirmationcontroller.expenseCategory.value[index]["image"]!,   claimconfirmationcontroller.expenseCategory.value[index]["label"]),
                                 )

                             ),
                             claimconfirmationcontroller.expenseCategory.value[index]["expand"]? Padding(
                               padding: const EdgeInsets.symmetric(vertical: 15),
                               child: Container(
                                 padding: const EdgeInsets.symmetric(
                                     horizontal: 20,
                                     vertical: 20
                                 ),
                                 decoration: boxBaseDecoration(greyLight, 0 ),
                                 child: Column(
                                   children: [
                                     headTitle("From", "Kozhikode"),
                                     gapHC(10),
                                     headTitle("To", "Thrissure"),
                                     gapHC(10),
                                     headTitle("Document date", "22/02/2024"),
                                     gapHC(10),
                                     headTitle("Number of employees", "03"),
                                     gapHC(10),
                                     headTitle("Remark", "Economy class"),
                                     gapHC(10),
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
                                     gapHC(10),
                                     headTitle("Amount", "9500.INR"),
                                   ],
                                 ),

                               ),
                             ):SizedBox(),

                           ],
                         );
                       }),
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    

                    
                      ],
                    ),
                  )),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),

              child: Divider(),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tcCustomhead("Total Amount", Colors.grey.shade600, FontWeight.w400),
                  tcCustomhead("\u{20B9}18,140.00", primaryColor, FontWeight.w700),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                            children: [
                              Expanded(
                                child:Custombutton(onTap: (){
                                  Get.back();
                                }, buttonName: "Cancel", buttonColor: Colors.white,
                                    buttonTextColor: Colors.black,
                                buttonBorderColor: Colors.grey.shade400,)
                              ),
                          gapWC(20),
                              Expanded(
                                child:Custombutton(onTap: (){
                                  show(context,autoDismiss: false,
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                gapHC(30),
                                                Image.asset(
                                                  AppAssets.msgBox
                                                  ,fit: BoxFit.fill,




                                                ),
                                                gapHC(30),
                                                tssb("Total Amount", Colors.grey.shade600, FontWeight.w500)
                                                ,
                                                tcustom("\u{20B9}15,23.00", primaryColor, 20.0, FontWeight.w500),
                                                gapHC(30),
                                                tcCustomhead("Are you sure you want to \n"
                                                    "submit the claim?", Colors.black87,
                                                    size: 21.0,
                                                    align: TextAlign.center, FontWeight.w500)


                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Custombutton(onTap: (){
                                                    Navigator.pop(context);
                                                    }, buttonName: "Cancel",
                                                        buttonColor: Colors.white,
                                                        buttonBorderColor: Colors.grey.shade400,
                                                        buttonTextColor: Colors.black)
                                                ),
                                                gapWC(20),
                                                Expanded(
                                                    child: Custombutton(onTap: (){
                                                      fToast.showToast(
                                                        child: showToastMessage(msg: "Claim has been submitted successfully",
                                                        iconColor: Colors.green,icon: Icons.check_circle_rounded),
                                                      );
                                                      Get.back();
                                                      Get.back();
                                                      Get.back();
                                                    }, buttonName: "Submit", buttonColor: primaryColor,
                                                        buttonTextColor: Colors.white
                                                    )
                                                ),
                                              ],
                                            ),
                                          ),
                                          gapHC(20)
                                        ],
                                      ));

                                }, buttonName: "Submit", buttonColor: primaryColor,
                                    buttonTextColor: Colors.white)
                              ),
                            ],
                          ),
            ),
            gapHC(20)
          ],
        ),


      ),
    );
  }





}
