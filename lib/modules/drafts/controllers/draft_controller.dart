import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/modules/claim/claim_page.dart';
import 'package:travel_claim/utils/local_storage_data_provider.dart';
import 'package:travel_claim/views/components/app_dialog.dart';


class DraftController extends GetxController with GetSingleTickerProviderStateMixin{
  var isBusy = false.obs;

  var items = <ClaimForm>[].obs;


  final _repository = LocalStorageDataProvider();

  @override
  void onInit() {
    getDrafts();
    super.onInit();
  }

  void gotoClaimForm(ClaimForm claim){
    Get.toNamed(ClaimPage.routeName,arguments: claim);
  }

  getDrafts({bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isBusy(true);
      }
      var response = await _repository.getClaims();
        items(response);
    } catch (_) {
      print('draft claims get error: ${_.toString()}');
    } finally {
      if(!isSilent) {
        isBusy(false);
      }
    }
  }

  void delete(ClaimForm claim){
    AppDialog.showDialog(title:"Delete?",content:  "Are you sure want to delete this draft?",negativeText: "Cancel",negativeOnPressed: (){
      Get.back();
    },positiveText: "Delete",positiveOnPressed: (){
      Get.back();
      _delete(claim);
    });
  }

  _delete(ClaimForm claim)async{
    try{
      await _repository.delete(claim.storageId);
      getDrafts();
    }catch(_){
      print('draft claims delete error: ${_.toString()}');
    }
  }
}
