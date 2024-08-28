import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/advance.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/models/claim_history.dart';
import 'package:travel_claim/models/employee.dart';
import 'package:travel_claim/modules/claim/claim_page.dart';
import 'package:travel_claim/modules/claim_approval/controllers/claim_approval_list_controller.dart';
import 'package:travel_claim/modules/special_approval/controllers/special_approval_list_controller.dart';
import 'package:travel_claim/modules/special_approval/special_approval_list_page.dart';
import 'package:travel_claim/resources/myg_repository.dart';
import 'package:travel_claim/utils/local_storage_data_provider.dart';
import 'package:travel_claim/views/components/app_dialog.dart';


class AdvanceDetailController extends GetxController with GetSingleTickerProviderStateMixin{
  var isBusy = false.obs;
  var isUpdateBusy = false.obs;

  var advance = Rxn<AdvanceHistory>();


  final _repository = MygRepository();

  TextEditingController textEditingControllerConfirmRemarks = TextEditingController();


  @override
  void onInit() {
    advance(Get.arguments);
    super.onInit();
  }
}
