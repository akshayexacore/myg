import 'package:flutter/material.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/textInputField.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class DraftinnerScreen extends StatefulWidget {
  const DraftinnerScreen({super.key});

  @override
  State<DraftinnerScreen> createState() => _DraftinnerScreenState();
}

class _DraftinnerScreenState extends State<DraftinnerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Draft"),
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

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    ));
  }
}
