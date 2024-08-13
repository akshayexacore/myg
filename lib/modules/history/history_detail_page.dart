
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/history/controllers/history_detail_controller.dart';
import 'package:travel_claim/utils/app_formatter.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:path/path.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class HistoryDetailPage extends StatelessWidget {
  HistoryDetailPage({Key? key}) : super(key: key);

  static const routeName = '/history_detail';

  final _controller = Get.find<HistoryDetailController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("History"),
      body: Obx((){
        if(_controller.isBusy.isTrue){
          return const Center(child: SpinKitDoubleBounce(color: primaryColor,));
        }

        if(_controller.claim.value!.categories!.isEmpty){
          return Center(child: ts("Claim details not found!", Colors.black54));
        }
        return SingleChildScrollView(
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
                        tssb("#${_controller.claim.value!.tripClaimId}", Colors.white,FontWeight.w500),
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
                    headTitle("Type of trip", _controller.claim.value!.tripTypeDetails?.name ?? ''),
                    gapHC(3),
                    headTitle("Branch name", _controller.claim.value!.visitBranchDetail?.name ?? ''),
                    gapHC(3),
                    headTitle("Purpose of trip", _controller.claim.value!.tripPurpose),
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
                        tssb(_controller.claim.value!.status=="Rejected"?"Rejected": "Approved",_controller.claim.value!.status=="Rejected"?pinkreject: Colors.green,FontWeight.w700)

                      ],
                    ),

                    gapHC(2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ts("Finance approval", Colors.black),
                        tssb(_controller.claim.value!.status=="Rejected"?"Rejected":_controller.claim.value!.status=="Paid"?"Approved":"Pending",
                            _controller.claim.value!.status=="Rejected"?pinkreject:_controller.claim.value!.status=="Paid"?Colors.green:yellowpending,
                            FontWeight.w700)

                      ],
                    ),

                    gapHC(10),

                    _controller.claim.value!.status=="Pending"?SizedBox(): Column(
                      children: [
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ts("${_controller.claim.value!.status} Date", Colors.black),
                            tssb('22/10/24',
                                Colors.black,
                                FontWeight.w700)

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ts(_controller.claim.value!.status=="Rejected"?"Rejected person":"Approved Finance person", Colors.black),
                            tssb('Adham (MYGX-1111)',
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
                          decoration: boxBaseDecoration(  _controller.claim.value!.status=="Rejected"?pinkreject:_controller.claim.value!.status=="Paid"?Colors.green:yellowpending, 20),
                          child: Center(child: tssb(_controller.claim.value!.status=="Rejected"?"Rejected":_controller.claim.value!.status=="Paid"?"Paid":"Pending", Colors.white, FontWeight.w500)),
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
              _controller.claim.value!.status=="Rejected"  ? Padding(
                padding:   EdgeInsets.symmetric(horizontal: 15,vertical: 5),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    tssb("Reason for rejection", Colors.black, FontWeight.w400),
                    gapHC(5),
                    ts('Your claim for the train has been rejected because the bill date and submitted date are different. Additionally, the submitted travel location does not match the location on the train.', Colors.black.withOpacity(0.6))

                  ],
                ),
              ):SizedBox(),





              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: tssb("Submitted Categories", Colors.black, FontWeight.w600),
              ),
              SizedBox(height: 15,),
              ExpandedTileList.separated(
                key: ValueKey(_controller.claim.value!.categories!
                    .map(
                      (element) => "${element.id}-${element.name}",
                )
                    .toList()
                    .join("")),
                itemCount: _controller.claim.value!.categories!.length,
                maxOpened: 2,
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                initiallyOpenedControllersIndexes: [0],
                itemBuilder: (context, index, con) {
                  return ExpandedTile(
                    theme: ExpandedTileThemeData(
                      headerColor: greyLight,
                      headerPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 9),
                      headerSplashColor: greyLight,
                      contentSeparatorColor: Colors.white,
                      contentBackgroundColor: Colors.white,
                      headerBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: greyLight)),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 8),
                    ),
                    controller: con,
                    title: tss(
                        _controller.claim.value!.categories![index].name,
                        Colors.black,
                        15.0),
                    leading: Image.network(
                      _controller.claim.value!.categories![index].imageUrl,
                      height: 25,
                      width: 25,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_down,
                      color: primaryColor.withOpacity(0.8),
                      size: 24,
                    ),
                    trailingRotation: 180,
                    contentseparator: 8,
                    content: Column(
                      children: [
                        Obx(() {
                          return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, formIndex) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 20
                                  ),
                                  decoration: boxBaseDecoration(greyLight, 0 ),
                                  child: Column(
                                    children: [
                                      if(_controller.claim.value!.categories![index].hasTripFrom)
                                        headTitle("From", _controller.claim.value!.categories![index].items[formIndex].tripFrom),
                                      if(_controller.claim.value!.categories![index].hasTripFrom)
                                        gapHC(10),
                                      if(_controller.claim.value!.categories![index].hasTripTo)
                                        headTitle("To", _controller.claim.value!.categories![index].items[formIndex].tripTo),
                                      if(_controller.claim.value!.categories![index].hasTripTo)
                                        gapHC(10),
                                      if(_controller.claim.value!.categories![index].hasToDate)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                                flex: 5,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ts("Checked In", Colors.black),
                                                    Text(AppFormatter.formatDDMMMYYYY(_controller.claim.value!.categories![index].items[formIndex].fromDate!),style:  const TextStyle(
                                                        fontFamily: 'Roboto',fontSize: 14,
                                                        fontWeight: FontWeight.w700,color: Colors.black))
                                                  ],
                                                )),


                                            Expanded(
                                              flex: 5,
                                              child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  ts("Checked Out", Colors.black),
                                                  Text(AppFormatter.formatDDMMMYYYY(_controller.claim.value!.categories![index].items[formIndex].toDate!),textAlign: TextAlign.left,overflow: TextOverflow.fade,style: const TextStyle(
                                                      fontFamily: 'Roboto',fontSize: 14,
                                                      fontWeight: FontWeight.bold,color: Colors.black)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      if(_controller.claim.value!.categories![index].hasToDate)
                                        gapHC(10),
                                      if(!_controller.claim.value!.categories![index].hasToDate)
                                        headTitle("Document date", AppFormatter.formatDDMMMYYYY(_controller.claim.value!.categories![index].items[formIndex].fromDate!)),
                                      if(!_controller.claim.value!.categories![index].hasToDate)
                                        gapHC(10),
                                      headTitle("Number of employees", _controller.claim.value!.categories![index].items[formIndex].noOfEmployees.toString()),
                                      if(_controller.claim.value!.categories![index].items[formIndex].noOfEmployees>1)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Flexible(
                                                flex: 5,
                                                child: SizedBox()),


                                            Expanded(
                                              flex: 5,
                                              child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: _controller.claim.value!.categories![index].items[formIndex].employees.map((e) {
                                                  return Container(
                                                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 6),
                                                    margin: EdgeInsets.only(bottom: 2),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(14),
                                                        color: primaryColor
                                                    ),
                                                    child: ts('${e.name}(${e.employeeId})', Colors.white),
                                                  );
                                                },).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      gapHC(10),

                                      if(_controller.claim.value!.categories![index].items[formIndex].selectedClass!=null)
                                        headTitle("Class", _controller.claim.value!.categories![index].items[formIndex].selectedClass?.name),
                                      if(_controller.claim.value!.categories![index].items[formIndex].selectedClass!=null)
                                        gapHC(10),
                                      headTitle("Remark", _controller.claim.value!.categories![index].items[formIndex].remarks.isEmpty ? 'Nil' : _controller.claim.value!.categories![index].items[formIndex].remarks),
                                      gapHC(10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                              flex: 5,
                                              child: ts("Attached files", Colors.black)),


                                          Expanded(
                                            flex: 5,
                                            child:_controller.claim.value!.categories![index].items[formIndex].files.isNotEmpty ? Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(AppAssets.file,height: 16,width: 14,fit: BoxFit.fill,),
                                                gapWC(7),
                                                Expanded(
                                                  child: Text(basename(_controller.claim.value!.categories![index].items[formIndex].files.first),textAlign: TextAlign.left,overflow: TextOverflow.fade,style: const TextStyle(
                                                      fontFamily: 'Roboto',fontSize: 14,
                                                      fontWeight: FontWeight.bold,color: Colors.black)),
                                                ),
                                              ],
                                            ) : const Text("Nil",style:  TextStyle(
                                                fontFamily: 'Roboto',fontSize: 14,
                                                fontWeight: FontWeight.w700,color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      gapHC(10),
                                      headTitle("Amount", "${_controller.claim.value!.categories![index].items[formIndex].amount!.toStringAsFixed(2)} INR"),
                                    ],
                                  ),

                                );
                              },
                              separatorBuilder: (context, index) =>
                              const SizedBox(height: 15,),
                              itemCount: _controller.claim.value!.categories![index].items.length);
                        }),
                        gapHC(10)
                      ],
                    ),
                    onTap: () {
                      debugPrint("tapped!!");
                    },
                    onLongTap: () {
                      debugPrint("looooooooooong tapped!!");
                    },
                  );
                },
              ),
              gapHC(15),

            ],
          ),
        );
      }),
    ));
  }
}
