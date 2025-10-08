import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/models/draft_list_model.dart';
import 'package:travel_claim/modules/claim/claim_page.dart';
import 'package:travel_claim/resources/myg_repository.dart';
import 'package:travel_claim/utils/local_storage_data_provider.dart';
import 'package:travel_claim/views/components/app_dialog.dart';


class DraftController extends GetxController with GetSingleTickerProviderStateMixin{
  var isBusy = false.obs;

  var items = <DraftListModel>[].obs;

  final _mygRepository = MygRepository();
  final _repository = LocalStorageDataProvider();

  @override
  void onInit() {
    getDrafts();
    super.onInit();
  }

  void gotoClaimForm(DraftListModel claim){
    Get.toNamed(ClaimPage.routeName,arguments: claim);
  }

  getDrafts({bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isBusy(true);
      }
      var response = await _mygRepository.getClaimDraftHistory();
        items(response.claimList);
    } catch (_) {
      print('draft claims get error: ${_.toString()}');
    } finally {
      if(!isSilent) {
        isBusy(false);
      }
    }
  }

  void delete(DraftListModel claim){
    AppDialog.showDialog(title:"Delete?",content:  "Are you sure want to delete this draft?",negativeText: "Cancel",negativeOnPressed: (){
      Get.back();
    },positiveText: "Delete",positiveOnPressed: (){
      Get.back();
      _delete(claim);
    });
  }

  _delete(DraftListModel claim)async{
    try{
      await _mygRepository.deleteDraft(body:{"trip_claim_id":claim.tripClaimId });
      getDrafts(isSilent: true);
    }catch(_){
      print('draft claims delete error: ${_.toString()}');
    }
  }
}
