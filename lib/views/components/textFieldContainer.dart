

import 'package:flutter/material.dart';
import 'common.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget ? child;
  final double ? txtWidth;
  final double ? txtRadius;
  final String ? labelName;
  final String ? labelYn;


  const TextFieldContainer({
    Key ?  key,
    this.child  ,
    this.txtWidth,
    this.txtRadius,
    this.labelName, this.labelYn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: labelYn == 'Y'? 80: 55,
      margin: const EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelYn == 'Y'? Text(labelName!,style: const TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold,fontSize: 14,)) : Container(),
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal:10, vertical: 0),
            width: size.width * txtWidth!,
            decoration: boxOutlineDecoration(Colors.white, txtRadius!),
            child: child,
          ),
        ],
      ),
    );
  }
}