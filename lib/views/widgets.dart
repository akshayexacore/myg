import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';

Widget headTitle(head,value,{colors,txtalign,fonsize}){
  return  Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Flexible(
        flex: 5,
          child: ts(head, Color(0xff333333).withOpacity(0.8))),

 
      Expanded(
        flex: 5,
        child: Text(value,textAlign: txtalign??TextAlign.left,overflow: TextOverflow.fade,style:  TextStyle(
            fontFamily: 'Roboto',fontSize: fonsize??14,
            fontWeight: FontWeight.w500,color:colors?? Color(0xff333333))),
      ),
    ],
  );
}
Widget menuCard(tl,tr,bl,br,icon,title,){
  return   Container(
    // width: 135,
    margin: const EdgeInsets.symmetric(horizontal: 10),
    height: 135,
    decoration:
    boxDecorationC(Colors.white, tl, tr, bl, br),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(icon,fit: BoxFit.fill,),
        gapHC(15),
        tssb(title, Colors.black,FontWeight.w500,height: 1.0)
      ],
    ),
  );
}

Widget expansionTile(String ?image,String ? title){
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: boxBaseDecoration(greyLight, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Image.network(
              image!,
              height: 25,
              width: 25,
            ),
            gapWC(20),
            tss(title, Colors.black, 15.0),
          ],
        ),
        Icon(Icons.keyboard_arrow_down,
          color: primaryColor.withOpacity(0.8),size: 34,)
      ],
    ),
  );
}

Widget showToastMessage({String ?msg, Color? iconColor, IconData? icon,Color bgColor = primaryColor,required double width}){
  return   Container(
    width: width - 28,
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
    margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: boxDecoration(bgColor, 20.0),
    child: Row(
      children: [
        Container(
            decoration: boxDecoration(Colors.white, 40),
            child: Icon(icon,color: iconColor,)),
      gapWC(10),
        Expanded(child: ts(msg,Colors.white)),
      ],
    ),
  );

}


