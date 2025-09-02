import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'common.dart';

class TabButton extends StatelessWidget {
  final String? text;
  final String? count;
  final int? selectedPage;
  final int? pageNumber;
  final Function onPressed;
  final IconData? icon;
  final double width;
  final double? radius;
  final bool? isWhite;
  final bool? isShowIcon;
  final bool? isShowCount;
  final double? iconSize;
  final Color? tabcolor;
  TabButton(
      {this.text,
      this.selectedPage,
      this.pageNumber,
      this.icon,
      this.radius,
      this.iconSize,
      this.tabcolor,
      required this.width,
      required this.onPressed,
      this.isWhite,
      this.isShowIcon,
      this.isShowCount,
      this.count});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color fBgColor = (isWhite ?? false) ? Colors.white : primaryColor;
    Color? fSBgColor = (isWhite ?? false) ? tabcolor : Colors.white;
    Color fStxtColor = (isWhite ?? false) ? Colors.white : Colors.black;
    Color fNtxtColor = (isWhite ?? false) ? Colors.black : Colors.white;

    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: selectedPage == pageNumber ? Colors.white : fBgColor,
        ),
        padding: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 6.0 : 6.0,
          //     horizontal: selectedPage == pageNumber ? 20.0 : 0,
        ),
        margin: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 0 : 0.0,
          //  horizontal: selectedPage == pageNumber ? 0 : 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // isShowIcon==false?gapHC(0):  Container(
            //   child: Icon(icon ?? null,
            //       size: iconSize ?? 15,
            //       color: selectedPage == pageNumber ? fStxtColor : fNtxtColor),
            // ),

            Text(
              text ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: selectedPage == pageNumber
                    ? FontWeight.w500
                    : FontWeight.w400,
                color: selectedPage == pageNumber ? primaryColor : fNtxtColor,
              ),
            ),
            gapHC(5),
            Container(
              color: selectedPage == pageNumber
                  ? primaryColor
                  : Colors.grey.shade300,
              height: 2.5,
            ),
            isShowCount == true && count != "0"
                ? CircleAvatar(
                    radius: 10,
                    backgroundColor: selectedPage == pageNumber
                        ? fStxtColor.withOpacity(0.2)
                        : tabcolor?.withOpacity(0.1),
                    child: tcn(
                        count,
                        selectedPage == pageNumber ? fStxtColor : fNtxtColor,
                        10),
                  )
                : gapHC(0)
          ],
        ),
      ),
    );
  }
}
