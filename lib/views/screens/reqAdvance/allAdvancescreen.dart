import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';

class Alladvancescreen extends StatefulWidget {
  const Alladvancescreen({super.key});

  @override
  State<Alladvancescreen> createState() => _AlladvancescreenState();
}

class _AlladvancescreenState extends State<Alladvancescreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Advances"),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: ListView.builder(
          itemCount: 12,
            itemBuilder: (context,index){
          return   Container(
            margin: EdgeInsets.only(bottom: 15),
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
                      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 30),
                      decoration: boxDecoration(index==0?Colors.green:primaryColor, 20),
                      child: tssb(index==0? "Paid":"Settled", Colors.white, FontWeight.w500),
                    )
                  ],
                ),
                tssb("22/02/2023", Colors.black, FontWeight.bold,height: 0.9),
                gapHC(8),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ts("Type of Trip", Colors.black),
                    tssb("Inauguration", Colors.black,FontWeight.bold),
                    ts("Amount", Colors.black),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ts("Branch name", Colors.black),
                    tssb("Thrissure", Colors.black,FontWeight.bold),
                    tssb("\u{20B9} 40000.00", primaryColor,FontWeight.w500),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    ));
  }
}
