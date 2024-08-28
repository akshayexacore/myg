import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:travel_claim/views/components/alertDialog.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/components/textInputField.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/screens/reqAdvance/reqAdvController/reqAdvanceController.dart';
import 'package:travel_claim/views/style/colors.dart';

class ReqadvanceScreen extends StatefulWidget {
  const ReqadvanceScreen({super.key});

  @override
  State<ReqadvanceScreen> createState() => _ReqadvanceScreenState();
}

class _ReqadvanceScreenState extends State<ReqadvanceScreen> {
  final RequestAdvancecontroller requestAdvancecontroller =
  Get.put(RequestAdvancecontroller());
  final FocusNode remark_focusNode = FocusNode();
  //final FocusNode amount_focusNode = FocusNode();
  final FocusNode purpose_focusNode = FocusNode();
  @override
  void dispose() {
    // Clean up the focus node when the widget is disposed
    remark_focusNode.dispose();
  //  amount_focusNode.dispose();
    purpose_focusNode.dispose();
    requestAdvancecontroller.focusNode.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestAdvancecontroller.focusNode = FocusNode();

    // Add listener to the FocusNode
    requestAdvancecontroller.focusNode.addListener(() {
      if (!requestAdvancecontroller.focusNode.hasFocus) {
        // Perform action when keyboard is dismissed
        print('Keyboard dismissed');
        requestAdvancecontroller.formatNumber();
        // You can replace this with any action you want to perform
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: customAppBar("Request Advance"),
          body: Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 17),
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  decoration: boxOutlineShadowCustom(Colors.white, 10.0,Colors.grey.shade400),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ts("Date", Colors.black),
                      gapHC(2),
                      Obx(
                            () => GestureDetector(
                          onTap: () {
                            requestAdvancecontroller.wSelectFromDate(context);
                          },
                          child: Container(
                            height: 45,
                            width: size.width * 0.4,
                            decoration: boxOutlineCustom(
                                Colors.white, 10, Colors.grey.shade400),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ts(
                                      setDate(
                                          6,
                                          requestAdvancecontroller.reqDate.value
                                          as DateTime),
                                      Colors.black),
                                  const Icon(
                                    Icons.calendar_month,
                                    color: primaryColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      gapHC(10),
                      ts("Type of trip", Colors.black),
                      gapHC(2),
            
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
                          value: requestAdvancecontroller.lstrTypeofTrip.value
                              .toString(),
                          isExpanded: true,
                          // Down Arrow Icon
                          icon: const Icon(Icons.arrow_forward_ios_rounded,
                              size: 13),
            
                          // Array list of items
                          items: requestAdvancecontroller.typeOfTripList
                              .map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: ts(
                                items,
                                Colors.black,
                              ),
                            );
                          }).toList(),
                          onChanged: (dynamic value) {
                            requestAdvancecontroller.fnOnChnageTripBranch(value, "Trip");
                          },
                        ),
                      )),
                      gapHC(10),
                      ts("Branch name", Colors.black),
                      gapHC(2),
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
                          value: requestAdvancecontroller.lstrBranchName.value
                              .toString(),
                          isExpanded: true,
                          // Down Arrow Icon
                          icon: const Icon(Icons.arrow_forward_ios_rounded,
                              size: 13),
            
                          // Array list of items
                          items:
                          requestAdvancecontroller.branchList.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: ts(
                                items,
                                Colors.black,
                              ),
                            );
                          }).toList(),
                          onChanged: (dynamic value) {
                            requestAdvancecontroller.fnOnChnageTripBranch(value, "Branch");
                          },
                        ),
                      )),
                      gapHC(10),
                      ts("Purpose of trip", Colors.black),
                      gapHC(2),
                      Container(
                        child: TextinputfieldContainer(
                            showIcon: false,
                            verticalPadding: 6,
                            textInputAction: TextInputAction.done,
                            controller: requestAdvancecontroller.txtpurposeTrip,
                            maxline: 3,
                            focusNode: purpose_focusNode,
                            onSubmitted:  (){
                              purpose_focusNode.unfocus();
                            } ,
                            hintText: "Enter your purpose",
                            isEnable: true,
                            isObscure: false),
                      ),
                      gapHC(10),
                      ts("Remark", Colors.black),
                      gapHC(2),
                      Container(
                        child: TextinputfieldContainer(
                            showIcon: false,
                            verticalPadding: 6,
                            controller: requestAdvancecontroller.txtRemark,
                            maxline: 3,
                            hintText: "Enter your remarks",
                            textInputAction: TextInputAction.done,

                            focusNode: remark_focusNode,
                            onSubmitted:  (){
                              remark_focusNode.unfocus();
                            } ,
                            isEnable: true,
                            isObscure: false),
                      ),
            
                      gapHC(10),
                      ts("Amount", Colors.black),
                      gapHC(2),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: requestAdvancecontroller.txtAmount.value,
                              obscureText: false,
                              enabled: true,
                              textInputAction:TextInputAction.done ,



                              style: const TextStyle(color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                contentPadding:EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 0.0
                                ),

                                hintText: 'Amount',
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
                              keyboardType: TextInputType.number,
                              inputFormatters: mfnInputDecFormatters(),
                              onSubmitted: (v){
                                dprint("ONSUBMITTTTTTTTTTTTTTTT");
                                requestAdvancecontroller.formatNumber();

                              },
                              focusNode: requestAdvancecontroller.focusNode,





                            ),
                          ),
                          Expanded(child: SizedBox())
                        ],
                      ),
                      gapHC(10),
                      Divider(),
                      gapHC(10),
                      Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: SizedBox()),
                          Expanded(
                            child: Custombutton(onTap: (){
                              dprint("SENDDDDDDDDDDDDDDDD.");

                              show(context,
                                  contHeight: size.height*0.35,
                                  autoDismiss: true,

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      gapHC(30),
                                      Image.asset(
                                        AppAssets.sentpng
                                        ,fit: BoxFit.fill,

                                      ),
                                      gapHC(30),
                                      tcCustomhead("Your request for advance \n"
                                          "has been sent", Colors.black87,
                                          size: 21.0,
                                          align: TextAlign.center, FontWeight.w500),

                                      gapHC(20)
                                    ],
                                  ));




                            }, buttonName: "Send",
                                buttonColor: primaryColor, buttonTextColor: Colors.white),
                          ),
            
                        ],
                      )
            
            
                    ],
                  ),
                ),
            
                Divider(),
                tssb("Advance payments", Colors.black, FontWeight.bold),
                gapHC(10),
                ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context,index){
                  return     Container(
                    margin: EdgeInsets.only(top: 10)
                    ,
                    decoration: boxOutlineCustom(Colors.white, 10.0, Colors.grey.shade400),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ts("Date", Colors.black),
                            Container(
                              height: 26,
                              width: 90,

                             // padding: EdgeInsets.symmetric(vertical: 2,horizontal: 30),
                              decoration: boxDecoration(index==1?primaryColor:Colors.green, 20),
                              child: Center(child: tssb(index==1?"Settled":"Paid", Colors.white, FontWeight.w500)),
                            )
                          ],
                        ),
                        tssb("22/02/2023", Colors.black, FontWeight.bold,height: 0.9),
                        gapHC(8),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ts("Type of Trip", Colors.black),
                                ts("Branch name", Colors.black),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                tssb("Inauguration", Colors.black,FontWeight.bold),
                                tssb("Thrissure", Colors.black,FontWeight.bold),

                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ts("Amount", Colors.black),
                                tssb("\u{20B9} 4000.00", primaryColor,FontWeight.w500),
                              ],
                            ),
                          ],
                        ),



                      ],
                    ),
                  );
                }),

                gapHC(20),


            
            
              ],
            ),
          ),),
    ));
  }
}
