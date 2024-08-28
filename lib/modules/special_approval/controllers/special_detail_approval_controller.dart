import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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


class SpecialDetailApprovalController extends GetxController with GetSingleTickerProviderStateMixin{
  var isBusy = false.obs;
  var isUpdateBusy = false.obs;

  var claim = Rxn<ClaimHistory>();


  final _repository = MygRepository();

  TextEditingController textEditingControllerConfirmRemarks = TextEditingController();


  @override
  void onInit() {
    claim(Get.arguments);
    if(claim.value!.categories == null || claim.value!.categories!.isEmpty){
      getDetails();
    }else{
      getDetails(isSilent: true);
    }
    super.onInit();
  }

  getDetails({bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isBusy(true);
      }
      var response = await _repository.getClaimDetailForSpecialApproval(claim.value!.tripClaimId);
        claim(response.claim);
    } catch (_) {
      print('detail claims get error: ${_.toString()}');
    } finally {
      if(!isSilent) {
        isBusy(false);
      }
    }
  }

  void reloadClaim(){
    if(Get.isRegistered<SpecialApprovalListController>()){
      Get.find<SpecialApprovalListController>().getApprovalList();
    }
    if(Get.isRegistered<SpecialDetailApprovalController>()){
      Get.find<SpecialDetailApprovalController>().getDetails();
    }
  }

  _clearForm(){
    textEditingControllerConfirmRemarks.clear();
  }


  approveOrRejectAll({bool isSilent = false,bool isReject  = false}) async {
    try {

      if(!isSilent) {
        isUpdateBusy(true);
      }

      var body = {
        "trip_claim_id":claim.value!.tripClaimId,
        "status": isReject ? "Rejected" : "Approved",
        "remarks": textEditingControllerConfirmRemarks.text,
      };
      var response = await _repository.specialApproveOrRejectAll(body: body);
      if(response.success){
        Get.back();
        Get.back();
        AppDialog.showToast(response.message.isNotEmpty ? response.message : "${isReject ? "Rejected" : "Approved"} the claim");
        reloadClaim();
      }else{
        AppDialog.showToast(response.message.isNotEmpty ? response.message : "Something went wrong",isError: true);
      }
    } catch (_) {
      print('special approveOrRejectAll error: ${_.toString()}');
      AppDialog.showToast("Something went wrong, Try again.",isError: true);
    } finally {
      if(!isSilent) {
        isUpdateBusy(false);
      }
    }
  }

  rejectSingle(ClaimFormData claim,{bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isUpdateBusy(true);
      }
      var body = {
        "trip_claim_details_id":claim.id,
        "remarks":textEditingControllerConfirmRemarks.text
      };
      var response = await _repository.rejectSingleSpecialClaimItem(body: body);
      if(response.success){
        Get.back();
        AppDialog.showToast(response.message.isNotEmpty ? response.message : "Rejected the item");
        reloadClaim();
        _clearForm();
      }else{
        AppDialog.showToast(response.message.isNotEmpty ? response.message : "Something went wrong",isError: true);
      }
    } catch (_) {
      print('reject single error: ${_.toString()}');
      AppDialog.showToast("Something went wrong, Try again.",isError: true);
    } finally {
      if(!isSilent) {
        isUpdateBusy(false);
      }
    }
  }
}
