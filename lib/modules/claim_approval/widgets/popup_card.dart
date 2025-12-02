import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_claim/utils/app_formatter.dart';
import 'package:travel_claim/views/components/common.dart';

import 'package:travel_claim/views/style/colors.dart';

expense_popup(Map<String, dynamic> data) {
  //ate final _controller = Get.put(LoginController());
  return showDialog(
    barrierDismissible: false,
    context: Get.context!,
    builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.only(top: 0),
        content: Container(
          width: 300,
          height: 400,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    tchcus("Claim Duplication", Colors.black, 18.0),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
              ),
              CommonCurvedContentContainer(
                children: [
                  rowTextsCommon("Submitted Date", data['submittedDate'] ?? ""),
                  rowTextsCommon("Branch Name", data['branchName'] ?? ""),
                  rowTextsCommon("Trip ID", data['tripId'] ?? ""),
                  rowTextsCommon("Category", data['category'] ?? ""),
                  rowTextsCommon("Amount", data['amount'] ?? ""),
                  rowTextsCommon(
                    "Document Date",
                    (data['document'] != null &&
                            data['document'].toString().trim().isNotEmpty)
                        ? AppFormatter.convertDateFormat(
                            data['document'].toString())
                        : "-",
                  ),
                  // rowTextsCommon(
                  //     "Other Employees", data['otherEmployees'] ?? ""),
                  // rowTextsCommon("Remarks", data['remarks'] ?? "",
                  //     padding: EdgeInsets.zero),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        )),
  );
}

class CommonCurvedContentContainer extends StatelessWidget {
  final List<Widget> children;
  const CommonCurvedContentContainer({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }
}

Widget rowTextsCommon(
  String leftText,
  String rightText, {
  TextStyle? leftTextStyle,
  TextStyle? rightTextStyle,
  EdgeInsetsGeometry? padding,
}) {
  return Padding(
    padding: padding ?? EdgeInsets.only(bottom: 20),
    child: Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              leftText,
              style: leftTextStyle ??
                  GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black.withOpacity(.7),
                      fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              rightText,
              style: rightTextStyle ??
                  GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
              // overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    ),
  );
}
