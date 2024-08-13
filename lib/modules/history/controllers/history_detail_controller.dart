import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/models/claim_history.dart';
import 'package:travel_claim/modules/claim/claim_page.dart';
import 'package:travel_claim/resources/myg_repository.dart';
import 'package:travel_claim/utils/local_storage_data_provider.dart';
import 'package:travel_claim/views/components/app_dialog.dart';


class HistoryDetailController extends GetxController with GetSingleTickerProviderStateMixin{
  var isBusy = false.obs;

  var claim = Rxn<ClaimHistory>();


  final _repository = MygRepository();

  @override
  void onInit() {
    claim(Get.arguments);
    if(claim.value!.categories == null || claim.value!.categories!.isEmpty){
      getDetails();
    }
    getDetails();
    super.onInit();
  }

  getDetails({bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isBusy(true);
      }
     /* var response = await _repository.getClaims();
        items(response);*/
    } catch (_) {
      print('detail claims get error: ${_.toString()}');
    } finally {
      if(!isSilent) {
        isBusy(false);
      }
    }
  }
}
