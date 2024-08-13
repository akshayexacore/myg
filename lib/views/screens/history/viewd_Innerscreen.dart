import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/screens/history/controller/historyController.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class ViewdInnerscreen extends StatefulWidget {
  final String status;
  final String? statusDate;
  final String ?statusPerson;
  final String ?statusCouses;
  const ViewdInnerscreen({super.key, required this.status,  this.statusDate,  this.statusPerson,  this.statusCouses});

  @override
  State<ViewdInnerscreen> createState() => _ViewdInnerscreenState();
}

class _ViewdInnerscreenState extends State<ViewdInnerscreen> {
  final Historycontroller historycontroller =
  Get.put(Historycontroller());
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("History"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapHC(10),
            Container(
             margin:  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
        
        
            Container(
              margin:  EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              decoration: boxBaseDecoration(greyLight, 10),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            child: Column(
              children: [
                headTitle("Type of trip", "Inauguration"),
                gapHC(3),
                headTitle("Branch name", "Thrissure"),
                gapHC(3),
                headTitle("Purpose of trip", "Inauguration at Thrissure"),
              ],
            ),),
        
        
            Container(
              margin:  EdgeInsets.symmetric(horizontal: 15,vertical: 8),
              decoration: boxBaseDecoration(greyLight, 10),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ts("Reporting person approval", Colors.black),
                      tssb(widget.status=="Rejected"?"Rejected": "Approved",widget.status=="Rejected"?pinkreject: Colors.green,FontWeight.w700)
        
                    ],
                  ),
        
                  gapHC(2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ts("Finance approval", Colors.black),
                      tssb(widget.status=="Rejected"?"Rejected":widget.status=="Paid"?"Approved":"Pending",
                          widget.status=="Rejected"?pinkreject:widget.status=="Paid"?Colors.green:yellowpending,
                          FontWeight.w700)
        
                    ],
                  ),
        
                  gapHC(10),

                 widget.status=="Pending"?SizedBox(): Column(
                    children: [
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ts("${widget.status} Date", Colors.black),
                          tssb(widget.statusDate,
                              Colors.black,
                              FontWeight.w700)

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ts(widget.status=="Rejected"?"Rejected person":"Approved Finance person", Colors.black),
                          tssb(widget.statusPerson,
                              Colors.black,
                              FontWeight.w700)

                        ],
                      ),
                    ],
                  ),



gapHC(10),





                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 26,
                        width: 90,
                      //  padding: EdgeInsets.symmetric(vertical: 2,horizontal: 30),
                        decoration: boxBaseDecoration(  widget.status=="Rejected"?pinkreject:widget.status=="Paid"?Colors.green:yellowpending, 20),
                        child: Center(child: tssb(widget.status=="Rejected"?"Rejected":widget.status=="Paid"?"Paid":"Pending", Colors.white, FontWeight.w500)),
                      ),
                      tcustom("\u{20B9}15,23.00", primaryColor, 18.0, FontWeight.w500),
        
                    ],
                  ),


                ],
              ),),
        
            const Padding(
              padding:   EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Divider(),
            ),
         widget.status=="Rejected"  ? Padding(
              padding:   EdgeInsets.symmetric(horizontal: 15,vertical: 5),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tssb("Reason for rejection", Colors.black, FontWeight.w400),
                  gapHC(5),
                  ts(widget.statusCouses, Colors.black.withOpacity(0.6))

                ],
              ),
            ):SizedBox(),





            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: tssb("Submitted Categories", Colors.black, FontWeight.bold),
            ),
        
            ListView.builder(
                itemCount:  historycontroller.submittedCategory.value.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: ScrollPhysics(),
                itemBuilder: (context,index){
                  dprint("!!1>>>>   ${historycontroller.submittedCategory}");
                  return Obx(()=>Column(
                    children: [
                      Bounce(
                          onTap: (){
                            setState(() {
                              historycontroller.submittedCategory.value[index]["expand"] =! historycontroller.submittedCategory.value[index]["expand"];
        
                            });
                            dprint("DDDD>> ${historycontroller.submittedCategory.value[index]["expand"]}");
        
                          },
                          child:Padding(
                            padding:   EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                            child: expansionTile(  historycontroller.submittedCategory.value[index]["image"]!, historycontroller.submittedCategory.value[index]["label"]),
                          )
                      ),
        
                      historycontroller.submittedCategory.value[index]["expand"]?
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
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
                              headTitle("Attached files", "tickets.pdf"),
                              gapHC(10),
                              headTitle("Amount", "9500.INR"),
                            ],
                          ),
        
                        ),
                      ):SizedBox()
        
                      //
                      // historycontroller.submittedCategory.value[index]["expand"]?
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     gapHC(20),
                      //     ts("1.${historycontroller.submittedCategory.value[index]["label"]} details", primaryColor, weight: FontWeight.w500),
                      //     const Divider(),
                      //     gapHC(10),
                      //     ts("From", Colors.black),
                      //     gapHC(3),
                      //     Container(
                      //         height: 45,
                      //         decoration: boxOutlineCustom(
                      //             Colors.white, 10, Colors.grey.shade400)),
                      //     gapHC(10),
                      //     ts("To", Colors.black),
                      //     gapHC(3),
                      //     Container(
                      //         height: 45,
                      //         decoration: boxOutlineCustom(
                      //             Colors.white, 10, Colors.grey.shade400)),
                      //     gapHC(10),
                      //     ts("Date", Colors.black),
                      //     gapHC(3),
                      //
                      //     gapHC(10),
                      //     tcustom(
                      //         "Number of employee", Colors.black, 14.0, FontWeight.w500),
                      //
                      //     gapHC(10),
                      //     ts("Amount", Colors.black),
                      //     gapHC(3),
                      //     Row(
                      //       children: [
                      //         Expanded(
                      //           child: Center(
                      //             child: Container(
                      //               height: 45,
                      //               padding: const EdgeInsets.symmetric(horizontal: 10),
                      //               decoration: boxOutlineCustom(
                      //                   Colors.white, 10, Colors.grey.withOpacity(0.5)),
                      //               child: Row(
                      //                 children: [
                      //                   ts("10000.00", Colors.grey.shade600,
                      //                       align: TextAlign.start),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         gapWC(15),
                      //         Expanded(
                      //           child: Center(
                      //             child: Container(
                      //               height: 45,
                      //               padding: const EdgeInsets.symmetric(horizontal: 20),
                      //               decoration: boxOutlineCustom(
                      //                   primaryColor, 20, Colors.grey.withOpacity(0.5)),
                      //               child: Center(
                      //                   child: ts("Choose file", Colors.white,
                      //                       align: TextAlign.start)),
                      //             ),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //     gapHC(10),
                      //     ts("Files", Colors.black),
                      //     gapHC(20),
                      //     Bounce(
                      //       onTap: (){
                      //         dprint("Adddmoooooooooooooer00");
                      //       },
                      //       child: Container(
                      //         decoration: boxOutlineCustom(Colors.white,10.0,primaryColor),
                      //         padding: const EdgeInsets.symmetric(vertical: 9,horizontal: 20),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             tssb("Add more", Colors.black, FontWeight.w500),
                      //             gapWC(2),
                      //             Icon(Icons.add,color: Colors.black,)
                      //           ],
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // )
                      //     :const SizedBox(),

                    ],
                  ),);
                }),
            gapHC(15),
        
          ],
        ),
      ),
    ));
  }
}
