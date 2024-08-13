import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:travel_claim/views/components/common.dart';

class Custombutton extends StatelessWidget {
  final VoidCallback onTap;
   final String buttonName;
   final Color buttonColor;
   final double ?verticaPadding;
   final Color buttonTextColor;
   final Color ? buttonBorderColor;
  const Custombutton({super.key, required this.onTap, required this.buttonName, required this.buttonColor, required this.buttonTextColor,  this.buttonBorderColor, this.verticaPadding});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap,
      child: Container(
        decoration: boxOutlineCustom(buttonColor,10.0,buttonBorderColor??buttonColor),
        padding:  EdgeInsets.symmetric(vertical: verticaPadding?? 9,horizontal: 20),
        child: tssb(buttonName, buttonTextColor, FontWeight.bold),
      ),
    );
  }
}
