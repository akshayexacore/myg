
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_claim/views/components/alertDialog.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/components/textInputField.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/screens/claimApprovel/controller/claimapprovel_controller.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class ClaimConfirmationScreen extends StatefulWidget {
  const ClaimConfirmationScreen({super.key});

  @override
  State<ClaimConfirmationScreen> createState() => _ClaimConfirmationScreenState();
}

class _ClaimConfirmationScreenState extends State<ClaimConfirmationScreen> {
  final ClaimapprovelController claimapprovelController = Get.put(ClaimapprovelController());

  final FocusNode remark_focusNode = FocusNode();
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    // Clean up the focus node when the widget is disposed
    remark_focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Claim confirmation"),
      body: SingleChildScrollView(
        child: Column(
         children: [
           Container(
             margin:   EdgeInsets.symmetric(horizontal: 15, vertical: 10),


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
           gapHC(5),


           Container(
             margin:  EdgeInsets.symmetric(horizontal: 15),
             decoration: boxBaseDecoration(greyLight, 10),
             padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 headTitle("Employee ID", "Basil(MYGX=111)"),
                 gapHC(5),
                 headTitle("Base Locatiob", "Kozhikode"),



               ],
             ),),

           Padding(
             padding:   EdgeInsets.symmetric(horizontal: 15, vertical: 10),

             child: Divider(),
           ),


           Padding(
             padding:   EdgeInsets.symmetric(horizontal: 15,),

             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 headTitle("Type of trip", "Inaugurations"),
                 gapHC(7),
                 headTitle("Branch name", "Thrissure"),
                 gapHC(7),
                 headTitle("Purpose of trip", "Inauguration atThrissure"),
                 gapHC(7),
                 headTitle("Claim period", "21/02/2024-22/02/2024"),
                 gapHC(7),
                 headTitle("Amount", "231231",colors: primaryColor),



               ],
             ),
           ),
           gapHC(10),

           ListView.builder(
               shrinkWrap: true,
               physics: ScrollPhysics(),
               itemCount:  claimapprovelController.claimList.value.length,
               itemBuilder: (context,index){
                 return    Column(
                   children: [
                     Bounce(
                         onTap: (){
                           setState(() {
                             claimapprovelController.claimList.value[index]["expand"] =! claimapprovelController.claimList.value[index]["expand"];

                           });
                           dprint("DDDD>> ${claimapprovelController.claimList.value[index]["expand"]}");

                         },
                         child: Padding(
                         padding:   EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                           child: expansionTile(   claimapprovelController.claimList.value[index]["image"]!,  claimapprovelController.claimList.value[index]["label"]),
                         )

                     ),
                     claimapprovelController.claimList.value[index]["expand"]?
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical: 8),
                       child: Column(
                         children: [
                           Container(
                             padding: const EdgeInsets.symmetric(
                                 horizontal: 20,
                                 vertical: 10
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
                                 Row(

                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                   children: [
                                     Flexible(
                                         flex: 5,
                                         child: ts("Number of employee", Colors.black)),


                                     Expanded(
                                       flex: 5,
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(twodigit(int.parse(claimapprovelController.numberOfemployeelist.value.length.toString())),textAlign: TextAlign.left,overflow: TextOverflow.fade,style:  const TextStyle(
                                               fontFamily: 'Roboto',fontSize: 14,
                                               fontWeight: FontWeight.w700,color:Colors.black)),
                                          gapHC(5),
                                           ListView.builder(
                                             shrinkWrap: true,
                                               itemCount: claimapprovelController.numberOfemployeelist.value.length,
                                               itemBuilder: (context,index){
                                                 var name = claimapprovelController.numberOfemployeelist.value[index];
                                             return Container(
                                               padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                               margin: EdgeInsets.only(bottom: 5),

                                               decoration: boxBaseDecoration(primaryColor, 20.0),
                                               child: Center(child: ts(name, Colors.white)),
                                             );

                                           }),
                                         ],
                                       ),
                                     ),
                                   ],
                                 ),
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
                                           const Text("tickets.pdf",textAlign: TextAlign.left,overflow: TextOverflow.fade,style: TextStyle(
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
                           gapHC(10),

                           Padding(
                             padding:   EdgeInsets.symmetric(horizontal: 15),

                             child: Row(
                               children: [
                                 Expanded(
                                     child:Custombutton(onTap: (){
                                       claimConfirmationbutton(ontap: (){
                                         Get.back();

                                         fToast.showToast(
                                             child: Center(
                                               child: showToastMessage(msg: "Claim has been Rejected",
                                                   iconColor: Colors.red,icon: Icons.close_rounded),
                                             ));
                                       },status: 'reject');

                                     }
                                         , buttonName: "Reject",
                                         buttonColor: Colors.white,
                                         buttonBorderColor:Colors.grey.shade400,
                                         buttonTextColor:primaryColor)),
                                 gapWC(20),
                                 Expanded(
                                     child:Custombutton(
                                       //  onTap:approvelrequest,
                                         onTap:(){
                                           approvelrequest();
                                         //   claimConfirmationbutton(ontap: (){
                                         //     Get.back();
                                         //     fToast.showToast(
                                         //         child: Center(
                                         //           child: showToastMessage(msg: "Claim has been Approved",
                                         //               iconColor: Colors.green,icon: Icons.check_circle_rounded),
                                         //         ));
                                         //
                                         //   },status: 'approve');
                                         // //
                                         },
                                         buttonName: "Send Approval",
                                         buttonColor: primaryColor,
                                         buttonTextColor: Colors.white)
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ):SizedBox(),

                   ],
                 );
               }),
           gapHC(20),
           Divider(),
           gapHC(20),
           Padding(
             padding:   EdgeInsets.symmetric(horizontal: 15),

             child: Row(
               children: [
                 Expanded(
                     child:Custombutton(onTap: (){
                       claimConfirmationbutton(ontap: (){
                         Get.back();

                         fToast.showToast(
                             child: Center(
                               child: showToastMessage(msg: "All Claim has Rejected",
                                   iconColor: Colors.red,icon: Icons.close_rounded),
                             ));
                       },status: 'rejectall');

                     }
                         , buttonName: "Reject all",
                         buttonColor: Colors.white,
                         buttonBorderColor:Colors.grey.shade400,
                         buttonTextColor:primaryColor)),
                 gapWC(20),
                 Expanded(
                     child:Custombutton(
                       //  onTap:approvelrequest,
                         onTap:(){
                           claimConfirmationbutton(ontap: (){
                             Get.back();
                             fToast.showToast(
                                 child: Center(
                                   child: showToastMessage(msg: "All Claim has Approved",
                                       iconColor: Colors.green,icon: Icons.check_circle_rounded),
                                 ));

                           },status: 'approveall');

                         },
                         buttonName: "Approve all",
                         buttonColor: primaryColor,
                         buttonTextColor: Colors.white)
                 ),
               ],
             ),
           ),
           gapHC(30)
         ],
        ),
      ),
    ));
  }

  submitAlert({status, ontap}) {
    var buttontxtst = status=='approve'?'Approve': status=='reject'?'Reject':"";
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
                          "submit the claim?", Colors.black87,
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
  approvelrequest(){
  return   show(context,
      // contHeight: size.height*0.89,
      autoDismiss: false,

      Padding(
        padding:   EdgeInsets.symmetric(horizontal: 15, vertical: 20),

        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    tssb('Approval request for lodging',Colors.black,FontWeight.bold),
                    gapHC(10),

                    Divider(),
                    gapHC(10),
                    Container(
                      //  margin:   EdgeInsets.symmetric(horizontal: 15, vertical: 10),


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
                    gapHC(10),


                    Container(
                      //  margin:   EdgeInsets.symmetric(horizontal: 15, vertical: 10),


                      decoration: boxBaseDecoration(greyLight, 10),
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ts("Checked-In", Colors.black),
                              gapHC(2),
                              tssb("22/02/2023", Colors.black,FontWeight.w500),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ts("Check-Out", Colors.black),
                              gapHC(2),
                              tssb("25/02/2024", Colors.black,FontWeight.w500),
                            ],
                          ),
                        ],
                      ),
                    ),
                    gapHC(10),
                    Divider(),
                    gapHC(10),
                    headTitle("Number of employee", "01"),
                    gapHC(7),
                    headTitle("Remark", "Thrissure"),
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
                              const Text("tickets.pdf",textAlign: TextAlign.left,overflow: TextOverflow.fade,style: TextStyle(
                                  fontFamily: 'Roboto',fontSize: 14,
                                  fontWeight: FontWeight.bold,color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    gapHC(7),
                    headTitle("Amount", "2344.00 INR"),
                    gapHC(10),
                    Obx(() => Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: boxOutlineCustom(
                          Colors.white, 10, Colors.grey.shade400),
                      child: DropdownButton(
                        focusColor: Colors.white,
                        dropdownColor: Colors.white,
                        underline: const SizedBox(),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                        // Initial Value
                        value: claimapprovelController.lstrApprover.value
                            .toString(),
                        isExpanded: true,
                        // Down Arrow Icon
                        icon: const Icon(Icons.arrow_forward_ios_rounded,
                            size: 13),

                        // Array list of items
                        items:
                        claimapprovelController.approverList.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: ts(
                              items,
                              Colors.black,
                            ),
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          claimapprovelController.fnOnsselectApprover(value);
                        },
                      ),
                    )),
                    gapHC(10),
                    TextinputfieldContainer(
                        showIcon: false,
                        verticalPadding: 6,

                        maxline: 3,
                        hintText: "Enter your remarks",
                        textInputAction: TextInputAction.done,

                        focusNode: remark_focusNode,
                        onSubmitted:  (){
                          remark_focusNode.unfocus();
                        } ,
                        isEnable: true,
                        isObscure: false),
                    gapHC(20)





                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child:Custombutton(onTap: (){
                      // bottomsheet(context);
                      Get.back();
                    }
                        , buttonName: "Close",
                        buttonColor: Colors.white,
                        buttonBorderColor:Colors.grey.shade400,
                        buttonTextColor:Colors.black)),
                gapWC(20),
                Expanded(
                    child:Custombutton(onTap:(){
                      // submitAlert(status: 'approve',ontap: (){
                      //
                      // });
                      claimConfirmationbutton(ontap: (){
                        Get.back();
                        Get.back();
                        fToast.showToast(
                            child: Center(
                              child: showToastMessage(msg: "Claim has been Approved",
                                  iconColor: Colors.green,icon: Icons.check_circle_rounded),
                            ));

                      },status: 'approve');


                    },
                        buttonName: "Send",
                        buttonColor: primaryColor,
                        buttonTextColor: Colors.white)
                ),
              ],
            ),



          ],
        ),
      ));
  }
  claimConfirmationbutton({status,ontap}){
    var buttontxtst=status=="approve"?'Approve':status=="reject"?'Reject':status=="rejectall"?'Reject all':status=="approveall"?'Approve all':'';
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(

                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),

                    decoration: boxDecoration(Colors.white, 20),
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            //  mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(status=="approve"||status=="approveall" ? AppAssets.sentpng:AppAssets.reject),
                              gapHC(20),
                              tcCustomhead("Are you sure you want to \n"
                                  "submit the claim?", Colors.black87,
                                  size: 21.0,
                                  align: TextAlign.center, FontWeight.w500),
                              gapHC(30),
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

                            ],
                          ),
                          gapHC(30),
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
                                  child:Custombutton(onTap:(ontap),
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
              ],
            ));
      },
    );
  }


}
