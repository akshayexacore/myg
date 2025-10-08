
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/drafts/controllers/draft_controller.dart';
import 'package:travel_claim/utils/app_formatter.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class DraftPage extends StatelessWidget {
  DraftPage({Key? key}) : super(key: key);

  static const routeName = '/draft';

  final _controller = Get.find<DraftController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: customAppBar("Draft"),
            body: Obx((){

              if(_controller.isBusy.isTrue){
                return Center(child: SpinKitDoubleBounce(color: primaryColor,));
              }

              if(_controller.items.isEmpty){
                return Center(child: ts("No items in draft", Colors.black54));
              }

              return ListView.builder(
                  itemCount: _controller.items.length,
                  itemBuilder: (context,index){
                    return Bounce(
                      onTap: (){
                        _controller.gotoClaimForm(_controller.items[index]);
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
                                  headTitle("Date",_controller.items[index].date??""),
                                  headTitle("Type of trip", _controller.items[index].tripTypeDetails?.triptypeName??""),
                                  headTitle("Branch name", _controller.items[index].visitBranchDetail?.map((e)=>e.branchName).join(',') ?? 'NA'),
                                ],
                              ),

                            ),
                            Positioned.fill(
                              child: Align(    alignment: Alignment.topRight,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5),
                                  padding: EdgeInsets.all(7),
                                  decoration: boxDecoration(primaryColor, 30),
                                  child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.white,),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(    alignment: Alignment.bottomRight,
                                child: GestureDetector(onTap: ()=>
                                _controller.delete(_controller.items[index]),
                                child: Container(margin: EdgeInsets.only(top: 5),padding: EdgeInsets.all(7),decoration: boxDecoration(Colors.red, 30),child: Icon(Icons.delete,size: 20,color: Colors.white,))),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            })

        ));
  }
}
