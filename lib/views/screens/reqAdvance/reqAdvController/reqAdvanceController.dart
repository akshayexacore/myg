import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_claim/views/components/common.dart';

class RequestAdvancecontroller extends GetxController{
  Rx<DateTime> reqDate = DateTime.now().obs;
  RxString lstrTypeofTrip = 'Inauguration'.obs;
  RxString lstrBranchName= 'Thrissure'.obs;
  late FocusNode focusNode;
  TextEditingController txtpurposeTrip = TextEditingController();
  TextEditingController txtRemark = TextEditingController();
  final NumberFormat _numberFormat = NumberFormat("#,##0.00");

  final Rx<TextEditingController> txtAmount = TextEditingController().obs;
  var typeOfTripList = [
    'Inauguration',
    'Branch Visit',
    'Others',

  ];
  var branchList = [
    'Thrissure',
    'Thiruvananthapuram',
    'Thamarassery',

  ];

  Future<void> wSelectFromDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2023, 1),
        lastDate: DateTime(2050, 8),
        initialDate: DateTime.now());
    if (pickedDate != null && pickedDate != reqDate.value) {
      reqDate.value = pickedDate;


    }
  }
  fnOnChnageTripBranch(val,mode) {
    if(mode=="Trip"){
      lstrTypeofTrip.value = val;
    }else if(mode=="Branch"){
      lstrBranchName.value = val;
    }


  }
  void formatNumber() {
    if (txtAmount.value.text.isNotEmpty) {

      txtAmount.value.text = _numberFormat.format(double.tryParse(txtAmount.value.text));
      dprint("ADSADADAS  >>>  >>> ${txtAmount.value.text}");
    }
  }
}